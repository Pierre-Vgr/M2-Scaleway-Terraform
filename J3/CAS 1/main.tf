
# Création du private network + DHCP

resource "scaleway_vpc_private_network" "pvig_priv" {
    name = "pvig_subnet"
}

resource "scaleway_vpc_public_gateway_dhcp" "main" {
    subnet = "10.100.14.0/24"
}

resource "scaleway_vpc_public_gateway_ip" "main" {
}

resource "scaleway_vpc_public_gateway" "main" {
  name  = "pvig-gw"
  type  = "VPC-GW-S"
  ip_id = scaleway_vpc_public_gateway_ip.main.id
}
resource "scaleway_vpc_public_gateway_pat_rule" "main" {
  gateway_id   = scaleway_vpc_public_gateway.main.id
  private_ip   = scaleway_vpc_public_gateway_dhcp.main.address
  private_port = scaleway_rdb_instance.main.private_network.0.port
  public_port  = 42
  protocol     = "both"
  depends_on   = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.pvig_priv]
}

resource "scaleway_vpc_gateway_network" "main" {
  gateway_id         = scaleway_vpc_public_gateway.main.id
  private_network_id = scaleway_vpc_private_network.pvig_priv.id
  dhcp_id            = scaleway_vpc_public_gateway_dhcp.main.id
  cleanup_dhcp       = true
  enable_masquerade  = true
  depends_on         = [scaleway_vpc_public_gateway_ip.main, scaleway_vpc_private_network.pvig_priv]
}


# création des l'IP publiques de l'instance pvig-ins

resource "scaleway_instance_ip" "pvig_ins_ip" {}

# Création du security group

resource "scaleway_instance_security_group" "pvig_sg" {
  inbound_default_policy  = "drop" # By default we drop incoming traffic that do not match any inbound_rule.
  outbound_default_policy = "accept" # By default we drop outgoing traffic that do not match any outbound_rule.

  inbound_rule {
    action = "accept"
    port   = 22
    ip     = var.auth_ip
  }
}

# création de l'instance rdb

resource "scaleway_rdb_instance" "main" {
  name           = "pvig-rdb"
  node_type      = "DB-DEV-S"
  engine         = "MySQL-8"
  is_ha_cluster  = true
  disable_backup = true
  user_name      = "pvig"
  password       = "Azerty77!"

    private_network {
    pn_id = scaleway_vpc_private_network.pvig_priv.id
    ip_net = "10.100.14.220/24"
  }

}

# création de la base

resource "scaleway_rdb_database" "main" {
  instance_id    = scaleway_rdb_instance.main.id
  name           = "my-new-database"
}

# création du volume de l'instance pvig-ins

resource "scaleway_instance_private_nic" "pnic01" {
    server_id          = scaleway_instance_server.pvig_ins.id
    private_network_id = scaleway_vpc_private_network.pvig_priv.id
}

resource "scaleway_instance_volume" "data" {
  size_in_gb     = 30
  type           = "b_ssd"
}

# création de l'instance pvig-ins

resource "scaleway_instance_server" "pvig_ins" {
  type           = "DEV1-S"
  image          = "ubuntu_jammy"
  name           = "pvig-ins"
  ip_id = scaleway_instance_ip.pvig_ins_ip.id
  security_group_id = scaleway_instance_security_group.pvig_sg.id

  private_network {
    pn_id = scaleway_vpc_private_network.pvig_priv.id
  }

    root_volume {
    delete_on_termination = false
  }

  additional_volume_ids = [ scaleway_instance_volume.data.id ]
}