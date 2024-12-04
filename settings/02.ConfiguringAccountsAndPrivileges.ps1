# Verifica se o script está sendo executado como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "🚫 Este script precisa ser executado como administrador." -ForegroundColor Red
    exit
    }
    clear 
# Função para desabilitar contas padrão
function Disable-AccountIfExists {
    param (
        [string]$accountName
    )
    try {
        $userAccount = Get-LocalUser -Name $accountName -ErrorAction SilentlyContinue
        if ($userAccount) {
            # Desabilita a conta se ela existir
            Disable-LocalUser -Name $accountName
            Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
            Write-Host "║ ✔️ Conta '$accountName' desabilitada com sucesso.        ║" -ForegroundColor Green
            Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
        } else {
            # Caso a conta não exista
            Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
            Write-Host "║ ❌ A conta '$accountName' não foi encontrada.              ║" -ForegroundColor Yellow
            Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
        }
    } catch {
        # Caso ocorra um erro durante o processo
        Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║ ❌ Erro ao desabilitar a conta '$accountName': $_          ║" -ForegroundColor Red
        Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    }
}

# Verifica as contas "Administrator" e "Guest" em inglês e português
$adminAccounts = @("Administrator", "Administrador")
$guestAccounts = @("Guest", "Convidado")

# Desabilita as contas "Administrator"/"Administrador"
foreach ($adminAccount in $adminAccounts) {
    Disable-AccountIfExists -accountName $adminAccount
}

# Desabilita as contas "Guest"/"Convidado"
foreach ($guestAccount in $guestAccounts) {
    Disable-AccountIfExists -accountName $guestAccount
}

# Configurar a política de execução para 'RemoteSigned', permitindo apenas scripts assinados ou scripts locais
Set-ExecutionPolicy RemoteSigned -Force
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║ 🛡️ Política de execução configurada para RemoteSigned.      ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# Habilitar o Controle de Conta de Usuário (UAC)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 1
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║ 🛡️ Controle de Conta de Usuário (UAC) habilitado.           ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
