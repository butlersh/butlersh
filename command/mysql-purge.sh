help_mysql_purge_command() {
    B_COMMAND_NAME='mysql:purge'
    B_DESCRIPTION='Purge MySQL from the current server'
    B_ARGS=(
        'version' 'The expected MySQL version <comment>[e.g. "8.0"]</comment>'
    )
    describe_command
}

run_mysql_purge_command() {
    F_ARGS_COUNT=0
    F_MYSQL_VERSION=
    
    for F_PARAM in "$@"
    do
        if [ "$F_PARAM" = 'mysql:purge' ]; then
            continue
        fi

        if [[ "$F_PARAM" == -* ]] || [[ "$F_PARAM" == --* ]]; then
            io_print_error "The <comment>$F_PARAM</comment> option is unsupported." && exit 1
        else
            F_ARGS_COUNT=$(expr $F_ARGS_COUNT + 1)

            if [ -z $F_MYSQL_VERSION ]; then
                F_MYSQL_VERSION=$F_PARAM
            fi
        fi
    done

    if [ "$F_ARGS_COUNT" -gt "1" ]; then
        io_print_error "Too many arguments (expected: 1, given: $F_ARGS_COUNT)" && exit 1
    fi

    purge_mysql80 && exit 0
}
