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

# verify flag
if [ "$1" = "-t" ] || [ "$1" = "-b" ]; then

    # check if <text> and <file> is filled and valid
    if [[ ! -z "$2" && ! -z "$3" && -f "$3" ]]; then

        # check if <text> doesn't exist in <file> yet
        if [ $(cat "$3" | grep -c "$2") -eq 0 ]; then

            # append
            if [ "$1" = "-b" ]; then
                printf "\n\n" | tee -a "$3"
                echo "$2" | tee -a "$3"
                printf "\n" | tee -a "$3"
                printf "\ndone\n\n"
                exit 0

            # prepend
            elif [ "$1" = "-t" ]; then
                mv "$3" "$3"-temp
                echo "$2" > "$3"
                printf "\n" | tee -a "$3"
                cat "$3"-temp | tee -a "$3"
                rm "$3"-temp
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

    # if one of the fields is not filled
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
