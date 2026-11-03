#!/bin/bash

for LOGFILE in case/logs/*.log; do
    echo "$LOGFILE: $(grep -c 'Accepted password' "$LOGFILE") accepted"
done
