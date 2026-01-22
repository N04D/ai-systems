# Sentinel — Node Record  
**NODE_RECORD v1**

## Purpose

This document defines **what Sentinel records per node**.

A node record is a **current snapshot**, not a history.
Historical data lives in logs; the node record reflects *now*.

The node record is the canonical source for:
- node status
- node identity
- basic hardware characteristics
- health scoring

---

## Design Principles

- One node = one record
- Records are overwritten, not appended
- Only Sentinel writes node records
- Nodes never write their own record directly

The node record must be:
- deterministic
- human-readable
- machine-parseable
- boring

---

## Record Location

For each node:


/data/sentinel/nodes//state.json

Where `<node-id>` is the stable identifier defined in `specs.md`.

---

## Mandatory Fields

Each node record **must** contain the following fields:

### `node_id`
- Type: string (UUID)
- Source: `/etc/sentinel-node-id`
- Immutable

### `hostname`
- Type: string
- Source: node-reported
- Informational only
- May change over time

### `last_seen`
- Type: string (ISO 8601 UTC)
- Meaning: timestamp of last received event

### `status`
- Type: string
- Allowed values:
  - `online`
  - `stale`
  - `offline`

### `score`
- Type: string
- Allowed values:
  - `green`
  - `yellow`
  - `red`

---

## Hardware Specs (`specs`)

The `specs` object describes **static or slow-changing properties**.

```json
"specs": {
  "cpu": "ARMv8",
  "cores": 4,
  "ram_mb": 2048,
  "disk_gb": 128
}

Rules:
values are node-reported
Sentinel does not validate correctness
updates overwrite previous values

Status Evaluation Rules
Status is derived solely from last_seen.
Let heartbeat_interval be a configured constant.
online
now - last_seen ≤ 2 × heartbeat_interval
stale
2 × heartbeat_interval < now - last_seen ≤ 5 × heartbeat_interval
offline
now - last_seen > 5 × heartbeat_interval
Sentinel never infers intent or cause.

Score Mapping
Status maps directly to score:
Status
Score
online
green
stale
yellow
offline
red

No alternative scoring models exist in v1.

Fields Explicitly Not Tracked
The following are out of scope and must not appear in the node record:
task history
error counts
performance metrics
log excerpts
IP addresses
credentials
uptime of worker nodes
subjective health indicators
If it is not listed, it does not belong here.

Example Record
{
  "node_id": "a7f1b2c9-3e4d-4f8b-9a12-9c0d4e6a1f23",
  "hostname": "pi5-worker-01",
  "last_seen": "2026-01-24T10:42:00Z",
  "status": "online",
  "score": "green",
  "specs": {
    "cpu": "ARMv8",
    "cores": 4,
    "ram_mb": 4096,
    "disk_gb": 64
  }
}


Lifecycle
Node record is created on first event
Node record is updated on every subsequent event
Node record is never deleted automatically
Manual cleanup, if ever required, is an administrative action.

Summary
The node record is:
a snapshot
authoritative
intentionally minimal
It answers one question only:
“What is the current state of this node?”




