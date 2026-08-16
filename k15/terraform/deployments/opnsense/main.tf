module "opnsense" {
  source = "../../modules/opnsense_vm"

  vm_name      = "opnsense"
  vm_id        = var.vm_id
  template_id  = var.template_id
  node_name    = var.node_name
  datastore_id = var.datastore_id

  wan_bridge = "vmbr0"
  lan_bridge = "vmbr1"
  lan_trunks = "20;30;40"

}