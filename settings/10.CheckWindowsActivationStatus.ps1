# Verifica o estado de ativação do Windows
function Get-WindowsActivationStatus {
    $wmipath = "SoftwareLicensingProduct"
    $query = "SELECT LicenseStatus FROM $wmipath WHERE LicenseStatus IS NOT NULL"

    try {
        # Obtem o status de ativação
        $activationStatus = Get-WmiObject -Query $query -ErrorAction Stop
        
        # Traduz o status de ativação para mensagens amigáveis
        switch ($activationStatus.LicenseStatus) {
            0 { $status = "❌ Unlicensed (Não está licenciado)" }
            1 { $status = "✅ Licensed (Licenciado e Ativado)" }
            2 { $status = "⏳ OOB Grace Period (Período de carência inicial)" }
            3 { $status = "⚠️ OOT Grace Period (Exige nova ativação)" }
            4 { $status = "❗ Non-Genuine Grace Period (Ativação não é genuína)" }
            5 { $status = "🔔 Notification (Ativação pendente)" }
            6 { $status = "🔄 Extended Grace Period (Período de carência estendido)" }
            default { $status = "❓ Unknown Status (Status desconhecido)" }
        }
        
        # Exibe o resultado com formato e cores personalizados
        Clear
        Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║          VERIFICAÇÃO DO ESTADO DE ATIVAÇÃO DO WINDOWS      ║" -ForegroundColor Green
        Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host "🔍 Status de ativação: $status" -ForegroundColor Yellow
        Write-Host "══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    } catch {
        # Trata erros e exibe mensagem amigável
        Clear
        Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Red
        Write-Host "║               ERRO AO VERIFICAR O STATUS                  ║" -ForegroundColor Red
        Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Red
        Write-Host "Detalhes do erro: $_" -ForegroundColor DarkRed
        Write-Host "══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    }
}

# Chama a função para verificar o status de ativação
Get-WindowsActivationStatus
