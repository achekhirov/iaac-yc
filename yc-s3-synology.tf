// Create SA for Synology
resource "yandex_iam_service_account" "synology-sa" {
  folder_id = var.folder_id
  name      = "synology-sa"
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "synology-sa-static-key" {
  service_account_id = yandex_iam_service_account.synology-sa.id
  description        = "Synology Hyper Backup"
}

resource "yandex_storage_bucket" "synology-homes" {
  bucket = "synology-homes"
}

resource "yandex_storage_bucket" "synology-photoarchive" {
  bucket = "synology-photoarchive"
}

output "synology_sa_access_key" {
  value = yandex_iam_service_account_static_access_key.synology-sa-static-key.access_key
}

output "synology_sa_secret_key" {
  value     = yandex_iam_service_account_static_access_key.synology-sa-static-key.secret_key
  sensitive = true # Marks the output as sensitive to obscure it in logs
}
