# Cognitive Archive Memory Model

## 1. Memory Layers and Their Intent

The Cognitive Archive utilizes a layered memory model to manage information based on its intended persistence and scope.

*   **Layer 1: Working Memory (Short-Term)**
    *   **Intent:** To hold information for the duration of a single, atomic task execution. This includes the current instruction set, input data, and intermediate results required to complete the immediate command. It is volatile and task-specific.

*   **Layer 2: Session Memory (Warm-Term)**
    *   **Intent:** To maintain context within a single, continuous user interaction session. This allows for recalling information from previous turns within the same session. This memory is cleared or explicitly archived at the end of each session.

*   **Layer 3: Archival Memory (Long-Term)**
    *   **Intent:** To serve as the permanent, immutable, and auditable record of the system's knowledge. It stores foundational documents, decisions, and the verified outcomes of past operations. This layer is append-only.

## 2. What Qualifies as Memory

A piece of information is considered "memory" only if it meets the following criteria:

*   **Memory Is:**
    *   An explicit instruction or fact provided by a human operator.
    *   A version-controlled file within the repository (e.g., runbooks, definitions).
    *   A committed log entry of a successfully executed command and its output.
    *   An explicit, human-confirmed record of a decision or observation.

*   **Memory Is Not:**
    *   Transient data from command execution that is not explicitly committed (e.g., `stdout` that is not redirected and saved).
    *   Runtime state of any process.
    *   Inferred or derived conclusions that are not explicitly written and sourced.
    *   External data or web content that has not been explicitly imported and committed to the archive.

## 3. Source Traceability Requirements

Every entry in the Archival Memory (Long-Term) must have a verifiable and unambiguous source.

*   Each memory item must link directly to its origin (e.g., a commit hash, a line number in a session log, a path to a source file).
*   Memory cannot be created without a source.
*   Modification of existing Archival Memory is forbidden. New information that supersedes old information must be added as a new, timestamped entry, referencing the entry it supersedes.

## 4. Temporal Characteristics

*   **Short-Term (Working):** Exists only within the lifecycle of a single tool execution. It is discarded immediately after the task is complete.
*   **Warm-Term (Session):** Persists for the duration of an interactive session (e.g., from `session-start.sh` to `session-close.sh`). It does not persist across different sessions.
*   **Long-Term (Archival):** Permanent and immutable. It is designed to be queryable indefinitely.

## 5. What Memory Must Never Be Used For

The system's memory is subject to strict prohibitions to align with its role as an execution agent.

*   **Autonomous Action:** Memory must never be used to initiate any action not explicitly commanded by the Human Operator.
*   **Behavioral Change:** The system must not use memory to learn, adapt, or alter its fundamental behavior. All behavior is defined by version-controlled documents.
*   **Inference of Intent:** Memory shall not be used to infer, predict, or anticipate user intent.
*   **Storage of Secrets:** Memory must never contain secrets, credentials, API keys, or private user data.
*   **Moral or Normative Reasoning:** Memory must not be used as a basis for any form of moral or value-based judgment.
