#Disable USB Storage
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR\" -Name "start" -Value 4
Get-PnpDevice| Where-Object {$_.friendlyname -match "USB Mass Storage Device" -and $_.status -match "OK" } | Disable-PnpDevice