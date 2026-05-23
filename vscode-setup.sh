#!/bin/bash
# ==============================================
# VSCode Extensions for AI Development
# Run: chmod +x vscode-extensions.sh && ./vscode-extensions.sh
# ==============================================


# # NOTE: This was created by claude and adjusted by me. It isn't tied into the rest of the files here. Just want to keep for reference.

# ── Python ──
code --install-extension ms-python.python
code --install-extension ms-python.pylance          # Language server (autocomplete, type checking)
code --install-extension ms-python.black-formatter  # Code formatter
code --install-extension ms-python.isort            # Import sorting

# ── Jupyter ──
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.vscode-jupyter-cell-tags

# ── AI & Claude ──
code --install-extension anthropic.claude-code      # Claude Code
code --install-extension github.copilot             # Useful for autocomplete even if Claude-first
code --install-extension github.copilot-chat

# ── Git ──
code --install-extension eamodio.gitlens            # Git blame, history, visual diff
code --install-extension mhutchie.git-graph         # Visual branch graph

# ── Docker ──
code --install-extension ms-azuretools.vscode-docker

# ── Remote & Containers ──
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-ssh

# ── Markdown & Docs ──
code --install-extension yzhang.markdown-all-in-one
code --install-extension davidanson.vscode-markdownlint

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
code --install-extension Catppuccin.catppuccin-vsc
code --install-extension Catppuccin.catppuccin-vsc-icons

echo ""
echo "Done! Open VSCode and:"
echo "  1. Cmd+Shift+P → 'Python: Select Interpreter' → pick your pyenv version"
echo "  2. Sign into Claude Code: run 'claude' in terminal"
echo "  3. Sign into GitHub Copilot via the accounts menu (bottom left)"