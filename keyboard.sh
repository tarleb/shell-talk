#!/usr/bin/zsh

print_key ()
{
    key=$1
    colored_key=$(echo "\x1b[37;1m$key\x1b[0m")
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
        *)
            echo "ERROR: Unknown key: $key"
            ;;
    esac
}

print_keys ()
{
    cmd='paste -d" "'
    for key in "$@"; do
        cmd="$cmd <(print_key $key)"
    done
    eval $cmd
}
