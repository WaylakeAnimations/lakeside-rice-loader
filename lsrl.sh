#!/bin/bash

LSRL_PATH=$(dirname "$(readlink -f "$0")")
RICE_SET=$1

bash ~/lsrl-loaded/stop.sh

rm ~/lsrl-loaded
ln -sf "$LSRL_PATH/rice-sets/$RICE_SET" ~/lsrl-loaded

bash ~/lsrl-loaded/start.sh

# Set GTK theme and icon theme
GTKT=$(cat ~/lsrl-loaded/rice.json | jq -r '.gtk_theme')
ICONT=$(cat ~/lsrl-loaded/rice.json | jq -r '.icon_theme')

gsettings set org.gnome.desktop.interface gtk-theme $GTKT
gsettings set org.gnome.desktop.interface icon-theme $ICONT

echo $1 > $LSRL_PATH/current.txt

exit 0