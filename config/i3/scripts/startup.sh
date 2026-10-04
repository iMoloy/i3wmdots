#!/bin/bash
# =============================================================
# Script Name: startup.sh
# Description: Staged background tasks to improve boot times.
# =============================================================

# Step 1: Core Environment & UI (Immediate)
~/.config/i3/scripts/SetSysVars &
~/.config/i3/scripts/load-theme &

# Polkit authentication agent
lxpolkit &

# Wait briefly for environment variables to settle
sleep 1

# Step 2: Compositor & Settings Daemon
picom --config ~/.config/i3/includes/picom/picom.conf &
xsettingsd --config=~/.config/i3/includes/xsettingsd &

# Wait for compositor to start
sleep 2

# Step 3: Desktop Daemons & Utilities
pidof -q eww || eww -c ~/.config/i3/eww daemon &
clipcatd &

# Execute autostart applications last
dex -a -s ~/.config/autostart &
