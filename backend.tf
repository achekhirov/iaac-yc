terraform {
  backend "s3" {
    bucket                      = "fwea2015-tf-state-bucket"
    key                         = "terraform.tfstate"
    endpoint                    = "storage.yandexcloud.net"
    region                      = "ru-central1"
    skip_credentials_validation = true
    skip_region_validation      = true
    #     skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    #     skip_s3_checksum            = true
    force_path_style = true
  }
}
