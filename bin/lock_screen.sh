#!/bin/bash

# Lock screen
# We use a shell script, since xautolock doesn't handle command line parameters for its locker
if [ "$(pidof alock)" ]; then
    exit 0
fi

# Turn off screen after a short time if requested.
if [ -r "${HOME}/.lock_blank_timeout" ]; then
    ( sleep $(<"${HOME}/.lock_blank_timeout")
        xset dpms force off
        rm "${HOME}/.lock_blank_timeout"
    ) &
fi

alock -auth pam -bg blank -cursor theme:name=xtr
