resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "centos" {
  family = var.centos7
}
resource "yandex_compute_instance" "clickhouse" {
  name        = local.clickhouse-name
  platform_id = var.vm_clickhouse_platform_id
  resources {
    cores         = var.vm_clickhouse_resources.cores
    memory        = var.vm_clickhouse_resources.memory
    core_fraction = var.vm_clickhouse_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    serial-port-enable = var.vm_metadata.serial-port-enable
   ssh-keys = "centos:${file(var.vm_metadata.ssh-keys)}"
  }

}


resource "yandex_compute_instance" "vector" {
  name        = local.vector-name
  platform_id = var.vm_vector_platform_id
  resources {
    cores         = var.vm_vector_resources.cores
    memory        = var.vm_vector_resources.memory
    core_fraction = var.vm_vector_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys = "centos:${file(var.vm_metadata.ssh-keys)}"
  }

}

resource "yandex_compute_instance" "lighthouse" {
  name        = local.lighthouse-name
  platform_id = var.vm_lighthouse_platform_id
  resources {
    cores         = var.vm_lighthouse_resources.cores
    memory        = var.vm_lighthouse_resources.memory
    core_fraction = var.vm_lighthouse_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys = "centos:${file(var.vm_metadata.ssh-keys)}"
  }

}
