locals {
  name = (
    var.custom_folder_name != ""
    ? var.custom_folder_name
    : "${var.project}-${var.environment_type}"
  )
  description = (
    var.custom_folder_description != ""
    ? var.custom_folder_description
    : ""
  )
  merged_labels = merge(
    var.custom_labels,
    {
      project          = var.project
      environment-type = var.environment_type
      managed-by       = "terraform"
    },
  )
}

resource "yandex_resourcemanager_folder" "folder" {
  cloud_id    = var.cloud_id
  name        = local.name
  description = local.description
  labels      = local.merged_labels
}
