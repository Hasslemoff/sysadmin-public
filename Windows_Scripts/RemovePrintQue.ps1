# Death to Printers.
Stop-Service spooler
Remove-Item -Path $env:windir\system32\spool\PRINTERS\*.*
Start-Service Spooler -ErrorAction Ignore
If ((Get-Service spooler).status -eq 'Stopped')
{Write-Output 'Error. Spooler could not be started or stopped. Check Service'}