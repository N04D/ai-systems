# Sentinel — Health Checks  
**HEALTH_CHECKS v1**

## Purpose

This document defines **which system components Sentinel monitors** and **how their health is determined**.

Health checks are:
- shallow
- binary
- non-intrusive

Sentinel observes availability, **not correctness**.

---

## Scope

Sentinel health checks cover:

- database services running on the NAS
- Sentinel’s own runtime state

Health checks do **not** cover:
- data integrity
- query correctness
- performance metrics
- load or throughput
- application-level semantics

---

## Design Principles

- Reachability over introspection
- No credentials
- No queries
- No side effects
- Failure must be obvious

If a service answers on its port, it is considered *up*.

---

## Monitored Services

### PostgreSQL

- Host: NAS
- Port: `5432`
- Check method: TCP port reachability

Result values:
- `up` — port reachable
- `down` — port unreachable

Sentinel does not:
- authenticate
- open database sessions
- run queries

---

### InfluxDB

- Host: NAS
- Port: `8086`
- Check method: TCP port reachability

Result values:
- `up` — port reachable
- `down` — port unreachable

No HTTP requests are required in v1.

---

## Check Frequency

- Health checks run at a fixed interval
- Interval is configurable
- All checks run independently

Sentinel does not synchronize checks with node heartbeats.

---

## Health State Output

All health check results are written to:


/data/sentinel/system/db_status.json

### Format

json
{
  "postgres": "up",
  "influxdb": "down",
  "last_check": "2026-01-24T11:00:00Z"
}

Rules:
File is overwritten on each check
No historical health data is kept here
Timestamp reflects check execution time
---
Failure Semantics
A failed check does not trigger retries
A failed check does not trigger alerts
A failed check does not affect node status
Health checks are informational only.
---
Sentinel Self-Health
Sentinel maintains its own runtime state separately in:
/data/sentinel/system/sentinel_state.json

This includes:
uptime
last received event timestamp
Self-health is not merged with database health.
---
Explicit Non-Responsibilities
Health checks do not:
diagnose root causes
restart services
notify operators
escalate failures
infer partial availability
If a service is down, it is reported as down. Nothing more.
---
Summary
Sentinel health checks answer one question only:
“Is this service reachable right now?”
Anything beyond that is outside the scope of Sentinel v1.


