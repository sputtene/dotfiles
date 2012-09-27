#!/bin/bash

# Lock screen
# We use a shell script, since xautolock doesn't handle command line parameters for its locker
if [ "$(pidof alock)" ]; then
	exit 0
fi

alock -auth pam -bg blank -cursor theme:name=xtr
