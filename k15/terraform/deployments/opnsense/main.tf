module "opnsense" {
  source = "../../modules/opnsense_vm"

  vm_name      = var.vm_name
  vm_id        = var.vm_id
  template_id  = var.template_id
  node_name    = var.node_name
  datastore_id = var.datastore_id

  wan_bridge = var.wan_bridge
  lan_bridge = var.lan_bridge
  lan_trunks = var.lan_trunks

}
