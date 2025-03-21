Write-Host "Installing PCoIP Graphic Agent" -ForegroundColor Green
$process = Start-Process -FilePath "$env:TEMP\pcoip.exe" -ArgumentList "/S /NoPostReboot _?$env:TEMP\pcoip.exe" -Wait -PassThru; $process.ExitCode
Write-Host "Done" -ForegroundColor Green

Write-Host "Licensing PCoIP Graphic Agent" -ForegroundColor Green
cd "C:\Program Files\Teradici\PCoIP Agent\"
$paramValue = $args[0]
$command =  ".\pcoip-register-host.ps1 -RegistrationCode '$paramValue'"
Invoke-Expression  $command
Start-Service -Name 'PCoIPAgent'
Write-Host "Done" -ForegroundColor Green
