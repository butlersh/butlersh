# GLOBAL variables starts with "B_"
B_APP_NAME='Butler'
B_APP_VERSION='latest'

B_AUTO_EXIT='yes'
B_DISABLE_OS_CHECK='yes'

B_NEEDS_HELP="no"
B_NEEDS_HELP_COMMAND=''
B_ANSI='yes'

# TODO: LOCAL variables in the main.sh. They should be different in order to be compared to GLOBAL variables.
B_COMMAND=''
B_OPTIONS=()
B_OPTIONS_STR=''
B_ARGUMENTS=()
B_ARGUMENTS_STR=''

for PARAM in "$@"
do
    NAME="$(cut -d'=' -f1 <<<"$PARAM")"

    if [ "$PARAM" = 'help' ]; then
        B_NEEDS_HELP='yes'
        B_NEEDS_HELP_COMMAND='help'
    elif [ "$NAME" = '--help' ]; then
        if [ "$PARAM" = '--help' ]; then
            B_NEEDS_HELP='yes'
        else
            io_print_error "The --help option does not accept a value"
            exit 1
        fi
    elif [ "$NAME" = '--version' ]; then
        if [ "$PARAM" = '--version' ]; then
            describe_version
        else
            io_print_error "The --version option does not accept a value"
            exit 1
        fi
    elif [[ "$PARAM" == -* ]]; then
        B_OPTIONS+=("$PARAM")
        B_OPTIONS_STR="$B_OPTIONS_STR $PARAM"
    elif [ -z "$B_COMMAND" ]; then
        B_COMMAND="$PARAM"
        B_NEEDS_HELP_COMMAND="$PARAM"
    else
        B_ARGUMENTS+=("$PARAM")
        B_ARGUMENTS_STR="$B_ARGUMENTS_STR $PARAM"
    fi
done

if [ $B_NEEDS_HELP = 'yes' ] && [ "$B_NEEDS_HELP_COMMAND" = 'help' ]; then
    run_help_command
fi

if [ $B_NEEDS_HELP = 'yes' ] && [ -z "$B_COMMAND" ]; then
    help_list_command
fi

if [ $B_NEEDS_HELP = 'yes' ] && [ "$B_COMMAND" != '' ]; then
    run_help_command "$B_COMMAND"
fi

if [ -z "$B_COMMAND" ]; then
    run_list_command
fi

run() {
    RUNNING_COMMAND="$1"

    shift

    case $RUNNING_COMMAND in
        "help")
            run_help_command "$@"
        ;;

        "list")
            run_list_command "$@"
        ;;

        "mysql:purge")
            run_mysql_purge_command "$@"
        ;;

        "mysql:setup")
            run_mysql_setup_command "$@"
        ;;

        "nginx:setup")
            run_nginx_setup_command "$@"
        ;;

        "php:setup")
            run_php_setup_command "$@"
        ;;

        "php:purge")
            run_php_purge_command "$@"
        ;;

        "security:setup")
            run_security_setup_command "$@"
        ;;

        *)
            io_print_error "The <comment>$RUNNING_COMMAND</comment> command was not found." && exit 1
        ;;
    esac
}

run "$B_COMMAND" $B_ARGUMENTS_STR $B_OPTIONS_STR
