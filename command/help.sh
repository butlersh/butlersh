run_help_command() {
    if [ -z "$1" ]; then
        B_COMMAND_NAME='help'
        B_DESCRIPTION='Display help for a command'
        B_ARGS=(
            'command_name'
            'The command name <comment>[default: "help"]</comment>'
        )
        describe_command
    fi

    case $1 in
        "list")
            help_list_command
        ;;
        "mysql:setup")
            help_mysql_setup_command
        ;;
        "nginx:setup")
            help_nginx_setup_command
        ;;
        "php:setup")
            help_php_setup_command
        ;;
        "php:purge")
            help_php_purge_command
        ;;
        "security:setup")
            help_security_setup_command
        ;;
        *)
            io_print_error "The <comment>$RUNNING_COMMAND</comment> command was not found." exit 1
        ;;
    esac
}
