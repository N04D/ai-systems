# Cluster Bootstrap Procedure (v1)

## Objective
Bring any number of nodes into a minimal operational cluster state.

## Per Node Actions
For each node defined in INVENTORY:

1. Ensure base directory exists:
   /home/infra/ai-systems

2. Ensure node identity:
   - Create node-id if missing
   - Never overwrite existing node-id

3. Ensure heartbeat sender exists:
   - heartbeat.sh present
   - Correct permissions

4. Emit one heartbeat:
   - No loops
   - No scheduling

## Completion Criteria
- All nodes have unique node-id
- All nodes successfully append a heartbeat to Sentinel
- No node modifies another node’s state
