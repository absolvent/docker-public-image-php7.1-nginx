#!/bin/bash

# entrypoint.sh
# Script that is being executed during container's initialization

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
. $DIR/helpers.sh

### PARAMS:
LAST_PARAM="${@: -1}"


case "$LAST_PARAM" in
        help)
            exec $DIR/show_help.sh
            exit 0
            ;;
esac

# Update .env file
. "$DIR/env_secrets_expand.sh"

# Check if there is ENV variable defined and try to run a script matching ENV value from /env
if [[ ! -z "${APP_ENV}" ]]; then
      log_info "Environment variable defined: APP_ENV=$APP_ENV"

      ENV_SCRIPT_NAME=$(tr "[:upper:]" "[:lower:]" <<<"$APP_ENV")
      ENV_SCRIPT_PATH="$DIR/env/$ENV_SCRIPT_NAME.sh"

      if [ -f $ENV_SCRIPT_PATH ]; then
         log_info "Found environment script: $ENV_SCRIPT_PATH. Executing..."
         . "$ENV_SCRIPT_PATH"
         log_info "Script $ENV_SCRIPT_PATH. Execution finished. Continuing..."
      else
         echo "Environment script: $ENV_SCRIPT_PATH not found. Continuing..."
      fi
fi

case "$LAST_PARAM" in
        test)
            exec $DIR/run_tests.sh
            exit 0
            ;;
esac

# Run supervisord to handle nginx and php-fpm processes together
exec "$DIR/supervisord.sh"
