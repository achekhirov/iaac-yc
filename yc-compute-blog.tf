
//
// Create a new Compute Disk.
//
resource "yandex_compute_disk" "blog_boot_disk" {
  name     = "boot-disk-blog"
  zone     = "ru-central1-b"
  type     = "network-ssd"
  image_id = "fd8q1krrgc5pncjckeht"
}

resource "yandex_compute_instance" "blog_compute" {
  name        = "blog"
  zone        = "ru-central1-b"
  platform_id = "standard-v3"

  resources {
    core_fraction = 100
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.blog_boot_disk.id
  }

  network_interface {
    subnet_id          = data.yandex_vpc_subnet.default_subnet_b.id
    security_group_ids = [yandex_vpc_security_group.blog_sg.id]
    nat                = true
  }
  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}
