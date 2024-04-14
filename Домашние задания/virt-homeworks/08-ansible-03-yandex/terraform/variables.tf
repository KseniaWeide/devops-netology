###cloud vars
variable "token" {
  type        = string
  description = ""
}

variable "cloud_id" {
  type        = string
  description = ""
}

variable "folder_id" {
  type        = string
  description = ""
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "netology.cloud"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "netology_subnet"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###Исправленный ssh
variable "vm_metadata" {
  type = map
  default = {
    serial-port-enable = 1
    ssh-keys           = "/root/.ssh/id_rsa.pub" 
  }
}
