#!/bin/bash

# 1. Read username
read -p "Enter username: " USERNAME

# 2. Reject empty input
if [ -z "$USERNAME" ]; then
    echo "Error: username cannot be empty" >&2
    exit 1
fi

# 3. Where does the account come from? (same logic as account_source.sh)
ROLE=""
STATUS=""
if grep -q "^$USERNAME," intel/users.csv; then
    SOURCE="CURRENT"
    EXIT_CODE=0
    LINE=$(grep -m1 "^$USERNAME," intel/users.csv)
    ROLE=$(echo "$LINE" | cut -d, -f2)
    STATUS=$(echo "$LINE" | cut -d, -f3)
elif grep -qx "$USERNAME" case/backups/users.old; then
    SOURCE="LEGACY"
    EXIT_CODE=2
else
    SOURCE="UNKNOWN"
    EXIT_CODE=3
fi

echo "$USERNAME: $SOURCE account"
if [ "$SOURCE" = "CURRENT" ]; then
    echo "  Role: $ROLE"
    echo "  Status: $STATUS"
fi

# 4. Count failed / accepted logins (trailing space avoids matching e.g. admin2)
FAILED=$(grep -c "Failed password for $USERNAME " case/logs/auth.log)
ACCEPTED=$(grep -c "Accepted password for $USERNAME " case/logs/auth.log)
echo "  Failed logins:   $FAILED"
echo "  Accepted logins: $ACCEPTED"

# 5. Risk classification
RISK=$(./risk_level.sh "$FAILED")
echo "  Risk level: $RISK"

# 6. Warnings
if [ "$SOURCE" = "CURRENT" ] && [ "${STATUS,,}" = "disabled" ] && [ "$ACCEPTED" -gt 0 ]; then
    echo "  WARNING: disabled account has accepted logins!"
fi

if { [ "$SOURCE" = "LEGACY" ] || [ "$SOURCE" = "UNKNOWN" ]; } && [ "$FAILED" -gt 0 ]; then
    echo "  WARNING: $SOURCE account targeted by failed logins (attacker may be guessing names)"
fi

if [ "$SOURCE" = "CURRENT" ] && [ "$ACCEPTED" -gt 0 ] && grep -q "^$USERNAME:" case/evidence/passwords.txt; then
    echo "  WARNING: current account has accepted logins AND appears in passwords.txt (credentials exposed)"
fi

# 7. Exit code: 0 current, 2 legacy, 3 unknown
exit $EXIT_CODE
