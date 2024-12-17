help_php_purge_command() {
    B_COMMAND_NAME='php:purge'
    B_DESCRIPTION='Purge PHP for the current server'
    B_ARGS=(
        'version' 'The expected PHP version <comment>[e.g. "8.4"]</comment>'
    )
    describe_command
}

run_php_purge_command() {
    F_ARGS_COUNT=0

    for PARAM in "$@"
    do
        if [ "$PARAM" = 'php:setup' ]; then
            continue
        fi

        if [[ "$PARAM" == -* ]] || [[ "$PARAM" == --* ]]; then
            io_print_error "The <comment>$PARAM</comment> option is unsupported." && exit 1
        else
            F_ARGS_COUNT=$(expr $F_ARGS_COUNT + 1)

            if [ -z $B_PHP_VERSION ]; then
                F_PHP_VERSION=$PARAM
            fi
        fi
    done

    if [ "$F_ARGS_COUNT" -gt "1" ]; then
        io_print_error "Too many arguments (expected: 1, given: $F_ARGS_COUNT)" && exit 1
    fi

    io_print_info "Purging PHP version $F_PHP_VERSION"

    apt-get purge -y "php$F_PHP_VERSION-*"

    io_print_info "Purged PHP version $F_PHP_VERSION"

    exit 0
}
