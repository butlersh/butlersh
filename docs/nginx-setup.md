---
title: Nginx Setup
nextjs:
  metadata:
    title: Nginx Setup
    description: Setting up Nginx for a server
---

## Usage

Run this command with your expected user, which is for running nginx workers.

```bash
butlersh nginx:setup --user=forge
```

{% callout title="Configuration" %}
It automatically installs Nginx with [h5bp](https://github.com/h5bp/server-configs-nginx.git) configuration.
{% /callout %}
