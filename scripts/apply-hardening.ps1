# Devopstrio AVD Image Factory
# Security Hardening Script (CIS Baseline Alignment)
# Target: Windows 11 Enterprise Multi-Session

$ErrorActionPreference = "SilentlyContinue"

Write-Output "#### INITIATING ENTERPRISE SECURITY HARDENING ####"

# 1. Disable Unnecessary Services
Write-Output "[INFO] Disabling telemetry and print spooler..."
Set-Service -Name "DiagTrack" -StartupType Disabled
Set-Service -Name "Spooler" -StartupType Disabled

# 2. Configure Windows Firewall Profiles
Write-Output "[INFO] Fortifying Windows Firewall..."
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True -DefaultInboundAction Block -DefaultOutboundAction Allow

# 3. Registry Based Hardening
Write-Output "[INFO] Injecting CIS Registry Hardening..."
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
if (!(Test-Path $RegPath)) { New-Item -Path $RegPath -Force }
New-ItemProperty -Path $RegPath -Name "AllowTelemetry" -Value 0 -PropertyType DWord -Force

# 4. Disable LM/NTLMv1
Write-Output "[INFO] Disabling legacy authentication protocols..."
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "LmCompatibilityLevel" -Value 5

# 5. RDP Hardening for VDI
Write-Output "[INFO] Enforcing NLA for RDP sessions..."
Set-ItemProperty-Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 1

# 6. Microsoft Defender Optimization
Write-Output "[INFO] Running Defender quick scan and signature update..."
Update-MpSignature
Start-MpScan -ScanType QuickScan

Write-Output "#### SECURITY HARDENING COMPLETE ####"
