# Operational Runbook: Node Provisioning and Maintenance

## 1. Node Roles and Trust Levels

*   **Human Operator:** The single source of truth for all operational commands. Executes all procedures defined in this runbook.
*   **Nodes:** All nodes are considered untrusted execution environments by default. They are Raspberry Pi 5 devices running Debian 13. No node has privileged access to any other system beyond what is explicitly defined by its role's configuration.

## 2. Initial Node Provisioning Checklist

This checklist must be followed exactly by the Human Operator for every new node.

1.  [ ] **Flash OS:** Flash a fresh image of Debian 13 to the SD card.
2.  [ ] **Initial Boot:** Boot the Raspberry Pi 5.
3.  [ ] **Set Hostname:** Set a unique, descriptive hostname.
    ```bash
    sudo hostnamectl set-hostname <unique-node-name>
    ```
4.  [ ] **Configure Network:** Configure a static IP address or DHCP reservation to ensure a stable address. (Manual step, depends on network environment).
5.  [ ] **Update System:** Perform an initial system update.
    ```bash
    sudo apt update && sudo apt upgrade -y
    ```
6.  [ ] **Install Essential Packages:** Install a minimal set of required tools.
    ```bash
    sudo apt install -y git vim curl
    ```
7.  [ ] **Create User:** Create a standard, non-root user for all operations.
    ```bash
    sudo adduser <username>
    ```
8.  [ ] **Configure SSH:** Configure SSH for remote access, preferably with key-based authentication. Disable password authentication.
9.  [ ] **Clone Repository:** Clone the `ai-systems` repository into the user's home directory.
    ```bash
    git clone <repository-url>
    ```

## 3. Package Installation Rules

*   **Source:** All packages must be installed from the official Debian 13 repositories using `apt`.
*   **Explicitness:** Always specify the package name explicitly.
*   **Documentation:** Any installed package that is not part of the initial provisioning checklist must be documented in the project's `context.md` with a justification.
*   **No `pip` without `venv`:** Python packages must only be installed within a virtual environment (`.venv`).
*   **No `npm` `-g`:** Global Node.js packages are forbidden. All dependencies must be project-local.

## 4. Service Management Rules

*   **Tool:** All services must be managed using `systemd`.
*   **Commands:** Only `systemctl start`, `systemctl stop`, `systemctl enable`, `systemctl disable`, and `systemctl status` are permitted for managing service states.
*   **Unit Files:** All `systemd` unit files must be stored and versioned in the Git repository. They must be symlinked into `/etc/systemd/system/`.
*   **Logs:** Service logs must be accessible via `journalctl`.

## 5. Failure Handling and Escalation

*   **Identify:** The Human Operator must first identify the failing component (hardware, OS, application) using logs (`journalctl`), system status (`systemctl`), and diagnostics.
*   **Isolate:** Disconnect the failing node from the network if it poses a risk.
*   **Rollback:** The primary recovery strategy is rollback.
    *   For code issues: `git revert` the problematic commit.
    *   For system issues: Re-image the node.
*   **Escalation:** If the issue cannot be resolved by re-imaging and re-provisioning, the node is considered compromised or failed and must be decommissioned. Do not attempt complex, undocumented recovery procedures.

## 6. What The System Must Never Do

*   **Never Auto-Update:** The system must never update itself (OS or application code) without explicit, manual intervention from the Human Operator.
*   **Never Self-Heal:** Nodes must not have scripts or agents that attempt to automatically fix a failed state.
*   **Never Store Credentials:** No credentials, API keys, or secrets should be stored on the node's filesystem. They must be managed externally.
*   **Never Introduce Unaudited Code:** All code running on the node must originate from the version-controlled Git repository.
*   **Never Circumvent the Runbook:** All operational tasks must follow the procedures defined in this document.
