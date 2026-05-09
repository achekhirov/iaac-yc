provider "yandex" {
  service_account_key_file = "fwea2015-tf-sa-key.json"
  folder_id                = var.folder_id # ID папки в личном облаке
  zone                     = var.zone      # Зона (например, ru-central1-a)
}
