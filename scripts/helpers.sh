#!/bin/bash

# helpers.sh
# Script with helper functions that can be used in other scripts.

### LOGGERS ###

# usage: log_debug 'Hello World'
# Env LOG_LEVEL must by set to DEBUG
log_debug()
{
    if [ $(tr "[:upper:]" "[:lower:]" <<<"$LOG_LEVEL") == debug ]
    then
        log_message "DEBUG: $1"
    fi
}

# usage: log_info 'Hello World'
log_info()
{
    log_message "INFO: $1"
}

# usage: log_info 'Hello World'
log_error()
{
    log_message "ERROR: $1"
}

# usage: log_message 'Hello World'
log_message() {
    echo '['$(date +'%a %Y-%m-%d %H:%M:%S %z')']' $1
}
