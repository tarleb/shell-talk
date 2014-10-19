#!/bin/sh

# Copyright (c) 2014  Albert Krewinkel <albert+shell-talk@zeitkraut.de>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
# SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
# OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
# CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

##############################################################################
#        _                            _
#       | |    __ _ _   _  ___  _   _| |_
#       | |   / _` | | | |/ _ \| | | | __|
#       | |__| (_| | |_| | (_) | |_| | |_
#       |_____\__,_|\__, |\___/ \__,_|\__|
#                   |___/
##############################################################################


CURRENT_FRAME=""
TALK_FRAMES=""

startframe ()
{
    clear
    CURRENT_FRAME="$1"
}

# Print the title of this frame
frametitle ()
{
    figlet -f standard "$@"
    printf "\n"
}

append_talk_frame ()
{
    TALK_FRAMES="$TALK_FRAMES $1"
}

# Define a new static frame
newframe ()
{
    local framename="$1"
    local frametitle="$2"
    shift; shift
    # get content
    framecontent="$@"
    eval "\"$framename\" ()
    {
        startframe \"$framename\"
        frametitle \"$frametitle\"
        echo \"$framecontent\"
    }"
    append_talk_frame "$framename"
}

# Echo a single item within a list
listitem ()
{
    echo "  * $@\n"
}

press_anykey ()
{
    if [ -z "$1" ]; then
        read -s -q
    fi
}
alias anykey='press_anykey $1'

with_font_color ()
{
    change_to_color "$1"
    shift
    eval $@
    reset_color
}

change_to_color ()
{
    case "$1" in
        black)   printf '\x1b[30m';;
        red)     printf '\x1b[31m';;
        green)   printf '\x1b[32m';;
        yellow)  printf '\x1b[33m';;
        blue)    printf '\x1b[34m';;
        magenta) printf '\x1b[35m';;
        cyan)    printf '\x1b[36m';;
        white)   printf '\x1b[37m';;
    esac
}

reset_color ()
{
    printf '\x1b[0m'
}

##############################################################################
#         ____            _             _
#        / ___|___  _ __ | |_ _ __ ___ | |___
#	| |   / _ \| '_ \| __| '__/ _ \| / __|
#	| |__| (_) | | | | |_| | | (_) | \__ \
#        \____\___/|_| |_|\__|_|  \___/|_|___/
##############################################################################

talk_frames ()
{
    echo "$TALK_FRAMES" | tr ' ' "\n"
}

next_frame ()
{
    talk_frames | grep -A1 "$CURRENT_FRAME" | tail -n1
}

prev_frame ()
{
    talk_frames | grep -B1 "$CURRENT_FRAME" | head -n1
}

cur_frame ()
{
    talk_frames | grep "$CURRENT_FRAME"
}

start_talk ()
{
    eval $(talk_frames | head -n1)
}

next ()
{
    eval $(next_frame) "$@"
}

prev ()
{
    eval $(prev_frame) "$@"
}

cur ()
{
    eval $(cur_frame) "$@"
}
