#!/usr/bin/env bash
# copilot_shell_script.sh
# Changes the assignment name in config.env and reruns the app
set -euo pipefail

read -rp "Enter the new assignment name (e.g., Assignment_2): " new_assignment
if [ -z "$new_assignment" ]; then
  echo "You must enter an assignment name!"
  exit 1
fi

config_file="submission_reminder_honore/config/config.env"

if [ ! -f "$config_file" ]; then
  echo "Config file not found. Please run create_environment.sh first."
  exit 1
fi

# Replace the assignment name in config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=$new_assignment/" "$config_file"

echo "Assignment name changed to $new_assignment!"
echo "Running the app again..."
bash submission_reminder_honore/scripts/startup.sh
