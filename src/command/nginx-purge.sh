help_nginx_purge_command() {
    B_COMMAND_NAME='nginx:purge'
    B_DESCRIPTION='Purge Nginx from the current server'
    describe_command
}

run_nginx_purge_command() {
    purge_nginx
}
