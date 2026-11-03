#!/bin/bash

SURVEYED=0
FLAGGED=0
IOC_TOTAL=0

for FILE in case/evidence/* case/scripts/* case/logs/*; do
    # 1. skip anything that is not a regular file
    [ -f "$FILE" ] || continue

    SURVEYED=$((SURVEYED + 1))
    SIZE=$(wc -c < "$FILE")
    TYPE=$(file -b "$FILE")
    HASH=$(sha256sum "$FILE" | awk '{print $1}')

    # extension expectation (same logic as magic_check.sh)
    if [[ "$FILE" == *.png ]]; then
        EXPECT="PNG"
    elif [[ "$FILE" == *.zip ]]; then
        EXPECT="Zip"
    elif [[ "$FILE" == *.txt || "$FILE" == *.md || "$FILE" == *.log ]]; then
        EXPECT="text"
    elif [[ "$FILE" == *.bin ]]; then
        EXPECT="empty"
    elif [[ "$FILE" == *.dat ]]; then
        EXPECT="data"
    elif [[ "$FILE" == *.sh ]]; then
        EXPECT="shell script"
    elif [[ "$FILE" == *.py ]]; then
        EXPECT="Python"
    else
        EXPECT=""
    fi

    # 2. name, size, type
    echo "File: $FILE"
    echo "  Size: $SIZE bytes"
    echo "  Type: $TYPE"

    # 3. line count for text files
    if [[ "$TYPE" == *text* ]]; then
        echo "  Lines: $(wc -l < "$FILE")"
    fi

    # 4. hash
    echo "  SHA-256: $HASH"

    # 5. flag mismatches
    if [ -n "$EXPECT" ] && [[ "$TYPE" != *"$EXPECT"* ]]; then
        echo "  !! extension suggests '$EXPECT' but detected: $TYPE"
        FLAGGED=$((FLAGGED + 1))
    fi

    # 6. IOC counts for .log files
    if [[ "$FILE" == *.log ]]; then
        MATCHES=0
        for INDICATOR in $(cat intel/iocs.txt); do
            if grep -qwF "$INDICATOR" "$FILE"; then
                MATCHES=$((MATCHES + 1))
            fi
        done
        IOC_LINES=$(grep -cwFf intel/iocs.txt "$FILE" || true)
        echo "  IOC indicators present: $MATCHES"
        echo "  Lines containing an indicator: $IOC_LINES"
        IOC_TOTAL=$((IOC_TOTAL + MATCHES))
    fi
    echo
done

# 7. summary
echo "===== SUMMARY ====="
echo "Files surveyed: $SURVEYED"
echo "Files flagged: $FLAGGED"
echo "Total IOC matches: $IOC_TOTAL"
