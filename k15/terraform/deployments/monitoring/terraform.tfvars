vm_id        = 140
vm_name      = "monitoring"
node_name    = "pve"
template_id  = 9000
datastore_id = "local-lvm"

cpu_cores    = 4
memory_mb    = 8192
disk_size_gb = 80

network_bridge   = "vmbr1"
network_firewall = false
vlan_id          = 0
ipv4_address     = "10.10.10.10/24"
ipv4_gateway     = "10.10.10.1"
dns_servers      = ["192.168.1.1"]

tags = ["VLAN10", "monitoring", "grafana", "prometheus", "loki", "terraform", "ansible"]