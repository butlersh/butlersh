B_COMMAND_NAME='command_name'
B_DESCRIPTION='Describe what the command does'
B_ARGS=()
B_OPTS=()
B_GLOBAL_OPTS=(
'-h, --help'
'Display help for the given command. When no command is given, display help for the <success>list</success> command'
'-q, --quiet'
'Do not output any message'
'-V, --version'
'Display this application version'
'--ansi|--no-ansi'
'Force (or disable --no-ansi) ANSI output'
'-n, --no-interaction'
'Do not ask any interactive question'
'-v|vv|vvv, --verbose'
'Increase the verbosity of messages: 1 for normal output, 2 for more verbose output and 3 for debug'
)

describe_arguments() {
    MAX_WIDTH=$1
    
    for DEF_ARG_LINE in "${B_ARGS[@]}"
    do
        if [ -z "$ARG_NAME" ]; then
            LINE_LEN="$(echo "$DEF_ARG_LINE" | wc -c)"
            SPACE_COUNT="$(expr $MAX_WIDTH - $LINE_LEN + 1)"
            SPACES=$(seq -s' ' $SPACE_COUNT | tr -d '[:digit:]')
            ARG_NAME="$DEF_ARG_LINE"
        else
            io_line "  <success>$ARG_NAME</success>$SPACES  $DEF_ARG_LINE"
            ARG_NAME=''
        fi
    done
}

describe_options() {
    MAX_WIDTH=$1
    
    for DEF_OPT_LINE in "${B_OPTS[@]}"
    do
        if [[ "$DEF_OPT_LINE" == --* ]]; then
            LINE_LEN="$(echo "$DEF_OPT_LINE" | wc -c)"
            LINE_LEN="$(expr $LINE_LEN + 4)"
            OPT_SIGNATURE="    <success>$DEF_OPT_LINE</success>"
        elif [[ "$DEF_OPT_LINE" == -* ]]; then
            LINE_LEN="$(echo "$DEF_OPT_LINE" | wc -c)"
            OPT_SIGNATURE="<success>$DEF_OPT_LINE</success>"
        else
            SPACE_COUNT="$(expr $MAX_WIDTH - $LINE_LEN + 1)"
            SPACES=$(seq -s' ' $SPACE_COUNT | tr -d '[:digit:]')
            io_line "  $OPT_SIGNATURE$SPACES  $DEF_OPT_LINE"
            OPT_SIGNATURE=''
        fi
    done

    for DEF_OPT_LINE in "${B_GLOBAL_OPTS[@]}"
    do
        if [[ "$DEF_OPT_LINE" == --* ]]; then
            LINE_LEN="$(echo "$DEF_OPT_LINE" | wc -c)"
            LINE_LEN="$(expr $LINE_LEN + 4)"
            OPT_SIGNATURE="    <success>$DEF_OPT_LINE</success>"
        elif [[ "$DEF_OPT_LINE" == -* ]]; then
            LINE_LEN="$(echo "$DEF_OPT_LINE" | wc -c)"
            OPT_SIGNATURE="<success>$DEF_OPT_LINE</success>"
        else
            SPACE_COUNT="$(expr $MAX_WIDTH - $LINE_LEN + 1)"
            SPACES=$(seq -s' ' $SPACE_COUNT | tr -d '[:digit:]')
            io_line "  $OPT_SIGNATURE$SPACES  $DEF_OPT_LINE"
            OPT_SIGNATURE=''
        fi
    done
}

describe_command() {
    # Detect the max width of an argument or option name
    MAX_WIDTH=0

    ARG_NAME=''
    for DEF_ARG_LINE in "${B_ARGS[@]}"
    do
        if [ -z "$ARG_NAME" ]; then
            ARG_NAME="$DEF_ARG_LINE"
            LINE_LEN="$(echo "$DEF_ARG_LINE" | wc -c)"
            if [ "$LINE_LEN" -gt "$MAX_WIDTH" ]; then
                MAX_WIDTH=$LINE_LEN
            fi
        else
            ARG_NAME=''
        fi
    done

    for DEF_OPT_LINE in "${B_GLOBAL_OPTS[@]}"
    do
        if [[ "$DEF_OPT_LINE" == --* ]]; then
            LINE_LEN="$(echo "$DEF_OPT_LINE" | wc -c)"
            LINE_LEN="$(expr $LINE_LEN + 4)"
        elif [[ "$DEF_OPT_LINE" == -* ]]; then
            LINE_LEN="$(echo "$DEF_OPT_LINE" | wc -c)"
        fi

        if [ "$LINE_LEN" -gt "$MAX_WIDTH" ]; then
            MAX_WIDTH=$LINE_LEN
        fi
    done

    for DEF_OPT_LINE in "${B_OPTS[@]}"
    do
        if [[ "$DEF_OPT_LINE" == --* ]]; then
            LINE_LEN="$(echo "$DEF_OPT_LINE" | wc -c)"
            LINE_LEN="$(expr $LINE_LEN + 4)"
        elif [[ "$DEF_OPT_LINE" == -* ]]; then
            LINE_LEN="$(echo "$DEF_OPT_LINE" | wc -c)"
        fi

        if [ "$LINE_LEN" -gt "$MAX_WIDTH" ]; then
            MAX_WIDTH=$LINE_LEN
        fi
    done

    # Description:
    io_comment 'Description:'
    io_line "  $B_DESCRIPTION"
    io_line

    # Usage:
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

    # Arguments:
    if [ "$ARG_PLACEHOLDER" != '' ]; then
        io_comment 'Arguments:'
        describe_arguments $MAX_WIDTH
        io_line
    fi

    # Options:
    io_comment 'Options:'
    describe_options $MAX_WIDTH

    if [ "$B_AUTO_EXIT" = 'yes' ]; then
        exit 0
    fi
}

describe_version() {
    if [ -z "$B_APP_NAME" ]; then
        B_APP_NAME='Butler'
    fi

    if [ -z "$B_APP_VERSION" ]; then
        B_APP_VERSION='latest'
    fi

    io_line "<success>$B_APP_NAME</success> version <comment>$B_APP_VERSION</comment>"

    exit 0
}
