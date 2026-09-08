#!/usr/bin/env bash
#
# Fetch the official Csound 6.18.1 universal CsoundLib64.framework for macOS.
#
# Csound 6.18.1 is the final release of the Csound 6 series, so this pin is
# expected to be stable indefinitely. The framework is NOT committed to this
# repo (see .gitignore and issue #2); this script reproduces it on demand.
#
# The upstream asset is an installer .dmg containing a .pkg, so the sequence is:
#   download -> verify sha256 -> mount dmg -> expand pkg -> extract payload
#   -> strip unused parts -> place at Csound_framework/6_18/
#
# Usage:
#   ./fetch-csound-framework.sh            # fetch if not already present
#   ./fetch-csound-framework.sh --force    # re-extract even if present
#   ./fetch-csound-framework.sh --clean    # remove framework and download cache
#
# This script only fetches and strips. Re-linking install names for embedding
# into the plugin bundle is a separate step.

set -euo pipefail

CSOUND_VERSION="6.18.1"
DMG_NAME="Csound-MacOS-universal-${CSOUND_VERSION}.dmg"
DMG_URL="https://github.com/csound/csound/releases/download/${CSOUND_VERSION}/${DMG_NAME}"

# SHA256 of the upstream release asset. GitHub records no digest for an asset
# this old, so this was computed locally on first download and pinned here. It
# guards against a corrupted download or a silently replaced asset.
DMG_SHA256="f103680851876f82988886fe6bc062450b87d3dcf647805d7b1a7228a3e868b9"
DMG_SIZE_BYTES=47780410

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMEWORK_ROOT="${SCRIPT_DIR}/Csound_framework"
DEST_DIR="${FRAMEWORK_ROOT}/6_18"
DEST_FRAMEWORK="${DEST_DIR}/CsoundLib64.framework"
CACHE_DIR="${FRAMEWORK_ROOT}/.download-cache"

# ---------------------------------------------------------------------------
# What gets stripped from the extracted framework.
#
# The full framework is ~94 MB; this brings it to ~19.5 MB. Paths are relative
# to CsoundLib64.framework/.
#
# Deliberately KEPT:
#   Versions/6.0/Resources/Info.plist  - required to codesign/notarise the
#                                        embedded framework
#   Versions/6.0/Resources/Opcodes64   - the plugin opcode directory, kept even
#                                        when its contents are stripped; see
#                                        STRIP_OPCODES below
#   Versions/6.0/Headers               - CMake uses this as the include dir
#   libs/                              - CsoundLib64 hard-links
#                                        @loader_path/../../libs/libsndfile.1.dylib
# ---------------------------------------------------------------------------
STRIP_PATHS=(
    "Versions/6.0/Resources/Manual"     # 58 MB of HTML documentation
    "Versions/6.0/Resources/Java"       # 736 KB JNI bindings
    "Versions/6.0/Resources/Python"     # 124 KB Python bindings
    "Versions/6.0/samples"              # 5.4 MB of example audio
    "libCsoundLib64.a"                  # 8.0 MB static lib, build-time only
    "libcsnd6.a"                        # 548 KB static lib, build-time only
)

# Hadron's orchestra uses no plugin opcodes, so the contents of Opcodes64 and
# the four dylibs only they reference are dropped by default (~7 MB). Set this
# to 0 to keep them if Hadron ever starts using a plugin opcode.
#
# The Opcodes64 directory itself is kept either way, empty when stripping. The
# plugin points OPCODE6DIR64 at it (see VST-AU/src/CSoundInterface.cpp), and an
# empty directory is what makes that setting do its job: Csound scans it, finds
# nothing, and says nothing. Delete the directory instead and Csound warns on
# every load; leave OPCODE6DIR64 unset instead and Csound falls back to its
# compiled-in default, /Library/Frameworks/CsoundLib64.framework, loading a
# separately installed Csound's plugin opcodes into the plugin's process.
STRIP_OPCODES=1
if [[ "${STRIP_OPCODES}" == "1" ]]; then
    STRIP_PATHS+=(
        "libs/liblo.7.dylib"
        "libs/libportaudio.2.dylib"
        "libs/libportmidi.dylib"
        "libs/libsamplerate.0.dylib"
    )
fi

# ---------------------------------------------------------------------------

MOUNT_POINT=""
WORK_DIR=""

cleanup() {
    if [[ -n "${MOUNT_POINT}" && -d "${MOUNT_POINT}" ]]; then
        hdiutil detach "${MOUNT_POINT}" -quiet 2>/dev/null || \
            hdiutil detach "${MOUNT_POINT}" -force -quiet 2>/dev/null || true
    fi
    [[ -n "${WORK_DIR}" && -d "${WORK_DIR}" ]] && rm -rf "${WORK_DIR}"
    return 0
}
trap cleanup EXIT

info() { printf '\033[1m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[33mwarning:\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[31merror:\033[0m %s\n' "$*" >&2; exit 1; }

FORCE=0
for arg in "$@"; do
    case "${arg}" in
        --force) FORCE=1 ;;
        --clean)
            info "Removing ${DEST_DIR} and ${CACHE_DIR}"
            rm -rf "${DEST_DIR}" "${CACHE_DIR}"
            exit 0
            ;;
        -h|--help) sed -n '2,25p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *) die "unknown argument: ${arg}" ;;
    esac
done

[[ "$(uname -s)" == "Darwin" ]] || die "this script only runs on macOS"

if [[ -d "${DEST_FRAMEWORK}" && "${FORCE}" != "1" ]]; then
    info "Framework already present at ${DEST_FRAMEWORK}"
    info "Use --force to re-extract, or --clean to remove it."
    exit 0
fi

# --- download (cached) ------------------------------------------------------

mkdir -p "${CACHE_DIR}"
DMG_PATH="${CACHE_DIR}/${DMG_NAME}"

verify_dmg() {
    [[ -f "${DMG_PATH}" ]] || return 1
    local actual
    actual="$(shasum -a 256 "${DMG_PATH}" | cut -d' ' -f1)"
    [[ "${actual}" == "${DMG_SHA256}" ]]
}

if verify_dmg; then
    info "Using cached ${DMG_NAME} (checksum verified)"
else
    [[ -f "${DMG_PATH}" ]] && warn "cached dmg failed checksum, re-downloading"
    info "Downloading ${DMG_NAME} ($(( DMG_SIZE_BYTES / 1024 / 1024 )) MB)"
    info "  from ${DMG_URL}"
    curl -fL --progress-bar -o "${DMG_PATH}.partial" "${DMG_URL}" \
        || die "download failed"
    mv "${DMG_PATH}.partial" "${DMG_PATH}"
    verify_dmg || die "checksum mismatch on ${DMG_NAME}
  expected ${DMG_SHA256}
  actual   $(shasum -a 256 "${DMG_PATH}" | cut -d' ' -f1)
The upstream asset may have been replaced. Do not use it without checking."
    info "Checksum verified"
fi

# --- mount, expand, extract -------------------------------------------------

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/csound-fetch.XXXXXX")"
MOUNT_POINT="${WORK_DIR}/mnt"
mkdir -p "${MOUNT_POINT}"

info "Mounting disk image"
hdiutil attach -nobrowse -readonly -noverify -quiet \
    -mountpoint "${MOUNT_POINT}" "${DMG_PATH}" || die "failed to mount ${DMG_NAME}"

PKG_PATH="${MOUNT_POINT}/csound-MacOS-universal-${CSOUND_VERSION}.pkg"
[[ -f "${PKG_PATH}" ]] || die "expected installer not found: ${PKG_PATH}"

info "Expanding installer package"
pkgutil --expand "${PKG_PATH}" "${WORK_DIR}/pkg" || die "pkgutil --expand failed"

# The installer ships two sub-packages; CsoundLib64.pkg holds the framework,
# CsoundApps64.pkg holds command line tools we do not need.
PAYLOAD="${WORK_DIR}/pkg/CsoundLib64.pkg/Payload"
[[ -f "${PAYLOAD}" ]] || die "CsoundLib64 payload not found in installer"

info "Extracting framework payload"
mkdir -p "${WORK_DIR}/payload"
tar -xf "${PAYLOAD}" -C "${WORK_DIR}/payload" \
    || die "failed to extract payload (gzip cpio archive)"

EXTRACTED="${WORK_DIR}/payload/Library/Frameworks/CsoundLib64.framework"
[[ -d "${EXTRACTED}" ]] || die "CsoundLib64.framework not found in payload"

# --- strip ------------------------------------------------------------------

info "Stripping unused components"
for rel in "${STRIP_PATHS[@]}"; do
    target="${EXTRACTED}/${rel}"
    if [[ -e "${target}" ]]; then
        size="$(du -sh "${target}" 2>/dev/null | cut -f1 | tr -d ' ')"
        rm -rf "${target}"
        printf '    removed %-40s %s\n' "${rel}" "${size}"
    else
        warn "strip target not present (upstream layout changed?): ${rel}"
    fi
done

# Emptied rather than removed, so that OPCODE6DIR64 has an existing directory
# to point at. See the STRIP_OPCODES comment above.
if [[ "${STRIP_OPCODES}" == "1" ]]; then
    opcodes="${EXTRACTED}/Versions/6.0/Resources/Opcodes64"
    if [[ -d "${opcodes}" ]]; then
        size="$(du -sh "${opcodes}" 2>/dev/null | cut -f1 | tr -d ' ')"
        rm -rf "${opcodes}"
        mkdir -p "${opcodes}"
        printf '    emptied %-40s %s\n' "Versions/6.0/Resources/Opcodes64" "${size}"
    else
        warn "strip target not present (upstream layout changed?): Versions/6.0/Resources/Opcodes64"
    fi
fi

# --- normalise framework layout ---------------------------------------------

# Csound ships libs/ at the framework root. Apple requires a versioned
# framework to contain nothing but symlinks and Versions/ at its root, so
# codesign --strict rejects the framework as shipped:
#     "unsealed contents present in the root directory of an embedded framework"
# which would fail notarisation once embedded in the plugin.
#
# Moving libs/ under Versions/6.0/ and leaving a root symlink fixes this
# without breaking anything: the binaries reference
# @loader_path/../../libs/libsndfile.1.dylib, which from Versions/6.0/ resolves
# to <framework>/libs -> Versions/Current/libs, i.e. the new location.
if [[ -d "${EXTRACTED}/libs" && ! -L "${EXTRACTED}/libs" ]]; then
    info "Normalising framework layout (moving libs/ under Versions/6.0)"
    mv "${EXTRACTED}/libs" "${EXTRACTED}/Versions/6.0/libs"
    ln -s "Versions/Current/libs" "${EXTRACTED}/libs"
fi

# --- install into the repo --------------------------------------------------

info "Installing to ${DEST_DIR}"
rm -rf "${DEST_DIR}"
mkdir -p "${DEST_DIR}"
# ditto preserves symlinks, permissions and the framework's Versions structure
ditto "${EXTRACTED}" "${DEST_FRAMEWORK}" || die "failed to copy framework"

# Files off a downloaded disk image carry a quarantine flag that can make the
# loader refuse the framework at runtime.
xattr -dr com.apple.quarantine "${DEST_FRAMEWORK}" 2>/dev/null || true
find "${DEST_DIR}" -name '.DS_Store' -delete 2>/dev/null || true

# --- verify -----------------------------------------------------------------

info "Verifying result"
fail=0
check() {
    if [[ -e "$2" ]]; then
        printf '    \033[32mok\033[0m   %s\n' "$1"
    else
        printf '    \033[31mFAIL\033[0m %s\n' "$1"
        fail=1
    fi
}

check "Versions/6.0/CsoundLib64"          "${DEST_FRAMEWORK}/Versions/6.0/CsoundLib64"
check "Versions/6.0/libcsnd6.6.0.dylib"   "${DEST_FRAMEWORK}/Versions/6.0/libcsnd6.6.0.dylib"
check "Versions/6.0/Headers/csound.h"     "${DEST_FRAMEWORK}/Versions/6.0/Headers/csound.h"
check "Versions/6.0/Resources/Info.plist" "${DEST_FRAMEWORK}/Versions/6.0/Resources/Info.plist"
check "libs/libsndfile.1.dylib"           "${DEST_FRAMEWORK}/libs/libsndfile.1.dylib"
check "Versions/6.0/libs/"                "${DEST_FRAMEWORK}/Versions/6.0/libs"
check "Versions/Current -> 6.0 symlink"   "${DEST_FRAMEWORK}/Versions/Current"
check "Versions/6.0/Resources/Opcodes64"  "${DEST_FRAMEWORK}/Versions/6.0/Resources/Opcodes64"
if [[ "${STRIP_OPCODES}" == "1" ]]; then
    if [[ -z "$(ls -A "${DEST_FRAMEWORK}/Versions/6.0/Resources/Opcodes64" 2>/dev/null)" ]]; then
        printf '    \033[32mok\033[0m   %s\n' "Versions/6.0/Resources/Opcodes64 is empty"
    else
        printf '    \033[31mFAIL\033[0m %s\n' "Versions/6.0/Resources/Opcodes64 is not empty"
        fail=1
    fi
fi

# The top level entries must be symlinks, not copies, or the bundle is invalid.
for link in CsoundLib64 Headers Resources libs; do
    if [[ -L "${DEST_FRAMEWORK}/${link}" ]]; then
        printf '    \033[32mok\033[0m   %s is a symlink -> %s\n' \
            "${link}" "$(readlink "${DEST_FRAMEWORK}/${link}")"
    else
        printf '    \033[31mFAIL\033[0m %s is not a symlink\n' "${link}"
        fail=1
    fi
done

archs="$(lipo -archs "${DEST_FRAMEWORK}/Versions/6.0/CsoundLib64" 2>/dev/null || echo "?")"
if [[ "${archs}" == *x86_64* && "${archs}" == *arm64* ]]; then
    printf '    \033[32mok\033[0m   universal binary (%s)\n' "${archs}"
else
    printf '    \033[31mFAIL\033[0m not universal (got: %s)\n' "${archs}"
    fail=1
fi

[[ "${fail}" == "0" ]] || die "verification failed; the framework is not usable"

info "Done. Csound ${CSOUND_VERSION} framework at ${DEST_FRAMEWORK} ($(du -sh "${DEST_DIR}" | cut -f1))"
