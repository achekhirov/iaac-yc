// Create SA
resource "yandex_iam_service_account" "tf-state-sa" {
  folder_id = var.folder_id
  name      = "fwea2015-tf-state-sa"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "tf-state-sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.tf-state-sa.id}"
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "tf-state-sa-static-key" {
  service_account_id = yandex_iam_service_account.tf-state-sa.id
  description        = "static access key for object storage"
}

// Use keys to create bucket
resource "yandex_storage_bucket" "tf_state" {
  access_key = yandex_iam_service_account_static_access_key.tf-state-sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.tf-state-sa-static-key.secret_key
  bucket     = "fwea2015-tf-state-bucket"
}

output "tf_state_sa_access_key" {
  value = yandex_iam_service_account_static_access_key.tf-state-sa-static-key.access_key
}

output "tf_state_sa_secret_key" {
  value     = yandex_iam_service_account_static_access_key.tf-state-sa-static-key.secret_key
  sensitive = true # Marks the output as sensitive to obscure it in logs
}
