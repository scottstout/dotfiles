# Omarchy

Setup for [Omarchy](https://omarchy.org/) — Arch + Hyprland.

## Why this is so much shorter than macos/ and win/

Omarchy ships most of the terminal toolset in its base image: `bat`, `btop`,
`eza`, `fd`, `fzf`, `git`, `jq`, `less`, `neovim`, `ripgrep`, `starship`, `tmux`,
`zoxide`, and a Nerd Font. `setup.sh` is only the delta.

Two deliberate differences from the macOS script:

- **mise, not nvm/pyenv/direnv.** Omarchy already drives mise — it is how
  `omarchy default agent` installs Claude, Codex and the rest — and mise covers
  all three. Don't port them over.
- **`omarchy install ...`, not an AUR helper**, for GUI apps and services. Those
  installers wire the app into the current Omarchy theme, and the Sunshine one
  opens the Moonlight streaming ports. A raw AUR install skips all of that.

## Use

```bash
./setup.sh              # prompts for sudo; run from a terminal
./patches/install.sh    # optional, see below
az login --use-device-code
```

`setup.sh` is idempotent — `omarchy pkg add` skips what's present.

## patches/

`omarchy-agent` accepts no passthrough flags, so there is no supported seam for
adding `--continue` to the agent keybinding. `patches/` edits the `claude)` case
in `/usr/bin/omarchy-agent` directly, so Omarchy's own **SUPER+SHIFT+CTRL+A**
resumes the last conversation rather than starting a new one.

That file is owned by the Omarchy package, so an upgrade reverts it. The
companion `post-update.d` hook re-applies it after every `omarchy update`.

The patch script is idempotent, keeps a `.orig` beside the target, validates the
result with `bash -n` before installing, and skips itself with a message if
`omarchy-agent` ever stops matching the shape it expects — so a future upstream
rewrite cannot break an update.

## aarch64

Relevant only under Try Omarchy on Apple Silicon; everything below is fine on a
bare-metal x86 Omarchy box. AUR `-bin` packages are the thing to check, and they
vary — read the PKGBUILD's `arch=()` rather than assuming:

| Package | `arch=()` | On ARM |
|---|---|---|
| `drawio-desktop-bin` | `x86_64 aarch64` | works |
| `claude-desktop` | `x86_64 aarch64` | works |
| `obsidian-bin` | `x86_64` | no |
| `bruno`, `bruno-bin` | `x86_64` | no |
| `marp-cli` | `x86_64` | use mise instead |
| `powershell-bin` | `x86_64` | use mise instead |
| `visual-studio-code-bin` | `x86_64` | use `omarchy install editor vscode` |

Where the AUR build is x86_64-only but the vendor ships a linux-arm64 release,
mise is the way through — that covers `marp-cli`, `powershell` and
`databricks-cli` (which isn't in the AUR at all).

## Related

Machine-specific state — the full config snapshot for a particular box, hostname
and all — lives in the private `scottstout/omarchy-config` repo, synced
automatically after each `omarchy update`. This directory is the portable half:
how to build a machine, not what one machine currently is.
