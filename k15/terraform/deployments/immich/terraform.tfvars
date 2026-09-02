vm_id        = 150
vm_name      = "immich"
node_name    = "pve"
template_id  = 9000
datastore_id = "local-lvm"
data_disk = {
  datastore_id = "samsung-lvm"
  size_gb      = 200
}

cpu_cores      = 4
memory_mb      = 8192
disk_size_gb   = 50
network_bridge = "vmbr1"
vlan_id        = 50
ipv4_address   = "10.10.50.10/24"
ipv4_gateway   = "10.10.50.1"
dns_servers    = ["192.168.1.160"]
on_boot        = true
tags           = ["VLAN50", "immich", "docker", "terraform", "ansible", "samsung-lvm"]