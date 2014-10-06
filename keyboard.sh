#!/usr/bin/zsh

export BEAUTIFY_PREV_WAS_ESC="no"

beautify_key ()
{
    [ "yes" = "${BEAUTIFY_PREV_WAS_ESC}" ] && printf 'Alt '
    local key="$1"
    case "$key" in
        '')
            printf 'Ctrl a' ;;
        '')
            printf 'Ctrl b' ;;
        '')
            printf 'Ctrl c' ;;
        '')
            printf 'Ctrl d' ;;
        '')
            printf 'Ctrl e' ;;
        '')
            printf 'Ctrl f' ;;
        '')
            printf 'Ctrl g' ;;
        '')
            printf 'Ctrl h' ;;
        '	')
            printf 'TAB' ;;
        '
')
            printf 'ENTER' ;;
        '')
            printf 'Ctrl k' ;;
        '')
            printf 'Ctrl n' ;;
        '')
            printf 'Ctrl m' ;;
        '')
            printf 'Ctrl n' ;;
        '')
            printf 'Ctrl o' ;;
        '')
            printf 'Ctrl p' ;;
        '')
            printf 'Ctrl q' ;;
        '')
            printf 'Ctrl r' ;;
        '')
            printf 'Ctrl s' ;;
        '')
            printf 'Ctrl t' ;;
        '')
            printf 'Ctrl u' ;;
        '')
            printf 'Ctrl v' ;;
        '')
            printf 'Ctrl w' ;;
        '')
            printf 'Ctrl x' ;;
        '')
            printf 'Ctrl y' ;;
        '')
            printf 'Ctrl z' ;;
        ' ')
            printf 'SPACE' ;;
        '')
            printf 'ESC' ;;
        '')
            printf 'DEL' ;;
        ?)
            printf "$key"
            ;;
    esac
}

print_key ()
{
    local key=$1
    local colored_key
    colored_key=$(printf "\x1b[1m%s\x1b[0m" "$key")
    case $key in
        ?)
            printf " ______ \n"
            printf "|\    /|\n"
            printf "| +--+ |\n"
            printf "| |%s | |\n" $colored_key
            printf "| +--+ |\n"
            printf "|/____\|\n"
            ;;
        ??)
            printf " _______ \n"
            printf "|\     /|\n"
            printf "| +---+ |\n"
            printf "| |%s | |\n" $colored_key
            printf "| +---+ |\n"
            printf "|/_____\|\n"
            ;;
        ???)
            printf " ________ \n"
            printf "|\      /|\n"
            printf "| +----+ |\n"
            printf "| |%s | |\n" $colored_key
            printf "| +----+ |\n"
            printf "|/______\|\n"
            ;;
        ????)
            printf " ________ \n"
            printf "|\      /|\n"
            printf "| +----+ |\n"
            printf "| |%s| |\n" $colored_key
            printf "| +----+ |\n"
            printf "|/______\|\n"
            ;;
        ?????)
            printf " _________ \n"
            printf "|\       /|\n"
            printf "| +-----+ |\n"
            printf "| |%s| |\n" $colored_key
            printf "| +-----+ |\n"
            printf "|/_______\|\n"
            ;;
        *)
            echo "ERROR: Unknown key: $key"
            ;;
    esac
}

print_keys ()
{
    local cmd
    cmd='paste -d" "'
    for key in "$@"; do
        curkey=$(print_key "${key}" | sed -e "s/'/'\"'\"'/g")
        cmd=$(printf "$cmd <(echo '%s')" "$curkey")
    done
    eval $cmd
}

show_keys_send_to ()
{
    local tmux_target_pane="$1"
    while read -sk k; do
        print_keys $(beautify_key "$k")
        if [ "$k" = '' ]; then
            BEAUTIFY_PREV_WAS_ESC=yes
        else
            BEAUTIFY_PREV_WAS_ESC=no
        fi
        tmux send-keys -t "$tmux_target_pane" "$k"
    done
}

show_keys_top_send_to ()
{
    local tmux_target_pane="$1"
    while read -sk k; do
        show_key_on_top "$k"
        if [ "$k" = '' ]; then
            BEAUTIFY_PREV_WAS_ESC=yes
        else
            BEAUTIFY_PREV_WAS_ESC=no
        fi
        tmux send-keys -t "$tmux_target_pane" "$k"
    done
}

delete_line ()
{
    printf "\033[2K\n"
}

save_cursor ()
{
    printf "\033\067"
}

cursor_initial_pos ()
{
    printf "\033[f"
}

cursor_restore ()
{
    printf "\033\070"
}

show_key_on_top ()
{
    save_cursor
    cursor_initial_pos
    for i in {1..7}; do
        delete_line
    done
    cursor_initial_pos
    print_keys $(beautify_key "$1")
    cursor_restore
}
