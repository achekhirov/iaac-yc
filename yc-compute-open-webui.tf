# Создание загрузочных дисков
resource "yandex_compute_disk" "openwebui_boot_disk" {
  name        = "disk-ubuntu-webui"
  description = "A VM for Open WebUI interface"
  image_id    = "fd8ulqth5qf5suqiecli"
  type        = "network-ssd"
  zone        = "ru-central1-b"
  size        = "20"
}

resource "yandex_compute_instance" "openwebui_compute" {
  name                      = "openwebui"
  zone                      = "ru-central1-b"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  resources {
    core_fraction = 100
    cores         = 8
    memory        = 16
  }

  boot_disk {
    disk_id = yandex_compute_disk.openwebui_boot_disk.id
  }

  network_interface {
    subnet_id          = data.yandex_vpc_subnet.default_subnet_b.id
    security_group_ids = [yandex_vpc_security_group.openwebui_sg.id]
    nat                = true
  }
  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}
