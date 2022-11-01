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