# Devopstrio AVD Image Factory
# Base Packer Template for Windows 11 Multi-Session
# Build Target: Azure Managed Image / Compute Gallery Version

packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

variable "client_id" { type = string }
variable "client_secret" { type = string, sensitive = true }
variable "tenant_id" { type = string }
variable "subscription_id" { type = string }

source "azure-arm" "avd-win11" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  managed_image_resource_group_name = "rg-avd-image-factory-prd"
  managed_image_name               = "Win11-Multisession-{{timestamp}}"

  os_type         = "Windows"
  image_publisher = "MicrosoftWindowsDesktop"
  image_offer     = "Windows-11"
  image_sku       = "win11-22h2-avd"

  vm_size         = "Standard_D4s_v5"
  location        = "UK South"
}

build {
  sources = ["source.azure-arm.avd-win11"]

  # Step 1: Install Enterprise Software
  provisioner "powershell" {
    script = "./scripts/install-apps.ps1"
  }

  # Step 2: Apply Security Hardening (CIS Benchmark)
  provisioner "powershell" {
    script = "./scripts/apply-hardening.ps1"
  }

  # Step 3: Optimization for VDI (FSLogix, AppX cleanup)
  provisioner "powershell" {
    inline = [
      "Set-ExecutionPolicy Bypass -Scope Process -Force",
      "Write-Output 'Optimizing VDI stack...'",
      "Remove-AppxPackage -Package 'Microsoft.BingNews_1.0.0.0_x64__8wekyb3d8bbwe'",
      "Add-AppxPackage -Register 'C:\\Program Files\\WindowsApps\\*'"
    ]
  }

  # Final Step: Sysprep for Generalization
  provisioner "powershell" {
    inline = [
      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit",
      "while($true) { $p = Get-Process sysprep -ErrorAction SilentlyContinue; if(!$p) { break; } Start-Sleep -s 10 }"
    ]
  }
}
