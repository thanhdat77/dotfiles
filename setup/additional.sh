#!/usr/bin/env bash

# yazi
if ! command -v yazi &>/dev/null; then
    echo "Installing yazi..."
    curl -L https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip -o /tmp/yazi.zip
    unzip -q /tmp/yazi.zip -d /tmp/yazi-extracted
    sudo mv /tmp/yazi-extracted/yazi-*/yazi /usr/local/bin/
    sudo mv /tmp/yazi-extracted/yazi-*/ya /usr/local/bin/
    rm -rf /tmp/yazi.zip /tmp/yazi-extracted
    echo "yazi installed: $(yazi --version)"
else
    echo "yazi already installed: $(yazi --version)"
fi
