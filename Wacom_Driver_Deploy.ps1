#Invoke-WebRequest -Uri "https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/download/4.0.6/PSAppDeployToolkit_v4.0.6.zip" -OutFile "$env:TEMP\psadt.zip"

#Unblock-File -Path "$env:TEMP\psadt.zip"

#Expand-Archive -Path "$env:TEMP\psadt.zip" -DestinationPath "$env:TEMP\PADT" -Force

#Copy-Item -Path "$env:TEMP\PADT\Toolkit\AppDeployToolkit" -Destination "$env:TEMP\WacomTablet\AppDeployToolkit" -Recurse -Force
#Copy-Item -Path "$env:TEMP\PADT\Toolkit\Files" -Destination "$env:TEMP\WacomTablet\Files" -Force


#Invoke-WebRequest -Uri "https://cdn.wacom.com/u/productsupport/drivers/win/professional/WacomTablet_6.4.9-2.exe" -OutFile "$env:TEMP\WacomTablet\Files\"
#Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Inf3rnus187/Script/refs/heads/main/Wacom_Tablet_Driver_Install_and_Uninstall.ps1" -OutFile "$env:TEMP\WacomTablet\Files\Deploy-WacomTablet.ps1"
#Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File $env:TEMP\WacomTablet\Files\Deploy-WacomTablet.ps1 -DeploymentType Install -DeployMode Interactive" -Wait
cls

Remove-Item  -LiteralPath 'C:\Temp' -Force -Recurse
Install-Module -Name PSAppDeployToolkit -Scope CurrentUser
Import-Module PSAppDeployToolkit
New-ADTTemplate -Destination 'C:\Temp' -Name 'WacomTablet' -Show
Remove-Item -Path "C:\Temp\WacomTablet\Invoke-AppDeployToolkit.ps1" -Force

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Inf3rnus187/Script/refs/heads/main/Wacom_Tablet_Driver_Install_and_Uninstall.ps1" -OutFile "C:\Temp\WacomTablet\Invoke-AppDeployToolkit.ps1"
Invoke-WebRequest -Uri "https://cdn.wacom.com/u/productsupport/drivers/win/professional/WacomTablet_6.4.9-2.exe" -OutFile "C:\Temp\WacomTablet\Files\WacomTablet_6.4.9-2.exe"
Powershell.exe -ExecutionPolicy Bypass "C:\Temp\WacomTablet\Invoke-AppDeployToolkit.ps1" -DeploymentType "Install" -DeployMode "NonInteractive"
