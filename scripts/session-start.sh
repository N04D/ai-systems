#!/usr/bin/env bash
set -e

DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M")

if [ ! -f templates/active-session.md ]; then
  echo "ERROR: templates/active-session.md not found"
  exit 1
fi

cp templates/active-session.md session.md

sed -i.bak \
  -e "s|*(Replace with the current date)*|$DATE|g" \
  session.md

rm session.md.bak

echo "Active session started at $DATE $TIME"
echo "session.md created"
