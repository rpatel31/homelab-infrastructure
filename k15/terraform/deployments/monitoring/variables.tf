variable "proxmox_endpoint" {
  description = "Proxmox API Endpoint"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API Token"
  type        = string
  sensitive   = true
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
}

variable "vm_id" {
  description = "VM ID"
  type        = number
}

variable "vm_name" {
  description = "VM Name"
  type        = string
}

variable "template_id" {
  description = "VM template ID "
  type        = number

}

variable "datastore_id" {
  description = "datastore for container root filesystem"
  type        = string
}

variable "cpu_cores" {
  description = "CPU cores assigned to lxc"
  type        = number
}

variable "memory_mb" {
  description = "Memory assigned to container in MB"
  type        = number
}

variable "disk_size_gb" {
  description = "file system size in GB"
  type        = number
}

variable "network_firewall" {
  description = "Enable proxmox firewall on container network interface"
  type        = bool
  default     = false
}

variable "vlan_id" {
  description = "Vlan tag set to container network, 0 mean untagged"
  type        = number

}
variable "network_bridge" {
  description = "network brdife used to vm"
  type        = string

}

variable "ipv4_address" {
  description = "IPv4 address or dhcp"
  type        = string

}

variable "ipv4_gateway" {
  description = "default gateway, leave null when using dhcp"
  type        = string

}

variable "dns_servers" {
  description = "DNS resolver config inside VM by cloudinit"
  type        = list(string)


}

variable "cloud_init_username" {
  description = "Init IaC user created by cloud-init"
  type        = string
  default     = "ansible"

}

variable "cloud_init_ssh_pub_key_path" {
  description = "ssh public key path for iac use by cloud-init"
  type        = string
  default     = "~/.ssh/homelab_iac.pub"

}

variable "tags" {
  description = "Tags for the VM"
  type        = list(string)

}