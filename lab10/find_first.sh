#!/bin/bash

LOG="case/logs/firewall.log"
FOUND=""

while IFS= read -r INDICATOR; do
    if grep -qwF "$INDICATOR" "$LOG"; then
        FOUND="$INDICATOR"
        break
    fi
done < intel/iocs.txt

if [ -n "$FOUND" ]; then
    echo "First match in $LOG: $FOUND — stopping search."
else
    echo "No indicators from intel/iocs.txt found in $LOG."
fi
