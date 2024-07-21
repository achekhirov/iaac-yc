variable "project" {
  description = "Project name is used to identify resources"
  type        = string
}

variable "environment_type" {
  description = "Environment type is used to identify resources (without index). For example: staging, nft, production, test, review, uat, canary, sandbox"
  default     = "dev"
  type        = string
}

variable "folder_id" {
  description = "Folder ID in YC"
  type        = string
}

variable "subnets" {
  description = "Subnet map"
  default     = []
  type = list(object({
    name        = string
    cidr        = list(string)
    zone        = string
    description = string
    routes      = optional(string, "")
  }))
}


variable "name_prefix" {
  description = "Name of the resource override"
  default     = ""
  type        = string
}

variable "custom_route_enabled" {
  description = "Use custom route in subnets.routes VPC"
  default     = false
  type        = bool
}

variable "custom_labels" {
  description = "Custom labels to assign to resources"
  default     = {}
  type        = map(string)
}

