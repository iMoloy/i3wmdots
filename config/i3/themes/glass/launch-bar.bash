# This file launches the glass bar

[ -z "$THEME" ] && read -r THEME < "$HOME/.config/i3/.theme"
[ -z "$THEME" ] && THEME="glass"

generate_eww_workspaces() {
    local eww_file monitors count m workspace_name
    local listen_workspaces widgets workspace_widgets

    eww_file="${HOME}/.config/i3/themes/${THEME}/eww/workspaces.yuck"
    monitors=$(i3-msg -t get_outputs | jq -r '.[].name')
    count=0
    listen_workspaces=""
    widgets=""
    workspace_widgets=";; Workspaces Widgets ;;\n"

    printf "%s\n" ";; Workspaces ;;" > "$eww_file"

    for m in $monitors; do
        workspace_name="workspace${count}"
        listen_workspaces="${listen_workspaces}(deflisten ${workspace_name} \"scripts/WorkSpaces $m\")\n"
        widgets="${widgets}           (box :visible { monitor==\"$m\" } :halign \"center\" (${workspace_name}))\n"
        workspace_widgets="${workspace_widgets}(defwidget ${workspace_name} [] (literal :content ${workspace_name}))\n"
        count=$((count + 1))
    done

    printf "%b" "$listen_workspaces" >> "$eww_file"
    printf "%b" "$workspace_widgets" >> "$eww_file"
    printf "%b" ";; Workspaces Main Widget ;;\n(defwidget workspaces [monitor]\n   (box    :orientation \"v\"\n           :space-evenly \"false\"\n           :valign \"start\"\n           :halign \"center\"\n$widgets))" >> "$eww_file"
}

generate_eww_workspaces

for m in $(i3-msg -t get_outputs | jq -r '.[].name'); do
    eww -c "${HOME}/.config/i3/themes/${THEME}/eww" open bar --id "$m" --arg monitor="$m" --toggle
done

# Fix eww when entering fullscreen state
i3-msg -t subscribe -m '[ "window" ]' | jq --unbuffered -r 'select(.change == "fullscreen_mode") | .container.fullscreen_mode' | while read -r is_fullscreen; do
    if [ "$is_fullscreen" = "1" ]; then
        HideBar -h
    else
        HideBar -u
    fi
done &

