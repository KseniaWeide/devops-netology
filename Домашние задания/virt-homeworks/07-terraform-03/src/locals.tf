locals {
  env = "develop"
  project = "platform"
  role1 = "web"
  role2 = "db"
}

locals {
  web_name = "netology-${ local.env }-${ local.project }-${ local.role1}"
  db_name  = "netology-${ local.env }-${ local.project }-${ local.role2}"
}

locals {
 ssh_keys_and_serial_port = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    serial-port-enable = 1
  }
} 
