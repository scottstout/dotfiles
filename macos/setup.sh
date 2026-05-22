#!/bin/bash
# ==============================================
# Mac AI Developer Setup Script
# Run: chmod +x setup.sh && ./setup.sh
# ==============================================

# NOTE: This was created by claude and adjusted by me. It isn't tied into the rest of the files here. Just want to keep for reference.


# ── 1. Homebrew (if not already installed) ──
#if ! command -v brew &>/dev/null; then
 # echo "Installing Homebrew..."
 # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#fi

brew update && brew upgrade

# ── 2. Core CLI Tools ──
brew install git
brew install gh           # GitHub CLI
brew install wget
brew install curl
brew install gnupg        # GPG for git commit signing

# ── 3. Version Managers ──
brew install nvm           # Node version manager
brew install pyenv         # Python version manager
brew install pyenv-virtualenv
brew install uv


# ── 4. Runtimes (via version managers after install) ──
# After this script, run:
   nvm install --lts
   pyenv install 3.12
   pyenv global 3.12

# ── 5. Python ML/AI Dependencies (system-level) ──
brew install miniforge    # Conda for ML environments

# ── 6. Terminal Enhancements ──
brew install starship     # Shell prompt
brew install --cask font-meslo-lg-nerd-font 
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install fzf
brew install ripgrep      # Fast search (also used by Claude Code)
brew install bat          # Better cat
brew install eza          # Better ls
brew install jq           # JSON processing
brew install httpie       # HTTP client
brew install tree         # Directory tree viewer
brew install tmux         # Terminal multiplexer

# ── 7. AI / LLM Tools ──
# brew install ollama       # Run local LLMs

# ── 8. Dev Services ──
#brew install postgresql@16
#brew install redis
#brew install sqlite

# ── 9. Build Tools ──
#brew install cmake
#brew install pkg-config
#brew install ffmpeg       # Often needed for multimodal/audio AI work

# ── 10. GUI Apps (Casks) ──
brew install --cask iterm2
brew install --cask visual-studio-code
#brew install --cask cursor
brew install --cask zed
brew install --cask obsidian
brew install --cask bruno          # API client
#brew install --cask raycast
#brew install --cask rectangle
brew install --cask 1password
brew install --cask claude
brew install --cask claude-code
brew install --cask google-chrome # needed sometimes for playwright/browser automation
brew install direnv


# Log into App Store before running this

# THis wasn't worth it. Just go to app store and install Xcode.
#brew install mas # mas can only install apps you've already "purchased" (free or paid) with your Apple ID, so make sure to log in to the App Store and "purchase" Xcode (it's free) before running this command.
#mas install 497799835 # Xcode (for command line tools and simulators)

# Git Setup
git config --global user.name "Scott Stout"
git config --global user.email "scott.stout@framedata.ai"
git config --global init.defaultBranch main

# ── 11. Post-brew: Claude Code ──
#echo ""
#echo "========================================"
#echo "Next steps (run manually after this script):"
#echo "========================================"
#echo "1. Set up nvm in your shell:"
#echo '   export NVM_DIR="$HOME/.nvm"'
#echo '   source $(brew --prefix nvm)/nvm.sh'
##echo ""
#echo "2. Install Node.js LTS:"
#echo "   nvm install --lts"
#echo "   nvm use --lts"
#echo ""
#echo "3. Install Claude Code:"
#echo "   npm install -g @anthropic-ai/claude-code"
#echo ""
#echo "4. Install Python 3.12:"
#echo "   pyenv install 3.12"
#echo "   pyenv global 3.12"
#echo ""
#echo "5. Install core Python AI libs:"
#echo "   pip install anthropic openai langchain langgraph"
#echo "   pip install jupyter ipython pandas numpy pydantic"
#echo "   pip install fastapi uvicorn httpx"
#echo "   pip install transformers huggingface_hub"
#echo ""
echo "6. Install Oh My Zsh (optional):"
echo '   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
echo ""
echo "Done! 🚀"