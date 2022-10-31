# CAS 1
## Création du dossier scaleway-terraform

Nous avons dans un premier temps créer un dossier qui recensera par la suite tous nos fichiers de configuration Terraform et nous nous y sommes déplacé :

`mkdir scaleway-terraform && cd scaleway-terraform`

## Création des fichiers Terraform

Nous avons ensuite créer les fichiers de configuration nécessaires au bon fonctionnement de Terraform et au déploiement de notre IaC.

Création des fichiers provider.tf, main.tf, variables.tf & terraform.tfvars :

`touch provider.tf main.tf variables.tf terraform.tfvars`

- provider.tf = Configuration du provider scaleway
- main.tf = Configuration des instances
- variables.tf = Déclaration des variables
- terraform.tfvars = Valeur des variables

## Configuration provider.tf

Première étape, la configuration du fichier provider.tf. Ce fichier nous servira à spécifier le provider sur lequel nous voulons terraformer notre infrastructure. Il sera composé ainsi :

```
terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.2.7"
    }
  }
  required_version = ">= 0.13"
}

  provider "scaleway" {
    access_key      = var.access_key
    secret_key      = var.secret_key
    project_id      = var.project_id
    zone            = var.zone
    region          = var.region
  }
```

Le fichier est gobalement composé du choix du provider, de la spécification du projet de notre groupe ainsi que des identifiants d'un de nous sous la forme d'une clé d'accès et d'une clé secrète. Nous retrouvons certaines variables sous la forme var.XXX. Celles-ci s'appuie sur plusieurs fichiers sur lesquels nous reviendrons en suivant.

## Configuration des fichiers variables.tf et terraform.tfvars

Ces deux fichiers sont dédiés aux variables sur lesquelles notre configuration Terraform va s'appuyer. L'idée étant naturellement d'éviter de devoir déclarer des données précises dans notre fichier main.tf dédié à la configuration de nos instances. S'appuyer sur des variables simplifie grandement la réutilisation du script de déploiement par la suite en ayant uniquement un minimum de données à modifier sans devoir mettre les mains dans le script principal en lui même.

variables.tf sera composé ainsi :

```
variable "zone" {
  type = string
}

variable "region" {
  type = string
}

variable "env" {
  type = string
}

variable "project_id" {
  type        = string
  description = "Your project ID"
}

variable "access_key" {
    type = string
    description = "access key user rdom"
}

variable "secret_key" {
    type = string
    description = "secret key user rdom"
}
```

Nous retrouvons ici le nom de nos variables sur lesquelles nous nous appuierons par la suite. Etant une valeur de chaîne de caractères, celles-ci sont déclarées comme string.

terraform.tfvars sera composé ainsi :

```
zone                           = "fr-par-1"
region                         = "fr-par"
env                            = "dev"
project_id                     = "59972b2a-5ceb-447d-9266-ef00f9591ce1"
access_key		       = "SCW0FHXY5FS9F5C7DPKC"
secret_key		       = "6ac6428b-5dd9-4d29-9db1-133e661e3162"
```

Nous retrouvons dans ce fichier nos valeurs réelles et modulables à souhait en fonction du besoin.

## Configuration du fichier main.tf

Ce fichier est dédié à la configuration même de nos instances et ceci au travers de plusieurs choix concernant celle-ci.

```
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

}

# Création de la BDD

resource "scaleway_rdb_database" "main" {
  instance_id    = scaleway_rdb_instance.main.id
  name           = "rdomdb"
}

# Création instance rdom-inst

resource "scaleway_instance_server" "rdom_inst" {
  type           = "DEV1-S"
  image          = "ubuntu_jammy"
  name           = "rdom-inst"
  ip_id = scaleway_instance_ip.rdom_inst_ip.id

    root_volume {
    delete_on_termination = false
  }

}
```

Nous pouvons citer rapidement le choix d'affecté ou non une adresse IP publique à nos instance, le type de l'instance ainsi que l'image et les identifiants souhaités.

## Terraform init et plan

Nos fichiers de configuration étant désormais prêt, nous avons ensuite lancer les deux commandes suivantes :

`terraform init`

`terraform plan`

La première commande servant à initialiser le plugin Terraform et nous permettre de travailler avec et la seconde nous servant à nous retourner une synthèse des paramètrages configurés précédemment dans nos différents fichiers de configuration. Cette opération nous permettant de nous assurer que nous n'avons pas fais d'erreurs de syntaxe et de l'exactitude de nos paramétrages.

Output:
```
root@vortex:/home/romain/Terraform/scaleway-terraform# terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # scaleway_instance_ip.rdom_inst_ip will be created
  + resource "scaleway_instance_ip" "rdom_inst_ip" {
      + address         = (known after apply)
      + id              = (known after apply)
      + organization_id = (known after apply)
      + project_id      = (known after apply)
      + reverse         = (known after apply)
      + server_id       = (known after apply)
      + zone            = (known after apply)
    }

  # scaleway_instance_server.rdom_inst will be created
  + resource "scaleway_instance_server" "rdom_inst" {
      + boot_type                        = "local"
      + bootscript_id                    = (known after apply)
      + enable_dynamic_ip                = false
      + enable_ipv6                      = false
      + id                               = (known after apply)
      + image                            = "ubuntu_jammy"
      + ip_id                            = (known after apply)
      + ipv6_address                     = (known after apply)
      + ipv6_gateway                     = (known after apply)
      + ipv6_prefix_length               = (known after apply)
      + name                             = "rdom-inst"
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

  # scaleway_rdb_database.main will be created
  + resource "scaleway_rdb_database" "main" {
      + id          = (known after apply)
      + instance_id = (known after apply)
      + managed     = (known after apply)
      + name        = "rdomdb"
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
      + name                      = "rdom-rdb"
      + node_type                 = "DB-DEV-S"
      + organization_id           = (known after apply)
      + password                  = (sensitive value)
      + project_id                = (known after apply)
      + read_replicas             = (known after apply)
      + region                    = (known after apply)
      + settings                  = (known after apply)
      + user_name                 = "romain"
      + volume_size_in_gb         = (known after apply)
      + volume_type               = "lssd"
    }

Plan: 4 to add, 0 to change, 0 to destroy.

```

## Terraform apply

Dernière étape, l'utilisation de la commande terraform apply :

`terraform apply`

Celle-ci va alors nous permettre de lancer le déploiement de notre IaC après confirmation de notre part :


Output avant déploiement:
```
root@vortex:/home/romain/Terraform/scaleway-terraform# terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # scaleway_instance_ip.rdom_inst_ip will be created
  + resource "scaleway_instance_ip" "rdom_inst_ip" {
      + address         = (known after apply)
      + id              = (known after apply)
      + organization_id = (known after apply)
      + project_id      = (known after apply)
      + reverse         = (known after apply)
      + server_id       = (known after apply)
      + zone            = (known after apply)
    }

  # scaleway_instance_server.rdom_inst will be created
  + resource "scaleway_instance_server" "rdom_inst" {
      + boot_type                        = "local"
      + bootscript_id                    = (known after apply)
      + enable_dynamic_ip                = false
      + enable_ipv6                      = false
      + id                               = (known after apply)
      + image                            = "ubuntu_jammy"
      + ip_id                            = (known after apply)
      + ipv6_address                     = (known after apply)
      + ipv6_gateway                     = (known after apply)
      + ipv6_prefix_length               = (known after apply)
      + name                             = "rdom-inst"
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

  # scaleway_rdb_database.main will be created
  + resource "scaleway_rdb_database" "main" {
      + id          = (known after apply)
      + instance_id = (known after apply)
      + managed     = (known after apply)
      + name        = "rdomdb"
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
      + name                      = "rdom-rdb"
      + node_type                 = "DB-DEV-S"
      + organization_id           = (known after apply)
      + password                  = (sensitive value)
      + project_id                = (known after apply)
      + read_replicas             = (known after apply)
      + region                    = (known after apply)
      + settings                  = (known after apply)
      + user_name                 = "romain"
      + volume_size_in_gb         = (known after apply)
      + volume_type               = "lssd"
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

```

Output pendant déploiement:
```
scaleway_instance_ip.rdom_inst_ip: Creating...
scaleway_rdb_instance.main: Creating...
scaleway_instance_ip.rdom_inst_ip: Creation complete after 1s [id=fr-par-1/2d96f63e-3be9-4e5f-9b77-b78f80c82eba]
scaleway_instance_server.rdom_inst: Creating...
scaleway_rdb_instance.main: Still creating... [10s elapsed]
scaleway_instance_server.rdom_inst: Still creating... [10s elapsed]
scaleway_rdb_instance.main: Still creating... [20s elapsed]
scaleway_instance_server.rdom_inst: Still creating... [20s elapsed]
scaleway_instance_server.rdom_inst: Creation complete after 29s [id=fr-par-1/6d838c30-1b72-4fa1-b971-3636d3d58b29]
scaleway_rdb_instance.main: Still creating... [30s elapsed]
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
scaleway_rdb_instance.main: Still creating... [3m11s elapsed]
scaleway_rdb_instance.main: Still creating... [3m21s elapsed]
scaleway_rdb_instance.main: Still creating... [3m31s elapsed]
scaleway_rdb_instance.main: Still creating... [3m41s elapsed]
scaleway_rdb_instance.main: Still creating... [3m51s elapsed]
scaleway_rdb_instance.main: Still creating... [4m1s elapsed]
scaleway_rdb_instance.main: Still creating... [4m11s elapsed]
scaleway_rdb_instance.main: Still creating... [4m21s elapsed]
scaleway_rdb_instance.main: Still creating... [4m31s elapsed]
scaleway_rdb_instance.main: Still creating... [4m41s elapsed]
scaleway_rdb_instance.main: Still creating... [4m51s elapsed]
scaleway_rdb_instance.main: Still creating... [5m1s elapsed]
scaleway_rdb_instance.main: Creation complete after 5m3s [id=fr-par/467afc41-ef23-4b40-b3e7-71b89f4a32bf]
scaleway_rdb_database.main: Creating...
scaleway_rdb_database.main: Creation complete after 1s [id=fr-par/467afc41-ef23-4b40-b3e7-71b89f4a32bf/rdomdb]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
```
## Ajout SSH Key

Afin de permettre la connexion à notre instance via SSH sans avoir à entrer quelconque identifiant, nous avons fais en sorte d'intégrer, dans la configuration de notre instance, notre clé publique générée au préalable depuis une de nos machine.

Nous avons utiliser la même façon de faire que précédemment en nous appuyant sur une variable en ajoutant dans les fichiers terraform.tfvars et variables.tf les lignes suivantes :

Terraform.tfvars:
`ssh_key			       = "ee3c3e00-a919-4cf8-a43b-XXXXXXX"`

Variables.tf :
`variable "ssh_key" {
    type = string
    description = "ssh key user rdom"
}`

Pour finir, nous avons modifier le fichier main.tf afin d'indiquer sur quelle instance nous voulions appliquer cette configuration SSH :

```
# Intégration de la clé publique SSH

data "scaleway_account_ssh_key" "rdom_ssh" {
  ssh_key_id  = var.ssh_key
}

# Création instance rdom-inst

resource "scaleway_instance_server" "rdom_inst" {
  type           = "DEV1-S"
  image          = "ubuntu_jammy"
  name           = "rdom-inst"
  ip_id = scaleway_instance_ip.rdom_inst_ip.id

    root_volume {
    delete_on_termination = false
  }
}
```

Nous avons ensuite refait un déploiement et nous avons tester la connexion via ssh sur la machine.

`ssh root@51.158.XXX.XXX`

Output :

```
root@vortex:/home/romain# ssh root@51.158.XXX.XXX
The authenticity of host '51.158.XXX.XXX (51.158.XXX.XXX)' can't be established.
ED25519 key fingerprint is SHA256:dtW+QJktFWeyM4tEI7bLTdJHoyEmMv8OQXXXXXXX.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '51.158.XXX.XXX' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04 LTS (GNU/Linux 5.15.0-41-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sun Oct 30 14:10:06 UTC 2022

  System load:  0.08642578125     Processes:             106
  Usage of /:   9.7% of 17.87GB   Users logged in:       0
  Memory usage: 10%               IPv4 address for ens2: 10.72.16.19
  Swap usage:   0%

26 updates can be applied immediately.
12 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

root@rdom-inst:~# 
```

La connexion fût un succès.

## Ajout du Security Group rdom_sg_inst

Afin de répondre à la demande concernant les accès SSH que depuis notre IP publique et l'accès à tous l'Internet à notre apache ( installé au préalable sur l'instance ) sur le port 80, nous allons mettre en place un Security Group.

Nous utilisons le même fonctionnement que précédemment :

- Déclaration d'une variable auth_ip dans le fichier terraform.tfstate qui pointe notre IP publique

`auth_ip                        = "176.XXX.XXX.XXX"`

- Déclaration de la valeur de notre variable dans le fichier variables.tf

`variable "auth_ip" {
  type = string
  description = "Adresse IP autorisée à se connecter en SSH"
}`

- Application du Security Group sur notre instance en modifiant le fichier main.tf

```
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
}
```

S'en est suivi la commande terraform apply afin d'appliquer nos modifications.

Le test de connexion SSH depuis une IP donné par une connexion 4G se révéla infructueux.

`root@vortex:/home/romain# ssh root@51.158.XXX.XXX
ssh: connect to host 51.158.XXX.XXX port 22: Connection timed out`

L'accès au serveur apache sur le port 80 depuis l'adresse IP publique de l'instance nous donne bien accès à la page par défaut d'apache.

Le Security Group est donc bien fonctionnel.

## Configuration VPC + DHCP + Public Gateway

Nous avons tenter de mettre en place un VPC et une publique gateway + DHCP afin que les machines ne soient accessibles uniquement via ce point d'entrée unique dans un premier temps. 

L'idée à terme était de ne permettre de joindre la BDD uniquement que via notre instance et non pas depuis l'extérieur.

Nous voulions que notre DHCP donne automatiquement une configuration réseau privée à nos deux machines au travers d'un VPC afin qu'elle soit capable de communiquer entre elle et non pas accessible depuis n'importe où.

La configuration que nous avons mis en place dans le fichier main.tf était celle-ci :

```
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
```
La public gateway a bien été crée. Le DHCP était actif mais ne distribué aucune adresse IP privé à nos machines. Nous n'avons pas pu aller plus loin sur ce sujet.


