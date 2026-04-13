#!/bin/sh
if [ -z "$ARCH_THEME" ] || [ "$ARCH_THEME" = "onedark" ]; then
  cat ~/.config/kitty/themes/Doom_One.conf
else
  cat ~/.config/kitty/themes/default.conf
fi
