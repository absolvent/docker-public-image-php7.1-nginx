# php7.1-nginx Help

This is the base image (from: bitnami/php-fpm:7.1) for php projects 
that contains a php-fpm and nginx configured during a container instantiation.

## Usage

### Build a new image based on php7.1-nginx
1. Create a Dockerfile with base image php7.1-nginx and copy 
your application code to `/app` folder and `index.php` or `index.html` 
file in `/app/public`. Copy files with `www-data` user rights:

    ```
    # Dockerfile
    FROM absolvent/php7.1-nginx
    COPY --chown=www-data:www-data ./your-example-data/   /app/public
    ```

2. Build a new image from the Dockerfile

3. Run the container and map the port 80 to your desired port

## Environmental scripts

If `APP_ENV` is defined, `entrypoint.sh` script is trying to run script 
from `/scripts/env/<APP_ENV_VALUE>.sh`

## Scripts

Initialization scripts used during container's instantiation are being 
located in folder `/scripts` 


### entrypoint.sh
Script that is being executed during container's initialization

### env_secrets_expand.sh
Iterates over `.env` file, searches for `{{DOCKER-SECRET:SECRET_NAME}}` texts 
and tries to replace them with a content of `/run/secrets/SECRET_NAME` files

### healthcheck.sh
Script that is being executed every 30s to verify if the container is healthy, 
can be overwritten to adapt to the specific needs of the final image. 
If it returns 0 - container is considered as healthy, 1 - unhealthy

### helpers.sh
Script with helper functions that can be used in other scripts.

### show_help.sh
Tries to display a help from file /help.md if available

### supervisord.sh
Script that executes a supervisor for handling multi-process image (nginx and php-fpm)

#############  END OF HELP  #############
