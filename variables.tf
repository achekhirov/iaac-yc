variable "yc_token" {
  description = "IAM-токен для личного облака"
  type        = string
}

variable "folder_id" {
  description = "ID папки в личном облаке"
  type        = string
}
variable "zone" {
  default = "ru-central1-a"
}
variable "mysql_user_password" {
  type        = string
  description = "Password for MySQL blog user"
  sensitive   = true # скрывает значение в выводе Terraform
}

variable "mysql_deploytool_password" {
  type        = string
  description = "Password for MySQL deploy tool user"
  sensitive   = true # скрывает значение в выводе Terraform
}
