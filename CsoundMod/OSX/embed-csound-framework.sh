#!/usr/bin/env bash
#
# Copy CsoundLib64.framework into a built Hadron plugin bundle.
#
# Run as a POST_BUILD step from VST-AU/src/CMakeLists.txt, once per plugin
# format. Given a bundle, it installs the framework at
#     <bundle>/Contents/Frameworks/CsoundLib64.framework
# which is where the install name written by relink-csound-framework.sh points:
#     @loader_path/../Frameworks/CsoundLib64.framework/Versions/6.0/CsoundLib64
# The two must agree; --embed-dir here pairs with --embed-path there.
#
# The copy is pruned of the parts only the build needs (see PRUNE_PATHS), so
# the shipped framework is smaller than the one in the source tree. Pruning
# breaks the framework's signature seal, so the copy is re-signed ad-hoc.
#
# This does NOT sign the plugin bundle itself. The plugin binary keeps the
# ad-hoc signature the linker gave it, and dyld verifies each Mach-O
# separately, so the plugin loads as-is. Signing the bundle as a whole is a
# distribution concern and needs a real Developer ID.
#
# Usage:
#   ./embed-csound-framework.sh <path/to/Hadron.vst>
#   ./embed-csound-framework.sh --framework <path> <bundle>
#   ./embed-csound-framework.sh --embed-dir Resources <bundle>
#   ./embed-csound-framework.sh --no-prune <bundle>

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

FRAMEWORK="${SCRIPT_DIR}/Csound_framework/6_18/CsoundLib64.framework"
EMBED_DIR="Frameworks"
BUNDLE=""
PRUNE=1

# Paths (relative to the copied CsoundLib64.framework/) that the plugin does
# not need at runtime. Together these take the shipped framework from 14 MB to
# about 13 MB.
#
#   Headers          CMake's include dir, compile time only. The framework root
#                    symlink goes too, or it dangles and codesign rejects it.
#   libcsnd6         the C++ wrapper library. CMake does not link it (see
#                    VST-AU/src/CMakeLists.txt) and CsoundLib64 does not depend
#                    on it; Hadron uses only the Csound class from csound.hpp,
#                    which is inline in the header.
PRUNE_PATHS=(
    "Versions/6.0/Headers"
    "Headers"
    "Versions/6.0/libcsnd6.6.0.dylib"
)

info() { printf '\033[1m==>\033[0m %s\n' "$*"; }
die()  { printf '\033[31merror:\033[0m %s\n' "$*" >&2; exit 1; }
ok()   { printf '    \033[32mok\033[0m   %s\n' "$*"; }
bad()  { printf '    \033[31mFAIL\033[0m %s\n' "$*"; }

while [[ $# -gt 0 ]]; do
    case "$1" in
        --framework) FRAMEWORK="${2:?--framework needs a path}"; shift 2 ;;
        --embed-dir) EMBED_DIR="${2:?--embed-dir needs a name}"; shift 2 ;;
        --no-prune)  PRUNE=0; shift ;;
        -h|--help)   sed -n '2,26p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
        -*)          die "unknown argument: $1" ;;
        *)           [[ -z "${BUNDLE}" ]] || die "only one bundle may be given"
                     BUNDLE="$1"; shift ;;
    esac
done

[[ "$(uname -s)" == "Darwin" ]] || die "this script only runs on macOS"
[[ -n "${BUNDLE}" ]] || die "no bundle given; usage: $(basename "$0") <path/to/Hadron.vst>"
[[ -d "${BUNDLE}" ]] || die "bundle not found: ${BUNDLE}"
[[ -d "${BUNDLE}/Contents/MacOS" ]] || die "not a plugin bundle (no Contents/MacOS): ${BUNDLE}"
[[ -d "${FRAMEWORK}" ]] || die "framework not found: ${FRAMEWORK}
Run fetch-csound-framework.sh and relink-csound-framework.sh first."

DEST_DIR="${BUNDLE}/Contents/${EMBED_DIR}"
DEST="${DEST_DIR}/$(basename "${FRAMEWORK}")"

info "Embedding into $(basename "${BUNDLE}")"
printf '    from  %s\n' "${FRAMEWORK}"
printf '    to    Contents/%s/\n' "${EMBED_DIR}"

# --- copy -------------------------------------------------------------------

# ditto, not `cmake -E copy_directory`: the latter follows symlinks, which
# would replace the framework's Versions/Current indirection with three full
# copies of its contents and produce a bundle codesign rejects.
rm -rf "${DEST}"
mkdir -p "${DEST_DIR}"
ditto "${FRAMEWORK}" "${DEST}" || die "failed to copy the framework into the bundle"

# --- prune ------------------------------------------------------------------

if [[ "${PRUNE}" == "1" ]]; then
    for rel in "${PRUNE_PATHS[@]}"; do
        target="${DEST}/${rel}"
        # -e is false for a dangling symlink, so test -L as well
        if [[ -e "${target}" || -L "${target}" ]]; then
            rm -rf "${target}"
        else
            printf '\033[33mwarning:\033[0m prune target not present: %s\n' "${rel}" >&2
        fi
    done

    # Removing sealed files invalidates the signature ditto just copied.
    codesign --force --sign - "${DEST}/Versions/6.0" >/dev/null 2>&1 \
        || die "failed to re-sign the pruned framework"
fi

# --- verify -----------------------------------------------------------------

info "Verifying"
fail=0

[[ -f "${DEST}/Versions/6.0/CsoundLib64" ]] \
    && ok "CsoundLib64 present" \
    || { bad "CsoundLib64 missing from the embedded framework"; fail=1; }

[[ -f "${DEST}/Versions/6.0/libs/libsndfile.1.dylib" ]] \
    && ok "libs/ travelled with the framework" \
    || { bad "libs/libsndfile.1.dylib missing"; fail=1; }

# Every framework root entry must still be a symlink; a dereferenced copy here
# is the classic way an embedded framework silently becomes invalid.
for link in CsoundLib64 Resources libs; do
    [[ -L "${DEST}/${link}" ]] \
        && ok "${link} is a symlink" \
        || { bad "${link} is not a symlink"; fail=1; }
done

# A pruned entry leaving a dangling symlink behind fails codesign later with a
# message that does not name the symlink, so check for it directly.
dangling="$(find "${DEST}" -type l ! -exec test -e {} \; -print 2>/dev/null || true)"
if [[ -z "${dangling}" ]]; then
    ok "no dangling symlinks"
else
    bad "dangling symlinks in the embedded framework:"
    printf '         %s\n' ${dangling}
    fail=1
fi

if codesign --verify --deep --strict "${DEST}" 2>/dev/null; then
    ok "signature valid: embedded framework (deep, strict)"
else
    bad "embedded framework fails deep strict verification:"
    codesign --verify --deep --strict "${DEST}" 2>&1 | sed 's/^/         /'
    fail=1
fi

# The point of the whole exercise: the plugin binary's reference to the
# framework must resolve inside the bundle, with nothing left pointing at a
# system-wide Csound install.
EXE="$(find "${BUNDLE}/Contents/MacOS" -maxdepth 1 -type f -perm -u+x | head -1)"
if [[ -z "${EXE}" ]]; then
    bad "no executable found in Contents/MacOS"
    fail=1
else
    dep="$(otool -L "${EXE}" | awk '/^\t/ {print $1}' | grep -m1 'CsoundLib64$' || true)"
    if [[ -z "${dep}" ]]; then
        bad "$(basename "${EXE}") does not link CsoundLib64 at all"
        fail=1
    elif [[ "${dep}" != @loader_path/* ]]; then
        bad "$(basename "${EXE}") loads CsoundLib64 from ${dep}"
        fail=1
    else
        resolved="${BUNDLE}/Contents/MacOS/${dep#@loader_path/}"
        if [[ -f "${resolved}" ]]; then
            ok "$(basename "${EXE}") -> ${dep} resolves inside the bundle"
        else
            bad "$(basename "${EXE}") -> ${dep} does not resolve (expected ${resolved})"
            fail=1
        fi
    fi

    if otool -L "${EXE}" | grep -q '/Library/Frameworks/CsoundLib64'; then
        bad "$(basename "${EXE}") still references /Library/Frameworks/CsoundLib64"
        fail=1
    else
        ok "no dependency on a system-wide Csound install"
    fi
fi

[[ "${fail}" == "0" ]] || die "the embedded framework is not usable"

info "Done. Embedded $(du -sh "${DEST}" | cut -f1 | tr -d ' ') at Contents/${EMBED_DIR}/"
