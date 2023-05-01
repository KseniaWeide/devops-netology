variable "vm_web_image_family" {
  type        = string
  description = "OS release name"
  default     = "ubuntu-2004-lts"
}



variable "vm_web_platform_id" {
  type        = string
  description = "Platform id"
  default     = "standard-v1"
}

variable "vm_web_resources" {
  type = map
  default = {
    cores = 2
    memory = 4
    core_fraction = 5
  }
}

variable "vm_db_platform_id" {
  type        = string
  description = "VM db Platform id"
  default     = "standard-v1"
}


variable "vm_db_resources" {
  type = map
  default = {
    cores = 2
    memory = 2
    core_fraction = 20
  }
}

