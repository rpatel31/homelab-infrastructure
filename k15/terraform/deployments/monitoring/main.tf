module "monitoring" {
  source = "../../modules/debian_vm"

  vm_id        = var.vm_id
  vm_name      = var.vm_name
  template_id  = var.template_id
  node_name    = var.node_name
  datastore_id = var.datastore_id

  cpu_cores    = var.cpu_cores
  memory_mb    = var.memory_mb
  disk_size_gb = var.disk_size_gb

  network_bridge = var.network_bridge
  ipv4_address   = var.ipv4_address
  ipv4_gateway   = var.ipv4_gateway
  dns_servers    = var.dns_servers

  cloud_init_username     = var.cloud_init_username
  cloud_init_ssh_pub_keys = [trimspace(file(pathexpand(var.cloud_init_ssh_pub_key_path)))]
  tags                    = var.tags

}