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
    
    F_LINES=(
        'help'              'Display help for a command'
        'list'              'List commands'
        'mysql:purge'       'Purge MySQL from the current server'
        'mysql:setup'       'Set up MySQL for the current server'
        'nginx:purge'       'Purge Nginx from the current server'
        'nginx:setup'       'Set up Nginx for the current server'
        'php:purge'         'Purse PHP from the current server'
        'php:setup'         'Set up PHP for the current server'
        'security:setup'    'Set up security for the current server'
    )
        
    F_MAX_WIDTH=0
    F_COMMAND=''

    for F_LINE in "${F_LINES[@]}"
    do
        if [ -z "$F_COMMAND" ]; then
            F_COMMAND="$F_LINE"
            F_COMMAND_LEN="$(echo "$F_COMMAND" | wc -c)"
            
            if [ "$F_COMMAND_LEN" -gt "$F_MAX_WIDTH" ]; then
                F_MAX_WIDTH=$F_COMMAND_LEN
            fi
        else
            F_COMMAND=''
        fi
    done

    io_comment "Available commands:"

    F_CURRENT_NAMESPACE=''

    for F_LINE in "${F_LINES[@]}"
    do
        if [ -z "$F_COMMAND" ]; then
            if [[ "$F_LINE" == *:* ]]; then
                F_LOOP_NAMESPACE=$(cut -d':' -f1 <<<"$F_LINE")
            fi

            F_COMMAND_LEN="$(echo "$F_LINE" | wc -c)"
            F_SPACE_COUNT="$(expr $F_MAX_WIDTH - $F_COMMAND_LEN + 1)"
            F_SPACES=$(seq -s' ' $F_SPACE_COUNT | tr -d '[:digit:]')
            F_COMMAND="$F_LINE"
        else
            if [ "$F_LOOP_NAMESPACE" != "$F_CURRENT_NAMESPACE" ]; then
                F_CURRENT_NAMESPACE="$F_LOOP_NAMESPACE"
                io_line " <comment>$F_CURRENT_NAMESPACE</comment>"
            fi
            io_line "  <success>$F_COMMAND</success>$F_SPACES  $F_LINE"
            F_COMMAND=''
        fi
    done

    exit 0
}
