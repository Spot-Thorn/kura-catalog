# Kura elevates before launching this script, so a self-elevation block here would
# double-prompt for UAC and detach the output. Fail loudly instead.
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This action requires Administrator."
    exit 1
}

$wcmSvcPath = "HKLM:\SYSTEM\CurrentControlSet\Services\WcmSvc"
if (Test-Path $wcmSvcPath) {
    $deps = (Get-ItemProperty -Path $wcmSvcPath -Name "DependOnService" -ErrorAction SilentlyContinue).DependOnService
    $newDeps = $deps | Where-Object { $_ -ne 'WinHTTPAutoProxySvc' }
    Set-ItemProperty -Path $wcmSvcPath -Name "DependOnService" -Value $newDeps -ErrorAction SilentlyContinue
}

$winHttpPath = "HKLM:\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc"
if (Test-Path $winHttpPath) {
    Set-ItemProperty -Path $winHttpPath -Name "Start" -Value 3 -ErrorAction SilentlyContinue
}

sc.exe config WcmSvc depend= RpcSs/NSI | Out-Null

Write-Host "Operation completed successfully!" -ForegroundColor Green
Read-Host -Prompt "Press Enter to exit"