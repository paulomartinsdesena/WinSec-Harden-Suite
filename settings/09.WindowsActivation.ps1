# Verifica se está sendo executado como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "🚫 Este script precisa ser executado como administrador." -ForegroundColor Red
    exit
}

# Início do Script
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║       SCRIPT DE ATIVAÇÃO DO WINDOWS       ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Host ""
Write-Host "Iniciando o processo de ativação..." -ForegroundColor Yellow

# Etapa 1: Inserir Chave
Write-Host "🔹 Inserindo chave de produto..." -ForegroundColor Cyan
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
Write-Host "✅ Chave de produto inserida com sucesso!" -ForegroundColor Green

# Etapa 2: Configurar Servidor KMS
Write-Host "🔹 Configurando servidor KMS..." -ForegroundColor Cyan
slmgr /skms kms10.tiremoto.com.br
Write-Host "✅ Servidor KMS configurado com sucesso!" -ForegroundColor Green

# Etapa 3: Ativar Windows
Write-Host "🔹 Ativando o Windows..." -ForegroundColor Cyan
slmgr /ato
Write-Host "✅ Windows ativado com sucesso!" -ForegroundColor Green

# Mensagem Final
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║       PROCESSO CONCLUÍDO COM SUCESSO       ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Cyan
