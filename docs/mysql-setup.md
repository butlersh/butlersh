---
title: MySQL Setup
nextjs:
  metadata:
    title: MySQL Setup
    description: Setting up MySQL for a server
---

## Usage

Run this command with a specific MySQL version, it currently supports 8.0 only.

```bash
butlersh mysql:setup 8.0
```

{% callout title="The root password" %}
The root password is "secret" by default. You may change it by using the "mysql_secure_installation" command.
{% /callout %}
