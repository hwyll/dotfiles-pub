---

# dotfiles

This repository contains dotfiles for macOS.
It uses **stow** to manage dotfiles,
**brew** to install packages,
**git** to install Oh My Zsh and plugins,
and `setup.sh` to install or uninstall the configurations.

---

## Table of Contents

* [Requirements](#requirements)
* [Quick Start](#quick-start)
* [Project Structure](#project-structure)
* [Installation](#installation)
* [Uninstallation](#uninstallation)
* [Adding Packages](#adding-packages)
* [Adding Zsh Plugins](#adding-zsh-plugins)
* [Adding Dotfiles](#adding-dotfiles)
* [Adding OS Support](#adding-os-support)

---

## Requirements

* bash (v3.2)

---

## Quick Start

### Installing With Git
Clone the repo and install everything:

```bash
git clone https://github.com/hwyll/dotfiles.git ./dotfiles
bash ./dotfiles/setup.sh --install
```

### Installing Without Git

If `git` is not available, 
1. Download the repository as a zip.
2. Unzip folder, rename as `dotfiles`, and place where you want it to live.
3. Install using setup.sh

```bash
bash ./dotfiles/setup.sh --install
```

4. Remove the folder.
5. After install, clone the repo to the same location.

```bash
git clone https://github.com/hwyll/dotfiles.git ./dotfiles
```

---

## Project Structure

```
.
├── setup.sh             # Main installer/uninstaller script
├── lib/                 # Helper scripts (brew, zsh, stow, utils)
├── packages/            # Package lists (common.txt, macos.txt, zsh-plugins.txt)
├── config/              # Dotfiles organized by package/folder
└── README.md
```

---

## Installation

```bash
./setup.sh --install
```

This will:

1. Install Homebrew
2. Install all packages from `packages/common.txt` and `packages/macos.txt`
3. Symlink all dotfiles from `config/` into `$HOME` using GNU Stow
4. Install oh-my-zsh and configured zsh plugins

---

## Uninstallation

```bash
./setup.sh --uninstall
```

This will:

1. Remove all symlinks created by Stow
2. Uninstall all packages listed in `packages/*.txt`
3. Remove zsh plugins
4. Uninstall oh-my-zsh

---

## Adding Packages

1. Open the appropriate package list file in `packages/`:

   * `packages/common.txt` → packages for all systems
   * `packages/macos.txt` → packages specific to macOS

2. Add your package on a new line, e.g.:

```
htop
neovim
```

3. Save the file. The next time you run:

```bash
./setup.sh --install
```

the new package(s) will be installed automatically.

---

## Adding Zsh Plugins

1. Open `packages/zsh-plugins.txt`.
2. Add a new plugin in the format:

```
<git_url> <plugin_name>
```

Example:

```
https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions
```

3. Save the file. Plugins will be installed into `$ZSH_CUSTOM/plugins` automatically.

---

## Adding Dotfiles

1. Place a new folder under `config/` with the name of the application or package (e.g., `myapp/`).
2. Add your dotfiles inside the folder, preserving any folder structure. Example:

```
config/
└── myapp/
    └── .myapprc
```

3. The folder name becomes the **Stow package name**, and files will be symlinked into `$HOME` when you run:

```bash
./setup.sh --install
```

---

## Adding OS Support

To extend the setup for a new os (e.g., Linux):

1. **Add a package list**

   * Create a new file under `packages/`, e.g., `packages/linux.txt`.
   * List all OS-specific packages in that file, one per line.

2. **Update the package manager abstraction (`lib/pkgmgr.sh`)**

   * Determine the installed package manager (e.g., `apt`, `pacman`, `dnf`).
   * Add install/uninstall logic for that manager in `pkg_install` and `pkg_uninstall`.
   * Consider mapping package name from common.txt in package manager if names differ.

3. **Update `setup.sh`**

   * Use `uname` or `/etc/os-release` to detect the OS.
   * Load the new OS’s package list in addition to `common.txt`.

**Example in `setup.sh`:**

```bash
OS_TYPE=$(uname | tr '[:upper:]' '[:lower:]')
case "$OS_TYPE" in
    darwin) OS_PACKAGES="$(read_list "$PACKAGES_DIR/macos.txt")" ;;
    linux) OS_PACKAGES="$(read_list "$PACKAGES_DIR/linux.txt")" ;;
    *) warn "Unknown OS: $OS_TYPE" ;;
esac
```

---
