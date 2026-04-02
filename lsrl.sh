#!/bin/bash

LSRL_PATH=$(dirname "$(readlink -f "$0")")
NAME=[LSRL]

# check if "$1" is empty
if [ -z "$1" ] ; then
    printf "\n$NAME [rice-set-folder-name] is required (check -h)\n\n"
    exit 69

# print help if "$1" is --help or -h
elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then

printf "\nLakeside Rice Loader (https://github.com/WaylakeAnimations/lakeside-rice-loader)
Switch between rice sets, initialize new rice set, and more...

Recommended usage:

  ./lsrl.sh [rice-set-folder-name]
  ./lsrl.sh [flag]

Flags:
  -h, --help         Display informations about this script
                     (vro, this is literally the thing you just opened)
  -r, --relaunch     (Re)launch last rice set (reads from ./current.txt)
  -i, --init <name>  Initialize a new rice set project

Exit codes:
  0:  Task done (not failed) successfully
  3:  Missing rice folder
  64: Unintended usage detected
  69: Missing input(s)\n\n"

    exit 0

# check if "$1" is --init
elif [ "$1" = "--init" ] || [ "$1" = "-i" ]; then

    # check if "$2" is filled
    if [ ! -z "$2" ] ; then

        # if "$2" got filled in, sart a separate project initializing script
        "$LSRL_PATH/project-init.sh" iHopeThisSentenceDoesntExistInDictionaries "$2"
        exit 0

    else
        printf "\n$NAME <name> is required (check -h)\n\n"
        # tbh, i didn't put much thoughts into picking the exit codes
        exit 69
    fi
fi

# check for -r first
if [ "$1" = "--relaunch" ] || [ "$1" = "-r" ]; then

    # take $RICE_SET from current.txt, but only if its content is valid
    if [[ -f "$LSRL_PATH/current.txt" && -f "$LSRL_PATH/rice-sets/$(cat "$LSRL_PATH/current.txt")/rice.json" ]]; then
        RICE_SET=$(cat "$LSRL_PATH/current.txt")

    else # (fallback to axolotl)
        RICE_SET="axolotl"
    fi

# If "$1" isn't any of the flags AND isn't empty, $RICE_SET can take it
# but still... check if specified rice is valid
elif [[ -f "$LSRL_PATH/rice-sets/"$1"/rice.json" ]]; then
    RICE_SET="$1"

else
    printf "\n$NAME $1 not found\n\n"
    exit 3
fi

# "Close current rice set"
bash ~/lsrl-loaded/stop.sh

# "Replace symlink

# It's REALLY important to delete the link first because without doing that,
# the new symlink would just go inside the symlink and the current theme folder
rm ~/lsrl-loaded
ln -s "$LSRL_PATH/rice-sets/$RICE_SET" ~/lsrl-loaded

# "Start selected rice set"
bash ~/lsrl-loaded/start.sh

# Set GTK theme and icon theme
GTKT=$(cat ~/lsrl-loaded/rice.json | jq -r '.gtk_theme')
ICONT=$(cat ~/lsrl-loaded/rice.json | jq -r '.icon_theme')

gsettings set org.gnome.desktop.interface gtk-theme $GTKT
gsettings set org.gnome.desktop.interface icon-theme $ICONT

# Write selected rice set folder name to a file
echo "$RICE_SET" | tee "$LSRL_PATH/current.txt"

exit 0
