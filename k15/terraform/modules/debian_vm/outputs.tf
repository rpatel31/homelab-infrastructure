output "vm_id" {
  description = "Proxmox VM ID"
  value       = proxmox_virtual_environment_vm.this.vm_id
}

output "vm_name" {
  description = "VM Name"
  value       = proxmox_virtual_environment_vm.this.name
}

output "ipv4_addresses" {
  description = "IPv4 Address reported by QEMU guest agent"
  value       = proxmox_virtual_environment_vm.this.ipv4_addresses
}