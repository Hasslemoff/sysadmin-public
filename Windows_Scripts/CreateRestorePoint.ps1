# Creates a restore point for Desktop OSs incase of a dodgy update.

$winos = Get-WmiObject Win32_OperatingSystem | Select-Object Caption;
if ($winos -like '*Server*') {
$Host.UI.WriteErrorLine('System restore point was not created. System restore points are not supported on Windows Server.');
} else {
    Checkpoint-Computer -Description ${Restore Point Name}
}