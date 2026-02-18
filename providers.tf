provider "yandex" {
  token     = var.yc_token      # IAM‑токен из yc CLI (или переменная)
  folder_id = var.folder_id  # ID папки в личном облаке
  zone      = var.zone              # Зона (например, ru-central1-a)
}
