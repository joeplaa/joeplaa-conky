#!/usr/bin/env bash
# https://askubuntu.com/a/438611

## Pause
#sleep 10

## Run conky
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd ${SCRIPT_DIR}
conky -c conkyrc
