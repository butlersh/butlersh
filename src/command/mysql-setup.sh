help_mysql_setup_command() {
    B_COMMAND_NAME='mysql:setup'
    B_DESCRIPTION='Set up MySQL for the current server'
    B_ARGS=(
        'version' 'The expected MySQL version <comment>[e.g. "8.0"]</comment>'
    )
    describe_command
}

run_mysql_setup_command() {
    # TODO: Should be customizable.
    B_MYSQL_ROOT_PASSWORD="secret"

    for PARAM in "$@"
    do
        if [[ "$PARAM" == -* ]] || [[ "$PARAM" == --* ]]; then
            io_print_error "Unsupported option $PARAM" && exit 1
        else
            B_MYSQL_VERSION="$PARAM"
        fi
    done

    if [ -z "$B_MYSQL_VERSION" ]; then
        io_print_error 'The MySQL version is required.' && exit 1
    fi

    check_supported_os
    check_root_privileges

    export DEBIAN_FRONTEND=noninteractive

    case "$B_MYSQL_VERSION" in
      "8.0")
          install_mysql80
      ;;
      *)
          io_print_error "The MySQL version <comment>$B_MYSQL_VERSION</comment> is invalid or unsupported." && exit 1
      ;;
    esac
}
