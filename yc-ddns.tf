### 6. Cloud Function
resource "yandex_function" "update_dns_func" {
  name               = "update-dns-function"
  description        = "Updates A record in Cloud DNS when VM starts"
  runtime            = "python39"
  entrypoint         = "handler"
  memory             = 128
  execution_timeout  = 10
  service_account_id = yandex_iam_service_account.dns_updater_sa.id
  user_hash          = "first-ddns-function"

  content {
    zip_filename = "${path.module}/ddns-updater.zip"
  }

  environment = {
    DNS_ZONE_ID = yandex_dns_zone.main_zone.id
    FOLDER_ID   = var.folder_id
    RECORD_NAME = "blog.alexeychekhirov.net."
  }

}
