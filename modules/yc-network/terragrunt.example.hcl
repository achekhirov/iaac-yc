include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "/Users/alexeychekhirov/Documents/iaac/yc/modules/yc-network"
}

dependency "netbox-prefixes" {
  config_path = "../netbox-prefixes"
}

dependency "yc-folder" {
  config_path = "../yc-folder"

  mock_outputs = {
    folder_id   = "__mock__folder_id"
    folder_name = "__mock__folder_name"
  }
}

locals {
  project          = include.root.locals.project
  environment_type = include.root.locals.environment_type
  vpc_folder_id    = include.root.locals.vpc_folder_id
  vpc_id           = include.root.locals.vpc_id
}

inputs = {
  project          = local.project
  environment_type = local.environment_type
  folder_id        = dependency.yc-folder.outputs.folder_id
  vpc_folder_id    = local.vpc_folder_id
  network_id       = local.vpc_id

  subnets = [
    {
      name        = "${local.env}-private-subnet1-a"
      cidr        = "10.0.0.0/24"
      zone        = "ru-central1-a"
      description = "private segment zone A"
    },
    {
      name        = "${local.env}-private-subnet1-b"
      cidr        = "10.0.0.0/24"
      zone        = "ru-central1-b"
      description = "private segment zone B"
    },
  ]
}
