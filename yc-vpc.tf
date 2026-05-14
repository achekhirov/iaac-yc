// Retrieving VPC configuration
data "yandex_vpc_network" "default_network" {
  name = "default" # имя существующей сети
}

// Retrieving Subnet configuration
data "yandex_vpc_subnet" "default_subnet_b" {
  name = "default-ru-central1-b"
}

resource "yandex_vpc_security_group" "blog_sg" {
  name        = "blog-sg"
  description = "Security Group for my blog VM"
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

  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "MySQL"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 3306
  }
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
  ingress {
    protocol       = "TCP"
    description    = "Flask"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5000
  }
  ingress {
    protocol       = "TCP"
    description    = "Django"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 8000
  }
}
