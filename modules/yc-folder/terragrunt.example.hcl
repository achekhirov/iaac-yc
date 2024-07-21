include {
  path = find_in_parent_folders()
}

terraform {
  source = "/Users/alexeychekhirov/Documents/iaac/yc/modules/yc-folder"
}

locals {
  cloud_vars       = read_terragrunt_config(find_in_parent_folders("cloud.hcl"))
  cloud_id         = local.cloud_vars.locals.cloud_id
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  project          = local.environment_vars.locals.project
  environment_type = local.environment_vars.locals.environment_type
}

inputs = {
  cloud_id         = local.cloud_id
  project          = local.project
  environment_type = local.environment_type
}
