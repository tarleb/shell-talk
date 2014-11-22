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

set_optimal_font_size ()
{
    local font="${1:-"${FONT}"}"
    readonly optimal_lines=25
    local font_size=16
    sleep 0.5
    while [ "$(tput lines)" -gt "${optimal_lines}" ]; do
        font_size=$(($font_size + 2))
        echo "\033]710;xft: ${font}:pixelsize=${font_size}\033\\"
        echo "\033]711;xft: ${font}:pixelsize=${font_size}:bold\033\\"
        sleep 0.5
    done
    echo $font_size;
}

set_terminal_font ()
{
    local font_size="${1}"
    local font="${2:-"${FONT}"}"
    if [ -z "${font_size}" ]; then
        set_optimal_font_size "$font"
    else
        # Set the fonts for this terminal
        echo "\033]710;xft: ${font}:pixelsize=${font_size}\033\\"
        echo "\033]711;xft: ${font}:pixelsize=${font_size}:bold\033\\"
    fi
}

set_spartanic_prompt ()
{
    # Reset precommand used by zsh
    precmd () true
    # Set the prompt to something simple
    PROMPT="%{$fg[magenta]%}%#%{$reset_color%} "
}

# Setup terminal with the desired fonts and colors
prepare_shell ()
{
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
append_talk_frame "title"

newframe "why" Warum\? "$(
    listitem Kryptisch
    listitem Fordert den Nutzer
    listitem Steilere Lernkurve als GUI
)"

newframe "reasons" Vorteile "$(
    listitem Funktioniert fast immer
    listitem Benutzbar über langsame Netzwerke
    listitem Gut dokumentiert
    listitem Kombinieren verschiedener Programme ist einfach
)"

newframe "unix" "Philosophie" "$(
    listitem Kleine Programme
    listitem Ein Program, eine Aufgabe
    listitem Kombinierbarkeit von Programmen
    with_font_color yellow \
        listitem Text ist das universelle Interface
)"

newframe "customization" "Benutzung" "$(
    listitem Prinzipien
    listitem Mögliche Befehle
    listitem Umgebung an Benutzer anpassen
    listitem Nicht nachgeben
)"

newframe "comfy" "Mach's dir bequem" "$(
    listitem Tastenkürzel
    listitem Aliase
    listitem Erscheinungsbild
    listitem Werkzeuge
    listitem Skripte
)"

newframe "scripting" "Skripten" "$(
    listitem Shell ist eine Programmiersprache
    listitem Repetitive Aufgaben gut automatisierbar
    listitem Skripte laufen auf vielen Systemen
)"

newframe "streams" "Streams" "$(
    listitem "0 Eingabe        stdin"
    listitem "1 Ausgabe        stdout"
    listitem "2 Fehlerausgabe  stderr"
)"

# Echo some thanks or the like at the end of the talk
thanks ()
{
    startframe "thanks"
    figlet -f big Das war\'s
    sleep 3
    clear
    echo "\n\n\n\n\n"
    cowsay -f moose Fragen\?
    echo "\n\n\n\n\n"
}

export TALK_FRAMES="title why reasons unix customization comfy scripting streams thanks"

magic_shell_art ()
{
    sed -e 's/\*/\x1b[34m*\x1b[0m/g'\
        -e "s/[.:;'\`]/\x1b[30m&\x1b[0m/g"\
        -e 's/|\?___|\?/\x1b[35;05m& \x1b[0m/g'\
        -e 's%_\{1,2\}[^_]\|[(/)]%\x1b[35m&\x1b[0m%g'\
        magic-shell.txt
}
