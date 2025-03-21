$NewUser = 'User1'
$FullName = ''
$Description = ''
$RandomString = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 10 | ForEach-Object {[char]$_})
$password = ConvertTo-SecureString "$RandomString" -AsPlainText -Force 


Write-Host "Create $NewUser with password $RandomString and prevent password change and account expire" -ForegroundColor Green
New-LocalUser $NewUser -Password $password -FullName $FullName -Description $Description -AccountNeverExpires -UserMayNotChangePassword 
Add-LocalGroupMember -Group "Administrateurs" -Member $NewUser
Set-LocalUser -Name $NewUser -PasswordNeverExpires 1
Write-Host "Done" -ForegroundColor Green

Write-Host "Test $NewUser Credentials" -ForegroundColor Green
Add-Type -AssemblyName System.DirectoryServices.AccountManagement 
$type = [DirectoryServices.AccountManagement.ContextType]::Machine
$PrincipalContext = [DirectoryServices.AccountManagement.PrincipalContext]::new($type)
$PrincipalContext.ValidateCredentials($NewUser,$RandomString)
if ($Result -ne "True")
{
Write-Host "Logins are corrects" -ForegroundColor Yellow
}
Write-Host "Done" -ForegroundColor Green

Write-Host "Save All infos on users-info.txt in your Desktop " -ForegroundColor Green
$myIP = (Invoke-WebRequest -UseBasicParsing -uri "https://api.ipify.org/").Content
$LocalIP = (Get-NetIPConfiguration -InterfaceAlias "tap*").IPv4Address.IPAddress
$myIP | Out-file users-info.txt -NoClobber
$LocalIP | Out-file users-info.txt -Append
hostname | Out-file users-info.txt -Append
$NewUser | Out-file users-info.txt -Append
$RandomString | Out-file users-info.txt -Append
Write-Host "Done" -ForegroundColor Green
