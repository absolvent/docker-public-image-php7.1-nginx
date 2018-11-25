#!/bin/bash

# show_help.sh
# Tries to display a help from file /help.md

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
. $DIR/helpers.sh

FILE=/help.md
if [ -f $FILE ]; then
   cat $FILE
else
   log_error "File $FILE does not exists. Sorry..."
fi
