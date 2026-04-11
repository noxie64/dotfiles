#!/bin/bash
for file in "$HOME"/.config/hypr/xsess/*; do
    sudo cp "$file" /usr/share/xsessions/
done
