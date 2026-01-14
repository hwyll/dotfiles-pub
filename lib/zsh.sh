#!/usr/bin/env bash
set -euo pipefail

[[ -n "${ZSH_SH_INCLUDED:-}" ]] && return
ZSH_SH_INCLUDED=1

source "$DOTFILES_ROOT/lib/bootstrap.sh"
source "$DOTFILES_ROOT/lib/log.sh"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
ZSH_DIR="$HOME/.oh-my-zsh"

# -------------------------
# Installs oh-my-zsh
# Usage: install_oh_my_zsh
# -------------------------
install_oh_my_zsh() {
  if [[ -d "$ZSH_DIR" ]]; then
    warn "oh-my-zsh already installed, skipping"
    return
  fi

  info "Installing oh-my-zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# -------------------------
# Install multiple zsh plugins using git clone
# Usage: install_zsh_plugins <space-separated array of "git_url|plugin_name">
# -------------------------
install_zsh_plugins() {
  local plugins=("$@")
  for plugin in "${plugins[@]}"; do
    local url="${plugin%%|*}"
    local name="${plugin##*|}"
    install_zsh_plugin "$url" "$name"
  done
}

# -------------------------
# Installs a zsh plugin using git clone
# Usage: install_zsh_plugin <git_url> <plugin_name>
# -------------------------
install_zsh_plugin() {
  local repo_url="$1"
  local plugin_name="$2"
  local dest="$ZSH_CUSTOM/plugins/$plugin_name"

  if [[ -d "$dest" ]]; then
    warn "Zsh plugin $plugin_name already installed, skipping"
  else
    info "Installing zsh plugin $plugin_name..."
    git clone "$repo_url" "$dest"
  fi
}

# -------------------------
# Uninstalls zsh plugins
# Usage: uninstall_zsh_plugins
# -------------------------
uninstall_zsh_plugins() {
  local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
  for dir in "$plugin_dir"/*/; do
    [[ -d "$dir" ]] || continue
    info "Removing zsh plugin $(basename "$dir")..."
    rm -rf "$dir"
  done
}

# -------------------------
# Uninstalls oh-my-zsh
# Usage: uninstall_oh_my_zsh
# -------------------------
uninstall_oh_my_zsh() {
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    info "Removing oh-my-zsh..."
    rm -rf "$HOME/.oh-my-zsh"
  else
    warn "oh-my-zsh not found, skipping."
  fi
}
