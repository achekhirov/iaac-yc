# Terraform Module: Yandex Cloud Network

Модуль для управления [подсетями](https://cloud.yandex.ru/docs/vpc/concepts/network) в Яндекс.Облаке.

- Описание переменных смотри в [variables.tf](variables.tf).
- Пример terragrunt.hcl смотри в [terragrunt.example.hcl](terragrunt.example.hcl).

## Обновление с версий 2.x.x до версии 3.x.x

- Заменить `env` на `environment`, `project`.
- Убрать переменную `cloud_id` из `terragrunt.hcl`.
- Измениить структуру переменной `subnets` в `terragrunt.hcl` согласно примеру в `terragrunt.example.hcl`.
- Создать файл `moved-blocks.tf` рядом с `terragrunt.hcl` в текущем окружении проекта.
- Сделать `terragrunt state list`.
- Выписать названия ресурсов каждой сети, `terragrunt output` по cidr сетям, и так как в модуле используется именование через cidr блок, внести изменения в `moved-blocks.tf`:

```hcl
moved {
  from = yandex_vpc_subnet.subnets["tp-staging1-private-subnet1-a"]
  to   = yandex_vpc_subnet.subnets["10.192.104.192/26"]
}
moved {
  from = yandex_vpc_subnet.subnets["tp-staging1-private-subnet1-b"]
  to   = yandex_vpc_subnet.subnets["10.192.169.192/26"]
}
moved {
  from = yandex_vpc_subnet.subnets["tp-staging1-private-subnet1-c"]
  to   = yandex_vpc_subnet.subnets["10.192.234.0/26"]
}
```

- В `terragrunt.hcl` поставить обновленную версию модуля.
- Примениить изменения и убедиться, что все ресурсы сетей сделали `moved`, нет удалений.
- Изменения ресурсов допускаются при добавлении лейблов.
- После применения удалить файл `moved-blocks.tf`, пушить в репу с окружением не нужно.

<!-- BEGIN_TF_DOCS -->
![](https://img.shields.io/badge/owner-Tech%20Platform%20Team-red)


[CHANGELOG](CHANGELOG.md)

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.3 |
| yandex | ~> 0.92 |

## Providers

| Name | Version |
|------|---------|
| yandex | ~> 0.92 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns_servers | DNS servers used by subnet | `list(any)` | n/a | yes |
| domain_name | Subnet domain name | `string` | n/a | yes |
| environment | Environment name is used to identify resources (with index). For example: staging2, nft3, prod16, e2e-test1, promo-test1 | `string` | n/a | yes |
| environment_type | Environment type is used to identify resources (without index). For example: staging, nft, production, test, review, uat, canary, sandbox | `string` | n/a | yes |
| folder_id | Folder ID in YC | `string` | n/a | yes |
| network_id | Yandex network ID | `string` | n/a | yes |
| project | Project name is used to identify resources. For example: tp, b2r-irm, b2r-sharepoint, lg-lm, b2c-web | `string` | n/a | yes |
| vpc_folder_id | VPC folder id in YC (main) | `string` | n/a | yes |
| cloud_id | DEPRECATED | `string` | `null` | no |
| custom_labels | Custom labels to assign to resources | `map(string)` | `{}` | no |
| custom_route_enabled | Use custom route in subnets.routes VPC | `bool` | `false` | no |
| env | DEPRECATED | `string` | `null` | no |
| label_managed_by_team | Value for label 'managed_by_team' | `string` | `"tp"` | no |
| name_prefix | Name of the resource override | `string` | `""` | no |
| subnets | Subnet map | <pre>list(object({<br>    name        = string<br>    cidr        = list(string)<br>    zone        = string<br>    description = string<br>    routes      = optional(string, "")<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| private_subnets | Private subnets created |
| public_subnets | Public subnets created |

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_gateway.nat_gateway](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_gateway) | resource |
| [yandex_vpc_route_table.rt](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_subnet.subnets](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |


<!-- END_TF_DOCS -->
