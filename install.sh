#!/bin/bash
set -e

REPO='potrepka/iterator'
BINARY='iterator'
INSTALL_DIR='/usr/local/bin'

curl -fsSL "https://raw.githubusercontent.com/$REPO/main/$BINARY" -o "/tmp/$BINARY"
sudo mv "/tmp/$BINARY" "$INSTALL_DIR/$BINARY"
sudo chmod +x "$INSTALL_DIR/$BINARY"

echo "Installed $BINARY to $INSTALL_DIR/$BINARY"
