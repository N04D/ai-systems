# odroid-nas — Bootstrap v1

## Purpose
Bootstrap the odroid-nas node as the central infrastructure host.

This script is responsible for:
- verifying the NAS mount
- installing and configuring NFS (server)
- installing and enabling PostgreSQL

Nothing else.

## Explicit Non-Goals
- No disk formatting
- No filesystem changes
- No data migration
- No database schema creation
- No worker setup

## Assumptions
- OS: Ubuntu 20.04 LTS
- `/mnt/backup` exists and is correctly mounted
- Node is reachable on the local network only

## Idempotency
All scripts must be safe to run multiple times without changing correct state.
