include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "/Users/alexeychekhirov/Documents/iaac/yc/modules/yc-folder"
}

inputs = {
  cloud_id         = include.root.locals.cloud_id
  project          = include.root.locals.project
  environment_type = include.root.locals.environment_type
}
