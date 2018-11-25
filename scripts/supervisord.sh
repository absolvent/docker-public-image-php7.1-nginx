#!/usr/bin/env bash

# supervisord.sh
# Script that executes a supervisor for handling multi-process image (nginx and php-fpm)

exec "/usr/bin/supervisord" -n -c "/etc/supervisord.conf"
