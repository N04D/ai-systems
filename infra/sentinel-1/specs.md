# Sentinel-1 — Watchdog & Node State  
**SPEC v1**

## Purpose

Sentinel-1 functions as:

- a central **watchdog** for all nodes  
- a central **status collector**  
- the **single source of truth** for node liveness and basic system status  

Sentinel **does not analyze**, **does not control**, and **does not decide**.  
It observes, records, and exposes state.

---

## Architectural Boundaries

- All logs and state are stored **locally** on the Sentinel node  
  (RPi3 with 128GB SD card).
- No dependency on NAS availability.
- No database writes.
- No project awareness.
- The NAS is **only checked for availability**, never used.

---

## Runtime Filesystem Layout (local to Sentinel)


/data/sentinel/
├── nodes/
│ └── /
│ ├── state.json
│ └── heartbeats.log
├── system/
│ ├── db_status.json
│ └── sentinel_state.json
├── intake/
│ └── events.log
└── README.md

Rules:

- File-based only.
- No symlinks.
- No mounts.
- No network filesystems.

---

## Node Identity

### Principle

**Hostname is not identity.**

Each node must have a **stable node identifier** that:

- is independent of hostname
- does not change accidentally
- is explicitly part of this system

### Canonical Node ID

Each node **must** have the file:


/etc/sentinel-node-id

Contents:

- a single UUID string
- read-only

Example:


a7f1b2c9-3e4d-4f8b-9a12-9c0d4e6a1f23

Fallback (only if required):

- `/etc/machine-id`

### Usage

- Sentinel uses **only `node_id`** for state correlation.
- `hostname` is stored only as a label and may change.

---

## Heartbeat Protocol (v1)

### Incoming Event (JSON, one line)

Each node periodically sends a heartbeat:

```json
{
  "node_id": "a7f1b2c9-3e4d-4f8b-9a12-9c0d4e6a1f23",
  "hostname": "pi3-sentinel",
  "type": "heartbeat",
  "ts": "2026-01-24T09:12:00Z",
  "specs": {
    "cpu": "ARMv8",
    "cores": 4,
    "ram_mb": 2048,
    "disk_gb": 128
  }
}

Transport (v1)
File append via ssh, scp, rsync, or equivalent
No HTTP required
Reliability is preferred over elegance
Sentinel stores events unchanged.

Sentinel Event Processing
Upon receiving an event:
Append unchanged to:
/data/sentinel/intake/events.log


Ensure the node directory exists:
/data/sentinel/nodes/<node-id>/


Update:
heartbeats.log (append-only)
state.json (overwrite)

Node State Format (state.json)
{
  "node_id": "a7f1b2c9-3e4d-4f8b-9a12-9c0d4e6a1f23",
  "hostname": "pi3-sentinel",
  "last_seen": "2026-01-24T09:12:00Z",
  "status": "online",
  "specs": {
    "cpu": "ARMv8",
    "cores": 4,
    "ram_mb": 2048,
    "disk_gb": 128
  },
  "score": "green"
}


Status & Scoring Rules
Let heartbeat_interval be a configured constant.
online
now - last_seen ≤ 2 × heartbeat_interval
stale
2 × interval < now - last_seen ≤ 5 × interval
offline
now - last_seen > 5 × interval
Score mapping:
online → green
stale → yellow
offline → red
No heuristics.
No ML.
No exceptions.

Database Health Checks
Sentinel periodically checks:
PostgreSQL: port 5432 reachable
InfluxDB: port 8086 reachable
Results are written to:
/data/sentinel/system/db_status.json

Format:
{
  "postgres": "up",
  "influxdb": "down",
  "last_check": "2026-01-24T09:15:00Z"
}

Rules:
No queries.
No credentials.
Reachability only.

Sentinel Self-State
Sentinel maintains its own state in:
/data/sentinel/system/sentinel_state.json

{
  "node": "sentinel",
  "uptime_seconds": 86400,
  "last_event_received": "2026-01-24T09:12:03Z"
}


Explicit Non-Responsibilities
Sentinel does not:
forward logs
aggregate data
trigger alerts
render a UI
mutate databases
make decisions
Sentinel observes and remembers. Period.

Done Criteria (v1)
This SPEC is considered correctly implemented when:
the directory structure exists exactly as defined
heartbeat events are processed correctly
node state transitions occur as specified
database reachability is correctly reflected
all behavior is file-based and reproducible





