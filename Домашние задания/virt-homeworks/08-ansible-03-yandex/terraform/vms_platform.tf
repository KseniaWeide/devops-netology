variable "centos7" {
  type        = string
  description = "OS release name"
  default     = "centos-7"
}



variable "vm_clickhouse_platform_id" {
  type        = string
  description = "Platform id"
  default     = "standard-v1"
}

variable "vm_clickhouse_resources" {
  type = map
  default = {
    cores = 2
    memory = 4
    core_fraction = 20
  }
}

variable "vm_vector_platform_id" {
  type        = string
  description = "VM vector Platform id"
  default     = "standard-v1"
}


variable "vm_vector_resources" {
  type = map
  default = {
    cores = 2
    memory = 4
    core_fraction = 20
  }
}

variable "vm_lighthouse_platform_id" {
  type        = string
  description = "VM lighthouse Platform id"
  default     = "standard-v1"
}


variable "vm_lighthouse_resources" {
  type = map
  default = {
    cores = 2
    memory = 4
    core_fraction = 20
  }
}
