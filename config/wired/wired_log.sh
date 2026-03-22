#!/bin/bash
NOTIFICATION_LOG_FILE="$HOME/Notifications/wired.log"

jq -r '
"\u001b[32m" as $green  |
"\u001b[33m" as $yellow |
"\u001b[0m"  as $reset  |
"\u001b[39m" as $white  |
"\u001b[36m" as $cyan   |
"\u001b[0;90m" as $gray |
if .urgency == "Critical" then
    "\u001b[41m\u001b[37m"
elif .urgency == "Normal" then
    "\($yellow)"
else
    "\($white)"
end as $urgency_color |
if .urgency == "Critical" then
    "\($urgency_color)[-]"
elif .urgency == "Normal" then
    "\($urgency_color)[!]"
else
    "\($urgency_color)[+]"
end as $urgency |
"\($green)[\($cyan)\(.time | strftime("%H:%M:%S"))\($green)] - \($urgency)\($reset)\($green) - \($cyan)\(.summary): \($gray)|\($urgency_color)\(.body)\($gray)|\($reset)"' \
    "$NOTIFICATION_LOG_FILE" | less
