Write-Host "Activate Windows" -ForegroundColor Green
slmgr //b /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr //b /skms kms.digiboy.ir
slmgr //b /ato
slmgr //b /ckms
Write-Host "Done" -ForegroundColor Green
