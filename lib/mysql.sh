install_mysql80 () {
  io_info "Start installing MySQL 8.0"

  debconf-set-selections <<< "mysql-server mysql-server/root_password password ${B_MYSQL_ROOT_PASSWORD}"
  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${B_MYSQL_ROOT_PASSWORD}"

  apt-get -y install mysql-server

  io_info "Finished installing MySQL 8.0"
}