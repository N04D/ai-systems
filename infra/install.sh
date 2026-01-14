#!/usr/bin/env bash
set -euo pipefail

echo "== odroid-nas bootstrap v1 =="

# --- 1. Verify mount -------------------------------------------------

MOUNTPOINT="/mnt/backup"

if ! mountpoint -q "$MOUNTPOINT"; then
  echo "ERROR: $MOUNTPOINT is not mounted. Aborting."
  exit 1
fi

echo "OK: $MOUNTPOINT is mounted."

# --- 2. Install NFS server ------------------------------------------

echo "Installing NFS server..."
sudo apt update
sudo apt install -y nfs-kernel-server

# --- 3. Configure NFS export ----------------------------------------

EXPORT_LINE="$MOUNTPOINT *(rw,sync,no_subtree_check,no_root_squash)"

if ! grep -q "^$MOUNTPOINT" /etc/exports; then
  echo "Configuring NFS export..."
  echo "$EXPORT_LINE" | sudo tee -a /etc/exports
else
  echo "NFS export already configured."
fi

sudo exportfs -ra
sudo systemctl enable nfs-server
sudo systemctl restart nfs-server

echo "OK: NFS server configured."

# --- 4. Install PostgreSQL ------------------------------------------

echo "Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib

sudo systemctl enable postgresql
sudo systemctl start postgresql

echo "OK: PostgreSQL is running."

echo "Bootstrap complete."
