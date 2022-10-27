# Création du private network + DHCP

resource "scaleway_vpc_private_network" "pvig_priv" {
    name = "pvig-subnet"
}

resource "scaleway_vpc_private_network" "iso_priv" {
    name = "pvig-subnet-isolated"
}

# resource "scaleway_vpc_public_gateway_dhcp" "main" {
#     subnet = "10.100.14.0/24"
# }

# resource "scaleway_vpc_public_gateway_ip" "main" {
# }

# resource "scaleway_vpc_public_gateway" "main" {
#   name  = "pvig-gw"
#   type  = "VPC-GW-S"
#   ip_id = scaleway_vpc_public_gateway_ip.main.id
# }
# resource "scaleway_vpc_public_gateway_pat_rule" "main" {
#   gateway_id   = scaleway_vpc_public_gateway.main.id
#   private_ip   = scaleway_vpc_public_gateway_dhcp.main.address
#   private_port = 80
#   public_port  = 80
#   protocol     = "both"
#   depends_on   = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.pvig_priv]
# }

# resource "scaleway_vpc_gateway_network" "main" {
#   gateway_id         = scaleway_vpc_public_gateway.main.id
#   private_network_id = [scaleway_vpc_private_network.pvig_priv.id, scaleway_vpc_private_network.iso_priv.id]
#   dhcp_id            = scaleway_vpc_public_gateway_dhcp.main.id
#   cleanup_dhcp       = true
#   enable_masquerade  = true
#   depends_on         = [scaleway_vpc_public_gateway_ip.main, scaleway_vpc_private_network.pvig_priv]
# }

# Création des instances sur le même VPC

resource "scaleway_instance_server" "main" {
  count          = var.instance_count
  type           = var.instance_type
  image          = "ubuntu_jammy"
  name           = "pvig-ins-${count.index + 1}"

  private_network {
    pn_id = scaleway_vpc_private_network.pvig_priv.id
  }

    root_volume {
    delete_on_termination = false
  }

}

# Création de l'instance isolée

resource "scaleway_instance_server" "iso" {
  type           = var.instance_type
  image          = "ubuntu_jammy"
  name           = "pvig-ins-isolated"

  private_network {
    pn_id = scaleway_vpc_private_network.iso_priv.id
  }

    root_volume {
    delete_on_termination = false
  }

}
