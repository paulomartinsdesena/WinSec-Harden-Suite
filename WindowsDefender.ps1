# Verifica se o Windows Defender está ativado
$defenderStatus = Get-Service -Name WinDefend

if ($defenderStatus.Status -eq 'Stopped') {
    # Ativa o Windows Defender
    Start-Service -Name WinDefend
    Write-Host "Windows Defender ativado."
} else {
    Write-Host "Windows Defender já está ativo."
}

# Configura o Windows Defender para realizar verificações automáticas
Set-MpPreference -DisableRealtimeMonitoring $false
Write-Host "Verificação em tempo real ativada."
