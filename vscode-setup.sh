#!/bin/bash
# ==============================================
# VS Code setup: extensions + settings restore
# Run: chmod +x vscode-setup.sh && ./vscode-setup.sh
# ==============================================
#
# NOTE: Extension list generated from the actual install (`code --list-extensions`)
# on 2026-07-19. Auto-installed dependency extensions (debugpy, jupyter-renderers,
# remote-ssh-edit, dotnet-runtime, etc.) are omitted — they come back automatically
# with their parent extension.

set -e

# ── Python ──
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance   # Language server (autocomplete, type checking)
code --install-extension ms-python.black-formatter  # Code formatter
code --install-extension ms-python.isort            # Import sorting
code --install-extension ms-python.vscode-python-envs

# ── Jupyter ──
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.vscode-jupyter-cell-tags

# ── AI & Claude / Copilot ──
code --install-extension anthropic.claude-code      # Claude Code
code --install-extension ms-copilotstudio.vscode-copilotstudio
code --install-extension ms-azuretools.vscode-azure-github-copilot
code --install-extension ms-vscode.vscode-chat-customizations-evaluations
code --install-extension ms-windows-ai-studio.windows-ai-studio

# ── Azure ──
code --install-extension ms-azuretools.vscode-azureresourcegroups
code --install-extension ms-azuretools.vscode-bicep
code --install-extension ms-azuretools.vscode-azureterraform
code --install-extension ms-azuretools.vscode-azure-mcp-server
code --install-extension ms-azuretools.vscode-containers
code --install-extension ms-azuretools.vscode-docker

# ── .NET / PowerShell ──
code --install-extension ms-dotnettools.csharp
code --install-extension ms-dotnettools.csdevkit
code --install-extension ms-vscode.powershell

# ── Infrastructure as Code ──
code --install-extension hashicorp.terraform

# ── Git ──
code --install-extension eamodio.gitlens            # Git blame, history, visual diff
code --install-extension mhutchie.git-graph         # Visual branch graph
code --install-extension github.vscode-github-actions

# ── Remote & Containers ──
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-ssh

# ── Markdown & Docs ──
code --install-extension yzhang.markdown-all-in-one
code --install-extension davidanson.vscode-markdownlint
code --install-extension marp-team.marp-vscode      # Markdown → slide decks

# ── YAML / TOML / ENV ──
code --install-extension redhat.vscode-yaml
code --install-extension tamasfe.even-better-toml
code --install-extension mikestead.dotenv

# ── REST / API ──
code --install-extension humao.rest-client          # Test API calls right from .http files

# ── Code Quality ──
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension streetsidesoftware.code-spell-checker

# ── UI & Themes ──
code --install-extension pkief.material-icon-theme
code --install-extension zhuangtongfa.material-theme  # One Dark Pro

# ── Restore user settings + MCP config ──
# Backed-up copies live in ./vscode/ (settings.json, mcp.json).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODE_USER="$HOME/Library/Application Support/Code/User"
mkdir -p "$CODE_USER"

for f in settings.json mcp.json; do
    src="$SCRIPT_DIR/vscode/$f"
    dst="$CODE_USER/$f"
    if [ -f "$src" ]; then
        [ -f "$dst" ] && cp "$dst" "$dst.bak"   # keep a backup of whatever was there
        cp "$src" "$dst"
        echo "Restored $f"
    fi
done

echo ""
echo "Done! Open VS Code and:"
echo "  1. Cmd+Shift+P → 'Python: Select Interpreter' → pick your pyenv version"
echo "  2. Sign into Claude Code: run 'claude' in terminal"
echo "  3. Activate theme: Cmd+K Cmd+T → 'One Dark Pro'"
echo "  4. Activate file icons: Cmd+Shift+P → 'File Icon Theme' → 'Material Icon Theme'"
