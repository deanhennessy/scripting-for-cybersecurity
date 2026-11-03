#!/bin/bash

IOC_FILE="intel/iocs.txt"
LOG_COUNT=0
TOTAL_MATCHES=0

while IFS= read -r -d '' LOGFILE; do
    LOG_COUNT=$((LOG_COUNT + 1))
    LINES=$(wc -l < "$LOGFILE")
    FAILED=$(grep -c "Failed password" "$LOGFILE" || true)
    MATCHES=0
    STOPPED=""

    while IFS= read -r INDICATOR; do
        [ -z "$INDICATOR" ] && continue
        if grep -qwF "$INDICATOR" "$LOGFILE"; then
            MATCHES=$((MATCHES + 1))
            if [ "$MATCHES" -ge 3 ]; then
                STOPPED="yes"
                break
            fi
        fi
    done < "$IOC_FILE"

    echo "File: $LOGFILE"
    echo "  Lines: $LINES"
    echo "  Failed logins: $FAILED"
    echo "  IOC matches: $MATCHES"
    if [ -n "$STOPPED" ]; then
        echo "  NOTE: check stopped early after 3 matches"
    fi
    echo

    TOTAL_MATCHES=$((TOTAL_MATCHES + MATCHES))
done < <(find case -type f -name "*.log" -print0)

echo "Logs scanned: $LOG_COUNT"
echo "Total IOC matches: $TOTAL_MATCHES"

if [ "$TOTAL_MATCHES" -eq 0 ]; then
    exit 0
else
    exit 1
fi
