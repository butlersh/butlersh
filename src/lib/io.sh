io_line() {
    if [ "$B_ANSI" = 'yes' ]; then
        B_IO_LINE=$(echo "$1" | \
            sed 's/<success>/\\e[32m/g' | \
            sed 's/<\/success>/\\e[0m/g' | \
            sed 's/<info>/\\e[34m/g' | \
            sed 's/<\/info>/\\e[0m/g' | \
            sed 's/<comment>/\\e[33m/g' | \
            sed 's/<\/comment>/\\e[0m/g' | \
            sed 's/<error>/\\e[31m/g' | \
            sed 's/<\/error>/\\e[0m/g'
        )
    else
        B_IO_LINE=$(echo "$1" | \
            sed 's/<success>//g' | \
            sed 's/<\/success>//g' | \
            sed 's/<info>//g' | \
            sed 's/<\/info>//g' | \
            sed 's/<comment>//g' | \
            sed 's/<\/comment>//g' | \
            sed 's/<error>//g' | \
            sed 's/<\/error>//g'
        )
    fi

    echo -e "$B_IO_LINE"
}

io_success() {
    io_line "<success>$1</success>"
}

io_info() {
    io_line "<info>$1</info>"
}

io_comment() {
    io_line "<comment>$1</comment>"
}

io_error() {
    io_line "<error>$1</error>"
}

io_print_success() {
    if [ "$B_ANSI" = 'yes' ]; then
        io_line "\n  \e[42m SUCCESS \e[0m $1\n"
    else
        io_line "\n [SUCCESS] $1\n"
    fi
}

io_print_info() {
    if [ "$B_ANSI" = 'yes' ]; then
        io_line "\n  \e[44m INFO \e[0m $1\n"
    else
        io_line "\n [INFO] $1\n"
    fi
}

io_print_warning() {
    if [ "$B_ANSI" = 'yes' ]; then
        io_line "\n  \e[43m WARNING \e[0m $1\n"
    else
        io_line "\n [WARNING] $1\n"
    fi
}

io_print_error() {
    if [ "$B_ANSI" = 'yes' ]; then
        io_line "\n  \e[41m ERROR \e[0m $1\n"
    else
        io_line "\n [ERROR] $1\n"
    fi
}
