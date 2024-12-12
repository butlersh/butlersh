#!/usr/bin/env bash

CLI_NAME='butlersh'

rm -rf $CLI_NAME

echo '#!/usr/bin/env bash' > "$CLI_NAME"

LIBS=$(ls ./lib)

for LIB_FILE_NAME in $LIBS
do
  cat "lib/$LIB_FILE_NAME" >> "$CLI_NAME"
done

COMMANDS=$(ls ./command)

for COMMAND_FILE_NAME in $COMMANDS
do
  cat "command/$COMMAND_FILE_NAME" >> "$CLI_NAME"
done

cat main.sh >> "$CLI_NAME"

chmod +x "$CLI_NAME"
