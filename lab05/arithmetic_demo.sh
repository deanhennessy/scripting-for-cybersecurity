PERCENT_SCRIPTS=$((SCRIPTS * 100 / TOTAL_FILES))
echo "Scripts as % of all files: $PERCENT_SCRIPTS%"
echo "Wrong order: $((LOG_FILES / TOTAL_FILES * 100))"
