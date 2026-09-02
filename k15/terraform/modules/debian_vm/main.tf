

resource "proxmox_virtual_environment_vm" "this" {
  name      = var.vm_name
  vm_id     = var.vm_id
  node_name = var.node_name
  tags      = var.tags
  on_boot   = var.on_boot

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
  }

  disk {
    datastore_id = var.datastore_id
    interface    = "scsi0"
    size         = var.disk_size_gb
  }

  dynamic "disk" {
    for_each = var.data_disk == null ? [] : [var.data_disk]
    content {
      datastore_id = disk.value.datastore_id
      interface    = "scsi1"
      size         = disk.value.size_gb
    }

  }

  network_device {
    bridge  = var.network_bridge
    model   = "virtio"
    vlan_id = var.vlan_id
  }

  agent {
    enabled = true

    wait_for_ip {
      ipv4 = true
    }
  }

  initialization {
    datastore_id = var.datastore_id

    dynamic "dns" {
      for_each = length(var.dns_servers) > 0 ? [1] : []

      content {
        servers = var.dns_servers
      }
    }

    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }

    user_account {
      username = var.cloud_init_username
      keys     = var.cloud_init_ssh_pub_keys
    }
  }
  operating_system {
    type = "l26"
  }

  started = true
}
