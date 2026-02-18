// Retrieving VPC configuration
data "yandex_vpc_network" "default_network" {
  name = "default" # имя существующей сети
}

// Retrieving Subnet configuration
data "yandex_vpc_subnet" "default_subnet_b" {
  name = "default-ru-central1-b"
}

resource "yandex_vpc_security_group" "test1_sg" {
  name        = "ubuntu-lab-sg"
  description = "Security Group for Ubuntu lab/test VM"
  network_id  = data.yandex_vpc_network.default_network.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

# Создание загрузочных дисков
resource "yandex_compute_disk" "test1_boot_disk" {
  name        = "disk-ubuntu-24-04-lts-1757791913373"
  description = "A VM for job interview purposes"

  type     = "network-ssd"
  zone     = "ru-central1-b"
  size     = "20"
  image_id = "fd888dplf7gt1nguheht"
}

resource "yandex_compute_instance" "test1_compute" {
  name        = "test1"
  zone        = "ru-central1-b"
  platform_id = "standard-v3"

  resources {
    core_fraction = 100
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.test1_boot_disk.id
  }

  network_interface {
    subnet_id          = data.yandex_vpc_subnet.default_subnet_b.id
    security_group_ids = [yandex_vpc_security_group.test1_sg.id]
    nat                = true
  }
  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}
