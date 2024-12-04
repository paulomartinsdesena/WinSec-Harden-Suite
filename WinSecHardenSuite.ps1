# Script: MainMenu.ps1
# Permite escolher qual script executar a partir da lista com estilo personalizado

function Show-Menu {
    Clear-Host
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                   WinSec Harden Suite v1.0                 ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host "              Developed by Paulo Sena (S3N4)" -ForegroundColor Yellow
    Write-Host "============================================================" -ForegroundColor Red
    Write-Host "[01] 🔄 Atualização e Patching"                              -ForegroundColor Green
    Write-Host "[02] 👥 Configuração de Contas e Privilégios"              -ForegroundColor Green
    Write-Host "[03] 🔥 Configuração de Firewall e Filtro de Tráfego"      -ForegroundColor Green
    Write-Host "[04] 🛠️ Remoção de Serviços Desnecessários"              -ForegroundColor Green
    Write-Host "[05] 🛡️ Configuração de Antivirus e Antimalware"          -ForegroundColor Green
    Write-Host "[06] 🕵️ Auditoria e Monitoramento"                       -ForegroundColor Green
    Write-Host "[07] 🔒 Configuração de Criptografia"                     -ForegroundColor Green
    Write-Host "[08] ❌ Eliminação de Protocolos ou Aplicações Inseguras" -ForegroundColor Green
    Write-Host "[09] 🖥️ Ativação do Windows"                             -ForegroundColor Green
    Write-Host "[10] 📄 Verificar Status de Ativação do Windows"          -ForegroundColor Green
    Write-Host "[11] ❌ Desinstalador de programas do Windows"          -ForegroundColor Green
    Write-Host "[00] 🚪 Sair"                                             -ForegroundColor Yellow
    Write-Host "============================================================" -ForegroundColor Red
}

function Execute-Script {
    param (
        [int]$option
    )
    clear
    switch ($option) {
        1 { Write-Host "🔄 Executando Atualização e Patching..." -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\01.UpdatePatching.ps1" -NoNewWindow -Wait  }
        2 { Write-Host "👥 Executando Configuração de Contas e Privilégios..." -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\02.Configuring Accounts And Privileges.ps1" }
        3 { Write-Host "🔥 Configurando Firewall e Filtro de Tráfego..." -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\03.Firewall And Traffic Filtering.ps1" }
        4 { Write-Host "🛠️  Removendo Serviços Desnecessários..." -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\04.RemovingUnnecessaryServices.ps1" -NoNewWindow -Wait }
        5 { Write-Host "🛡️  Configurando Antivirus e Antimalware..." -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\05.Antivirus and Antimalware.ps1" }
        6 { Write-Host "🕵️  Iniciando Auditoria e Monitoramento..." -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\06.Auditing and Monitoring.ps1" }
        7 { Write-Host "🔒 Configurando Criptografia..." -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\07.Cryptography.ps1" }
        8 { Write-Host "❌ Eliminando Protocolos ou Aplicações Inseguras..." -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\08.Elimination of insecure protocols or applications.ps1" }
        9 { Write-Host "🖥️  Iniciando Ativação do Windows..." -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\09.WindowsActivation.ps1" -NoNewWindow -Wait }
        10 { Write-Host "📄 Verificando Status de Ativação do Windows..." -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\10.CheckWindowsActivationStatus.ps1" -NoNewWindow -Wait }
        11 { Write-Host "❌ Desinstalador de programas do Windows" -ForegroundColor Yellow; Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\settings\11.ProgramUninstaller.ps1" -NoNewWindow -Wait }
        0 { Write-Host "🚪 Saindo do script... Até logo!" -ForegroundColor Green; exit }
        default { Write-Host "⚠️  Opção inválida. Tente novamente." -ForegroundColor Red }
    }
}

# Loop do menu principal
do {
    Show-Menu
    $userInput = Read-Host "Selecione uma opção (ex.: 01, 02, 00)"
    Execute-Script -option $userInput
    Pause
} while ($userInput -ne 0)
