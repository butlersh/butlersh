help_list_command() {
    B_COMMAND_NAME='list'
    B_DESCRIPTION='List commands'
    B_ARGS=(
        'namespace'
        'The command namespace'
    )
    describe_command
}

run_list_command() {
    io_line "<success>$B_APP_NAME</success> version <comment>$B_APP_VERSION</comment>"
    io_line

    io_comment 'Usage:'
    io_line "  command [options] [arguments]"
    io_line

    io_comment 'Options:'
    describe_options 21 # The longest option signature is "-v|vv|vvv, --verbose"
    io_line

    io_comment "Available commands:"
    io_line '  <success>help</success>            Display help for a command'
    io_line '  <success>list</success>            List commands'
    io_comment ' mysql'
    io_line '  <success>mysql:setup</success>     Set up MySQL for the current server'
    io_comment ' nginx'
    io_line '  <success>nginx:setup</success>     Set up Nginx for the current server'
    io_comment ' php'
    io_line '  <success>php:setup</success>       Set up PHP for the current server'
    io_comment ' security'
    io_line '  <success>security:setup</success>  Set up security for the current server'

    exit 0
}
