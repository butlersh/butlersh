---
title: PHP
nextjs:
  metadata:
    title: PHP
    description: Install or remove PHP on a server
---

## Usage

Run this command with a specific PHP version (**8.0**, **8.1**, **8.3** or **8.4**).

```bash
butler php:setup 8.4 --user=forge --group=forge
```

> And Composer is also installed if it doesn't exist.

Remove a PHP version from the server.

```bash
butler php:purge 8.4
```
