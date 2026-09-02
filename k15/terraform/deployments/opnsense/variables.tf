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

variable "template_id" {
  description = "opnsense template vm id "
  type        = number

}
