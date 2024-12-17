help_nginx_setup_command() {
    B_COMMAND_NAME='nginx:setup'
    B_DESCRIPTION='Set up Nginx for the current server'
    B_OPTS=(
        '--user=USER' 'The user is for running nginx workers <comment>[default: "www-data"]</comment>'
    )
    describe_command
}

run_nginx_setup_command() {
    F_USER="www-data"

    F_ARGS_COUNT=0

    for F_PARAM in "$@"
    do
        if [ "$F_PARAM" = 'nginx:setup' ]; then
            continue
        fi

        NAME="$(cut -d'=' -f1 <<<"$PARAM")"
        VALUE="$(cut -d'=' -f2 <<<"$PARAM")"

        if [ "$NAME" = '--user' ]; then
            F_USER="$VALUE"
        elif [[ "$F_PARAM" == -* ]] || [[ "$F_PARAM" == --* ]]; then
            io_print_error "The <comment>$F_PARAM</comment> option is unsupported." && exit 1
        else
            F_ARGS_COUNT=$(expr $F_ARGS_COUNT + 1)
        fi
    done

    if [ "$F_ARGS_COUNT" -gt "0" ]; then
        io_print_error "Too many arguments (expected: 0, given: $F_ARGS_COUNT)" && exit 1
    fi

    install_nginx $F_USER
}
