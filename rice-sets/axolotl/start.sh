#!/bin/bash

if [ $(cat ~/.config/kitty/kitty.conf | grep -c "include ~/lsrl-loaded/.config/kitty/kitty-lr.conf") -eq 0 ]; then
    printf '\ninclude ~/lsrl-loaded/.config/kitty/kitty-lr.conf\n' | tee -a ~/.config/kitty/kitty.conf
fi

if [ $(cat ~/.config/hypr/hyprland.conf | grep -c "source = ~/lsrl-loaded/.config/hypr/hyprland-lr.conf") -eq 0 ]; then
    printf '\nsource = ~/lsrl-loaded/.config/hypr/hyprland-lr.conf\n' | tee -a ~/.config/hypr/hyprland.conf
fi

hyprctl reload

if [ pgrep -c hyprpaper -eq 0 ]; then
    hyprpaper --config ~/.config/hypr/hyprpaper.conf
fi

hyprctl hyprpaper wallpaper ' , ~/lsrl-loaded/wallpaper/static.png, fill'
waybar -c ~/lsrl-loaded/.config/waybar/config.jsonc -s ~/lsrl-loaded/.config/waybar/style.css &

bash /home/Waylake/.config/waybar-quotes/quote_picker.sh
waybar -c ~/.config/waybar-quotes/config.jsonc -s ~/lsrl-loaded/.config/waybar-quotes/style.css &

exit 0