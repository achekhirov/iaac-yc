variable "cloud_id" {
  description = "Cloud ID in YC"
  type        = string
  default     = "b1grem40nqckc9kuc9oj"
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment_type" {
  description = "Environment type"
  default     = "dev"
  type        = string
}

variable "custom_folder_name" {
  description = "Custom name of the folder"
  default     = ""
  type        = string
}

variable "custom_folder_description" {
  description = "Custom description of the folder"
  default     = ""
  type        = string
}
