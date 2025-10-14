#!/usr/bin/env bash
# create_environment.sh
# Creates submission_reminder_honore environment
set -euo pipefail

username="honore"
rootdir="submission_reminder_${username}"
echo "Creating environment in: ${rootdir}"

# Create structure
mkdir -p "${rootdir}/config"
mkdir -p "${rootdir}/scripts"
mkdir -p "${rootdir}/data"

# Create config.env
cat > "${rootdir}/config/config.env" <<'EOF'
ASSIGNMENT=Assignment_1
DUE_DATE=2025-12-31
NOTIFY_THRESHOLD_DAYS=2
EOF

# Create functions.sh
cat > "${rootdir}/scripts/functions.sh" <<'EOF'
#!/usr/bin/env bash
# functions.sh - helper functions

# load_config loads variables from config file
load_config() {
  local cfg="$1"
  if [ -f "$cfg" ]; then
    source "$cfg"
  fi
}

# find_pending prints names of students who haven't submitted
find_pending() {
  local file="$1"
  local assignment="$2"
  awk -F',' -v ASS="$assignment" 'NR>1 { if($3==ASS && tolower($4)=="not") print $2 }' "$file"
}
EOF

# Create reminder.sh
cat > "${rootdir}/scripts/reminder.sh" <<'EOF'
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
EOF

# Create submissions.txt (10 students)
cat > "${rootdir}/data/submissions.txt" <<'EOF'
ID,Name,Assignment,Status
1001,Alice,Assignment_1,submitted
1002,Bob,Assignment_1,not
1003,Charlie,Assignment_1,submitted
1004,David,Assignment_1,not
1005,Eve,Assignment_1,not
1006,Faith,Assignment_1,not
1007,George,Assignment_1,submitted
1008,Hannah,Assignment_1,not
1009,Isaac,Assignment_1,not
1010,Jane,Assignment_1,submitted
EOF

# Create startup.sh
cat > "${rootdir}/scripts/startup.sh" <<'EOF'
#!/usr/bin/env bash
# startup.sh - starts the reminder app
echo "Starting the Submission Reminder App..."
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "${script_dir}/reminder.sh"
EOF

# Add empty image file
touch "${rootdir}/image.png"

# Make all scripts executable
chmod +x "${rootdir}/scripts/"*.sh

echo "Environment created successfully!"
echo "To start the app, run:"
echo "bash ${rootdir}/scripts/startup.sh"
