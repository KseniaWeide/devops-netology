variable "ip_address" {
  description = "IP-адрес для валидации"
  type        = string
  validation {
    condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",var.ip_address))
    error_message = "Неверный формат IP-адреса"
  }
}


variable "IP_list" {
  type        = list(string)
  description = "список ip-адресов"
  default     =  []
  validation {
    condition = alltrue([
      for a in var.IP_list : can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", a))
    ])
    error_message = "Неверный формат IP-адреса в списке"
  }
}

