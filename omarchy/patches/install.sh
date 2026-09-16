#!/bin/bash
# Make Omarchy's stock agent keybinding resume the last conversation.
#
# omarchy-agent takes no passthrough flags, so this edits the claude) case in
# /usr/bin/omarchy-agent. That file is package-owned, hence the post-update hook
# that puts the patch back after an upgrade reverts it.
#
# pkexec rather than sudo so this works from a prompt with no controlling
# terminal; from an ordinary interactive shell sudo is fine too.

set -euo pipefail
here=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

pkexec /bin/bash -c "install -m 755 -o root -g root \
  '$here/omarchy-agent-continue-patch' /usr/local/bin/ && \
  /usr/local/bin/omarchy-agent-continue-patch"

install -m 755 "$here/post-update.d/10-agent-continue" \
  "$HOME/.config/omarchy/hooks/post-update.d/"

echo "Patched. SUPER+SHIFT+CTRL+A now resumes the last conversation."
