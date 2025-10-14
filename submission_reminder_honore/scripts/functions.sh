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
