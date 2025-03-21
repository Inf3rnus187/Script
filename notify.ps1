$MailMessage = @{
To = $args[0]
#Bcc = "", ""
From = "Install Script <manuel@progiss.com>"
Subject = "$($env:COMPUTERNAME) - Ready"
Body = "<h1>File list!</h1> <p><strong>Generated:</strong> $(Get-Date -Format g)</p>”
Smtpserver = "ex.mail.ovh.net"
Port = 587
UseSsl = $true
BodyAsHtml = $true
Encoding = “UTF8”
Attachment = "C:\Windows\System32\users-info.txt"
}
$list = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object -Property Publisher | Format-Table -AutoSize 
$list | Out-File -FilePath  "$($ENV:Temp)\installed.txt"
$text = Get-Content "$($ENV:Temp)\installed.txt"
$User = $args[1]
$Pass = $args[2]
$Passs= ConvertTo-SecureString -String $Pass -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $passs
Send-MailMessage @MailMessage -Credential $Credential
