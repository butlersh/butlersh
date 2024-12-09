---
title: Getting started
---

Learn how to install Butlersh in your server in under 1 minute. {% .lead %}

{% quick-links %}

{% quick-link title="Installation" icon="installation" href="/" description="Step-by-step guides to setting up your system and installing the library." /%}

{% quick-link title="Architecture guide" icon="presets" href="/" description="Learn how the internals work and contribute." /%}

{% quick-link title="Plugins" icon="plugins" href="/" description="Extend the library with third-party plugins or write your own." /%}

{% quick-link title="API reference" icon="theming" href="/" description="Learn to easily customize and modify your app's visual design to fit your brand." /%}

{% /quick-links %}

---

## Quick start

Download the installer.sh file and execute it.

```bash
wget -qO https://butlersh-stg.confetticode.com/installer.sh > installer.sh

bash installer.sh
```

Check if the butlersh cli is available after installation by running `butlersh` command.

```bash
Butlersh CLI version dev-main

Usage:
  command [options] [arguments]

Options:
  -h, --help         Display help for the given command. When no command is given display help for the list command
  -V, --version      Display this application version

Available commands:
  security:setup  Set up security for a fresh server
```

{% callout type="note" title="Supported OS" %}
Butlersh currently supports Ubuntu 20.04, 22.04 and 24.04 only.
{% /callout %}
