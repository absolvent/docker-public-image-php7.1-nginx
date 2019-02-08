#!/usr/bin/env bash

# run_tests.sh
# @TODO

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
. $DIR/helpers.sh

log_info "running test"
log_info ${pwd}

./vendor/bin/phpunit --configuration phpunit.xml
