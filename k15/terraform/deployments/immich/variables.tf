variable "vm_name" {
  description = "Name of VM"
  type        = string
}

variable "vm_id" {
  description = "proxmox vm id"
  type        = number
}

variable "node_name" {
  description = "Node on which VM willbe created"
  type        = string
}

variable "template_id" {
  description = "vm templated id to clone"
  type        = number
}

variable "datastore_id" {
  description = "proxmox datastores for vm"
  type        = string
}

variable "disk_size_gb" {
  description = "size of VM disk in GB"
  type        = number
  default     = 8

}

variable "cpu_cores" {
  description = "No of Virtual CPU cores assigned to VM"
  type        = number
}

variable "cpu_type" {
  description = "CPU type exposed to VM"
  type        = string
  default     = "host"
}

variable "memory_mb" {
  description = "ded mem assigned to vm"
  type        = number
  default     = 2048
}

variable "network_bridge" {
  description = "network brdife used to vm"
  type        = string
  default     = "vmbr0"
}

variable "ipv4_address" {
  description = "IPv4 address or dhcp"
  type        = string
  default     = "dhcp"
}

variable "ipv4_gateway" {
  description = "default gateway, leave null when using dhcp"
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "DNS resolver config inside VM by cloudinit"
  type        = list(string)
  default     = []

}

variable "cloud_init_username" {
  description = "username config by cloud init"
  type        = string
  default     = "ansible"
}

variable "cloud_init_ssh_pub_key_path" {
  description = "ssh public key path for iac use by cloud-init"
  type        = string
  default     = "~/.ssh/homelab_iac.pub"

}

variable "vlan_id" {
  description = "Vlan the vm/lxc communicates on"
  type        = number
  default     = null
}

variable "on_boot" {
  description = "Start VM/LXC when proxmox boots"
  type        = bool
  default     = true
}

variable "data_disk" {
  description = "Additional Disk for VMs attached as scsi1"
  type = object({
    datastore_id = string
    size_gb      = number
  })
  default = null
}



variable "tags" {
  description = "Tags for the VM"
  type        = list(string)
  default     = ["terraform"]
}


variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API token"
  type        = string
  sensitive   = true
}
