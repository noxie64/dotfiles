#!/bin/bash
for file in "$HOME"/.config/hypr/wsess/*; do
    sudo cp -f "$file" /usr/share/wayland-sessions/
done
