# This file launch the bar/s
for mon in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$mon setsid -f polybar -q mel-bar -c "${HOME}"/.config/i3/themes/"${THEME}"/polybar/config.ini </dev/null >/dev/null 2>&1
    MONITOR=$mon setsid -f polybar -q mel2-bar -c "${HOME}"/.config/i3/themes/"${THEME}"/polybar/config.ini </dev/null >/dev/null 2>&1
done
