variable "container_id" {
  description = "Proxmox container ID"
  type        = number

}

variable "hostname" {
  description = "Hostname for the container"
  type        = string
}

variable "node_name" {
  description = "Proxmox node on which container will be created"
  type        = string
}

variable "template_id" {
  description = "Proxmox LXC template ID to clone"
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

variable "swap_mb" {
  description = "Swap for contianer in MB"
  type        = number
  default     = 512
}

variable "network_firewall" {
  description = "Enable proxmox firewall on container network interface"
  type        = bool
  default     = false
}

variable "vlan_id" {
  description = "Vlan tag set to container network, 0 mean untagged"
  type        = number
  default     = 0
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

variable "unprivileged" {
  description = "Run lxc as unprivileged"
  type        = bool
  default     = true
}

variable "started" {
  description = "Start container after creation"
  type        = bool
  default     = true
}

variable "start_on_boot" {
  description = "Auto start container on host boot"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for the VM"
  type        = list(string)
  default     = ["terraform", "lxc"]
}
