#!/usr/bin/env bash

wget -qO- "https://raw.githubusercontent.com/butlersh/butlersh/main/server-cli.sh" > server-cli.sh

chmod +x server-cli.sh

mv server-cli.sh /usr/local/bin/butlersh
