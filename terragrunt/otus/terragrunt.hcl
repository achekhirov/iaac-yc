locals {
  # Cloud
  cloud_id     = "b1grem40nqckc9kuc9oj"
  #Folder
  folder_id    = "b1gnuciqmvp9213fu7gr"
  # Environment
  project          = "otus"
  environment_type = "dev"
  env              = "${local.project}-${local.environment_type}"
}

remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
  }

  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
}

retry_max_attempts       = 5
retry_sleep_interval_sec = 5
