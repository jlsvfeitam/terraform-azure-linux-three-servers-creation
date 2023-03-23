output "azurerm_private_ip__ip_address_vms" {
  value = "${azurerm_network_interface.myni.*.private_ip_address}"
  description = "IP private all vms"
}

output "azurerm_public_ip__ip_address_vm1" {
  value = azurerm_public_ip.mypi[0].ip_address
  description = "IP public vm1"
}

output "azurerm_public_ip__ip_address_vm2" {
  value = azurerm_public_ip.mypi[1].ip_address
  description = "IP public vm2"
}

output "azurerm_public_ip__ip_address_vm3" {
  value = azurerm_public_ip.mypi[2].ip_address
  description = "IP public vm3"
}

output "azurerm_public_ip__ip_address_vms" {
  value = azurerm_public_ip.mypi[*].ip_address
  description = "IP public all vms"
}