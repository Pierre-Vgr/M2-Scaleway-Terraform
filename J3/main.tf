resource "scaleway_rdb_instance" "main" {
  name           = "rdom-pvig-rdb-rdb"
  node_type      = "DB-DEV-S"
  engine         = "MySQL-8"
  is_ha_cluster  = true
  disable_backup = true
  user_name      = "pvig"
  password       = "Azerty77"
}

resource "scaleway_rdb_database" "main" {
  instance_id    = scaleway_rdb_instance.main.id
  name           = "my-new-database"
}