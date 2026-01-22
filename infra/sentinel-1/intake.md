# Sentinel — Intake Protocol  
**INTAKE v1**

## Purpose

This document defines **how worker nodes deliver events to Sentinel**.

The intake layer is intentionally simple, reliable, and boring.
Its sole responsibility is to **accept events and persist them unchanged**.

No validation logic.  
No interpretation.  
No retries orchestration.

---

## Scope

Sentinel intake handles:

- heartbeat events
- status events
- error events

Sentinel intake does **not**:

- analyze content
- reject malformed events (unless structurally invalid)
- trigger actions
- modify payloads

---

## Accepted Transports (v1)

The following transports are allowed:

### 1. SSH append (preferred)

Nodes append events directly to Sentinel via SSH.

Example (conceptual):

bash
echo '<json-event>' | ssh sentinel 'cat >> /data/sentinel/intake/events.log'

### Characteristics:
simple
auditable
works on minimal systems
no daemon required

2. rsync append / file drop
Nodes may periodically transfer event files to Sentinel.
Rules:
files must be appended, not overwritten
file names must be unique per transfer
Example directory:
/data/sentinel/intake/incoming/

Sentinel may later consolidate these files.

### Disallowed Transports
The following are explicitly not allowed in v1:
HTTP / REST endpoints
message queues
databases
shared network filesystems (NFS, SMB)
direct writes outside intake paths
This keeps failure modes obvious and debuggable.

### Intake Filesystem Paths
Nodes may write only to:
/data/sentinel/intake/

Specifically:
/data/sentinel/intake/events.log

or subpaths explicitly created for intake.
Nodes must never write to:
/data/sentinel/nodes/
/data/sentinel/system/
any other Sentinel path
Violation = misbehaving node.

### Event Format Requirements
Each event:
must be valid JSON
must be exactly one line (JSONL)
must include:
node_id
type
ts (ISO 8601, UTC)
Events are not schema-validated at intake time.
Malformed lines may be logged but are not corrected.

### Ordering & Timing
Event ordering is best-effort
Sentinel does not reorder events
Clock skew between nodes is tolerated
ts is treated as node-reported time, not ground truth
Sentinel records receipt time separately if needed.

### Failure Handling
If intake fails:
the node retries on its own schedule
Sentinel does not signal errors back to nodes
partial writes are acceptable
duplicate events are acceptable
The system favors eventual visibility over strict guarantees.

### Security Model
Authentication is handled by SSH keys
Authorization is enforced by filesystem permissions
Sentinel does not parse or inspect event content for security decisions
Nodes are assumed to be authenticated but not trusted beyond their scope.

### Versioning
This document defines INTAKE v1.
Changes to intake behavior require:
updating this document
explicit version bump
coordinated rollout
Silent behavior changes are forbidden.

### Summary
Sentinel intake is intentionally minimal:
nodes send events
Sentinel stores them
nothing more happens here
All intelligence lives after intake, never inside it.
