/*
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.95.0"
    }
    template = "~> 2.0"

  }
  required_version = ">=0.13"
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "tfstate-develop-vit"
    region = "ru-central1"
    key = "terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g8roqvnljdcrg08i45/etnji3806a6ica5gfld8"
    dynamodb_table = "table215"
  }
}
*/
provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
}
# До 4 задания. Далее в net.tf
module "vpc_dev" {
  source   = "./vpc"
  env_name = "develop"
  zone     = "ru-central1-a"
  cidr     = "10.0.1.0/24"
}

/* До написанного модуля
#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}
*/

module "test-vm" {
  depends_on = [yandex_vpc_security_group.example]
  source   = "git::https://github.com/udjin10/yandex_compute_instance?ref=main"
  env_name = "develop"
  # network_id      = yandex_vpc_network.develop.id                                               
  network_id     = module.vpc_dev.vpc_id
  subnet_zones   = [module.vpc_dev.vpc_zones]
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = "web"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = false
  security_group_ids = [yandex_vpc_security_group.example.id]
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}



#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username       = var.username
    ssh_public_key = file(var.ssh_public_key)
    packages       = jsonencode(var.packages)
  }
}

