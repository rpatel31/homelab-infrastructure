resource "proxmox_virtual_environment_container" "this" {
  node_name     = var.node_name
  vm_id         = var.container_id
  tags          = var.tags
  unprivileged  = var.unprivileged
  start_on_boot = var.start_on_boot
  started       = var.started

  clone {
    vm_id        = var.template_id
    datastore_id = var.datastore_id
    full         = true
  }


  cpu {
    architecture = "amd64"
    cores        = var.cpu_cores
  }

  memory {
    dedicated = var.memory_mb
    swap      = var.swap_mb
  }

  disk {
    datastore_id = var.datastore_id
    size         = var.disk_size_gb
  }

  features {
    nesting = true
  }

  initialization {
    hostname = var.hostname

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


  }

  network_interface {
    name     = "eth0"
    bridge   = var.network_bridge
    firewall = var.network_firewall
    vlan_id  = var.vlan_id
  }

  wait_for_ip {
    ipv4 = true
  }
}