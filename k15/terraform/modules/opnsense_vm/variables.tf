variable "vm_name" {
  description = "Name of VM"
  type        = string
  default     = "opnsense"
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
  default     = 9001
}

variable "datastore_id" {
  description = "proxmox datastores for vm"
  type        = string
}




variable "cpu_cores" {
  description = "No of Virtual CPU cores assigned to VM"
  type        = number
  default     = 2
}

variable "cpu_type" {
  description = "CPU type exposed to VM"
  type        = string
  default     = "host"
}

variable "memory_mb" {
  description = "ded mem assigned to vm"
  type        = number
  default     = 6144
}

variable "wan_bridge" {
  description = "Proxmox bridge connected to opnsense WAN interface"
  type        = string
  default     = "vmbr0"

}

variable "lan_bridge" {
  description = "Proxmox bridge connected to opnsense LAN interface"
  type        = string
  default     = "vmbr1"

}

variable "lan_trunks" {
  description = "Optional, semicolon-seperated VLAN IDs passed to opnsense LAN interface"
  type        = string
  default     = "20;30;40"
}




variable "tags" {
  description = "Tags for the VM"
  type        = list(string)
  default     = ["opnsense", "firewall", "terraform"]
}



