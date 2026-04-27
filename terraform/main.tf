# Devopstrio AVD Image Factory
# Infrastructure as Code (Terraform)
# Target: Azure RM

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Image Operations Resource Group
resource "azurerm_resource_group" "factory_rg" {
  name     = "rg-avd-image-factory-prd"
  location = "uksouth"
  tags = {
    Automation = "Image-Factory"
    Owner      = "Desktop-Engineering"
  }
}

# 2. Azure Compute Gallery (The Registry)
resource "azurerm_shared_image_gallery" "gallery" {
  name                = "gal_avd_enterprise_images"
  resource_group_name = azurerm_resource_group.factory_rg.name
  location            = azurerm_resource_group.factory_rg.location
  description         = "Centralized hub for all security-hardened AVD golden images."
}

# 3. Image Definition (Win11 Multi-Session)
resource "azurerm_shared_image" "win11_ms" {
  name                = "Win11-Multisession-Hardened"
  gallery_name        = azurerm_shared_image_gallery.gallery.name
  resource_group_name = azurerm_resource_group.factory_rg.name
  location            = azurerm_resource_group.factory_rg.location
  os_type             = "Windows"

  identifier {
    publisher = "Devopstrio"
    offer     = "AVD-Enterprise"
    sku       = "Win11-MS-CIS"
  }
}

# 4. Storage for Automation Artifacts & Scripts
resource "azurerm_storage_account" "factory_storage" {
  name                     = "stavdimagefactoryprd"
  resource_group_name      = azurerm_resource_group.factory_rg.name
  location                 = azurerm_resource_group.factory_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# 5. Key Vault (Build & Service Principal Secrets)
resource "azurerm_key_vault" "factory_vault" {
  name                = "kv-avd-image-secrets"
  location            = azurerm_resource_group.factory_rg.location
  resource_group_name = azurerm_resource_group.factory_rg.name
  tenant_id           = "your-tenant-id"
  sku_name            = "premium"

  access_policy {
    tenant_id = "your-tenant-id"
    object_id = "your-service-principal-id"
    secret_permissions = ["Get", "List"]
  }
}

# Outputs
output "gallery_id" {
  value = azurerm_shared_image_gallery.gallery.id
}

output "win11_image_definition" {
  value = azurerm_shared_image.win11_ms.id
}
