resource "scaleway_rdb_instance" "rdom-pvig-rdb" {
  name           = "rdom-pvig-rdb-rdb"
  node_type      = "DB-DEV-S"
  engine         = "MySQL-8"
  is_ha_cluster  = true
  disable_backup = true
  user_name      = "pvig"
  password       = "Azerty77"
}

resource "scaleway_rdb_database" "rdom-pvig-db" {
  instance_id    = scaleway_rdb_instance.rdom-pvig-db.id
  name           = "my-new-database"
}