help_php_setup_command() {
    B_COMMAND_NAME='php:setup'
    B_DESCRIPTION='Set up PHP for the current server'
    B_ARGS=(
        'version' 'The expected PHP version <comment>[e.g. "8.4"]</comment>'
    )
    B_OPTS=(
        '--user=USER' 'The user is for running PHP-FPM workers <comment>[default: "www-data"]</comment>'
        '--group=GROUP' 'The group is for running PHP-FPM workers <comment>[default: "www-data"]</comment>'
    )
    describe_command
}

function run_php_setup_command() {
    B_USER="www-data"
    B_GROUP="www-data"
    B_PHP_VERSION=""

    BT_ARGS_COUNT=0

    for PARAM in "$@"
    do
        if [ "$PARAM" = 'php:setup' ]; then
            continue
        fi

        NAME="$(cut -d'=' -f1 <<<"$PARAM")"
        VALUE="$(cut -d'=' -f2 <<<"$PARAM")"

        if [ "$NAME" = '--user' ]; then
            B_USER="$VALUE"
        elif [ "$NAME" = '--group' ]; then
            B_GROUP="$VALUE"
        elif [[ "$PARAM" == -* ]] || [[ "$PARAM" == --* ]]; then
            io_print_error "Unsupported option $PARAM" && exit 1
        else
            BT_ARGS_COUNT=$(expr $BT_ARGS_COUNT + 1)

            if [ -z $B_PHP_VERSION ]; then
                B_PHP_VERSION=$PARAM
            fi
        fi
    done

    if [ "$BT_ARGS_COUNT" -gt "1" ]; then
        io_print_error "Too many arguments (expected: 1, given: $BT_ARGS_COUNT)" && exit 1
    fi

    SUPPORTED_PHP_VERSIONS=("8.0" "8.1" "8.2" "8.3" "8.4")

    if [ -z "$B_PHP_VERSION" ]; then
        io_print_error 'The PHP version is required. Use --help for more details.' && exit 1
    fi

    if [[ ${SUPPORTED_PHP_VERSIONS[@]} =~ $VALUE ]]; then
        io_print_info "Installing PHP $B_PHP_VERSION"
    else
        io_print_error "The PHP version <comment>$B_PHP_VERSION</comment> is invalid or unsupported." && exit 1
    fi

    check_supported_os
    check_root_privileges

    export DEBIAN_FRONTEND=noninteractive

    apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8

    locale-gen en_US.UTF-8
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8

    apt-get install -y software-properties-common

    # TODO: Check if group exists.

    add-apt-repository -y ppa:ondrej/php

    apt-get update

    apt-get install -y \
        php"${B_PHP_VERSION}"-cli \
        php"${B_PHP_VERSION}"-curl \
        php"${B_PHP_VERSION}"-bcmath \
        php"${B_PHP_VERSION}"-fpm \
        php"${B_PHP_VERSION}"-gd \
        php"${B_PHP_VERSION}"-imap \
        php"${B_PHP_VERSION}"-intl \
        php"${B_PHP_VERSION}"-mbstring \
        php"${B_PHP_VERSION}"-mcrypt \
        php"${B_PHP_VERSION}"-mysql \
        php"${B_PHP_VERSION}"-pgsql \
        php"${B_PHP_VERSION}"-sqlite3 \
        php"${B_PHP_VERSION}"-xml \
        php"${B_PHP_VERSION}"-zip

    php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin/ --filename=composer

    # user = www-data
    sed -i "s/user = www-data/user = ${B_USER}/g" "/etc/php/${B_PHP_VERSION}/fpm/pool.d/www.conf";
    # group = www-data
    sed -i "s/group = www-data/group = ${B_GROUP}/g" "/etc/php/${B_PHP_VERSION}/fpm/pool.d/www.conf";

    # Change the pool name
    sed -i "s/\[www\]/\[PHP $B_PHP_VERSION\]/g" "/etc/php/$B_PHP_VERSION/fpm/pool.d/www.conf";

    systemctl restart php"${B_PHP_VERSION}"-fpm

    # Allow to run "sudo systemctl [reload|restart|status] php*-fpm" without password prompt.
    export PHP_FPM_ACTIONS="
$B_USER ALL=(ALL) NOPASSWD: /usr/bin/systemctl reload php*-fpm
$B_USER ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart php*-fpm
$B_USER ALL=(ALL) NOPASSWD: /usr/bin/systemctl status php*-fpm"
    if ! echo "${PHP_FPM_ACTIONS}" | tee "/etc/sudoers.d/$B_USER"; then
        io_print_warning "Can not configure /etc/sudoers.d/$B_USER file. You have to configure it by yourself."
    fi

    io_print_info "Installed PHP $B_PHP_VERSION"
}
