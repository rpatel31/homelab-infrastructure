output "container_id" {
  description = "container ID"
  value       = proxmox_virtual_environment_container.this.vm_id
}

output "hostname" {
  description = "container hostname"
  value       = var.hostname
}

output "ipv4" {
  description = "IPv4 Address for container"
  value       = proxmox_virtual_environment_container.this.ipv4
}