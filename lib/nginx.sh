install_nginx() {
    F_USER="$1"
    
    F_CONFIG_URL="https://raw.githubusercontent.com/butlersh/butlersh/main/config"
    
    check_supported_os
    check_root_privileges
    
    io_print_info "Start installing Nginx"

    export DEBIAN_FRONTEND=noninteractive
    export NEEDRESTART_MODE=a

    apt-get install -y software-properties-common
    
    add-apt-repository -y ppa:ondrej/nginx
    
    # Install nginx with certbot to use free SSL via Letsencrypt.
    apt-get install -y nginx certbot python3-certbot-nginx
    
    if [ -d /etc/nginx ]; then
        rm -rf /etc/nginx.old

        mv /etc/nginx /etc/nginx.old
    fi
    
    git clone https://github.com/h5bp/server-configs-nginx.git /etc/nginx
    
    mkdir -p /etc/nginx/extra
    
    wget -O fastcgi.conf "$F_CONFIG_URL/fastcgi.conf" --quiet
    wget -O fastcgi-php.conf "$F_CONFIG_URL/fastcgi-php.conf" --quiet
    
    mv fastcgi.conf /etc/nginx/extra/fastcgi.conf
    mv fastcgi-php.conf /etc/nginx/extra/fastcgi-php.conf
    
    sed -i "s/www-data/${F_USER}/g" /etc/nginx/nginx.conf;
    
    systemctl restart nginx
    
    io_print_info "Finished installing Nginx"
}

purge_nginx () {
  io_print_info "Start purging Nginx"

  apt-get -y purge nginx*

  io_print_info "Finished purging Nginx"
}
