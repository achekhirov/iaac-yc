// Retrieving VPC configuration
data "yandex_vpc_network" "default_network" {
  name = "default" # имя существующей сети
}

// Retrieving Subnet configuration
data "yandex_vpc_subnet" "default_subnet_b" {
  name = "default-ru-central1-b"
}
