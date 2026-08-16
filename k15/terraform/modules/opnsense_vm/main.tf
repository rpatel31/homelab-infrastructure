resource "proxmox_virtual_environment_vm" "this" {
  name      = var.vm_name
  vm_id     = var.vm_id
  node_name = var.node_name
  tags      = var.tags
  machine   = "q35"
  scsi_hardware = "virtio-scsi-single"

  clone {
    vm_id        = var.template_id
    datastore_id = var.datastore_id
    full         = true
  }

  cpu {
    cores = var.cpu_cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory_mb
    floating  = 0
  }





  network_device {
    bridge   = var.wan_bridge
    model    = "virtio"
    firewall = false

  }

  network_device {
    bridge   = var.lan_bridge
    model    = "virtio"
    trunks   = var.lan_trunks
    firewall = false
  }

  operating_system {
    type = "other"
  }

  agent {
    enabled = true
    wait_for_ip {
      disabled = true
    }
  }

  boot_order = ["scsi0"]

  on_boot = true
  started = true

}