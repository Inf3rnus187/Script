Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private
$adapter = Get-NetAdapter | ? { $_.Name -like "tap*" }
$adapter | Disable-NetAdapterBinding -ComponentID ms_tcpip6
$adapter | Set-DnsClient -UseSuffixWhenRegistering $True
Register-DnsClient
