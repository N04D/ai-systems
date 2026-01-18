# Development Workflow for Cognitive Archive

## 1. Scope and Intent

This document defines the standard development workflow for the Cognitive Archive repository. Its primary goals are:
- To enable AI assistance in proposing code changes and solutions.
- To ensure all modifications are fully auditable.
- To establish Git as the single, authoritative source of truth for the codebase.
- To operate effectively within a Debian 13 environment on Raspberry Pi 5.

## 2. Roles

*   **Human Developer:** Initiates tasks, reviews AI proposals, provides explicit instructions, and executes final commands (especially those modifying external systems or requiring privileged access). Responsible for validating AI output.
*   **Gemini (AI Execution Agent):** Acts strictly as an execution agent. Writes code and executes commands exactly as specified by the Human Developer. Runs tests and reports raw output. Commits changes with clear messages. Stops immediately on errors. Does not make architectural decisions, change goals, reinterpret specifications, introduce abstractions, or perform normative reasoning. A "Codex-style executor" implies strict, literal interpretation and execution of provided instructions.

## 3. Rules for File Creation and Modification

*   All meaningful changes, including new files and directories, must be part of a Git commit.
*   Code must be written exactly as specified.
*   Refactoring or "improvements" are forbidden unless explicitly instructed.
*   Files or folders must not be renamed unless explicitly instructed.

## 4. Git Discipline

*   **All work happens inside Git:** Every significant change must be committed. No uncommitted "experiments".
*   **Small, atomic commits:** One logical change per commit.
*   **Clear, descriptive commit messages:** Focus on the "why" and "what" of the change.
*   **No squashing** unless explicitly instructed.
*   **Default branch:** `main`.
*   Do not rebase or force-push.
*   Rollback is always preferred over patching forward.
*   History must remain readable.
*   **Pushing to Remotes:** To ensure the remote repository is always synchronized for external review (e.g., by Codex), local commits must be pushed to the configured remote (e.g., GitHub) immediately after being made. This is the default procedure.
    *   The purpose is for code review and synchronization of repository state.
    *   It is not for deployment or release.
    *   The push must always consist of one or more reviewable commits.

## 5. Error Handling and Stop Conditions

*   If a command fails, report the error verbatim.
*   Do NOT guess, retry automatically, or "fix" silently.
*   Identify the failing command.
*   Stop execution and wait for instruction.
*   If instructions conflict with `cognitive-archive/docs/architecture.md` or `cognitive-archive/docs/definitions.md`, stop, report the conflict, and do not proceed.

## 6. Explicitly Forbidden Actions

*   Making architectural decisions.
*   Changing goals or scope.
*   Reinterpreting specifications.
*   Introducing abstractions or improvements.
*   Performing normative or moral reasoning.
*   Changing database schemas on its own.
*   Modifying architecture or definitions (except under explicit human instruction and review).
*   Introducing new dependencies without explicit instruction.
*   Adding background services without explicit instruction.
*   Automating without bounds.
