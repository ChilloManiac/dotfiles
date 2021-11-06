#!/usr/bin/bash

# if no args exit
if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    exit 1
fi

# if pidof exists exit
if [ -x "$(command -v pidof)" ]; then
    pidof $1 > /dev/null
    if [ $? -eq 0 ]; then
        exit 0
    fi
else
    echo "pidof not found"
    exit 1
fi

# run the command
$@
