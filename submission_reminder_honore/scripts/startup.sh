#!/usr/bin/env bash
# startup.sh - starts the reminder app
echo "Starting the Submission Reminder App..."
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "${script_dir}/reminder.sh"
