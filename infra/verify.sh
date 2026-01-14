#!/usr/bin/env bash
set -euo pipefail

echo "== odroid-nas verification =="

# --- Mount -----------------------------------------------------------

if mountpoint -q /mnt/backup; then
  echo "OK: /mnt/backup is mounted."
else
  echo "FAIL: /mnt/backup is not mounted."
  exit 1
fi

# --- NFS -------------------------------------------------------------

if systemctl is-active --quiet nfs-server; then
  echo "OK: NFS server is running."
else
  echo "FAIL: NFS server is not running."
  exit 1
fi

exportfs -v | grep -q "/mnt/backup" \
  && echo "OK: /mnt/backup is exported via NFS." \
  || { echo "FAIL: NFS export missing."; exit 1; }

# --- PostgreSQL ------------------------------------------------------

if systemctl is-active --quiet postgresql; then
  echo "OK: PostgreSQL is running."
else
  echo "FAIL: PostgreSQL is not running."
  exit 1
fi

echo "Verification complete."
