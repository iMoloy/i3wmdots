#!/bin/sh

pick_random_wall() {
    find "$1" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | shuf -n 1
}

set_wallpaper() {
    [ -n "$1" ] && [ -f "$1" ] || return 1
    xwallpaper --zoom "$1"
    echo "$1" > "$HOME/.config/i3/.wallpaper"
    WallSync &
}

case $ENGINE in
    "Random")
        set_wallpaper "$(pick_random_wall "$HOME/.config/i3/rices/$RICE/walls")"
        ;;
    "CustomDir")
        set_wallpaper "$(pick_random_wall "$CUSTOM_DIR")"
        ;;
    "Default")
        set_wallpaper "$DEFAULT_WALL"
        ;;
    "Animated")
        AnimatedWall --start "$ANIMATED_WALL"
        WallSync --animated &
        ;;
    "Slideshow")
        (
            while :; do
                random_img=$(pick_random_wall "$HOME/.config/i3/rices/$RICE/walls")
                [ -n "$random_img" ] && xwallpaper --zoom "$random_img" && echo "$random_img" > "$HOME/.config/i3/.wallpaper"
                WallSync
                sleep 900  # 15 minutos
            done
        ) &
        echo $! > /tmp/wall_refresh.pid
        ;;
    *)
        set_wallpaper "$(pick_random_wall "$HOME/.config/i3/rices/$RICE/walls")"
        ;;
esac
