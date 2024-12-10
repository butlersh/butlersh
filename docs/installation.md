---
title: Installation
nextjs:
  metadata:
    title: Installation
    description: Quidem magni aut exercitationem maxime rerum eos.
---

## Quick start

SSH into your server

```bash
ssh root@server-ip-address
```

Download the **installer.sh** file using curl or wget, and then execute it.

```bash
curl -o- https://butlersh-stg.confetticode.com/installer.sh | bash
```

```bash
wget -qO- https://butlersh-stg.confetticode.com/installer.sh | bash
```

Check if the Butlersh CLI is available after installation by running `butlersh` command.

```bash
butlersh
```

You should see the following output

```bash
Butlersh version dev-main

Usage:
  command [options] [arguments]

Options:
  -h, --help      Display help for the given command. When no command is given, display help for the list command
  -V, --version   Display this application version

Available commands:
  list            List commands
 mysql
  mysql:setup     Set up MySQL for the current server
 nginx
  nginx:setup     Set up Nginx for the current server
 php
  php:setup       Set up PHP for the current server
 security
  security:setup  Set up security for the current server
```

{% callout type="note" title="Supported OS" %}
Butlersh only supports Ubuntu 20.04, 22.04 and 24.04. You shouldn't run it on other Linux distros because the environment's incompatible.
{% /callout %}
