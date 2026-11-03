#!/bin/bash
# Exit codes: 0 found | 1 usage | 2 log missing | 3 not a regular file
#             4 unreadable | 5 empty search term | 6 not found in log

FIREWALL="case/logs/firewall.log"
IOCS="intel/iocs.txt"

if [ $# -ne 2 ]; then
    echo "Usage: $0 <logfile> <ip_or_username>" >&2
    exit 1
fi

LOGFILE=$1
TERM_ARG=$2

if [ ! -e "$LOGFILE" ]; then
    echo "Error: '$LOGFILE' does not exist" >&2
    exit 2
fi
if [ ! -f "$LOGFILE" ]; then
    echo "Error: '$LOGFILE' is not a regular file" >&2
    exit 3
fi
if [ ! -r "$LOGFILE" ]; then
    echo "Error: '$LOGFILE' is not readable" >&2
    exit 4
fi
if [ -z "$TERM_ARG" ]; then
    echo "Error: search term is empty" >&2
    exit 5
fi

if echo "$TERM_ARG" | grep -Eq '^[0-9]+(\.[0-9]+){3}$'; then
    TOTAL=$(grep -cwF "$TERM_ARG" "$LOGFILE")
    FAILED=$(grep "Failed password" "$LOGFILE" | grep -cwF "$TERM_ARG")

    echo "Type: IP address"
    echo "Occurrences in $LOGFILE: $TOTAL"
    echo "Failed password events: $FAILED"

    # TODO: replace with your Lab 7 thresholds
    if [ "$FAILED" -ge 5 ]; then
        echo "Risk: HIGH"
    elif [ "$FAILED" -ge 3 ]; then
        echo "Risk: MEDIUM"
    else
        echo "Risk: LOW"
    fi

    if grep -qwF "$TERM_ARG" "$FIREWALL"; then
        echo "Firewall entries:"
        grep -wF "$TERM_ARG" "$FIREWALL"
    else
        echo "Firewall entries: none"
    fi

    if grep -qxF "$TERM_ARG" "$IOCS"; then
        echo "IOC list: LISTED"
    else
        echo "IOC list: not listed"
    fi
else
    TOTAL=$(grep -c "for $TERM_ARG " "$LOGFILE")
    FAILS=$(grep -c "Failed password for $TERM_ARG " "$LOGFILE")
    ACCEPTS=$(grep -c "Accepted password for $TERM_ARG " "$LOGFILE")

    echo "Type: username"
    echo "Failed logins: $FAILS"
    echo "Accepted logins: $ACCEPTS"

    # TODO: replace these lists with your Lab 7, Part 5 logic
    CURRENT_USERS="alice bob"
    LEGACY_USERS="admin"
    if echo " $CURRENT_USERS " | grep -q " $TERM_ARG "; then
        echo "Account status: CURRENT"
    elif echo " $LEGACY_USERS " | grep -q " $TERM_ARG "; then
        echo "Account status: LEGACY"
    else
        echo "Account status: UNKNOWN"
    fi
fi

if [ "$TOTAL" -gt 0 ]; then
    echo "Result: '$TERM_ARG' FOUND in $LOGFILE"
    exit 0
else
    echo "Result: '$TERM_ARG' NOT FOUND in $LOGFILE"
    exit 6
fi
