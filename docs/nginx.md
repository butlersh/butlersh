---
title: Nginx
nextjs:
  metadata:
    title: Nginx
    description: Install or remove Nginx on a server
---

## Usage

Run this command with your expected user, which is for running nginx workers.

```bash
butler nginx:setup --user=forge
```

{% callout title="Configuration" %}
It automatically installs Nginx with [h5bp](https://github.com/h5bp/server-configs-nginx.git) configuration.
{% /callout %}

Remove Nginx from the server.

```bash
butler nginx:purge
```
