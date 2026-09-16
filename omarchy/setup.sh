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

set -e   # macos/setup.sh omits this, which is how a typo lived there unnoticed

# ── 1. Azure ──
omarchy pkg add azure-cli           # in extra, prebuilt aarch64. 628 MB installed
mise use -g azd                     # Azure Developer CLI; not packaged for Arch
# Then: az login --use-device-code
# Device code beats plain `az login` here — the browser redirect to localhost is
# awkward from a VM or over SSH.

# ── 2. Infrastructure ──
omarchy pkg add terraform
omarchy install docker dbs          # Docker + a dev-configured database container

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

# ── 5. Editors ──
# These wire the app into the current Omarchy theme, which a raw AUR install
# does not. VS Code is not in the Arch repos at all.
omarchy install editor vscode
#omarchy install editor zed
# VS Code extensions and settings are cross-platform — see ../vscode-setup.sh

# ── 6. Services ──
omarchy install service 1password
omarchy install service tailscale
#omarchy install service sunshine   # remote desktop; also opens the Moonlight
                                    # streaming ports for LAN and Tailscale.
                                    # Uncomment on a machine you remote into.

# ── 7. Browsers ──
# Omarchy ships Chromium. Add another only if you need it.
#omarchy install browser chrome     # sometimes needed for playwright automation

# ── 8. Git identity ──
git config --global user.name "Scott Stout"
git config --global user.email "scott.stout@framedata.ai"
git config --global init.defaultBranch main

# ── 9. Agent keybinding ──
# Makes Omarchy's own SUPER+SHIFT+CTRL+A resume the last conversation instead of
# starting a new one. See patches/README notes in ../omarchy/README.md.
#./patches/install.sh

# ── 10. Not available on aarch64, or not verified ──
# powershell   — AUR powershell-bin is x86_64 only; mise has aqua:PowerShell
# obsidian     — not in the repos; AUR build unverified on ARM
# databricks   — not packaged; install from the vendor script
# marp-cli     — npm install -g @marp-team/marp-cli
# betterdisplay, linearmouse, whatcable — macOS only, no Linux equivalent needed

echo
echo "Done. Next:"
echo "  az login --use-device-code"
echo "  ../vscode-setup.sh          # extensions + settings"
