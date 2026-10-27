#!/usr/bin/env bash
# swaync-test.sh - fire every kind of notification at SwayNotificationCenter
# Requires: libnotify (notify-send >= 0.8 for actions), swaync, optionally python-gobject
# Usage: ./swaync-test.sh [delay_seconds]   (default 2)

DELAY="${1:-2}"
APP="swaync-test"
ICON_DIR="/usr/share/icons"

command -v notify-send >/dev/null || { echo "notify-send missing: sudo pacman -S libnotify"; exit 1; }
pgrep -x swaync >/dev/null || { echo "swaync is not running. Start it with: swaync &"; exit 1; }

step() { echo ">> $1"; }
pause() { sleep "$DELAY"; }

# ---------- 1. Urgency levels ----------
step "Urgency: low"
notify-send -a "$APP" -u low "Low urgency" "Background info, no rush."
pause

step "Urgency: normal"
notify-send -a "$APP" -u normal "Normal urgency" "A regular notification."
pause

step "Urgency: critical (does not auto-expire)"
notify-send -a "$APP" -u critical -i dialog-error "Critical urgency" "This stays until dismissed."
pause

# ---------- 2. Icons ----------
step "Themed icons"
notify-send -a "$APP" -i dialog-information "Info icon" "dialog-information"
sleep 1
notify-send -a "$APP" -i dialog-warning "Warning icon" "dialog-warning"
sleep 1
notify-send -a "$APP" -i battery-low "Battery icon" "battery-low"
pause

step "Image from file path (uses first PNG found in icon theme)"
IMG="$(find "$ICON_DIR" -name '*.png' -size +4k 2>/dev/null | head -n1)"
if [[ -n "$IMG" ]]; then
  notify-send -a "$APP" -h "string:image-path:$IMG" "Image-path hint" "$IMG"
else
  echo "   (no PNG found, skipped)"
fi
pause

# ---------- 3. Body formatting ----------
step "Markup in body"
notify-send -a "$APP" "Markup test" \
  "<b>Bold</b>, <i>italic</i>, <u>underline</u>
<a href=\"https://archlinux.org\">Arch Linux link</a>"
pause

step "Long body (tests wrapping / truncation)"
notify-send -a "$APP" "Long notification" \
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
pause

step "Title only (no body)"
notify-send -a "$APP" "Title only notification"
pause

step "Multi-line body"
notify-send -a "$APP" "Multi-line" $'Line 1\nLine 2\nLine 3\nLine 4'
pause

# ---------- 4. Timeouts / behavior ----------
step "Short timeout (1s)"
notify-send -a "$APP" -t 1000 "1 second timeout" "Gone quickly."
pause

step "Long timeout (10s)"
notify-send -a "$APP" -t 10000 "10 second timeout" "Sticks around a bit."
pause

step "Transient (not stored in notification center)"
notify-send -a "$APP" -h boolean:transient:true "Transient" "Should NOT appear in the control center."
pause

step "Resident (stays after action click)"
notify-send -a "$APP" -h boolean:resident:true "Resident" "Hint: resident=true"
pause

# ---------- 5. Categories & app names ----------
step "Categories"
for cat in email im device network transfer presence; do
  notify-send -a "$APP" -c "$cat" "Category: $cat" "category hint = $cat"
  sleep 0.7
done
pause

step "Different app names (tests grouping in control center)"
for app in Firefox Discord Spotify; do
  notify-send -a "$app" "Message from $app" "Grouping test 1"
  notify-send -a "$app" "Another from $app" "Grouping test 2"
done
pause

# ---------- 6. Replace / update ----------
step "Replace an existing notification"
ID="$(notify-send -a "$APP" -p "Original" "This will be replaced...")"
sleep "$DELAY"
notify-send -a "$APP" -r "$ID" "Replaced!" "Same ID, new content."
pause

step "Synchronous hint (volume-style replacement)"
for v in 20 40 60 80; do
  notify-send -a "$APP" -h string:x-canonical-private-synchronous:volume \
    -h "int:value:$v" "Volume" "$v%"
  sleep 0.5
done
pause

# ---------- 7. Progress bar ----------
step "Progress bar (value hint)"
PID="$(notify-send -a "$APP" -p -h int:value:0 "Downloading" "0%")"
for p in 10 25 50 75 100; do
  sleep 0.7
  notify-send -a "$APP" -r "$PID" -h "int:value:$p" "Downloading" "$p%"
done
pause

# ---------- 8. Action buttons ----------
step "Action buttons (click one!)"
(
  RESULT="$(notify-send -a "$APP" -t 0 \
    -A "yes=Yes" -A "no=No" -A "later=Remind me later" \
    "Action buttons" "Pick an option")"
  echo "   action clicked: ${RESULT:-<none/dismissed>}"
) &
pause

step "Default action (click the notification body)"
(
  RESULT="$(notify-send -a "$APP" -t 0 -A "default=Open" \
    "Default action" "Click the notification itself")"
  echo "   default action result: ${RESULT:-<none/dismissed>}"
) &
pause

# ---------- 9. Inline reply ----------
step "Inline reply (needs gdbus; swaync shows a reply text box)"
if command -v gdbus >/dev/null; then
  gdbus call --session \
    --dest org.freedesktop.Notifications \
    --object-path /org/freedesktop/Notifications \
    --method org.freedesktop.Notifications.Notify \
    "$APP" 0 "mail-message-new" "Inline reply" "Type a reply below" \
    '["inline-reply", "Reply"]' '{}' 0 >/dev/null
else
  echo "   (gdbus missing, skipped - provided by glib2)"
fi
pause

# ---------- 10. Sound hints ----------
step "Sound hints (silent if no sound theme installed)"
notify-send -a "$APP" -h string:sound-name:message-new-instant "Sound name hint" "sound-name=message-new-instant"
sleep 1
notify-send -a "$APP" -h boolean:suppress-sound:true "Suppress sound" "suppress-sound=true"
pause

# ---------- 11. Stress test ----------
step "Burst of 8 notifications"
for i in {1..8}; do
  notify-send -a "$APP" "Burst #$i" "Stress test notification $i of 8"
done
pause

# ---------- 12. swaync-client checks ----------
if command -v swaync-client >/dev/null; then
  step "Notification count: $(swaync-client -c)"
  step "DND state: $(swaync-client -D)"

  step "Toggling DND on, sending one (should be hidden), then off"
  swaync-client -dn
  notify-send -a "$APP" "DND test" "You should NOT see this popup (it lands in the center)."
  sleep "$DELAY"
  swaync-client -df
  notify-send -a "$APP" "DND off" "Popups are back."
  pause

  step "Opening control center for 3s"
  swaync-client -op
  sleep 3
  swaync-client -cp
fi

echo
echo "Done. Cleanup options:"
echo "  swaync-client -C   # clear all notifications"
echo "  swaync-client -d   # close all popups"
