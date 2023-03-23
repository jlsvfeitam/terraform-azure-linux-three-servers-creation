variable "azurerm_virtual_network__name" {
  type    = string
  default = "my-resourcegroup"
}

variable "azurerm_subnet__name" {
  type    = string
  default = "my-subnet"
}


variable "azurerm_network_interface__names" {
  type    = list(string)
  default = ["my-ni-1", "my-ni-2", "my-ni-3"]
}

variable "private_ips" {
  type    = list(string)
  default = ["10.0.0.9", "10.0.0.10", "10.0.0.11"]
}

variable "azurerm_linux_virtual_machine__names" {
  type    = list(string)
  default = ["my-lvm-1-pele" , "my-lvm-2-romario", "my-lvm-3-ronaldo"]
}


variable "username" {
  type    = string
  default = "operatorinfra"
}