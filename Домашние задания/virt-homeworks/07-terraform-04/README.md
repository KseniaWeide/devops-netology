# Домашнее задание к занятию "Продвинутые методы работы с Terraform"

### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания ВМ с помощью remote модуля.
2. Создайте 1 ВМ, используя данный модуль. В файле cloud-init.yml необходимо использовать переменную для ssh ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание что ssh-authorized-keys принимает в себя список, а не строку!
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```.


- Решение:
 ![img.png](img.png)
![img_1.png](img_1.png)

------

### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.vpc_dev.
6. Сгенерируйте документацию к модулю с помощью terraform-docs.    
 
Пример вызова:
```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```
![img_3.png](img_3.png)

------------------------------------------------
 ## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_test-vm"></a> [test-vm](#module\_test-vm) | git::https://github.com/ksenia-nikolaeva/yandex_compute_instance.git | main |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [template_file.userdata](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id | `string` | n/a | yes |
| <a name="input_default_cidr"></a> [default\_cidr](#input\_default\_cidr) | https://cloud.yandex.ru/docs/vpc/operations/subnet-create | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone) | https://cloud.yandex.ru/docs/overview/concepts/geo-scope | `string` | `"ru-central1-a"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token | `string` | n/a | yes |
| <a name="input_vm_db_name"></a> [vm\_db\_name](#input\_vm\_db\_name) | example vm\_db\_ prefix | `string` | `"netology-develop-platform-db"` | no |
| <a name="input_vm_web_name"></a> [vm\_web\_name](#input\_vm\_web\_name) | example vm\_web\_ prefix | `string` | `"netology-develop-platform-web"` | no |
| <a name="input_vms_ssh_root_key"></a> [vms\_ssh\_root\_key](#input\_vms\_ssh\_root\_key) | ssh-keygen -t ed25519 | `string` | `"your_ssh_ed25519_key"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC network&subnet name | `string` | `"develop"` | no |

## Outputs


| Name | Description |
|------|-------------|
| <a name="output_external_ip_address"></a> [external\_ip\_address](#output\_external\_ip\_address) | n/a |


 ------------------------------------------

### Задание 3
1. Выведите список ресурсов в стейте.
2. Удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте его обратно. Проверьте terraform plan - изменений быть не должно.
Приложите список выполненных команд и вывод.

Решение:
```bash

vagrant@server1:~/dz_terraform/ter-homeworks/04/demonstration1$ terraform state list
data.template_file.cloudinit
module.test-vm.data.yandex_compute_image.my_image
module.test-vm.yandex_compute_instance.vm[0]
module.vpc.yandex_vpc_network.net_name
module.vpc.yandex_vpc_subnet.subnet_name
vagrant@server1:~/dz_terraform/ter-homeworks/04/demonstration1$ terraform state show module.vpc.yandex_vpc_network.net_name
# module.vpc.yandex_vpc_network.net_name:
resource "yandex_vpc_network" "net_name" {
    created_at                = "2023-11-23T07:21:03Z"
    default_security_group_id = "enp8hc7bcj9vmuthuqor"
    folder_id                 = "b1gk3u0k5bfco8fvc50h"
    id                        = "enpp9agne0q3ck2m34sc"
    labels                    = {}
    name                      = "develop"
    subnet_ids                = []
}
vagrant@server1:~/dz_terraform/ter-homeworks/04/demonstration1$ terraform state show module.vpc.yandex_vpc_subnet.subnet_name
# module.vpc.yandex_vpc_subnet.subnet_name:
resource "yandex_vpc_subnet" "subnet_name" {
    created_at     = "2023-11-23T07:21:13Z"
    folder_id      = "b1gk3u0k5bfco8fvc50h"
    id             = "e9blm6likh00knrqiocs"
    labels         = {}
    name           = "develop-ru-central1-a"
    network_id     = "enpp9agne0q3ck2m34sc"
    v4_cidr_blocks = [
        "10.0.1.0/24",
    ]
    v6_cidr_blocks = []
    zone           = "ru-central1-a"
}
vagrant@server1:~/dz_terraform/ter-homeworks/04/demonstration1$ terraform state rm 'module.vpc'
Removed module.vpc.yandex_vpc_network.net_name
Removed module.vpc.yandex_vpc_subnet.subnet_name
Successfully removed 2 resource instance(s).
vagrant@server1:~/dz_terraform/ter-homeworks/04/demonstration1$ terraform import module.vpc.yandex_vpc_network.net_name enpp9agne0q3ck2m34sc
module.vpc.yandex_vpc_network.net_name: Importing from ID "enpp9agne0q3ck2m34sc"...
module.vpc.yandex_vpc_network.net_name: Import prepared!
  Prepared yandex_vpc_network for import
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.vpc.yandex_vpc_network.net_name: Refreshing state... [id=enpp9agne0q3ck2m34sc]
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=d7f8f22686b76e2ccd4b02e77eb899b12d7fe26d9f55decf469b15191e86ad9f]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 0s [id=fd8tir33idvbn40d00nm]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

vagrant@server1:~/dz_terraform/ter-homeworks/04/demonstration1$ terraform import module.vpc.yandex_vpc_subnet.subnet_name e9blm6likh00knrqiocs
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.vpc.yandex_vpc_subnet.subnet_name: Importing from ID "e9blm6likh00knrqiocs"...
module.vpc.yandex_vpc_subnet.subnet_name: Import prepared!
  Prepared yandex_vpc_subnet for import
module.vpc.yandex_vpc_subnet.subnet_name: Refreshing state... [id=e9blm6likh00knrqiocs]
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=d7f8f22686b76e2ccd4b02e77eb899b12d7fe26d9f55decf469b15191e86ad9f]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 1s [id=fd8tir33idvbn40d00nm]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

vagrant@server1:~/dz_terraform/ter-homeworks/04/demonstration1$ terraform plan
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=d7f8f22686b76e2ccd4b02e77eb899b12d7fe26d9f55decf469b15191e86ad9f]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.vpc.yandex_vpc_network.net_name: Refreshing state... [id=enpp9agne0q3ck2m34sc]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 1s [id=fd8tir33idvbn40d00nm]
module.vpc.yandex_vpc_subnet.subnet_name: Refreshing state... [id=e9blm6likh00knrqiocs]
module.test-vm.yandex_compute_instance.vm[0]: Refreshing state... [id=fhmm2cvqrtmonv0pmum6]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found
no differences, so no changes are needed.

vagrant@server1:~/dz_terraform/ter-homeworks/04/demonstration1$ 
```

## Дополнительные задания (со звездочкой*)

