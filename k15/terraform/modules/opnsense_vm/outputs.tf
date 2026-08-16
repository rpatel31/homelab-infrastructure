output "vm_id" {
  description = "Proxmox VM ID"
  value       = proxmox_virtual_environment_vm.this.vm_id
}

output "vm_name" {
  description = "opnsense VM Name"
  value       = proxmox_virtual_environment_vm.this.name
}