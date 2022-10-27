## Création de l'instance RDB

`mkdir scaleway-terraform && cd scaleway-terraform`

Création des fichiers provider.tf, main.tf, variables.tf & terraform.tfvars.

- provider.tf = configuration du provider scaleway
- main.tf = configuration des instances
- variables.tf = déclaration des variables
- terraform.tfvars = valeur des variables

`terraform init`

Output:
```
Initializing the backend...

Initializing provider plugins...
- Finding scaleway/scaleway versions matching "2.2.7"...
- Installing scaleway/scaleway v2.2.7...
- Installed scaleway/scaleway v2.2.7 (signed by a HashiCorp partner, key ID F5BF26CADF6F9614)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

`terraform plan`

Output:

```
erraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
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

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

scaleway_instance_volume.data: Creating...
scaleway_rdb_instance.main: Creating...
scaleway_instance_volume.data: Creation complete after 1s [id=fr-par-1/6ff12c2d-0eb2-431e-8269-2789e76798ae]
scaleway_instance_server.web: Creating...
scaleway_rdb_instance.main: Still creating... [10s elapsed]
scaleway_instance_server.web: Still creating... [10s elapsed]
scaleway_rdb_instance.main: Still creating... [20s elapsed]
scaleway_instance_server.web: Still creating... [20s elapsed]
scaleway_rdb_instance.main: Still creating... [30s elapsed]
scaleway_instance_server.web: Still creating... [30s elapsed]
scaleway_instance_server.web: Creation complete after 35s [id=fr-par-1/d0b18d29-da36-4fa5-ab52-571b64e08b19]
scaleway_rdb_instance.main: Still creating... [40s elapsed]
scaleway_rdb_instance.main: Still creating... [50s elapsed]
scaleway_rdb_instance.main: Still creating... [1m0s elapsed]
scaleway_rdb_instance.main: Still creating... [1m10s elapsed]
scaleway_rdb_instance.main: Still creating... [1m20s elapsed]
scaleway_rdb_instance.main: Still creating... [1m30s elapsed]
scaleway_rdb_instance.main: Still creating... [1m40s elapsed]
scaleway_rdb_instance.main: Still creating... [1m50s elapsed]
scaleway_rdb_instance.main: Still creating... [2m0s elapsed]
scaleway_rdb_instance.main: Still creating... [2m10s elapsed]
scaleway_rdb_instance.main: Still creating... [2m20s elapsed]
scaleway_rdb_instance.main: Still creating... [2m30s elapsed]
scaleway_rdb_instance.main: Still creating... [2m40s elapsed]
scaleway_rdb_instance.main: Still creating... [2m50s elapsed]
scaleway_rdb_instance.main: Still creating... [3m0s elapsed]
scaleway_rdb_instance.main: Still creating... [3m10s elapsed]
scaleway_rdb_instance.main: Still creating... [3m20s elapsed]
scaleway_rdb_instance.main: Still creating... [3m30s elapsed]
scaleway_rdb_instance.main: Still creating... [3m40s elapsed]
scaleway_rdb_instance.main: Still creating... [3m50s elapsed]
scaleway_rdb_instance.main: Still creating... [4m0s elapsed]
scaleway_rdb_instance.main: Still creating... [4m10s elapsed]
scaleway_rdb_instance.main: Still creating... [4m20s elapsed]
scaleway_rdb_instance.main: Still creating... [4m30s elapsed]
scaleway_rdb_instance.main: Creation complete after 4m33s [id=fr-par/d50e124a-e5cb-4e93-9268-13b60fd8b042]
scaleway_rdb_database.main: Creating...
scaleway_rdb_database.main: Creation complete after 1s [id=fr-par/d50e124a-e5cb-4e93-9268-13b60fd8b042/my-new-database]
```