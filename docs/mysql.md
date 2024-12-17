---
title: MySQL
nextjs:
  metadata:
    title: MySQL
    description: Install or remove MySQL on a server.
---

## Usage

Run this command with a specific MySQL version, it currently supports 8.0 only.

```bash
butler mysql:setup 8.0
```

{% callout title="The root password" %}
The root password is "secret" by default. You may change it by using the "mysql_secure_installation" command.
{% /callout %}

Remove MySQL from the server.

```bash
butler mysql:purge
```
