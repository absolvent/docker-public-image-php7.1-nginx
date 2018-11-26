#!/bin/bash

# env_secrets_expand.sh
# Iterates over .env file, searches for {{DOCKER-SECRET:SECRET_NAME}} texts and tries to
# replace them with a content of /run/secrets/SECRET_NAME files

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
. $DIR/helpers.sh

SECRET_DIR="/run/secrets"
ENV_FILE="/app/.env"

if [ -f "$ENV_FILE" ]; then
    while read -r ENV_LINE
    do
        ENV_KEY=$(echo ${ENV_LINE} | cut -d= -f 1)
        ENV_VALUE=$(echo ${ENV_LINE} | cut -d= -f 2)

        secret="${SECRET_DIR}/${ENV_KEY}"
        if [ -f "$secret" ]; then
            sed -i.bak -e "s/^${ENV_KEY}=.*/${ENV_KEY}=$(cat ${secret})/g" "${ENV_FILE}"
        fi
    done<"${ENV_FILE}"
else
    echo "No .env file found."
fi
