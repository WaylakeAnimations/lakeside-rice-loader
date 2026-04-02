#!/bin/bash

if [ -z "$1" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    printf "\nlake's text appender

usage:
  appender.sh [flag] <text> <file>

check if <text> already exist, if not, append/prepend <text> and extra newlines
(just in case) to the bottom/top of <file>

flags:
  -h, --help   show this
  -t  place    <text> on the top of <file> (prepend)
  -b  place    <text> on the bottom of <file> (append)\n\n"
    exit 0
fi

# hacky-ish way to handle ~ inside quotes, of course, flush first in case it exist
rm /tmp/lslr-apd.txt
echo "$3" > /tmp/lslr-apd.txt
sed -i "s|~|${HOME}|g" /tmp/lslr-apd.txt

# store here
TEXT="$2"
FILE=$(cat /tmp/lslr-apd.txt)

# clean up after $FILE take it
rm /tmp/lslr-apd.txt

# verify flag
if [ "$1" = "-t" ] || [ "$1" = "-b" ]; then

    # check if <text> and <file> is filled and valid
    if [[ ! -z "$TEXT" && ! -z "$FILE" && -f "$FILE" ]]; then

        # check if <text> doesn't exist in <file> yet
        if [ $(cat "$FILE" | grep -c "$TEXT") -eq 0 ]; then

            # append
            if [ "$1" = "-b" ]; then
                printf "\n\n" | tee -a "$FILE"
                echo "$TEXT" | tee -a "$FILE"
                printf "\n" | tee -a "$FILE"
                printf "\ndone\n\n"
                exit 0

            # prepend
            elif [ "$1" = "-t" ]; then
                mv "$FILE" "$FILE"-temp
                echo "$TEXT" > "$FILE"
                printf "\n" | tee -a "$FILE"
                cat "$FILE"-temp | tee -a "$FILE"
                rm "$FILE"-temp
                printf "\ndone\n\n"
                exit 0

            # another invalid flag error catcher (just in case)
            else
                printf "\ninvalid flag\n\n"
                exit 64
            fi

        # if <text> already exist in <file>
        else
            printf "\nalready exists\n\n"
            exit 7
        fi

    else
        printf "\nlack of valid input(s)\n\n"
        exit 69
    fi

# if flag is invalid
else
    printf "\ninvalid flag\n\n"
    exit 64
fi

exit 0
