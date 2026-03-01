#!/bin/sh

pgrep -x onedrive > /dev/null && exit 0
screen -dmS onedrive onedrive --monitor ~/OneDrive
