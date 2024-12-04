# Verifica se o script está sendo executado como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Red
    Write-Host "║ 🚫 Este script precisa ser executado como administrador. ║" -ForegroundColor Red
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Red
    exit
}
clear

# Habilitar o Firewall do Windows
function Enable-WindowsFirewall {
    try {
        # Habilita o firewall nos perfis de Domínio, Público e Privado
        Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
        
        Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║ 🔥 Firewall do Windows habilitado em todos os perfis.      ║" -ForegroundColor Green
        Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    } catch {
        Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Red
        Write-Host "║ ❌ Erro ao habilitar o Firewall do Windows.                 ║" -ForegroundColor Red
        Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Red
    }
}

# Chama a função para habilitar o Firewall
Enable-WindowsFirewall

