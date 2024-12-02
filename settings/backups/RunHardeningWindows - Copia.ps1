# Script: MainMenu.ps1
# Permite escolher qual script executar a partir da lista

function Show-Menu {
    Clear-Host
    Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║            HARDENING DO WINDOWS      v1.0  ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host "       Developed by Paulo Sena (S3N4)"          -ForegroundColor Cyan
    Write-Host "[01] Update Patching"                      -ForegroundColor green
    Write-Host "[02] Configuring Accounts and Privileges"  -ForegroundColor green
    Write-Host "[03] Firewall and Traffic Filtering"       -ForegroundColor green
    Write-Host "[04] Removing Unnecessary Services"        -ForegroundColor green
    Write-Host "[05] Antivirus and Antimalware"            -ForegroundColor green
    Write-Host "[06] Auditing and Monitoring"              -ForegroundColor green
    Write-Host "[07] Cryptography"                         -ForegroundColor green
    Write-Host "[08] Elimination of Insecure Protocols or Applications" -ForegroundColor green
    Write-Host "[09] Windows Activation"                   -ForegroundColor green
    Write-Host "[10] Check Windows Activation Status"      -ForegroundColor green
    Write-Host "[0] Sair"                                  -ForegroundColor green
    Write-Host "=====================================================" -ForegroundColor Red #Cyan
}

function Execute-Script {
    param (
        [int]$option
    )
    clear
    switch ($option) {
        1 { Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\01.UpdatePatching.ps1" -NoNewWindow -Wait  }
        2 { Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\02.Configuring Accounts And Privileges.ps1" }
        3 { Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\03.Firewall And Traffic Filtering.ps1" }
        4 { Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\04.Removing Unnecessary Services.ps1" }
        5 { Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\05.Antivirus and Antimalware.ps1" }
        6 { Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\06.Auditing and Monitoring.ps1" }
        7 { Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\07.Cryptography.ps1" }
        8 { Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\08.Elimination of insecure protocols or applications.ps1" }
        9 { Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\09.WindowsActivation.ps1" -NoNewWindow -Wait   }
        10 { Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\10.CheckWindowsActivationStatus.ps1" -NoNewWindow -Wait   }
        0 { Write-Host "Saindo do script..." -ForegroundColor Yellow; exit }
        default { Write-Host "Opção inválida. Tente novamente." -ForegroundColor Red }
    }
}

# Loop para o menu principal
do {
    Show-Menu
    $userInput = Read-Host "Selecione uma opção"
    Execute-Script -option $userInput
    Pause
} while ($userInput -ne 0)
