#!/bin/bash

LSRL_PATH=$(dirname "$(readlink -f "$0")")
NAME=[LSRL-init]

# unintended usage detection
if [ -z $1 ]; then
    printf "\n$NAME nah, that's not how you use this, check ./lsrl -h\n\n"
    exit 64

elif [ $1 = iHopeThisSentenceDoesntExistInDictionaries ]; then
    if [ -z $2 ]; then

        printf "\n$NAME wait, if there was no folder name specified, ./lsrl.sh should've caught it by itself...

$NAME what are you staring at?...\n\n"

        exit 69
    fi
fi

# this section only run when this script is started by lsrl.sh
# at least that's how i intended it to be
# (i just want that script to be less cluttered)

printf "\n$NAME Making directories...\n"

mkdir "$LSRL_PATH/rice-sets/$2"
cd "$LSRL_PATH/rice-sets/$2"

mkdir ./.config
mkdir ./wallpaper

printf "$NAME Generating basic scripts and metadata...\n"


printf ']{
    "description": "insert desciption, bottom text",
    "gtk_theme": "Matchamod-dark-azul",
    "icon_theme": "Papirus-Dark"
}' > ./rice.json


printf "#!/bin/bash

hyprctl reload
hyprctl hyprpaper wallpaper ' , ~/lsrl-loaded/wallpaper/static.png, fill'

# Example on how you should write the config arguments...
# waybar -c ~/lsrl-loaded/.config/waybar/config.jsonc -s ~/lsrl-loaded/.config/waybar/style.css &

exit 0" > ./start.sh


printf "#!/bin/bash

# pkill waybar" > ./stop.sh


printf "$NAME Done...\n\n"

exit 0