---
title: Security setup
nextjs:
  metadata:
    title: Security setup
    description: Set up security for a fresh server
---

After creating a fresh server, we shouldn't use root. This command will create a new sudo user, disable SSH using root, install fail2ban,... for better security rules.

## Usage

Run this command with your expected username.

```bash
butlersh security:setup --user=forge
```

A new sudo user called **forge** will be created. The default password is **secret**, you may change it using `passwd` command.

It also automatically copies keys from **/root/.ssh/authorized_keys** or **/home/ubuntu/.ssh/authorized_keys** to **/home/forge/.ssh/authorized_keys**. You may add others to **/home/forge/.ssh/authorized_keys** if necessary.

```bash
echo 'Another SSH key' >> /home/forge/.ssh/authorized_keys
```

Finally, please open a new tab to check if you can SSH into your server using **forge**

```bash
ssh forge@server-ip-address
```

{% callout type="note" title="SSH connection" %}
Now, you can SSH using forge only, root is diabled.
{% /callout %}

## Firewalls

Butlersh currently doesn't interact with **iptable** or **ufw**. We recommend using network firewalls powered by server providers. E.g. Both Hetzner Cloud and DigitalOcean have their firewalls. Amazon EC2 has security groups.
