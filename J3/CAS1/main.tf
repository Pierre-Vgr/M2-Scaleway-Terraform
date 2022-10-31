# Création du private network + DHCP

resource "scaleway_vpc_private_network" "rdom_vpc" {
    name = "rdom_sub"
}

resource "scaleway_vpc_public_gateway_dhcp" "main" {
    subnet = "10.100.14.0/24"
}

resource "scaleway_vpc_public_gateway_ip" "main" {
}

resource "scaleway_vpc_public_gateway" "main" {
  name  = "rdom-gate"
  type  = "VPC-GW-S"
  ip_id = scaleway_vpc_public_gateway_ip.main.id
}
resource "scaleway_vpc_public_gateway_pat_rule" "main" {
  gateway_id   = scaleway_vpc_public_gateway.main.id
  private_ip   = scaleway_vpc_public_gateway_dhcp.main.address
  private_port = scaleway_rdb_instance.main.private_network.0.port
  public_port  = 42
  protocol     = "both"
  depends_on   = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.rdom_vpc]
}

resource "scaleway_vpc_gateway_network" "main" {
  gateway_id         = scaleway_vpc_public_gateway.main.id
  private_network_id = scaleway_vpc_private_network.rdom_vpc.id
  dhcp_id            = scaleway_vpc_public_gateway_dhcp.main.id
  cleanup_dhcp       = true
  enable_masquerade  = true
  depends_on         = [scaleway_vpc_public_gateway_ip.main, scaleway_vpc_private_network.rdom_vpc]
}


# Création IP publique de instance rdom-inst

resource "scaleway_instance_ip" "rdom_inst_ip" {}

# Création instance rdom-rdb

resource "scaleway_rdb_instance" "main" {
  name           = "rdom-rdb"
  node_type      = "DB-DEV-S"
  engine         = "MySQL-8"
  is_ha_cluster  = true
  disable_backup = true
  user_name      = "romain"
  password       = "Azerty77$"

  private_network {
    pn_id = scaleway_vpc_private_network.rdom_vpc.id
    ip_net = "10.100.14.220/24"
  }

}

# Création de la BDD

resource "scaleway_rdb_database" "main" {
  instance_id    = scaleway_rdb_instance.main.id
  name           = "rdomdb"
}

# Intégration de la clé publique SSH

data "scaleway_account_ssh_key" "rdom_ssh" {
  ssh_key_id  = var.ssh_key
}

# Création du Security Group rdom_sg_inst

resource "scaleway_instance_security_group" "rdom_sg_inst" {
  inbound_default_policy  = "drop" # By default we drop incoming traffic that do not match any inbound_rule.
  outbound_default_policy = "accept" # By default we drop outgoing traffic that do not match any outbound_rule.

  inbound_rule {
    action = "accept"
    port   = 22
    ip     = var.auth_ip
  }

  inbound_rule {
    action = "accept"
    port   = 80
  }

}

# Création instance rdom-inst

resource "scaleway_instance_server" "rdom_inst" {
  type           = "DEV1-S"
  image          = "ubuntu_jammy"
  name           = "rdom-inst"
  ip_id = scaleway_instance_ip.rdom_inst_ip.id
  security_group_id = scaleway_instance_security_group.rdom_sg_inst.id

    root_volume {
    delete_on_termination = false
  }
  private_network {
    pn_id = scaleway_vpc_private_network.rdom_vpc.id
  }

}
