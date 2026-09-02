# Homelab IaC Project

My aim here is to automate my homelab deployments and service provisioning using Terraform for VMs and LXCs. Ansible to configure the apps and other settings on each virtualized environment.

The set up will eventually have VLANS for private apps (immich, cloud file store), General apps VLAN (one or many vms) , one for wuzah another for Windows /AD testing/practice.

| layer               | responsibility                                       |
| ------------------- | ---------------------------------------------------- |
| Proxmox             | Runs VMs & LXC containers, storage and bridges       |
| Terraform           | Creates Infrastructure from reusable modules         |
| Ansible             | Configures OS and installs apps/services             |
| cloud init template | Provides minimum bootstrapped template               |
| Docker Compose      | To run containerised applications                    |
| tailscale           | Provide remote access and exit node                  |
| Opnsense            | Route and filter traffic betwwen vlans and tailscale |

Terraform uses the BPG Proxmox provider version 0.111.1

the project directory will follow this structure:

homelab-infrastructure/
└── k15/
├── terraform/
│ ├── modules/
│ │ ├── debian_vm/
│ │ ├── debian_lxc/
│ │ └── opnsense_vm/
│ │
│ └── deployments/
│ ├── opnsense/
│ ├── tailscale_exit_node/
│ └── adguard/
│
└── ansible/
├── ansible.cfg
├── inventory/
│ ├── hosts.yml
│ ├── group_vars/
│ │ └── all/
│ │ └── connection.yml
│ └── host_vars/
│
├── playbooks/
│ └── install_adguard.yml
│
└── roles/
├── common/
├── adguard/
├── docker/
├── grafana/
├── loki/
├── prometheus/
├── ssh_hardening/
├── tailscale/
├── users/
├── wazuh_agent/
└── wazuh_server/

## Proxmox Secrets

Proxmox API Credentials are stored locally in ubuntu's .config directory at ~/.config/homelab/secrets/proxmox-k15.env

To use the secrets before running terraform apply, the secrets need to be read into bash via:

source ~/.config/homelab/secrets/proxmox-k15.env
there are to variable for the secrets:
TF_VAR_proxmox_endpoint
TF_VAR_proxmox_api_token

## Network Design

VLAN 1 -> normal home LAN
VLAN 10 -> K15 / server network
VLAN 20 -> general lab
VLAN 30 -> Windows / Active Directory lab
VLAN 40 -> security lab
VLAN 50 -> Private apps

# terraform

Terraform is split into modules and deployments.

Modules Describe reusable infrastructure type such as VMs and LXCs

Current plan has the following modules:

    debian_vm
    debian_lxc
    opnsense_vm
    windows_vm

Deployements Represent real infrastructure instances.

Each deployment is an independant terraform root, therefore each deployement has its on state file.

# Cloud-init templates

## cloud-init vm template

Created one cloud-init debian 13 vm template in proxmox that terraform can then clone for specific deployements. This is to avoid installing debain and the repeated set up for a ansible user and ssh public key, qemu guest agent.
Terraform module located at: k15/terraform/modules/debian_vm.

## Setup Debian 13 cloud init template

1.  Download Debian 13 cloud image onto proxmox
2.  Create a base VM with VirtIO and attach cloud-init drive via proxmox gui
3.  Install and enable qemu guest agent
4.  convert VM into a template

NOTE: I use BPG provider cloud-init config to create the user and add ssh key.
user_account {
username = var.cloud_init_username
keys = var.cloud_init_ssh_pub_keys
}

The ssh key is stored at ~/.ssh/homelab_iac.pub

Another option i couldve and may use is, a custom cloud-init yaml snippet to create multiple users, ansible and my own.
This would require the proxmox api to have elevated storage permissions which includes the ability to destroy files/disks. Opted against this for the time being.

When testing the template, terraform recieved a 403 whilst attempting to read guest agent info.
This was down to lack of permissions on the terraformProvisioner, it was missing the VM.GuestAgent.Audit privillage.
Added the role :

pveum role modify TerraformProvisioner \
 --append 1 \
 --privs "VM.GuestAgent.Audit"

# Tailscale Exit Node

Deploy a tailscale exit node to enable remote access to browse through home broadband.

## VM Config

| Setting          | Value               |
| ---------------- | ------------------- |
| VM ID            | 110                 |
| Name             | tailscale-exit-node |
| Template         | 9000                |
| CPU              | 2 cores             |
| Memory           | 1024 MB             |
| Disk             | 8 GB                |
| Bridge           | vmbr0               |
| Address          | 192.168.1.155/24    |
| Gateway          | 192.168.1.1         |
| DNS              | 192.168.1.1         |
| Start on boot    | Enabled             |
| QEMU Guest Agent | Enabled             |

## set up

1. Terraform cloned Debian template 9000 as VM 110.
2. Cloud-init created the ansible automation account and installed the homelab_iac public key.
3. Terraform-triggered Ansible waited for SSH to become available.
4. Ansible created the administrator account with a separate homelab_admin key.
5. Ansible configured both accounts passwordless sudo.
6. SSH was hardened by disabling root login and password authentication.
7. Tailscale installation script was downloaded and executed.
8. `tailscaled` was enabled and started.
9. The reusable Tailscale auth key was read from Ansible Vault.
10. IPv4 and IPv6 forwarding were enabled in `/etc/sysctl.d/99-tailscale.conf`.
11. The node advertised as exit-node.
12. Exit node was approved in the Tailscale administration console.

## issues

### Terraform completed before SSH was ready

Cause: Proxmox had finished creating the VM, but Debian was still completing its first boot.

Fix: Add `ansible.builtin.wait_for_connection` with a 120-second timeout and five-second retry interval.

# AdGuard Home LXC

Provide opt-in DNS filtering without making the entire home network dependent on the K15 or OPNsense.

## LXC Config

| Setting               | Value              |
| --------------------- | ------------------ |
| CT ID                 | 130                |
| Template              | 9100               |
| Address               | 192.168.1.160/24   |
| Gateway/bootstrap DNS | 192.168.1.1        |
| Bridge                | vmbr0, no VLAN tag |
| CPU                   | 2 cores            |
| Memory                | 2048 MB            |
| Swap                  | 512 MB             |
| Disk                  | 8 GB               |
| Start on boot         | Enabled            |

## Setup

1.  Terraform cloned LXC template 9100 into CT 130.
2.  Validate SSH and sudo with the ansible account.
3.  Add the host to the Ansible inventory.
4.  Ran the common role to manage shared packages and APT cache refresh.
5.  Ran the adguard role
6.  Completed the initial web setup at http://192.168.1.160:3000
7.  Point selected clients at `192.168.1.160` and verify queries.

# Monitoring VM

Provide observability and monitoring into the K15 services using one monitoring VM.

## VM config

| Setting   | Value             |
| --------- | ----------------- |
| VM ID     | 140               |
| Name      | monitoring        |
| Address   | 10.10.10.10/24    |
| VLAN      | 10/server network |
| CPU       | 4 cores           |
| Memory    | 8192 MB           |
| Root disk | 80 GB             |

## Application setup

| Component      | Deployment                | Port/persistence                             |
| -------------- | ------------------------- | -------------------------------------------- |
| Node Exporter  | Native systemd service    | 9100                                         |
| Prometheus     | Docker container          | Host/container 9090 managed config           |
| Grafana        | Docker container          | Host/container 3000 volume grafana-data      |
| Shared network | Docker network monitoring | Container DNS between Prometheus and Grafana |

## Setup process

1. Terraform cloned VM 140 from Debian template 9000 onto VLAN 10.
2. Added monitoring at 10.10.10.10 to the Ansible inventory.
3. Use Ansible roles in this order:

- common
- docker
- monitoring
- prometheus
- node_exporter
- grafana

4. Install Node Exporter as a dedicated system user and service.
5. Create the external Docker network monitoring.
6. Deploy Prometheus Compose file and prometheus.yml.
7. Configure Prometheus to scrape its own endpoint and Node Exporter at 10.10.10.10:9100
8. Deploy Grafana in a separate Compose project on the same Docker network
9. Provision the Prometheus datasource at http://prometheus:9090
10. Log into Grafana and validate the datasource.

## Problems

### Desktop unable to reach the monitoring VM

Cause:The NetworkManager VLAN profile referenced the wrong parent connection/interface.

Fix: Correct the VLAN parent, activate the profile , and validate both 10.10.10.1`and 10.10.10.10

1.check parent ethernet interface and network manager with:
nmcli connection show
ip -br link 2. Add Vlan 10
sudo nmcli connection add \
 type vlan \
 con-name "homelab-vlan10" \
 ifname "eno1.10" \
 dev "eno1" \
 id 10
this created:

connection: homelab-vlan10
Interface: eno1.10
parent: eno1
vlan id: 10

3. give vlan10 a perma address, config desktop as 10.10.10.2/24

   sudo nmcli connection modify "homelab-vlan10" \
   ipv4.method manual \
   ipv4.addresses "10.10.10.2/24" \
   ipv4.gateway "" \
   ipv4.never-default yes \
   connection.autoconnect yes

4. Activate it
   sudo nmcli connection up "homelab-vlan10"

   verify with:
   ip -br address show eno1.10

### Prometheus needed the correct host target for Node Exporter

Cause: From inside a container, localhost:9100 refers to that container, not the VM's Node Exporter service.

Fix: change scrape ip 10.10.10.10:9100.
