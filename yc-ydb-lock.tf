resource "yandex_iam_service_account" "tf-lock-sa" {
  folder_id = var.folder_id
  name      = "fwea2015-tf-lock-sa"
}

resource "yandex_ydb_database_serverless" "tf-lock-ydb" {
  name                = "yc-terraform-dev"
  deletion_protection = false

  serverless_database {
    enable_throttling_rcu_limit = false
    storage_size_limit          = 50
    throttling_rcu_limit        = 0
  }
}
