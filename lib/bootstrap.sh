#!/usr/bin/env bash
set -euo pipefail

[[ -n "${BOOTSTRAP_SH_INCLUDED:-}" ]] && return
BOOTSTRAP_SH_INCLUDED=1

# -------------------------
# Calculate the dotfiles root if not already set
# -------------------------
: "${DOTFILES_ROOT:=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd)}"
export DOTFILES_ROOT
