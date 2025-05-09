# Forces time sync.
If ((Get-Service w32time).status -ne 'Running')
{
       net start w32time
}

W32tm /resync /force