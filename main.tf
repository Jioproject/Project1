module "resource_group" {
  source   = "../module/azurerm_rg"
  rg_name  = "rg_vi"
  location = "centralus"
}

module "resource_group" {
  source   = "../module/azurerm_rg"
  rg_name  = "rg_vi"
  location = "centralus"
}

module "vnet" {
    source = "../module/azurerm_vnet"
    depends_on = [module.resource_group]
    vnet_name = "vnet_vi"
    rg_name = "rg_vi"
    location = "centralus"
    address_space = ["10.0.0.0/16"]
}

module "subnetf" {
    source = "../module/azurerm_subnet"
    depends_on = [module.vnet]
    subnet_name = "subnetf_vi"
    rg_name = "rg_vi"
    vnet_name = "vnet_vi"
    address_prefixes = ["10.0.1.0/24"]
}

module "subnetb" {
    source = "../module/azurerm_subnet"
    depends_on = [module.vnet]
    subnet_name = "subnetb_vi"
    rg_name = "rg_vi"
    vnet_name = "vnet_vi"
    address_prefixes = ["10.0.2.0/24"]
}

module "pipf" {
    source = "../module/azurerm_pip"
 depends_on = [module.subnetf]
 pip_name = "pipf_vi"
 location = "centralus"
 rg_name = "rg_vi"
 allocation_method = "Static"
 sku = "Standard" 
}
module "pipb" {
    source = "../module/azurerm_pip"
    depends_on = [module.subnetb]
    pip_name = "pipb_vi"
    location = "centralus"
    rg_name = "rg_vi"
    allocation_method = "Static"
    sku = "Standard"
}

module "nicf" {
    source = "../module/azurerm_nic"
    depends_on = [module.subnetf]
    nic_name = "nicf_vi"
    location = "centralus"
    rg_name = "rg_vi"
    ip_config = "ipconfigf_vi"
    subnet_name = "subnetf_vi"
    pip_name = "pipf_vi"
    vnet_name = "vnet_vi"
}

module "nicb" {
    source = "../module/azurerm_nic"
    depends_on = [module.subnetb]
    nic_name = "nicb_vi"
    location = "centralus"
    rg_name = "rg_vi"
    ip_config = "ipconfigb_vi"
    subnet_name = "subnetb_vi"
    pip_name = "pipb_vi"
    vnet_name = "vnet_vi"
}
module "vmf" {
    source = "../module/azurerm_vm"
    depends_on = [module.nicf]
    vm_name = "vmfvi"
    location = "centralus"
    rg_name = "rg_vi"
    nic_name = "nicf_vi"
    vm_size = "Standard_B1s"
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
}
module "vmb" {
    source = "../module/azurerm_vm"
    depends_on = [module.nicb]
    vm_name = "vmbvi"
    location = "centralus"
    rg_name = "rg_vi"
    nic_name = "nicb_vi"
    vm_size = "Standard_B1s"
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
}