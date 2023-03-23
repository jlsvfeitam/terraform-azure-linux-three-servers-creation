resource "azurerm_resource_group" "myrg" { 
  name     = "my-resourcegroup" 
  location = "uksouth" 
} 

resource "azurerm_virtual_network" "myvn" { 
  name                = var.azurerm_virtual_network__name
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  address_space       = ["10.0.0.0/24"]
} 

resource "azurerm_subnet" "mysn" { 
  name                 = var.azurerm_subnet__name 
  resource_group_name  = azurerm_resource_group.myrg.name 
  virtual_network_name = azurerm_virtual_network.myvn.name 
  address_prefixes     = ["10.0.0.0/28"] 
} 

resource "azurerm_public_ip" "mypi" { 
  count               = 3
  name                = "my-publicip-${count.index + 1}"
  location            = "uksouth" 
  resource_group_name = azurerm_resource_group.myrg.name 
  allocation_method   = "Dynamic" 
  sku                 = "Basic" 
} 

resource "azurerm_network_interface" "myni"   { 
  count               = length(var.azurerm_network_interface__names)
  name                = var.azurerm_network_interface__names[count.index]
  location            = "uksouth" 
  resource_group_name = azurerm_resource_group.myrg.name 

  ip_configuration { 
    name                          = "ipconfig-main" 
    subnet_id                     = azurerm_subnet.mysn.id 
    private_ip_address_allocation = "Static" 
    private_ip_address            = var.private_ips[count.index]
    public_ip_address_id          = azurerm_public_ip.mypi[count.index].id
  } 
} 

resource "azurerm_linux_virtual_machine" "mylvm" {
  count                 = length(var.azurerm_linux_virtual_machine__names)
  name                  = var.azurerm_linux_virtual_machine__names[count.index]
  location              = azurerm_resource_group.myrg.location
  resource_group_name   = azurerm_resource_group.myrg.name
  network_interface_ids = [azurerm_network_interface.myni[count.index].id]
  size                  = "Standard_DS1_v2"
  admin_username        = var.username

  admin_ssh_key {
    username   = var.username
    public_key = file("id_rsa_operatorinfra.pub")
  }

  os_disk {
    name                 = "hdd${count.index + 1}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = "env"
  }

}