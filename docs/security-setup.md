---
title: Security Setup
nextjs:
  metadata:
    title: Security setup
    description: Setting up security for a server
---

After creating a fresh server, we should use another user instead of root.
This command will help to create a new sudo user, disable SSH using root,
enable fail2ban, install a few common software and upgrade packages for better security purpose.

## Usage

Run this command with your expected username.

```bash
butlersh security:setup --user=forge
```

{% callout type="note" title="Choosing a username" %}
The username for many examples in this website is forge because it's inspired by Laravel Forge. You can choose another username instead.
{% /callout %}

A new sudo user called **forge** will be created. The default password is **secret**, you may change it using `passwd` command.

It also automatically copies keys from **/root/.ssh/authorized_keys** or **/home/ubuntu/.ssh/authorized_keys** to **/home/forge/.ssh/authorized_keys**. You may add others to **/home/forge/.ssh/authorized_keys** if necessary.

```bash
echo 'Another SSH key' >> /home/forge/.ssh/authorized_keys
```

Finally, please open a new tab on your computer to check if you can SSH into your server using **forge**

```bash
ssh forge@server-ip-address
```

{% callout type="warning" title="SSH connection" %}
It must NOT be able to ssh into your server using root.
{% /callout %}

## Firewall

Butlersh currently doesn't interact with either **iptable** or **ufw**. We recommend using firewall systems powered by server providers.
E.g., Both Hetzner Cloud and DigitalOcean have their solutions, and Amazon EC2 has security groups.
