#!/bin/bash

# Improved DISPLAY detection: Try common displays or fallback
timeout=30
while [ $timeout -gt 0 ] && [ -z "$DISPLAY" ]; do
    # Check for active displays (adjust if needed)
    for disp in :0 :1; do
        if xset -display $disp q >/dev/null 2>&1; then
            DISPLAY=$disp
            break
        fi
    done
    if [ -z "$DISPLAY" ]; then
        sleep 1
        timeout=$((timeout - 1))
    fi
done

if [ -z "$DISPLAY" ]; then
    echo "No DISPLAY found, exiting."
    exit 1
fi

export DISPLAY
exec /usr/bin/conky -c conkyrc
