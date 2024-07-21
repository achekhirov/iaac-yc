locals {
  name_prefix = var.name_prefix == "" ? "${var.project}-${var.environment_type}" : var.name_prefix
  merged_labels = merge(
    var.custom_labels,
    {
      project          = var.project
      environment-type = var.environment_type
      managed-by       = "terraform"
    },
  )
}

resource "yandex_vpc_network" "tf-test-vpc" {
  name        = "tf-test-vpc"
  folder_id   = var.folder_id
  description = "A test Network created by Terraform"
  labels = {
    tf-label    = "tf-test"
  }
}

# resource "yandex_vpc_subnet" "subnets" {
#   for_each       = length(local.subnets_flatten) > 0 ? { for subnet in local.subnets_flatten : subnet.cidr[0] => subnet } : {}
#   name           = each.value.name
#   v4_cidr_blocks = each.value.cidr
#   network_id     = var.network_id
#   zone           = each.value.zone
#   description    = each.value.description == null ? "${local.name_prefix}-subnet in ${each.value.zone}" : each.value.description
#   folder_id      = var.folder_id
#   route_table_id = each.value.routes == "" ? yandex_vpc_route_table.rt[0].id : each.value.routes
#   labels         = local.merged_labels
#   }
# 