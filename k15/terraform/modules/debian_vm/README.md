# Debian VM Module 

Reusable terraform module for deploying debian vms on PVE 

Modules Manages VM Infra Layer:

- Cloning Proxmox VM template
- VM id and hostname
- CPU and Memory
- Disk size and Datastore
- Network
- Static or DHCP IPv4
- DNS
- QEMU guest agent
- Cloud init bootstrap user
- SSH pub key
