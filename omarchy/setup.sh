#!/bin/bash
# ==============================================
# Omarchy Developer Setup
# Run: chmod +x setup.sh && ./setup.sh
# ==============================================
#
# Omarchy ships most of the terminal toolset already. bat, btop, eza, fd, fzf,
# git, jq, less, neovim, ripgrep, starship, tmux, zoxide and a Nerd Font are all
# in the base image, so this is only the delta on top of that — it is much
# shorter than macos/setup.sh or win/winsetup.ps1 on purpose.
#
# Two deliberate departures from the macOS script:
#
#   - mise instead of nvm/pyenv/direnv. Omarchy already drives mise (it is how
#     `omarchy default agent` installs Claude, Codex and friends), and mise
#     covers all three. Do not port those three from macos/setup.sh.
#   - `omarchy install ...` instead of AUR helpers for GUI apps and services.
#     Those installers wire the app into the current Omarchy theme and, for
#     Sunshine, open the streaming ports. An AUR install skips all of that.
#
# Everything below is idempotent: `omarchy pkg add` skips what is present, and
# `mise use -g` is a no-op when the tool is already at that version.
#
# Prompts for sudo, so run it from a terminal, not from a launcher.
#
# ----------------------------------------------------------------------------
# BEFORE ADDING AN AUR PACKAGE: check it builds for your architecture.
#
#   yay -Gp <package> | grep -E '^arch=|^source_aarch64'
#
# `yay -Si` does NOT print the arch line, so a version number coming back tells
# you nothing about ARM. Read the PKGBUILD.
#
#   arch=(x86_64 armv7h aarch64)                 <- claims support
#   source_aarch64=(...linux-arm64.tar.gz)       <- and actually has a source
#
# Both lines matter. arch=() can list aarch64 with no matching source, in which
# case the build has nothing to fetch. A `source_aarch64=` pointing at an
# upstream arm64 artifact is the real signal.
#
# Upstream shipping an arm64 build is NOT enough on its own — someone has to
# package it. PowerShell and VS Code both ship arm64 and are both packaged for
# it; Obsidian and Bruno ship arm64 builds that nobody has packaged.
#
# Official repos need no check at all. This machine's mirrorlist is
# mirror.archlinuxarm.org, so anything `pacman -Si` can find is already built
# for aarch64 — an x86-only package is not in the database to be found.
#
# Only matters under Try Omarchy on Apple Silicon. On an x86 box it is moot.
# ----------------------------------------------------------------------------

set -e   # macos/setup.sh omits this, which is how a typo lived there unnoticed

# ── 1. Azure ──
omarchy pkg add azure-cli           # in extra, prebuilt aarch64. 628 MB installed
mise use -g azd                     # Azure Developer CLI; not packaged for Arch
# Then: az login --use-device-code
# Device code beats plain `az login` here — the browser redirect to localhost is
# awkward from a VM or over SSH.

# ── 2. Infrastructure ──
omarchy pkg add terraform

# ── 3. Languages & runtimes ──
# Via mise so versions can differ per project. `omarchy install dev-env <lang>`
# is the alternative when you want Omarchy's opinionated setup instead.
mise use -g node
mise use -g uv                      # also available as `omarchy pkg add uv`
omarchy pkg add go

# ── 4. CLI tools Omarchy does not ship ──
#omarchy pkg add lazygit
#omarchy pkg add httpie
#omarchy pkg add tree
#omarchy pkg add wget
#omarchy pkg add gnupg               # commit signing
omarchy pkg add d2                  # diagrams; more capable than mermaid

# ── 5. Data & docs tooling ──
omarchy pkg aur add powershell-bin  # arch=(x86_64 armv7h aarch64); pulls MS's
                                    # own linux-arm64 tarball
mise use -g databricks-cli          # not in the AUR at all
mise use -g marp-cli                # AUR marp-cli is arch=(x86_64) with no
                                    # arm64 source, so take the Node build

# ── 6. Dev Services ──
# Commented out to match macos/setup.sh, where postgresql, redis and sqlite are
# all commented too. Nothing else here needs a database — terraform certainly
# does not.
#
# Note what this command is: it prompts for a database and then goes straight to
# `sudo docker run`. It does NOT install Docker, it requires it. On a machine
# without Docker it fails at the first command, and under `set -e` that takes
# the rest of this script with it.
#
# Install Docker first if you want one:
#   omarchy pkg add docker
#   sudo systemctl enable --now docker
#omarchy install docker dbs

# ── 7. Editors ──
# These wire the app into the current Omarchy theme, which a raw AUR install
# does not. VS Code is not in the Arch repos at all.
omarchy install editor vscode
#omarchy install editor zed
# VS Code extensions and settings are cross-platform — see ../vscode-setup.sh

# ── 8. GUI apps ──
omarchy pkg aur add drawio-desktop-bin   # PKGBUILD is arch=('x86_64' 'aarch64')
#omarchy pkg aur add claude-desktop      # also arch=('x86_64' 'aarch64')

# ── 9. Services ──
omarchy install service 1password
omarchy install service tailscale
#omarchy install service sunshine   # remote desktop; also opens the Moonlight
                                    # streaming ports for LAN and Tailscale.
                                    # Uncomment on a machine you remote into.

# ── 10. Browsers ──
# Omarchy ships Chromium. Add another only if you need it.
#omarchy install browser chrome     # sometimes needed for playwright automation

# ── 11. Git identity ──
git config --global user.name "Scott Stout"
git config --global user.email "scott.stout@framedata.ai"
git config --global init.defaultBranch main

# ── 12. Agent keybinding ──
# Makes Omarchy's own SUPER+SHIFT+CTRL+A resume the last conversation instead of
# starting a new one. See ./README.md.
#./patches/install.sh

# ── 13. x86_64 only ──
# These are fine on a bare-metal Omarchy box and simply cannot be installed
# under Try Omarchy on Apple Silicon. Uncomment on an x86 machine.
#omarchy pkg aur add obsidian-bin   # arch=('x86_64')
#omarchy pkg aur add bruno-bin      # arch=('x86_64'); see httpie in section 4

# ── 14. Not packaged anywhere ──
# supacode  — not in the AUR or the mise registry; install from the vendor.
# betterdisplay, linearmouse, whatcable — macOS only, no Linux counterpart needed.

echo
echo "Done. Next:"
echo "  az login --use-device-code"
echo "  ../vscode-setup.sh          # extensions + settings"
