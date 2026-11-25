<#
.SYNOPSIS
    First-Level IT Support & Network Diagnostic Toolkit
.DESCRIPTION
    Automates workstation health checks, Print Spooler verification, Windows Defender status,
    and 4-step TCP/IP & DNS connectivity diagnostics for IT helpdesk troubleshooting.
#>

$ReportDir = Join-Path $PSScriptRoot "..\lab-reports"
if (-not (Test-Path $ReportDir)) {
    New-Item -ItemType Directory -Path $ReportDir | Out-Null
}
$Timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ReportFile = Join-Path $ReportDir "Diagnostic_Report_$Timestamp.txt"

function Get-WorkstationHealth {
    Write-Host "`n[+] Running Workstation & Endpoint Security Audit..." -ForegroundColor Cyan
    $OS = Get-CimInstance Win32_OperatingSystem
    $CS = Get-CimInstance Win32_ComputerSystem
    $Disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
    $Spooler = Get-Service -Name "Spooler" -ErrorAction SilentlyContinue
    $Defender = Get-MpComputerStatus -ErrorAction SilentlyContinue

    $FreeRAM_GB = [math]::Round($OS.FreePhysicalMemory / 1MB, 2)
    $TotalRAM_GB = [math]::Round($CS.TotalPhysicalMemory / 1GB, 2)
    $FreeDisk_GB = [math]::Round($Disk.FreeSpace / 1GB, 2)
    $TotalDisk_GB = [math]::Round($Disk.Size / 1GB, 2)

    $AVStatus = if ($Defender) {
        "Real-Time Protection: $($Defender.RealTimeProtectionEnabled) | Signatures Updated: $($Defender.AntivirusSignatureLastUpdated)"
    } else {
        "Windows Defender status unavailable (Third-party AV or restricted permissions)"
    }

    $Output = @"
============================================================
WORKSTATION & ENDPOINT SECURITY HEALTH REPORT
Generated: $(Get-Date)
============================================================
Hostname         : $env:COMPUTERNAME
Logged-In User   : $env:USERNAME
OS Version       : $($OS.Caption) (Build $($OS.BuildNumber))
Last Boot Time   : $($OS.LastBootUpTime)
Memory (Free/Tot): $FreeRAM_GB GB / $TotalRAM_GB GB
C: Drive Free    : $FreeDisk_GB GB / $TotalDisk_GB GB
Print Spooler    : $($Spooler.Status) (Startup: $($Spooler.StartType))
Endpoint AV      : $AVStatus
============================================================
"@
    Write-Host $Output
    Add-Content -Path $ReportFile -Value $Output
}

function Test-NetworkStack {
    Write-Host "`n[+] Running 4-Layer Network & DNS Diagnostics..." -ForegroundColor Cyan
    $NetConfig = Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null } | Select-Object -First 1
    $LocalIP = $NetConfig.IPv4Address.IPAddress
    $Gateway = $NetConfig.IPv4DefaultGateway.NextHop
    $DNSServers = ($NetConfig.DNSServer.ServerAddresses) -join ", "

    $LoopbackTest = Test-Connection -ComputerName 127.0.0.1 -Count 1 -Quiet
    $GatewayTest  = if ($Gateway) { Test-Connection -ComputerName $Gateway -Count 1 -Quiet } else { $false }
    $InternetTest = Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet
    $DNSTest      = try { [bool](Resolve-DnsName -Name "sampathwealth.com" -ErrorAction Stop) } catch { $false }

    $NetOutput = @"
============================================================
NETWORK & DNS CONNECTIVITY DIAGNOSTICS
============================================================
Active Interface : $($NetConfig.InterfaceAlias)
IPv4 Address     : $LocalIP
Default Gateway  : $Gateway
DNS Server(s)    : $DNSServers
------------------------------------------------------------
1. Adapter Loopback (127.0.0.1)   : $(if($LoopbackTest){'PASS'}else{'FAIL'})
2. Local Gateway ($Gateway)       : $(if($GatewayTest){'PASS'}else{'FAIL'})
3. External IPv4 (8.8.8.8)        : $(if($InternetTest){'PASS'}else{'FAIL'})
4. DNS Resolution (External Web)  : $(if($DNSTest){'PASS'}else{'FAIL'})
============================================================
"@
    Write-Host $NetOutput
    Add-Content -Path $ReportFile -Value $NetOutput
}

function Show-Menu {
    Clear-Host
    Write-Host "===============================================" -ForegroundColor Yellow
    Write-Host "   ENTERPRISE IT SUPPORT DIAGNOSTIC TOOLKIT    " -ForegroundColor Yellow
    Write-Host "===============================================" -ForegroundColor Yellow
    Write-Host "1. Run Workstation, Printer & Antivirus Audit"
    Write-Host "2. Run 4-Layer Network & DNS Connectivity Test"
    Write-Host "3. Run Full Diagnostic Suite & Export Report"
    Write-Host "4. Exit"
    $Choice = Read-Host "`nSelect an option (1-4)"

    switch ($Choice) {
        "1" { Get-WorkstationHealth; Write-Host "Saved to $ReportFile" -ForegroundColor Green }
        "2" { Test-NetworkStack; Write-Host "Saved to $ReportFile" -ForegroundColor Green }
        "3" { Get-WorkstationHealth; Test-NetworkStack; Write-Host "Full report saved to $ReportFile" -ForegroundColor Green }
        "4" { return }
        default { Write-Host "Invalid selection." -ForegroundColor Red }
    }
}

Show-Menu
