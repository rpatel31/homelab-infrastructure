output "vm_id" {
  description = "immich VM ID"
  value       = module.immich.vm_id
}

output "vm_name" {
  description = "immich VM Name"
  value       = module.immich.vm_name
}

output "ipv4_address" {
  description = "immich VM IPv4 address "
  value       = module.immich.ipv4_addresses

}
