variable "proxmox_endpoint" {
  description = "Proxmox API Endpoint"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API Token"
  type        = string
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
}

variable "datastore_id" {
  description = "datastore for opnsense vm"
  type        = string
}

variable "vm_id" {
  description = "VM Id for opnsense instance"
  type        = number
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}
variable "template_id" {
  description = "opnsense template vm id "
  type        = number

}

variable "lan_trunks" {
  description = "VLAN IDs allowed on OPNsense LAN trunk interface"
  type        = string
}

variable "wan_bridge" {
  description = "Proxmox bridge used by OPNsense WAN Interface"
  type        = string
}

variable "lan_bridge" {
  description = "Proxmox bridge used by OPNsense LAN trunk interface"
  type        = string
}
