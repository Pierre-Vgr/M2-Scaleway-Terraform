# CAS 2
## Création des fichiers Terraform

Création des fichiers provider.tf, main.tf, variables.tf & terraform.tfvars.

- provider.tf = configuration du provider scaleway
- main.tf = configuration des instances
- variables.tf = déclaration des variables
- terraform.tfvars = valeur des variables

Le fichier provider ainsi que les variables de base ont été repris du cas 1 .

##  Création des instances

Dans un premier temps, nous avons créé nos instances multiples grace à count. Pour simplifier la répetition, nous avons ajouté deux variables dans variables.tf, nous utiliserons leur valeur par défaut.

```
variable "instance_count" {
  default = "2"
}

variable "instance_type" {
  default = "DEV1-S"

```

On tire également parti du count pour numéroter chaque instance dans son ordre de création.

```
name           = "pvig-ins-${count.index + 1}"
```

Output du terraform apply :

```
Terraform will perform the following actions:

  # scaleway_instance_server.main[0] will be created
  + resource "scaleway_instance_server" "main" {
      + boot_type                        = "local"
      + bootscript_id                    = (known after apply)
      + enable_dynamic_ip                = false
      + enable_ipv6                      = false
      + id                               = (known after apply)
      + image                            = "ubuntu_jammy"
      + ipv6_address                     = (known after apply)
      + ipv6_gateway                     = (known after apply)
      + ipv6_prefix_length               = (known after apply)
      + name                             = "pvig-ins-1"
      + organization_id                  = (known after apply)
      + placement_group_policy_respected = (known after apply)
      + private_ip                       = (known after apply)
      + project_id                       = (known after apply)
      + public_ip                        = (known after apply)
      + security_group_id                = (known after apply)
      + state                            = "started"
      + type                             = "DEV1-S"
      + zone                             = (known after apply)

      + root_volume {
          + boot                  = false
          + delete_on_termination = false
          + name                  = (known after apply)
          + size_in_gb            = (known after apply)
          + volume_id             = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # scaleway_instance_server.main[1] will be created

  
  + resource "scaleway_instance_server" "main" {
      + boot_type                        = "local"
      + bootscript_id                    = (known after apply)
      + enable_dynamic_ip                = false
      + enable_ipv6                      = false
      + id                               = (known after apply)
      + image                            = "ubuntu_jammy"
      + ipv6_address                     = (known after apply)
      + ipv6_gateway                     = (known after apply)
      + ipv6_prefix_length               = (known after apply)
      + name                             = "pvig-ins-2"
      + organization_id                  = (known after apply)
      + placement_group_policy_respected = (known after apply)
      + private_ip                       = (known after apply)
      + project_id                       = (known after apply)
      + public_ip                        = (known after apply)
      + security_group_id                = (known after apply)
      + state                            = "started"
      + type                             = "DEV1-S"
      + zone                             = (known after apply)

      + root_volume {
          + boot                  = false
          + delete_on_termination = false
          + name                  = (known after apply)
          + size_in_gb            = (known after apply)
          + volume_id             = (known after apply)
          + volume_type           = (known after apply)
        }
    }
```

La troisième instance est créée de manière classique.

## Création des private networks 

On vient ensuite créer deux réseaux privés en ajoutant le code suivant à notre fichier main :

```
resource "scaleway_vpc_private_network" "pvig_priv" {
    name = "pvig-subnet"
}

resource "scaleway_vpc_private_network" "iso_priv" {
    name = "pvig-subnet-isolated"
}
```
Pour les affecter à chacune des instances, on référence le réseau privé dans la création de la ressource :

```
  private_network {
    pn_id = scaleway_vpc_private_network.pvig_priv.id
  }
``` 
Output du terraform apply :

```
Terraform will perform the following actions:

  # scaleway_instance_server.iso will be updated in-place
  ~ resource "scaleway_instance_server" "iso" {
        id                    = "fr-par-1/2bbd97de-6798-4653-8612-883174ebe969"
        name                  = "pvig-ins-isolated"
        # (14 unchanged attributes hidden)

      + private_network {
          + pn_id = (known after apply)
        }

        # (1 unchanged block hidden)
    }

  # scaleway_instance_server.main[0] will be updated in-place
  ~ resource "scaleway_instance_server" "main" {
        id                    = "fr-par-1/f5a3c5d0-2234-471f-8de2-1798a0d6ebce"
        name                  = "pvig-ins-1"
        # (14 unchanged attributes hidden)

      + private_network {
          + pn_id = (known after apply)
        }

        # (1 unchanged block hidden)
    }

  # scaleway_instance_server.main[1] will be updated in-place
  ~ resource "scaleway_instance_server" "main" {
        id                    = "fr-par-1/21d931b4-0680-44ef-bf6a-28fc63efb4a0"
        name                  = "pvig-ins-2"
        # (14 unchanged attributes hidden)

      + private_network {
          + pn_id = (known after apply)
        }

        # (1 unchanged block hidden)
    }

  # scaleway_vpc_private_network.iso_priv will be created
  + resource "scaleway_vpc_private_network" "iso_priv" {
      + created_at      = (known after apply)
      + id              = (known after apply)
      + name            = "pvig-subnet-isolated"
      + organization_id = (known after apply)
      + project_id      = (known after apply)
      + updated_at      = (known after apply)
      + zone            = (known after apply)
    }

  # scaleway_vpc_private_network.pvig_priv will be created
  + resource "scaleway_vpc_private_network" "pvig_priv" {
      + created_at      = (known after apply)
      + id              = (known after apply)
      + name            = "pvig-subnet"
      + organization_id = (known after apply)
      + project_id      = (known after apply)
      + updated_at      = (known after apply)
      + zone            = (known after apply)
    }
``` 
## DCHP sur les réseaux isolés

Pour permettre à nos VM de communiquer, nous avons tenté de leur fournir du DHCP grace à une public gateway. 

```
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
  private_port = 80
  public_port  = 80
  protocol     = "both"
  depends_on   = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.pvig_priv]
}

resource "scaleway_vpc_gateway_network" "main" {
  gateway_id         = scaleway_vpc_public_gateway.main.id
  private_network_id = [scaleway_vpc_private_network.pvig_priv.id, scaleway_vpc_private_network.iso_priv.id]
  dhcp_id            = scaleway_vpc_public_gateway_dhcp.main.id
  cleanup_dhcp       = true
  enable_masquerade  = true
  depends_on         = [scaleway_vpc_public_gateway_ip.main, scaleway_vpc_private_network.pvig_priv]
}
```
L'un des problème rencontré est que nous n'avons pas réussi à affecter plusieurs private network à notre gateway depuis terraform :
```
╷
│ Error: Incorrect attribute value type
│ 
│   on main.tf line 34, in resource "scaleway_vpc_gateway_network" "main":
│   34:   private_network_id = [scaleway_vpc_private_network.pvig_priv.id, scaleway_vpc_private_network.iso_priv.id]
│ 
│ Inappropriate value for attribute "private_network_id": string required.
╵
```

Output terraform apply :

```
Terraform will perform the following actions:

  # scaleway_vpc_gateway_network.main will be created
  + resource "scaleway_vpc_gateway_network" "main" {
      + cleanup_dhcp       = true
      + created_at         = (known after apply)
      + dhcp_id            = (known after apply)
      + enable_dhcp        = true
      + enable_masquerade  = true
      + gateway_id         = (known after apply)
      + id                 = (known after apply)
      + mac_address        = (known after apply)
      + private_network_id = "fr-par-1/70fd60bf-6d8a-4226-a092-9fbec57dc652"
      + updated_at         = (known after apply)
      + zone               = (known after apply)
    }

  # scaleway_vpc_public_gateway.main will be created
  + resource "scaleway_vpc_public_gateway" "main" {
      + bastion_port    = (known after apply)
      + created_at      = (known after apply)
      + enable_smtp     = (known after apply)
      + id              = (known after apply)
      + ip_id           = (known after apply)
      + name            = "pvig-gw"
      + organization_id = (known after apply)
      + project_id      = (known after apply)
      + type            = "VPC-GW-S"
      + updated_at      = (known after apply)
      + zone            = (known after apply)
    }

  # scaleway_vpc_public_gateway_dhcp.main will be created
  + resource "scaleway_vpc_public_gateway_dhcp" "main" {
      + address              = (known after apply)
      + created_at           = (known after apply)
      + dns_local_name       = (known after apply)
      + dns_search           = (known after apply)
      + dns_servers_override = (known after apply)
      + enable_dynamic       = (known after apply)
      + id                   = (known after apply)
      + organization_id      = (known after apply)
      + pool_high            = (known after apply)
      + pool_low             = (known after apply)
      + project_id           = (known after apply)
      + push_default_route   = (known after apply)
      + push_dns_server      = (known after apply)
      + rebind_timer         = (known after apply)
      + renew_timer          = (known after apply)
      + subnet               = "10.100.14.0/24"
      + updated_at           = (known after apply)
      + valid_lifetime       = (known after apply)
      + zone                 = (known after apply)
    }

  # scaleway_vpc_public_gateway_ip.main will be created
  + resource "scaleway_vpc_public_gateway_ip" "main" {
      + address         = (known after apply)
      + created_at      = (known after apply)
      + id              = (known after apply)
      + organization_id = (known after apply)
      + project_id      = (known after apply)
      + reverse         = (known after apply)
      + updated_at      = (known after apply)
      + zone            = (known after apply)
    }

  # scaleway_vpc_public_gateway_pat_rule.main will be created
  + resource "scaleway_vpc_public_gateway_pat_rule" "main" {
      + created_at      = (known after apply)
      + gateway_id      = (known after apply)
      + id              = (known after apply)
      + organization_id = (known after apply)
      + private_ip      = (known after apply)
      + private_port    = 80
      + protocol        = "both"
      + public_port     = 80
      + updated_at      = (known after apply)
      + zone            = (known after apply)
    }
```

malgrès la création de la gateway, nos VM ne récupèrent pas d'adresse sur le même réseau