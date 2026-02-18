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
