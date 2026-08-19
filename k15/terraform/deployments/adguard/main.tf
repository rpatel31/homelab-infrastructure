module "adguard" {
  source = "../../modules/debian_lxc"

  container_id = var.container_id
  hostname     = var.hostname
  node_name    = var.node_name
  template_id  = var.template_id

  datastore_id = var.datastore_id
  cpu_cores    = var.cpu_cores
  memory_mb    = var.memory_mb
  swap_mb      = var.swap_mb
  disk_size_gb = var.disk_size_gb

  network_bridge   = var.network_bridge
  network_firewall = var.network_firewall
  vlan_id          = var.vlan_id
  ipv4_address     = var.ipv4_address
  ipv4_gateway     = var.ipv4_gateway
  dns_servers      = var.dns_servers

  unprivileged  = true
  started       = true
  start_on_boot = true
  tags          = var.tags

}