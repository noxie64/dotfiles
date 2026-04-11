#!/bin/bash
for file in "$HOME"/.config/hypr/wsess/*; do
    sudo cp "$file" /usr/share/wayland-sessions/
done
