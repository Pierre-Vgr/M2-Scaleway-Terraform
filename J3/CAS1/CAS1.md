# CAS 1
## Création des instances & bases

`mkdir scaleway-terraform && cd scaleway-terraform`

Création des fichiers provider.tf, main.tf, variables.tf & terraform.tfvars.

- provider.tf = configuration du provider scaleway
- main.tf = configuration des instances
- variables.tf = déclaration des variables
- terraform.tfvars = valeur des variables

`terraform init`

`terraform apply`

Output:

```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # scaleway_instance_server.web will be created
  + resource "scaleway_instance_server" "web" {
      + additional_volume_ids            = (known after apply)
      + boot_type                        = "local"
      + bootscript_id                    = (known after apply)
      + enable_dynamic_ip                = false
      + enable_ipv6                      = false
      + id                               = (known after apply)
      + image                            = "ubuntu_jammy"
      + ipv6_address                     = (known after apply)
      + ipv6_gateway                     = (known after apply)
      + ipv6_prefix_length               = (known after apply)
      + name                             = "pvig-ins"
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

  # scaleway_instance_volume.data will be created
  + resource "scaleway_instance_volume" "data" {
      + id              = (known after apply)
      + name            = (known after apply)
      + organization_id = (known after apply)
      + project_id      = (known after apply)
      + server_id       = (known after apply)
      + size_in_gb      = 100
      + type            = "b_ssd"
      + zone            = (known after apply)
    }

  # scaleway_rdb_database.main will be created
  + resource "scaleway_rdb_database" "main" {
      + id          = (known after apply)
      + instance_id = (known after apply)
      + managed     = (known after apply)
      + name        = "my-new-database"
      + owner       = (known after apply)
      + size        = (known after apply)
    }

  # scaleway_rdb_instance.main will be created
  + resource "scaleway_rdb_instance" "main" {
      + backup_same_region        = (known after apply)
      + backup_schedule_frequency = (known after apply)
      + backup_schedule_retention = (known after apply)
      + certificate               = (known after apply)
      + disable_backup            = true
      + endpoint_ip               = (known after apply)
      + endpoint_port             = (known after apply)
      + engine                    = "MySQL-8"
      + id                        = (known after apply)
      + is_ha_cluster             = true
      + load_balancer             = (known after apply)
      + name                      = "pvig-rdb"
      + node_type                 = "DB-DEV-S"
      + organization_id           = (known after apply)
      + password                  = (sensitive value)
      + project_id                = (known after apply)
      + read_replicas             = (known after apply)
      + region                    = (known after apply)
      + settings                  = (known after apply)
      + user_name                 = "pvig"
      + volume_size_in_gb         = (known after apply)
      + volume_type               = "lssd"
    }

Plan: 4 to add, 0 to change, 0 to destroy.

```
test connexion ssh

`ssh root@163.172.130.18`

Résultat : connexion possible à l'hôte depuis l'IP autorisée dans les variables.
Nous n'avons pas réussi à 

