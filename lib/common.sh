B_COMMAND_NAME='command_name'
B_DESCRIPTION='Describe what the command does'
B_ARGS=(
'first'
'The first argument <comment>[default: "foobar"]</comment>'
)
B_GLOBAL_OPTS=(
"-h, --help"
"Display help for the given command. When no command is given, display help for the <success>list</success> command"
#"-q, --quiet"
#"Do not output any message"
"-V, --version"
"Display this application version"
#"-a, --ansi|--no-ansi"
#"Force (or disable --no-ansi) ANSI output"
#"-v|vv|vvv, --verbose"
#"Increase the verbosity of messages: 1 for normal output, 2 for more verbose output and 3 for debug"
)

display_help() {
    io_comment 'Description:'
    io_line "  $B_DESCRIPTION"
    io_line

    USAGE="$B_COMMAND_NAME [options]"

    ARG_PLACEHOLDER=''
    ARG_NAME=''
    for DEF_ARG_LINE in "${B_ARGS[@]}"
    do
        if [ -z "$ARG_NAME" ]; then
            ARG_NAME="$DEF_ARG_LINE"
            ARG_PLACEHOLDER="<$DEF_ARG_LINE>"
        else
            ARG_NAME=''
        fi
    done

    if [ "$ARG_PLACEHOLDER" != '' ]; then
        USAGE="$USAGE [--] $ARG_PLACEHOLDER"
    fi


    io_comment 'Usage:'
    io_line "  $USAGE"
    io_line

    MAX_LEN=0

    ARG_NAME=''
    for DEF_ARG_LINE in "${B_ARGS[@]}"
    do
        if [ -z "$ARG_NAME" ]; then
            ARG_NAME="$DEF_ARG_LINE"
            LINE_LEN="$(echo "$DEF_ARG_LINE" | wc -c)"
            if [ "$LINE_LEN" -gt "$MAX_LEN" ]; then
                MAX_LEN=$LINE_LEN
            fi
        else
            ARG_NAME=''
        fi
    done

    for DEF_OPT_LINE in "${B_GLOBAL_OPTS[@]}"
    do
        if [[ "$DEF_OPT_LINE" == -* ]]; then
            LINE_LEN="$(echo "$DEF_OPT_LINE" | wc -c)"
            if [ "$LINE_LEN" -gt "$MAX_LEN" ]; then
                MAX_LEN=$LINE_LEN
            fi
        fi
    done

    PRINT_LINE=''

    if [ "$ARG_PLACEHOLDER" != '' ]; then
        io_comment 'Arguments:'
    fi

    for DEF_ARG_LINE in "${B_ARGS[@]}"
    do
        if [ -z "$PRINT_LINE" ]; then
            LINE_LEN="$(echo "$DEF_ARG_LINE" | wc -c)"
            SPACE_COUNT="$(expr $MAX_LEN - $LINE_LEN + 1)"
            SPACES=$(seq -s' ' $SPACE_COUNT | tr -d '[:digit:]')
            PRINT_LINE="$DEF_ARG_LINE"
        else
            io_line "  <success>$PRINT_LINE</success>$SPACES  $DEF_ARG_LINE"
            PRINT_LINE=''
        fi
    done

    io_line

    io_comment 'Options:'

    for DEF_OPT_LINE in "${B_GLOBAL_OPTS[@]}"
    do
        if [[ "$DEF_OPT_LINE" == -* ]]; then
            LINE_LEN="$(echo "$DEF_OPT_LINE" | wc -c)"
            SPACE_COUNT="$(expr $MAX_LEN - $LINE_LEN + 1)"
            SPACES=$(seq -s' ' $SPACE_COUNT | tr -d '[:digit:]')
            PRINT_LINE="$DEF_OPT_LINE"
        else
            io_line "  <success>$PRINT_LINE</success>$SPACES  $DEF_OPT_LINE"
            PRINT_LINE=''
        fi
    done

    exit 0
}

export B_VERSION=${env:-dev-main}

display_version() {
  io_line "<success>Butlersh</success> version <comment>$B_VERSION</comment>"

  exit 0
}
