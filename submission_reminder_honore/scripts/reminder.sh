#!/usr/bin/env bash
# reminder.sh - checks student submissions

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${script_dir}/functions.sh"

config_file="${script_dir}/../config/config.env"
data_file="${script_dir}/../data/submissions.txt"

load_config "$config_file"

echo "---------------------------------------"
echo "Checking submissions for $ASSIGNMENT"
echo "---------------------------------------"
echo "Students who HAVE NOT submitted:"
find_pending "$data_file" "$ASSIGNMENT" || echo "No pending submissions!"
