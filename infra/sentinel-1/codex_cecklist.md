# Sentinel v1 — Codex Verification Checklist

## Purpose

This checklist defines **how to verify** that the Sentinel v1 implementation
conforms exactly to the specifications in:

- `specs.md`
- `INTAKE.md`
- `NODE_RECORD.md`
- `HEALTH_CHECKS.md`
- `SECURITY_BOUNDARIES.md`

Codex must answer **PASS** or **FAIL** per section.
Partial compliance is a FAIL.

---

## 1. Filesystem Layout

### Verify

- `/data/sentinel/` exists
- `/data/sentinel/intake/` exists
- `/data/sentinel/nodes/` exists
- `/data/sentinel/system/` exists

### Fail if

- any directory is missing
- extra runtime directories exist outside spec
- paths differ from spec

---

## 2. Sentinel Node Identity

### Verify

- `/etc/sentinel-node-id` exists
- file contains exactly one UUID
- file permissions are read-only
- file is not regenerated on restart

### Fail if

- hostname is used as identity
- node-id is derived dynamically
- file is overwritten or mutable

---

## 3. Intake Behavior

### Verify

- events are appended to `/data/sentinel/intake/events.log`
- events are stored unchanged
- one event per line (JSONL)
- duplicate events are tolerated
- no schema validation occurs at intake

### Fail if

- events are modified
- events are rejected based on content
- intake writes outside `/data/sentinel/intake/`
- intake logic exists in state-processing code

---

## 4. Node Directory Creation

### Verify

For each new `node_id`:

- `/data/sentinel/nodes/<node-id>/` is created
- directory name equals `node_id`
- no hostname-based directories exist

### Fail if

- hostname is used as primary key
- directories are nested incorrectly
- directories are deleted automatically

---

## 5. Heartbeat Logging

### Verify

- `heartbeats.log` exists per node
- heartbeats are append-only
- entries correspond to received events
- no aggregation or summarization occurs

### Fail if

- heartbeat history is overwritten
- heartbeats are filtered or deduplicated
- timestamps are altered

---

## 6. Node State File (`state.json`)

### Verify

Each `state.json` contains exactly:

- `node_id`
- `hostname`
- `last_seen`
- `status`
- `score`
- `specs`

And nothing outside spec.

### Verify Status Rules

- `online` if `now - last_seen ≤ 2 × interval`
- `stale` if `2 × interval < now - last_seen ≤ 5 × interval`
- `offline` if `now - last_seen > 5 × interval`

### Verify Score Mapping

- online → green
- stale → yellow
- offline → red

### Fail if

- extra fields exist
- status is inferred heuristically
- score deviates from mapping
- state is appended instead of overwritten

---

## 7. Health Checks

### Verify

- PostgreSQL check uses only port 5432 reachability
- InfluxDB check uses only port 8086 reachability
- no credentials are used
- no queries are executed

### Verify Output

- `/data/sentinel/system/db_status.json` exists
- file is overwritten on each check
- contains `postgres`, `influxdb`, `last_check`

### Fail if

- database sessions are opened
- HTTP APIs are used
- results affect node status
- historical health is stored

---

## 8. Sentinel Self-State

### Verify

- `/data/sentinel/system/sentinel_state.json` exists
- contains uptime
- contains last received event timestamp

### Fail if

- self-state is merged with node records
- sentinel state is written outside system path

---

## 9. Security Boundaries

### Verify

- worker nodes can write only to `/data/sentinel/intake/`
- workers cannot write to `nodes/` or `system/`
- Sentinel is the sole writer of node state
- SSH keys enforce identity

### Fail if

- workers can modify node records
- workers can overwrite system files
- Sentinel pushes data to workers

---

## 10. Explicit Non-Responsibilities

### Verify absence of:

- web UI
- alerting
- database writes
- task execution logic
- decision-making code

### Fail if

- any of the above exists in any form

---

## Final Verdict

Codex must return:

- **PASS** — if all sections pass
- **FAIL** — if any section fails

If FAIL:
- list exact violations
- reference the violated document and section
- no suggestions unless requested

No partial credit.



