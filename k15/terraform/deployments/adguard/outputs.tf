output "container_id" {
  description = "Adguard container ID"
  value       = module.adguard.container_id
}

output "hostname" {
  description = "cAdguard ontainer hostname"
  value       = module.adguard.hostname
}

output "ipv4" {
  description = "Adguard IPv4 Address for container"
  value       = module.adguard.ipv4
}