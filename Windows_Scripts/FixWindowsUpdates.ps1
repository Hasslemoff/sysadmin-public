# Run this script if you start getting unknown Windows Update Agent errors while trying to deploy Windows updates. The script stops WUA and related services, renames WUA data folders, and then restarts the services

$SystemDirectory = [Environment]::SystemDirectory

Stop-Service -Name wuauserv -Force -Verbose -ErrorAction SilentlyContinue
Stop-Service -Name CryptSvc -Force -Verbose -ErrorAction SilentlyContinue
Stop-Service -Name BITS -Force -Verbose -ErrorAction SilentlyContinue
Stop-Service -Name msiserver -Force -Verbose -ErrorAction SilentlyContinue

$SoftwareDistRenamed = $Catroot2Renamed = $false;

if (Test-Path -Path "$env:WINDIR\SoftwareDistribution") {
    Remove-Item "$env:WINDIR\SoftwareDistribution.old" -Recurse -Force -ErrorAction SilentlyContinue 
}
Try {
    Rename-Item -Path "$env:WINDIR\SoftwareDistribution" -NewName "SoftwareDistribution.old" -Verbose -Force -ErrorAction Stop
    $SoftwareDistRenamed = $true
} Catch {
    $Host.UI.WriteWarningLine("$($_.Exception.Message)")
    $Host.UI.WriteErrorLine("$($_.Exception.Message)")
}

if ($SoftwareDistRenamed) {
    if (Test-Path -Path "$SystemDirectory\catroot2") {
        Remove-Item "$SystemDirectory\catroot2.old" -Recurse -Force -ErrorAction SilentlyContinue
    }
    Try {
        Rename-Item -Path "$SystemDirectory\catroot2" -NewName "catroot2.old" -Verbose -Force -ErrorAction Stop
        $Catroot2Renamed = $true;
    } Catch {
        $Host.UI.WriteWarningLine("$($_.Exception.Message)")
        $Host.UI.WriteErrorLine("$($_.Exception.Message)")
    }
}

Start-Service -Name wuauserv -Verbose -ErrorAction SilentlyContinue
Start-Service -Name CryptSvc -Verbose -ErrorAction SilentlyContinue
Start-Service -Name BITS -Verbose -ErrorAction SilentlyContinue
Start-Service -Name msiserver -Verbose -ErrorAction SilentlyContinue

if ($SoftwareDistRenamed -and $Catroot2Renamed) {
   $Host.UI.WriteLine("Restart your computer and try to install Windows Update.")
} else {
   $Host.UI.WriteErrorLine("Please try running this script later.")
}