#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/bin"

echo "=== Installing tools to ~/bin ==="
mkdir -p "$BIN_DIR"

for script in "$SCRIPT_DIR"/bin/*; do
  name="$(basename "$script")"
  cp "$script" "$BIN_DIR/$name"
  chmod 755 "$BIN_DIR/$name"
  echo "  Installed $name"
done

echo ""
echo "Make sure ~/bin is in your PATH. Add this to ~/.zshrc if missing:"
echo '  export PATH="$HOME/bin:$PATH"'
echo ""
echo "=== Done ==="
