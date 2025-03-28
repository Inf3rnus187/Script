Download the Powershell App Deployment Toolkit 3.8.4:
Invoke-WebRequest -Uri "https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/download/3.8.4/PSAppDeployToolkit_v3.8.4.zip" -OutFile "$env:TEMP\psadt.zip"

Download the zip file to a folder created at (C:\Downloads)
Open Windows PowerShell by Right-Clicking on Windows PowerShell and selecting Run as Administrator
Enter the following command to remove the Zone.Identifier:
Unblock-File -Path "$env:TEMP\psadt.zip"
Enter the following command to extract the contents of the zip file:
Expand-Archive -Path "$env:TEMP\psadt.zip" -DestinationPath "$env:TEMP\PADT"
Enter the following commands to copy the AppDeployToolkit & Files folders to “C:\Downloads\WacomTablet”:
Copy-Item -Path "$env:TEMP\PADT\Toolkit\AppDeployToolkit" -Destination "$env:TEMP\WacomTablet\AppDeployToolkit" -Recurse
Copy-Item -Path "$env:TEMP\PADT\Toolkit\Files" -Destination "$env:TEMP\WacomTablet\Files"
You should now see the AppDeploymentToolkit folder with files & the empty Files folder at “C:\Downloads\WacomTablet”

Invoke-WebRequest -Uri "https://cdn.wacom.com/u/productsupport/drivers/win/professional/WacomTablet_6.4.9-2.exe" -OutFile "$env:TEMP\WacomTablet\Files\"
Invoke-WebRequest -Uri "" -OutFile "$env:TEMP\WacomTablet\Files\Deploy-WacomTablet.ps1"
