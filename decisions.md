## 2026-01-13 — Local git only, no remotes

Decision:
- This project uses **only local git**.
- No remotes will be added.
- No push operations will be performed unless explicitly authorized by the user.

Rationale:
- Prevent accidental publication.
- Maintain full local control over context, history, and artifacts.

Status: approved

Decision:
- The project enforces **canonical filenames**: `README.md`, `context.md`, `session.md`, `decisions.md`, `sessions/YYYY-MM-DD.md`.
- These files **must not** be renamed, replaced, split, or merged without explicit user approval.
- AI may edit contents of these files **only** with explicit instruction from the user.

Rationale:
- Ensures consistency, prevents accidental duplication, and preserves tooling expectations.

Status: approved

---

## 2026-01-14 — Language policy

Decision:
- English is the canonical language for all system, architecture, code, and database artifacts.
- Dutch is used for content, translations, and human-facing texts only.

Rationale:
- English minimizes ambiguity and aligns with tooling, models, and infrastructure.

Status: approved 

---

# Decisions — Local ai-systems

This document records **binding architectural decisions**.
Any deviation requires an explicit new decision and commit.

---

## 2026-01 — Single Source of Truth (SSOT)

### Decision
The **odroid-nas** is the Single Source of Truth (SSOT) for the entire system.

### Scope
- All source documents and generated outputs reside on the NAS
- The central database runs on the NAS
- Local git repositories are hosted on the NAS
- Worker nodes do not maintain independent truth or state

### Rationale
A distributed system with multiple workers and agents requires a single authoritative location to prevent divergence, duplication, and race conditions.

Status: approved 

---

## 2026-01 — Database Choice

### Decision
The central database is **PostgreSQL**, running on the NAS.

### Scope
- The database stores task state, metadata, locks, and progress
- Worker nodes connect directly to PostgreSQL over the local network
- File-based locking is explicitly disallowed as a source of truth
- A single database instance is authoritative for all nodes

### Rationale
Git repositories and filesystem state are insufficient for shared, concurrent task coordination at scale (70,000+ items).

Status: approved 

---

## 2026-01 — Node Role Separation

### Decision
All nodes have explicitly defined and fixed roles.

### Scope
- **odroid-nas**
  - Central storage
  - Database hosting
  - Local git repositories
  - Backup coordination
- **Worker nodes (RPi5)**
  - Execute tasks only
  - Maintain no long-term authoritative state
  - May fail or restart without system-wide impact

### Rationale
Clear separation of responsibilities increases system stability and simplifies recovery and scaling.

Status: approved 

---

## 2026-01 — File Sharing Protocol

### Decision
**NFS** is the primary file sharing protocol between the NAS and worker nodes.

### Scope
- Linux-native file sharing
- UID/GID-based permission model is authoritative
- SMB may be enabled optionally for human access only (read-only)

### Rationale
NFS provides better performance, simpler semantics, and more reliable behavior for Linux-based workers handling large numbers of small files.

Status: approved 

---

## 2026-01 — Truth and Output Model

### Decision
The system uses multiple representations with a strict hierarchy of truth.

### Scope
- **Database**: authoritative source for task state and progress
- **JSON**: primary machine-generated output from agents
- **Markdown**: derived, human-readable representation only

### Rationale
Markdown is unsuitable as machine truth. Structured data and transactional state must be handled by the database and JSON artifacts.

Status: approved 

---

## 2026-01 — Backup Strategy

### Decision
Backups are implemented using **rsync-based snapshot strategies** to multiple independent disks.

### Scope
- RAID is explicitly not considered a backup solution
- At least two additional backup disks are used
- Periodic snapshots (daily / weekly)
- Backups are pull-based from the NAS

### Rationale
Snapshot-based backups provide recoverability without unnecessary complexity or single points of failure.

Status: approved 

---

## 2026-01 — Git Usage Policy

### Decision
Git is used **locally only**, with no public or remote repositories by default.

### Scope
- Git stores code, scripts, schemas, documentation, and templates
- Git does not store task state or operational truth
- Adding a remote requires an explicit decision and documentation

### Rationale
Separating version control from operational state prevents accidental coupling and data corruption.

Status: approved 

---

## 2026-01 — Language Policy

### Decision
English is the canonical language for all system-level artifacts.

### Scope
- Architecture documents
- Decision records
- Code and scripts
- Database schemas and field names
- Status values and logs

Dutch (or other languages) are used exclusively for:
- Content
- Translations
- Human-facing texts and publications

### Rationale
English minimizes ambiguity and aligns with tooling, infrastructure, and AI model internals, while preserving Dutch for cultural and editorial content.

Status: approved 

## 2026-01-13 — odroid-nas bootstrap v1 completed

Decision:
- odroid-nas is configured as central infrastructure node (SSOT).
- `/mnt/backup` is the authoritative shared storage.
- NFS kernel server is used for LAN-wide file access (192.168.1.0/24).
- PostgreSQL is installed and running locally on odroid-nas.
- Verification scripts use `dpkg-query` instead of `dpkg -l`.

Non-goals:
- No filesystem changes or formatting.
- No database schema defined yet.
- No LAN exposure of PostgreSQL yet.

Status: approved

## 2026-01-14 — PostgreSQL LAN access enabled (odroid-nas)

Decision:
- PostgreSQL listens only on the fixed IP `192.168.1.10`.
- LAN access is allowed for subnet `192.168.1.0/24` via `pg_hba.conf`.
- Authentication method is `scram-sha-256`.
- A minimal technical role `worker` is created for future nodes.

Rationale:
- odroid-nas has a static IP and acts as SSOT.
- Limiting listen address reduces attack surface.
- No databases or schemas are exposed at this stage.

Status: approved

## 2026-01-14 — System language is English

Decision:
- The project’s system language is **English**.
- Dutch is only used for explicitly requested outputs, primarily summaries labeled **Summary (NL)** or translation deliverables.

Rationale:
- Improves compatibility with terminal tools and VS Code/Copilot.
- Prevents mixed-language drift and inconsistent agent behavior.

Status: approved

