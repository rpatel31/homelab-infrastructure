terraform {
  required_version = ">= 1.15.0"

  cloud {
    organization = "homelab-infrastructure"

    workspaces {
      name = "k15-monitoring"
    }
  }

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.111.1"
    }


  }


}