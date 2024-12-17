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

Check if the ButlerShell CLI is available after installation by running `butler --version` command.

```bash
butler --version
```

You should see the following output

```bash
ButlerShell version dev-main
```

{% callout type="note" title="Supported OS" %}
ButlerShell only supports Ubuntu 20.04, 22.04 and 24.04. You shouldn't run it on other Linux distros because the environment's incompatible.
{% /callout %}
