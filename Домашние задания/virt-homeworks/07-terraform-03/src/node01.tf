
resource "yandex_compute_disk" "default" {
  count = 3
  name     = "disk-${count.index}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size = 1
}


resource "yandex_compute_instance" "wm-disk" {
# count = 2
# name = "netology-develop-platform-web-${count.index}"
 name = "netology-develop-platform-wm-disk"
 platform_id = "standard-v1"
 
 resources {
    cores         = var.vm_db_resources.cpu
    memory        = var.vm_db_resources.memory
    core_fraction = var.vm_db_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-db.image_id
      type = "network-hdd"
      size = 5
    }
  }
 
 dynamic "secondary_disk" {
   for_each = yandex_compute_disk.default
   content {
    disk_id = secondary_disk.value.id
    auto_delete = true
   }
  }


  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = local.ssh_keys_and_serial_port

}
