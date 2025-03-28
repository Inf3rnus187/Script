function Import-GitHubRegFile {
$URL = "https://raw.githubusercontent.com/Inf3rnus187/Script/refs/heads/main/pcoip_settings.reg"
$TempFilePath = "$env:TEMP\temp_import.reg"

    try {
        Write-Host "Téléchargement du fichier .reg depuis GitHub..." -ForegroundColor Cyan
        Invoke-WebRequest -Uri $GitHubRawUrl -OutFile $TempFilePath -ErrorAction Stop

        Write-Host "Importation du fichier dans le registre..." -ForegroundColor Cyan
        reg import $TempFilePath

        Write-Host "✅ Fichier importé avec succès depuis : $GitHubRawUrl" -ForegroundColor Green
    } catch {
        Write-Error "❌ Une erreur est survenue : $_"
    } finally {
        if (Test-Path $TempFilePath) {
            Remove-Item $TempFilePath -Force
            Write-Host "🧹 Fichier temporaire supprimé." -ForegroundColor Yellow
        }
    }
}


Write-Host "Installing PCoIP Graphic Agent" -ForegroundColor Green
Invoke-WebRequest -Uri "https://github.com/Inf3rnus187/Script/raw/refs/heads/main/pcoip-agent-graphics_latest.exe" -OutFile "$env:TEMP\pcoip.exe"
$process = Start-Process -FilePath "$env:TEMP\pcoip.exe" -ArgumentList "/S /NoPostReboot _?$env:TEMP\pcoip.exe" -Wait -PassThru; $process.ExitCode
Write-Host "Done" -ForegroundColor Green

Write-Host "Licensing PCoIP Graphic Agent" -ForegroundColor Green
cd "C:\Program Files\Teradici\PCoIP Agent\"
$paramValue = $args[0]
$command =  ".\pcoip-register-host.ps1 -RegistrationCode '$paramValue'"
Invoke-Expression  $command
Start-Service -Name 'PCoIPAgent'
Write-Host "Done" -ForegroundColor Green
Import-GitHubRegFile
