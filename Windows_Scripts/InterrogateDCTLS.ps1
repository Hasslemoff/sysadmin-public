$server = "DC.domain.com" $port = 636
$tcpClient = New-Object System.Net.Sockets.TcpClient($server, $port) $sslStream = New-Object System.Net.Security.SslStream($tcpClient.GetStream(), $false, ({ $true }))
$sslStream.AuthenticateAsClient($server)
$sslStream