# Deletes temp files
Remove-Item  "C:\Users\*\Appdata\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:windir\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue