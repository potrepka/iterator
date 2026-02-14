#!/bin/bash
set -e

REPO='potrepka/iterator'
BINARY='iterator'
INSTALL_DIR='/usr/local/bin'

TAG=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" 2>/dev/null \
    | grep '"tag_name"' | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/' || true)
[ -z "$TAG" ] && TAG='main'
TMP=$(mktemp)
curl -fsSL "https://raw.githubusercontent.com/$REPO/$TAG/$BINARY" -o "$TMP"
sudo mv "$TMP" "$INSTALL_DIR/$BINARY"
sudo chmod +x "$INSTALL_DIR/$BINARY"

echo "Installed $BINARY ($TAG) to $INSTALL_DIR/$BINARY"
