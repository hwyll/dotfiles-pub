#!/usr/bin/env bash
set -euo pipefail

[[ -n "${UTIL_SH_INCLUDED:-}" ]] && return
UTIL_SH_INCLUDED=1

# -------------------------
# Read a file into an array (ignoring empty lines and comments)
# Returns a space-separated string
# -------------------------
read_list() {
  local file="$1"
  [[ -f "$file" ]] || return 0
  local arr=()
  while read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    arr+=("$line")
  done <"$file"
  echo "${arr[@]}"
}

# -------------------------
# Read zsh plugins from file into an array
# Expected format per line in file: <git_url> <plugin_name>
# Returns space-separated strings of "url|name"
# -------------------------
read_zsh_plugins() {
  local file="$1"
  [[ -f "$file" ]] || return 0
  local arr=()
  while read -r url name; do
    [[ -z "$url" || -z "$name" || "$url" == \#* ]] && continue
    arr+=("$url|$name")
  done <"$file"
  echo "${arr[@]}"
}

# -------------------------
# Deduplicate array passed as space-separated string
# Returns deduplicated space-separated string
# -------------------------
deduplicate_array() {
  local input="$*"
  echo $(printf "%s\n" $input | sort -u)
}
