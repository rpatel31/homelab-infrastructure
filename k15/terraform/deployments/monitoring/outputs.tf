output "vm_id" {
  description = "Monitoring VM ID"
  value       = module.monitoring.vm_id
}

output "vm_name" {
  description = "Monitoring VM Name"
  value       = module.monitoring.vm_name
}

output "ipv4_address" {
  description = "Monitoring VM IPv4 address "
  value       = module.monitoring.ipv4_addresses

}