container_id = 130
hostname     = "adguard"
node_name    = "pve"
template_id  = 9100
datastore_id = "local-lvm"

cpu_cores    = 2
memory_mb    = 2048
swap_mb      = 512
disk_size_gb = 8

network_bridge = "vmbr0"
network_firewall = false
vlan_id        = 0
ipv4_address   = "192.168.1.160/24"
ipv4_gateway   = "192.168.1.1"
dns_servers    = ["192.168.1.1"]

tags = ["adguard", "dns", "terraform", "ansible"]