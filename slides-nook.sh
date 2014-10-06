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

FONT="Droid Sans Mono"
FONT_SIZE=30

set_terminal_font ()
{
    local font_size=${1:-$FONT_SIZE}
    local font=${2:-$FONT}
    # Set the fonts for this terminal
    echo "\033]710;xft: ${font}:pixelsize=${font_size}\033\\"
    echo "\033]711;xft: ${font}:pixelsize=${font_size}:bold\033\\"
}

set_spartanic_prompt ()
{
    # Reset precommand used by zsh
    precmd () true
    # Set the prompt to something simple
    PROMPT="%{$fg[magenta]%}%#%{$reset_color%} "
}

# Setup terminal with the desired fonts and colors
prepare_terminal ()
{
    set_terminal_font
    set_spartanic_prompt
    # use emacs keybindings for once
    bindkey -e
    clear
}

##############################################################################
#  _____
# |  ___| __ __ _ _ __ ___   ___  ___
# | |_ | '__/ _` | '_ ` _ \ / _ \/ __|
# |  _|| | | (_| | | | | | |  __/\__ \
# |_|  |_|  \__,_|_| |_| |_|\___||___/
##############################################################################
title ()
{
    startframe "title"
    magic_shell_art
}

why ()
{
    startframe "why"
    frametitle Warum\?
    listitem Kryptisch
    listitem Fordert den Nutzer
    listitem Steilere Lernkurve als GUI
}


reasons ()
{
    startframe "reasons"
    frametitle Vorteile
    listitem Funktioniert fast immer
    listitem Benutzbar über langsame Netzwerke
    listitem Gut dokumentiert
    listitem Kombinieren verschiedener Programme ist einfach
}

unix()
{
    startframe "unix"
    frametitle Philosophie
    listitem Kleine Programme
    listitem Ein Program, eine Aufgabe
    listitem Kombinierbarkeit von Programmen
    anykey
    with_font_color yellow \
        listitem Text ist das universelle Interface
}

streams ()
{
    startframe "streams"
    frametitle Streams
    listitem "0 Eingabe        stdin"
    listitem "1 Ausgabe        stdout"
    listitem "2 Fehlerausgabe  stderr"
}

# Echo some thanks or the like at the end of the talk
thanks ()
{
    startframe "thanks"
    figlet -f big Das war\'s
    sleep 3
    clear
    figlet -f big Fragen\?
}

export TALK_FRAMES="title why reasons unix streams thanks"

magic_shell_art ()
{
    sed -e 's/\*/\x1b[34m*\x1b[0m/g'\
        -e "s/[.:;'\`]/\x1b[30m&\x1b[0m/g"\
        -e 's/|\?___|\?/\x1b[35;05m& \x1b[0m/g'\
        -e 's%_\{1,2\}[^_]\|[(/)]%\x1b[35m&\x1b[0m%g'\
        magic-shell.txt
}
