#!/usr/bin/env bash
#
# Rewrite the install names of the vendored CsoundLib64.framework so it can be
# embedded inside the Hadron plugin bundle instead of being loaded from
# /Library/Frameworks.
#
# As shipped, the framework declares itself as
#     /Library/Frameworks/CsoundLib64.framework/CsoundLib64
# which makes the plugin depend on Csound being installed system-wide. This
# rewrites that to a path relative to whatever binary loads it:
#     @loader_path/../Frameworks/CsoundLib64.framework/Versions/6.0/CsoundLib64
# i.e. Contents/Frameworks/ inside the .vst / .component bundle, given the
# plugin binary sits in Contents/MacOS/.
#
# This must run BEFORE the plugin is linked: the framework's LC_ID_DYLIB is
# baked into the plugin binary at link time, so relinking afterwards is too
# late. Run it right after fetch-csound-framework.sh.
#
# The framework's own libs/ references are already framework-relative
# (@loader_path/../../libs/...) and are deliberately left alone.
#
# install_name_tool invalidates the ad-hoc signature the linker applied. An
# invalid signature is fatal on Apple Silicon, so every modified binary is
# re-signed ad-hoc afterwards.
#
# Usage:
#   ./relink-csound-framework.sh
#   ./relink-csound-framework.sh --framework /path/to/CsoundLib64.framework
#   ./relink-csound-framework.sh --embed-path ../Resources
#   ./relink-csound-framework.sh --check      # report only, change nothing

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

FRAMEWORK="${SCRIPT_DIR}/Csound_framework/6_18/CsoundLib64.framework"

# Where the framework will live inside the plugin bundle, relative to the
# loading binary (Contents/MacOS/Hadron). Contents/Frameworks is Apple's
# documented location for embedded frameworks, and the one the Csound 5 era
# scripts used: the framework copy in
# installer/DSP_installer/OSX/scripts/osx-universal-hadron-prepare-bundle.sh,
# and hadron-relink-csound5-framework.sh, deleted in this commit but in git
# history if the precedent is ever wanted.
# Nested code under Contents/Resources loads, but is the kind of layout
# notarisation objects to.
EMBED_PATH="../Frameworks"

CHECK_ONLY=0

info() { printf '\033[1m==>\033[0m %s\n' "$*"; }
die()  { printf '\033[31merror:\033[0m %s\n' "$*" >&2; exit 1; }
ok()   { printf '    \033[32mok\033[0m   %s\n' "$*"; }
bad()  { printf '    \033[31mFAIL\033[0m %s\n' "$*"; }

while [[ $# -gt 0 ]]; do
    case "$1" in
        --framework)  FRAMEWORK="${2:?--framework needs a path}"; shift 2 ;;
        --embed-path) EMBED_PATH="${2:?--embed-path needs a path}"; shift 2 ;;
        --check)      CHECK_ONLY=1; shift ;;
        -h|--help)    sed -n '2,30p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *)            die "unknown argument: $1" ;;
    esac
done

[[ "$(uname -s)" == "Darwin" ]] || die "this script only runs on macOS"
[[ -d "${FRAMEWORK}" ]] || die "framework not found: ${FRAMEWORK}
Run fetch-csound-framework.sh first."

CSOUND_LIB="${FRAMEWORK}/Versions/6.0/CsoundLib64"
CSND6_LIB="${FRAMEWORK}/Versions/6.0/libcsnd6.6.0.dylib"

[[ -f "${CSOUND_LIB}" ]] || die "missing ${CSOUND_LIB}"
[[ -f "${CSND6_LIB}"  ]] || die "missing ${CSND6_LIB}"

# Target install names, as seen from the binary that loads the framework.
BUNDLE_REL="${EMBED_PATH}/CsoundLib64.framework/Versions/6.0"
WANT_CSOUND_ID="@loader_path/${BUNDLE_REL}/CsoundLib64"
WANT_CSND6_ID="@loader_path/${BUNDLE_REL}/libcsnd6.6.0.dylib"

# libcsnd6 sits next to CsoundLib64 inside the framework, so its reference to
# CsoundLib64 is resolved relative to itself, not to the plugin binary.
WANT_CSND6_DEP_ON_CSOUND="@loader_path/CsoundLib64"

current_id() { otool -D "$1" | sed -n '2p'; }

# otool -L prints an untabbed header line per architecture; only the tab
# indented lines are actual dependencies. The header contains the file path,
# which itself contains "CsoundLib64", so it must be filtered out.
dep_on_csoundlib() {
    otool -L "$1" | awk '/^\t/ {print $1}' | grep -m1 'CsoundLib64$' || echo '(none)'
}

# --- report current state ---------------------------------------------------

info "Framework: ${FRAMEWORK}"
info "Embedding at: Contents/${EMBED_PATH#../}/CsoundLib64.framework"
echo
info "Current install names"
printf '    CsoundLib64 id        %s\n' "$(current_id "${CSOUND_LIB}")"
printf '    libcsnd6 id           %s\n' "$(current_id "${CSND6_LIB}")"
printf '    libcsnd6 -> CsoundLib %s\n' \
    "$(dep_on_csoundlib "${CSND6_LIB}")"

if [[ "${CHECK_ONLY}" == "1" ]]; then
    echo
    info "Wanted install names"
    printf '    CsoundLib64 id        %s\n' "${WANT_CSOUND_ID}"
    printf '    libcsnd6 id           %s\n' "${WANT_CSND6_ID}"
    printf '    libcsnd6 -> CsoundLib %s\n' "${WANT_CSND6_DEP_ON_CSOUND}"
    exit 0
fi

# --- rewrite ----------------------------------------------------------------

echo
info "Rewriting install names"

CUR_CSOUND_ID="$(current_id "${CSOUND_LIB}")"

install_name_tool -id "${WANT_CSOUND_ID}" "${CSOUND_LIB}"
printf '    CsoundLib64 id -> %s\n' "${WANT_CSOUND_ID}"

install_name_tool -id "${WANT_CSND6_ID}" "${CSND6_LIB}"
printf '    libcsnd6 id    -> %s\n' "${WANT_CSND6_ID}"

# Point libcsnd6 at its sibling. Rewrite both the original absolute path and
# the id we may have written on a previous run, so this is safe to re-run.
for old in "${CUR_CSOUND_ID}" \
           "/Library/Frameworks/CsoundLib64.framework/Versions/6.0/CsoundLib64" \
           "/Library/Frameworks/CsoundLib64.framework/CsoundLib64" \
           "${WANT_CSOUND_ID}"; do
    [[ "${old}" == "${WANT_CSND6_DEP_ON_CSOUND}" ]] && continue
    install_name_tool -change "${old}" "${WANT_CSND6_DEP_ON_CSOUND}" "${CSND6_LIB}" 2>/dev/null || true
done
printf '    libcsnd6 -> CsoundLib64 -> %s\n' "${WANT_CSND6_DEP_ON_CSOUND}"

# --- re-sign ----------------------------------------------------------------

# install_name_tool leaves the ad-hoc signature invalid. dyld on Apple Silicon
# refuses to load a binary whose signature does not verify, so re-sign both.
echo
info "Re-signing (ad-hoc) after modification"

# Nested code must be signed before the bundle that contains it: codesign
# resolves Versions/6.0/CsoundLib64 to the framework bundle and refuses to sign
# it while a nested dylib is unsigned. So libcsnd6 first, framework second.
codesign --force --sign - "${CSND6_LIB}" >/dev/null 2>&1 \
    || die "failed to re-sign $(basename "${CSND6_LIB}")"
printf '    signed %s\n' "$(basename "${CSND6_LIB}")"

codesign --force --sign - "${FRAMEWORK}/Versions/6.0" >/dev/null 2>&1 \
    || die "failed to re-sign the CsoundLib64.framework bundle"
printf '    signed %s\n' "CsoundLib64.framework (bundle)"

# --- verify -----------------------------------------------------------------

echo
info "Verifying"
fail=0

got="$(current_id "${CSOUND_LIB}")"
if [[ "${got}" == "${WANT_CSOUND_ID}" ]]; then ok "CsoundLib64 id"; else bad "CsoundLib64 id is ${got}"; fail=1; fi

got="$(current_id "${CSND6_LIB}")"
if [[ "${got}" == "${WANT_CSND6_ID}" ]]; then ok "libcsnd6 id"; else bad "libcsnd6 id is ${got}"; fail=1; fi

got="$(dep_on_csoundlib "${CSND6_LIB}")"
if [[ "${got}" == "${WANT_CSND6_DEP_ON_CSOUND}" ]]; then ok "libcsnd6 -> CsoundLib64"; else bad "libcsnd6 -> CsoundLib64 is ${got}"; fail=1; fi

# Nothing may still point into /Library/Frameworks, or the plugin would depend
# on a system-wide Csound install.
if otool -L "${CSOUND_LIB}" "${CSND6_LIB}" | grep -q '/Library/Frameworks/CsoundLib64'; then
    bad "a reference to /Library/Frameworks/CsoundLib64 remains"
    otool -L "${CSOUND_LIB}" "${CSND6_LIB}" | grep '/Library/Frameworks/CsoundLib64' | sed 's/^/         /'
    fail=1
else
    ok "no references to /Library/Frameworks remain"
fi

# libs/ must stay framework-relative so it travels with the framework.
if otool -L "${CSOUND_LIB}" | grep -q '@loader_path/../../libs/libsndfile.1.dylib'; then
    ok "libs/ references still framework-relative"
else
    bad "libsndfile reference is not @loader_path/../../libs/libsndfile.1.dylib"
    fail=1
fi

if codesign --verify --strict "${CSND6_LIB}" 2>/dev/null; then
    ok "signature valid: libcsnd6.6.0.dylib"
else
    bad "signature invalid: libcsnd6.6.0.dylib (would fail to load on Apple Silicon)"
    fail=1
fi

# --deep --strict is effectively what notarisation applies. This is what
# catches a malformed framework layout, not just a bad signature.
if codesign --verify --deep --strict "${FRAMEWORK}" 2>/dev/null; then
    ok "signature valid: CsoundLib64.framework (deep, strict)"
else
    bad "framework fails deep strict verification:"
    codesign --verify --deep --strict "${FRAMEWORK}" 2>&1 | sed 's/^/         /'
    fail=1
fi

for arch in x86_64 arm64; do
    if lipo -archs "${CSOUND_LIB}" | grep -q "${arch}"; then
        ok "still universal: ${arch}"
    else
        bad "lost architecture ${arch}"
        fail=1
    fi
done

[[ "${fail}" == "0" ]] || die "verification failed; do not build against this framework"

echo
info "Done. Framework is ready to embed at Contents/${EMBED_PATH#../}/"
