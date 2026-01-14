## 2026-01-13 — Local git only, no remotes

Decision:
- This project uses **only local git**.
- No remotes will be added.
- No push operations will be performed unless explicitly authorized by the user.

Rationale:
- Prevent accidental publication.
- Maintain full local control over context, history, and artifacts.

Status: approved## 2026-01-14 — Canonical filenames and write constraints

Decision:
- The project enforces **canonical filenames**: `README.md`, `context.md`, `session.md`, `decisions.md`, `sessions/YYYY-MM-DD.md`.
- These files **must not** be renamed, replaced, split, or merged without explicit user approval.
- AI may edit contents of these files **only** with explicit instruction from the user.

Rationale:
- Ensures consistency, prevents accidental duplication, and preserves tooling expectations.

Status: approved
