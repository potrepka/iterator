#!/bin/bash
set -e

REPO='potrepka/iterator'
BINARY='iterator'
INSTALL_DIR="$HOME/.local/bin"

TAG=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" 2>/dev/null \
    | grep '"tag_name"' | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/' || true)
[ -z "$TAG" ] && TAG='main'
TMP=$(mktemp)
curl -fsSL "https://raw.githubusercontent.com/$REPO/$TAG/$BINARY" -o "$TMP"
mkdir -p "$INSTALL_DIR"
mv "$TMP" "$INSTALL_DIR/$BINARY"
chmod +x "$INSTALL_DIR/$BINARY"

echo "Installed $BINARY ($TAG) to $INSTALL_DIR/$BINARY"
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
    echo "Add $INSTALL_DIR to your PATH if it is not already."
fi
