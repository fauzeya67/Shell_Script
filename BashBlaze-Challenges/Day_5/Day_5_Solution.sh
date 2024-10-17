#!/bin/bash

# Script to analyze log files and generate a summary report

# Check if a log file is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <log_file_path>"
    exit 1
fi

LOG_FILE="$1"
REPORT_FILE="summary_report_$(date +%Y%m%d).txt"
ARCHIVE_DIR="./archived_logs"

# Check if the log file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log file does not exist: $LOG_FILE"
    exit 1
fi

# Variables for counting
total_lines=0
error_count=0
declare -A error_messages

# Analyze log file
while IFS= read -r line; do
    total_lines=$((total_lines + 1))

    # Count error messages (keywords: ERROR, Failed)
    if [[ "$line" =~ ERROR|Failed ]]; then
        error_count=$((error_count + 1))

        # Keep track of error messages
        error_message=$(echo "$line" | grep -oP "(ERROR|Failed).*")
        ((error_messages["$error_message"]++))
    fi

    # Print critical events with line numbers
    if [[ "$line" =~ CRITICAL ]]; then
        echo "Critical event on line $total_lines: $line"
        echo "Critical event on line $total_lines: $line" >> "$REPORT_FILE"
    fi
done < "$LOG_FILE"# Generate report
{
    echo "Summary Report - $(date)"
    echo "Log file: $LOG_FILE"
    echo "Total lines processed: $total_lines"
    echo "Total error count: $error_count"
    echo "Top 5 error messages:"
    for error in "${!error_messages[@]}"; do
        echo "$error: ${error_messages[$error]}"
    done | sort -rn -k2 | head -n 5
    echo
    echo "Critical Events with Line Numbers"
    grep -n "CRITICAL" "$LOG_FILE" | tee -a "$REPORT_FILE"
} > "$REPORT_FILE"

# Optional enhancement: Archive processed log files
if [[ ! -d "$ARCHIVE_DIR" ]]; then
    mkdir -p "$ARCHIVE_DIR"
fi

mv "$LOG_FILE" "$ARCHIVE_DIR"

echo "Log analysis complete. Report saved to $REPORT_FILE"
echo "Log file moved to archive: $ARCHIVE_DIR"




