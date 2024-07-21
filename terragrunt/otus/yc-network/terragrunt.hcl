include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "/Users/alexeychekhirov/Documents/iaac/yc/modules/yc-network"
}

dependency "yc-folder" {
  config_path = "../yc-folder"
}

locals {
  folder_id        = include.root.locals.folder_id
  project          = include.root.locals.project
  environment_type = include.root.locals.environment_type
}

inputs = {
  project          = local.project
  environment_type = local.environment_type
  folder_id        = local.folder_id
}
