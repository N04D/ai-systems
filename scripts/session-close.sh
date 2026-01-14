#!/usr/bin/env bash
set -e

START_LINE=$(grep -i "Start" session.md || true)
START_TIME=$(echo "$START_LINE" | awk -F': ' '{print $2}')

if [ -z "$START_TIME" ]; then
  echo "ERROR: Start time not found in session.md"
  exit 1
fi

START_TS=$(date -d "$START_TIME" +"%s")
END_TS=$(date +"%s")

DURATION_SEC=$((END_TS - START_TS))
DURATION_H=$((DURATION_SEC / 3600))
DURATION_M=$(((DURATION_SEC % 3600) / 60))

STAMP=$(date +"%Y-%m-%d_%H%M")
END_HUMAN=$(date +"%Y-%m-%d %H:%M")

OUT="sessions/$STAMP.md"

mkdir -p sessions
cp templates/session-close.md "$OUT"

sed -i.bak \
  -e "s|YYYY-MM-DD_HHMM|$STAMP|g" \
  -e "s|YYYY-MM-DD HH:MM|$START_TIME|1" \
  -e "s|YYYY-MM-DD HH:MM|$END_HUMAN|2" \
  -e "s|Xh Ym|${DURATION_H}h ${DURATION_M}m|g" \
  "$OUT"

rm "$OUT.bak"

echo "Session archived to $OUT"
echo "Duration: ${DURATION_H}h ${DURATION_M}m"
echo "Remember to commit manually."
