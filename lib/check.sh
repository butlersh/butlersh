check_root_privileges() {
    F_USER=$(whoami)
    if [ "$F_USER" != 'root' ]; then
        io_print_error 'Please run this command/script as root.'
        exit 1
    fi
}

check_supported_os() {
    OS_DISTRO_NAME='unsupported'
    OS_RELEASE_NAME='unsupported'

    # If lsb_release exists, we'll it to determine OS_DISTRO_NAME and OS_RELEASE_NAME.
    if [ -f /usr/bin/lsb_release ]; then
        OS_DISTRO_NAME=${OS_DISTRO_NAME:-$(lsb_release -is)}
        OS_RELEASE_NAME=${OS_RELEASE_NAME:-$(lsb_release -cs)}
    # If /etc/os-release exists, we'll it to determine OS_DISTRO_NAME and OS_RELEASE_NAME.
    elif [ -f /etc/os-release ]; then
        if [ -n "$(cat /etc/os-release | grep ubuntu)" ]; then
            OS_DISTRO_NAME='ubuntu'
            OS_RELEASE_NAME=$(cat /etc/os-release | grep VERSION_CODENAME | cut -d'=' -f2)
        fi
    fi

    case "${OS_DISTRO_NAME}" in
        "Ubuntu" | "ubuntu")
            DISTRO_NAME="ubuntu"
            case "${OS_RELEASE_NAME}" in
                "noble" | "jammy" | "focal")
                    RELEASE_NAME="${OS_RELEASE_NAME}"
                ;;
                *)
                    RELEASE_NAME="unsupported"
                ;;
            esac
        ;;
        *)
            DISTRO_NAME="unsupported"
        ;;
    esac

    if [[ "${DISTRO_NAME}" == "unsupported" || "${RELEASE_NAME}" == "unsupported" ]]; then
        io_comment "This Linux distribution isn't supported yet."
        io_comment "If you'd like it to be, let us know!"
        io_comment "👉🏻 https://github.com/butlersh/butlersh/issues"
        exit 1
    fi
}
