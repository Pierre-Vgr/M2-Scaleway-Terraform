
# Création du private network

resource "scaleway_vpc_private_network" "pvig_priv" {
    name = "pvig_subnet"
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
}

# création de la base

resource "scaleway_rdb_database" "main" {
  instance_id    = scaleway_rdb_instance.main.id
  name           = "my-new-database"
}

# création du volume de l'instance pvig-ins

resource "scaleway_instance_volume" "data" {
  size_in_gb     = 30
  type           = "b_ssd"
}

# création de l'instance pvig-ins

resource "scaleway_instance_server" "web" {
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