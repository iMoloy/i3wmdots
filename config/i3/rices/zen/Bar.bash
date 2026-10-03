# This file launch the bar/s
for mon in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$mon setsid -f polybar -q cyn-bar -c "${HOME}"/.config/i3/rices/"${RICE}"/config.ini </dev/null >/dev/null 2>&1
    MONITOR=$mon setsid -f polybar -q cyn-bar2 -c "${HOME}"/.config/i3/rices/"${RICE}"/config.ini </dev/null >/dev/null 2>&1
done
