# Infrastructure Inventory (v1)

## Control Node
- name: rpi5-ml
- role: control
- host: 192.168.1.47
- user: infra
- access: local 
- path: /home/infra/ai-systems

## Data Node
- name: odroid-nas
- role: data
- host: 192.168.1.10
- user: infra
- access: ssh
- path: /home/infra/ai-systems

## Sentinel Node
- name: sentinel-1
- role: watchdog
- host: 192.168.1.92
- user: infra
- access: ssh
- runtime_root: /home/infra/ai-systems/sentinel-runtime
