#!/bin/bash

hyprctl reload
hyprctl hyprpaper wallpaper ' , ~/lsrl-loaded/wallpaper/static.png, fill'

waybar -c ~/lsrl-loaded/.config/waybar/config.jsonc -s ~/lsrl-loaded/.config/waybar/style.css &

bash /home/Waylake/.config/waybar-quotes/quote_picker.sh
waybar -c ~/.config/waybar-quotes/config.jsonc -s ~/lsrl-loaded/.config/waybar-quotes/style.css &

exit 0