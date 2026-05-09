### 4. DNS-зона
resource "yandex_dns_zone" "main_zone" {
  name        = "alexeychekhirovdotnet"
  description = "DNS zone for alexeychekhirov.net."
  zone        = "alexeychekhirov.net."
  folder_id   = var.folder_id
}

### 5. Начальная A-запись (опционально)
resource "yandex_dns_recordset" "a_record_blog" {
  zone_id = yandex_dns_zone.main_zone.id
  name    = "blog.alexeychekhirov.net."
  type    = "A"
  ttl     = 300
  data    = ["158.160.17.252"] # временный IP
}

resource "yandex_dns_recordset" "a_record_git" {
  zone_id = yandex_dns_zone.main_zone.id
  name    = "git.alexeychekhirov.net."
  type    = "A"
  ttl     = 300
  data    = ["178.154.226.28"]
}

resource "yandex_dns_recordset" "a_record_photo" {
  zone_id = yandex_dns_zone.main_zone.id
  name    = "photo.alexeychekhirov.net."
  type    = "A"
  ttl     = 300
  data    = ["151.101.128.119", "151.101.192.119"]
}

resource "yandex_dns_recordset" "txt_record_identity_hub" {
  zone_id = yandex_dns_zone.main_zone.id
  name    = "_yandexcloud-challenge"
  type    = "TXT"
  ttl     = 300
  data    = ["fs1lJ19JxFYqL02xU+cm9Ip9kVqTzxz5NDK4BB2HxAU="]
}
