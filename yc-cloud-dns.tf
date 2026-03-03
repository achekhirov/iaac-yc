### 1. Service Account для Cloud Function
resource "yandex_iam_service_account" "dns_updater_sa" {
  name        = "dns-updater-sa"
  description = "Service account for Cloud Function that updates DNS records"
}

### 2. Назначение ролей SA
resource "yandex_resourcemanager_folder_iam_member" "dns_editor" {
  folder_id = var.folder_id
  role      = "dns.editor"
  member    = "serviceAccount:${yandex_iam_service_account.dns_updater_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "compute_viewer" {
  folder_id = var.folder_id
  role      = "compute.viewer"
  member    = "serviceAccount:${yandex_iam_service_account.dns_updater_sa.id}"
}

### 4. DNS-зона
resource "yandex_dns_zone" "main_zone" {
  name        = "alexeychekhirovdotnet"
  description = "DNS zone for alexeychekhirov.net."
  zone        = "alexeychekhirov.net."
  folder_id   = var.folder_id
}

### 5. Начальная A-запись (опционально)
resource "yandex_dns_recordset" "a_record" {
  zone_id = yandex_dns_zone.main_zone.id
  name    = "blog.alexeychekhirov.net."
  type    = "A"
  ttl     = 300
  data    = ["158.160.17.252"] # временный IP
}
