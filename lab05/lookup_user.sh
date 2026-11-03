#!/bin/bash

read -p "Enter a username to look up: " TARGET_USER
LINE=$(grep -i "^$TARGET_USER," intel/users.csv | tr -d '\r')
if [ -z "$LINE" ]; then
    echo "$TARGET_USER: not found in intel/users.csv"
else
    echo "$LINE" | awk -F, '{print "User: " $1 " | role: " $2 " | status: " $3 " | dept: " $4}'
fi
