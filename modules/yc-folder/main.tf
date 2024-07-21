terraform {
  required_version = "~> 1.4"
  required_providers {
    kubernetes = {
      version = "~> 2.21"
    }
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.100"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-a"
}
