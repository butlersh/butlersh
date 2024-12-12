help_mysql_setup_command() {
    B_COMMAND_NAME='mysql:setup'
    B_DESCRIPTION='Set up MySQL for the current server'
    B_ARGS=(
        'version'
        'The expected MySQL version <comment>[e.g. "8.0"]</comment>'
    )
    display_help
}

mysql80 () {
  echo "butlersh.INFO: Start installing MySQL $B_MYSQL_VERSION"

  debconf-set-selections <<< "mysql-server mysql-server/root_password password ${B_MYSQL_PASSWORD}"
  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${B_MYSQL_PASSWORD}"

  apt-get -y install mysql-server

  echo "butlersh.INFO: Finished installing MySQL $B_MYSQL_VERSION"
}

run_mysql_setup_command() {
  B_MYSQL_VERSION='8.0'

  # TODO: Should be customizable.
  B_MYSQL_PASSWORD="secret"

  B_MYSQL_VERSION=$1

  check_supported_os
  check_root_privileges

  export DEBIAN_FRONTEND=noninteractive

  case "$B_MYSQL_VERSION" in
      "8.0")
          mysql80
      ;;
      *)
          echo "butlersh.ERROR: Unsupported MySQL version $B_MYSQL_VERSION"
          exit 1
      ;;
  esac
}
