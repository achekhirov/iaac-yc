locals {
  name        = "otus-dev"
  description = "A designated folder for MLOps courseworks"
}

resource "yandex_resourcemanager_folder" "otus-dev" {
  cloud_id    = var.cloud_id
  name        = local.name
  description = local.description
}
