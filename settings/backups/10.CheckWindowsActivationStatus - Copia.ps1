# Verifica o estado de ativação do Windows

function Get-WindowsActivationStatus {
    $wmipath = "SoftwareLicensingProduct"
    $query = "SELECT LicenseStatus FROM $wmipath WHERE LicenseStatus IS NOT NULL"
    
    try {
        $activationStatus = Get-WmiObject -Query $query -ErrorAction Stop
        
        switch ($activationStatus.LicenseStatus) {
            0 { $status = "Unlicensed (Não está licenciado)" }
            1 { $status = "Licensed (Licenciado e Ativado)" }
            2 { $status = "OOB Grace Period (Período de carência inicial)" }
            3 { $status = "OOT Grace Period (Exige uma nova Ativação)" }
            4 { $status = "Non-Genuine Grace Period (Ativação não é genuína)" }
            5 { $status = "Notification" }
            6 { $status = "Extended Grace Period (Período de carência estendido)" }
            default { $status = "Unknown Status" }
        }
        
        clear
        Write-Host " ========================================================================" -ForegroundColor Cyan
        Write-Output "Windows Activation Status: $status"  
        Write-Host " ========================================================================" -ForegroundColor Cyan
    } catch {
        Write-Host " ========================================================================" -ForegroundColor Cyan
        Write-Output "Erro ao verificar o status de ativação: $status" 
        Write-Host " ========================================================================" -ForegroundColor Cyan
    }
}

Get-WindowsActivationStatus



#Unlicensed: O Windows não está licenciado. Isso pode ocorrer se a chave do produto nunca foi inserida ou a ativação falhou.

#Licensed: O Windows está devidamente licenciado e ativado. Não há problemas de ativação e o sistema está funcionando normalmente.

#OOB Grace Period (Out of Box Grace Period): Período de carência inicial que o Windows fornece após a instalação. Durante esse período, o usuário tem um tempo limitado para ativar o Windows antes que algumas funcionalidades sejam desabilitadas.

#OOT Grace Period (Out of Tolerance Grace Period): Este período ocorre quando há uma mudança significativa de hardware que exige uma nova ativação. O Windows permite um período de carência para reativação após tais mudanças.

#Non-Genuine Grace Period: O Windows detectou que a ativação não é genuína (pirata) e fornece um período de carência durante o qual o usuário pode resolver o problema de ativação. Durante esse tempo, o sistema ainda pode funcionar com algumas limitações.

#Notification: O Windows não está ativado e exibe notificações ao usuário para lembrá-lo de ativar o sistema. Isso pode incluir mensagens na área de trabalho e outras notificações periódicas.

#Extended Grace Period: Período de carência estendido, que pode ser fornecido em algumas circunstâncias especiais, permitindo que o usuário tenha mais tempo para ativar o Windows.

#Unknown Status: O status de ativação não pôde ser determinado. Isso pode ser devido a um erro na consulta do WMI ou a uma configuração incomum do sistema.
