# Verificação de permissões administrativas
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Este script precisa ser executado como administrador." -ForegroundColor Red
    exit
}

# Passo 1: Inserir a chave de produto
Write-Host "Inserindo a chave de produto..." -ForegroundColor Cyan
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX

# Passo 2: Configurar o servidor KMS
Write-Host "Configurando o servidor KMS..." -ForegroundColor Cyan
slmgr /skms kms10.tiremoto.com.br

# Passo 3: Ativar o Windows
Write-Host "Ativando o Windows..." -ForegroundColor Cyan
slmgr /ato

# Mensagem de sucesso
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host "Ativação concluída! Verifique o status de ativação do Windows." -ForegroundColor Green
Write-Host " ========================================================================" -ForegroundColor Cyan
