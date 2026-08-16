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

variable "cloud_init_ssh_pub_keys" {
  description = "SSH pub key for intial cloud init ansible user"
  type        = list(string)

}



variable "tags" {
  description = "Tags for the VM"
  type        = list(string)
  default     = ["terraform"]
}



