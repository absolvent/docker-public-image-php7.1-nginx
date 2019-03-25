#!/usr/bin/env bash

# supervisord.sh
# Script that executes a supervisor for handling multi-process image (nginx and php-fpm)
# If env variable have CRON then script use cron service only

config="/etc/supervisord.conf"

if [ ! -z $CRON ];then
    config="/etc/supervisord_cron.conf"
fi

exec "/usr/bin/supervisord" -n -c ${config}
