# CAS 2
## Création des instances & bases

Création des fichiers provider.tf, main.tf, variables.tf & terraform.tfvars.

- provider.tf = configuration du provider scaleway
- main.tf = configuration des instances
- variables.tf = déclaration des variables
- terraform.tfvars = valeur des variables


## Création
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # scaleway_instance_server.iso will be created
  + resource "scaleway_instance_server" "iso" {
      + boot_type                        = "local"
      + bootscript_id                    = (known after apply)
      + enable_dynamic_ip                = false
      + enable_ipv6                      = false
      + id                               = (known after apply)
      + image                            = "ubuntu_jammy"
      + ipv6_address                     = (known after apply)
      + ipv6_gateway                     = (known after apply)
      + ipv6_prefix_length               = (known after apply)
      + name                             = "pvig-ins-isolated"
      + organization_id                  = (known after apply)
      + placement_group_policy_respected = (known after apply)
      + private_ip                       = (known after apply)
      + project_id                       = (known after apply)
      + public_ip                        = (known after apply)
      + security_group_id                = (known after apply)
      + state                            = "started"
      + type                             = "DEV1-S"
      + zone                             = (known after apply)

      + private_network {
          + mac_address = (known after apply)
          + pn_id       = (known after apply)
          + status      = (known after apply)
          + zone        = (known after apply)
        }

      + root_volume {
          + boot                  = false
          + delete_on_termination = false
          + name                  = (known after apply)
          + size_in_gb            = (known after apply)
          + volume_id             = (known after apply)
          + volume_type           = (known after apply)
        }
    }

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

      + private_network {
          + mac_address = (known after apply)
          + pn_id       = (known after apply)
          + status      = (known after apply)
          + zone        = (known after apply)
        }

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

      + private_network {
          + mac_address = (known after apply)
          + pn_id       = (known after apply)
          + status      = (known after apply)
          + zone        = (known after apply)
        }

      + root_volume {
          + boot                  = false
          + delete_on_termination = false
          + name                  = (known after apply)
          + size_in_gb            = (known after apply)
          + volume_id             = (known after apply)
          + volume_type           = (known after apply)
        }
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

Plan: 5 to add, 0 to change, 0 to destroy.
```
