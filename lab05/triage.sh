#!/bin/bash

CASE_DIR="case"
REPORT="triage-report-auto.txt"

read -p "Enter your analyst name: " ANALYST
read -p "Enter the case reference: " CASE_REF

# Header
{
  echo "Triage Report (Automated)"
  echo "Analyst: $ANALYST"
  echo "Case Reference: $CASE_REF"
  echo "Date: $(date)"
  echo
} > "$REPORT"

# Counts (stored in variables so they can be reused)
PY_COUNT=$(find "$CASE_DIR" -type f -name "*.py" | wc -l)
SH_COUNT=$(find "$CASE_DIR" -type f -name "*.sh" | wc -l)

{
  echo "Total Files: $(find "$CASE_DIR" -type f | wc -l)"
  echo "Total Directories: $(find "$CASE_DIR" -mindepth 1 -type d | wc -l)"
  echo "Python Files: $PY_COUNT"
  echo "Shell Scripts: $SH_COUNT"
  echo "Log Files: $(find "$CASE_DIR" -type f -name "*.log" | wc -l)"
  echo "Configuration Files: $(find "$CASE_DIR" -type f \( -name "*.conf" -o -name "*.cfg" -o -name "*.ini" \) | wc -l)"
  echo "Empty Files: $(find "$CASE_DIR" -type f -empty | wc -l)"
  echo "Archives: $(find "$CASE_DIR" -type f \( -name "*.zip" -o -name "*.tar" -o -name "*.gz" -o -name "*.tgz" \) | wc -l)"
  echo
  echo "Files containing 'admin':"
  grep -rl "admin" "$CASE_DIR"
  echo
  echo "Detected file types:"
  find "$CASE_DIR" -type f -exec file {} +
  echo
  echo "Scripts (Python + shell): $((PY_COUNT + SH_COUNT))"
} >> "$REPORT"
