//
// Create a new MDB MySQL Cluster.
//
resource "yandex_mdb_mysql_cluster" "mysql" {
  name        = "mysql-dev"
  environment = "PRESTABLE"
  network_id  = data.yandex_vpc_network.default_network.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    max_connections               = 10
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true

  }

  host {
    zone      = "ru-central1-b"
    subnet_id = data.yandex_vpc_subnet.default_subnet_b.id
  }
}

//
// Create a new MDB MySQL Database.
//
resource "yandex_mdb_mysql_database" "blog_db" {
  cluster_id = yandex_mdb_mysql_cluster.mysql.id
  name       = "blogdb"
}

//
// Create a new MDB MySQL Database User.
//
resource "yandex_mdb_mysql_user" "blog_admin" {
  cluster_id = yandex_mdb_mysql_cluster.mysql.id
  name       = "blog"
  password   = var.mysql_user_password

  permission {
    database_name = yandex_mdb_mysql_database.blog_db.name
    roles         = ["ALL"]
  }

  connection_limits {
    max_questions_per_hour   = -1
    max_updates_per_hour     = -1
    max_connections_per_hour = -1
    max_user_connections     = 40
  }

  global_permissions = ["PROCESS"]

  authentication_plugin = "SHA256_PASSWORD"
}

resource "yandex_mdb_mysql_database" "deploytool_db" {
  cluster_id = yandex_mdb_mysql_cluster.mysql.id
  name       = "deploytooldb"
}

resource "yandex_mdb_mysql_user" "deploytool_user" {
  cluster_id = yandex_mdb_mysql_cluster.mysql.id
  name       = "deploytool"
  password   = var.mysql_deploytool_password

  permission {
    database_name = yandex_mdb_mysql_database.deploytool_db.name
    roles         = ["ALL"]
  }

  connection_limits {
    max_questions_per_hour   = -1
    max_updates_per_hour     = -1
    max_connections_per_hour = -1
    max_user_connections     = 40
  }

  global_permissions = ["PROCESS"]

  authentication_plugin = "SHA256_PASSWORD"
}
