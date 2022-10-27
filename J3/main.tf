resource "scaleway_rdb_instance" "main" {
  name           = "pvig-rdb"
  node_type      = "DB-DEV-S"
  engine         = "MySQL-8"
  is_ha_cluster  = true
  disable_backup = true
  user_name      = "pvig"
  password       = "Azerty77!"
}

resource "scaleway_rdb_database" "main" {
  instance_id    = scaleway_rdb_instance.main.id
  name           = "my-new-database"
}

resource "scaleway_instance_volume" "data" {
  size_in_gb     = 100
  type           = "b_ssd"
}

resource "scaleway_instance_server" "web" {
  type           = "DEV1-S"
  image          = "ubuntu_jammy"
  name           = "pvig-ins"

  root_volume {
    delete_on_termination = false
  }

  additional_volume_ids = [ scaleway_instance_volume.data.id ]
}