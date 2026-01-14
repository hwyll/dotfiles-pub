#!/usr/bin/env bash
set -euo pipefail

[[ -n "${LOG_SH_INCLUDED:-}" ]] && return
LOG_SH_INCLUDED=1

# -------------------------
# Basic log function
# -------------------------
log() {
  local level="$1"
  local message="$2"
  local ts
  ts=$(date "+%Y-%m-%d %H:%M:%S")
  echo "[$ts] [$level] $message"
}

# -------------------------
# Levels
# -------------------------
info() { log "INFO" "$1"; }
warn() { log "WARN" "$1"; }
error() { log "ERROR" "$1"; }

# -------------------------
# Colored output if terminal
# -------------------------
if [ -t 1 ]; then
  info() { echo -e "\033[1;34m[INFO]\033[0m  $(date '+%Y-%m-%d %H:%M:%S') $1"; }
  warn() { echo -e "\033[1;33m[WARN]\033[0m  $(date '+%Y-%m-%d %H:%M:%S') $1"; }
  error() { echo -e "\033[1;31m[ERROR]\033[0m $(date '+%Y-%m-%d %H:%M:%S') $1"; }
fi
