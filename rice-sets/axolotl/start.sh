#!/bin/bash

LSRL_PATH=$(dirname $(dirname $(dirname "$(readlink -f "$0")")))

bash $LSRL_PATH/text-appender.sh -b "include ~/.lsrl-loaded/.config/kitty/kitty-lr.conf" "~/.config/kitty/kitty.conf"
bash $LSRL_PATH/text-appender.sh -b "source = ~/.lsrl-loaded/.config/hypr/hyprland-lr.conf" "~/.config/hypr/hyprland.conf"

hyprctl reload &

if [ $(pgrep -c hyprpaper) -eq 0 ]; then
    hyprpaper --config ~/.config/hypr/hyprpaper.conf &
fi

hyprctl hyprpaper wallpaper ' , ~/.lsrl-loaded/wallpaper/static.png, fill' &
waybar -c ~/.lsrl-loaded/.config/waybar/config.jsonc -s ~/.lsrl-loaded/.config/waybar/style.css &

bash /home/Waylake/.config/waybar-quotes/quote_picker.sh ;
waybar -c ~/.config/waybar-quotes/config.jsonc -s ~/.lsrl-loaded/.config/waybar-quotes/style.css &

exit 0