# dotfiles

My dotfiles and personal preferences, organised by platform.

| Path | What it is |
|---|---|
| `macos/` | macOS setup via Homebrew |
| `win/` | Windows setup via winget, Scoop and Chocolatey |
| `omarchy/` | [Omarchy](https://omarchy.org/) (Arch + Hyprland) setup |
| `vscode/` | VS Code settings, MCP config and extension list — cross-platform |
| `vscode-setup.sh` | Installs the extensions in `vscode/extensions.txt` |
| `old/` | Archived. The previous generation of this repo, kept for reference. |

These are **reference scripts, not an executable system** — read them and take
what applies rather than expecting a single bootstrap command. Commented-out
lines are deliberate: they record things tried and rejected, and why.

Git identity is `scott.stout@framedata.ai` everywhere.

## Conventions

- One directory per platform, each with its own setup script.
- Sections marked `# ── N. Name ──`, with inline comments explaining *why* a
  thing is there, not just what it is.
- Anything genuinely cross-platform lives at the top level (`vscode/`).

## What is not here

Secrets. `.gitignore` excludes `.private` and `.gitconfig`, and this repo is
public — keep it that way. Machine-specific state lives elsewhere; see
`omarchy/README.md`.
