#!/bin/bash

# healthcheck.sh
# Script that is being executed every 30s to verify if the container is healthy, can be overwritten to adapt
# to the specific needs of the final image. If it returns 0 - container is considered as healthy, 1 - unhealthy

# Example: wget --quiet --tries=1 --spider http://localhost/ || exit 1
exit 0
