# Verifica se o script está sendo executado como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "╔════════════════════════════════════════════════════════════╗" 
    Write-Host "║ 🚫 Este script precisa ser executado como administrador. ║" -ForegroundColor Red
    Write-Host "╚════════════════════════════════════════════════════════════╝"
    exit
}

# Desativar serviços desnecessários
$servicesToDisable = @(
    "ftpsvc",           # FTP Service
    "telnet"            # Telnet
   
)

Write-Host "╔════════════════════════════════════════════════════════════╗" 
Write-Host "║                 Desativando Serviços Necessários          ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════╝"

foreach ($service in $servicesToDisable) {
    try {
        $serviceStatus = Get-Service -Name $service -ErrorAction SilentlyContinue
        if ($serviceStatus) {
            Write-Host "╔════════════════════════════════════════════════════════════╗" 
            Write-Host "║ Desativando o serviço: $service..." -ForegroundColor Yellow
            Write-Host "╚════════════════════════════════════════════════════════════╝"
            
            Stop-Service -Name $service -Force
            Set-Service -Name $service -StartupType Disabled

            Write-Host "╔════════════════════════════════════════════════════════════╗"
            Write-Host "║ Serviço $service desativado com sucesso!" -ForegroundColor Green
            Write-Host "╚════════════════════════════════════════════════════════════╝"
        } else {
            Write-Host "╔════════════════════════════════════════════════════════════╗"
            Write-Host "║ Serviço $service não encontrado ou já desativado." -ForegroundColor Red
            Write-Host "╚════════════════════════════════════════════════════════════╝"
        }
    } catch {
        Write-Host "╔════════════════════════════════════════════════════════════╗"
        Write-Host "║ Erro ao desativar o serviço: $service" -ForegroundColor Red
        Write-Host "╚════════════════════════════════════════════════════════════╝"
    }
}

# Remover Bloatware (Skype, OneDrive, Office)
$bloatwareList = @(
    
    "Microsoft.3DBuilder",            # 3D Builder
    "Microsoft.CandyCrushSaga",       # Candy Crush Saga
    "Microsoft.Facebook",             # Facebook
    "Microsoft.GetHelp",              # Get Help
    "Microsoft.GetSkypeApp",          # Get Skype
    "Microsoft.MicrosoftSolitaireCollection", # Microsoft Solitaire Collection
    "Microsoft.XboxApp",              # Xbox
    "Microsoft.Weather",              # Weather
    "Microsoft.News",                 # News
    "Microsoft.Netflix",              # Netflix
    "Microsoft.Photos",               # Photos
    "Microsoft.Mail",                 # Mail and Calendar
    "Microsoft.Messaging"             # Messaging (Skype)
)

Write-Host "╔════════════════════════════════════════════════════════════╗"
Write-Host "║                 Removendo Bloatware..." -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════╝"

foreach ($bloatware in $bloatwareList) {
    try {
        $app = Get-AppxPackage -Name $bloatware
        if ($app) {
            Write-Host "╔════════════════════════════════════════════════════════════╗"
            Write-Host "║ Removendo: $bloatware..." -ForegroundColor Yellow
            Write-Host "╚════════════════════════════════════════════════════════════╝"
            
            Remove-AppxPackage -Package $app.PackageFullName
            
            Write-Host "╔════════════════════════════════════════════════════════════╗"
            Write-Host "║ $bloatware removido com sucesso!" -ForegroundColor Green
            Write-Host "╚════════════════════════════════════════════════════════════╝"
        } else {
            Write-Host "╔════════════════════════════════════════════════════════════╗"
            Write-Host "║ $bloatware não encontrado ou já removido." -ForegroundColor Red
            Write-Host "╚════════════════════════════════════════════════════════════╝"
        }
    } catch {
        Write-Host "╔════════════════════════════════════════════════════════════╗"
        Write-Host "║ Erro ao remover o $bloatware" -ForegroundColor Red
        Write-Host "╚════════════════════════════════════════════════════════════╝"
    }
}

# Limpeza pós-remoção de bloatware
Write-Host "╔════════════════════════════════════════════════════════════╗"
Write-Host "║                   Iniciando a limpeza pós-remoção...        ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════╝"

# Limpar arquivos temporários do sistema
Write-Host "╔════════════════════════════════════════════════════════════╗"
Write-Host "║ Limpando arquivos temporários..." -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════╝"
Remove-Item -Path "$env:temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# Limpar cache do Windows
Write-Host "╔════════════════════════════════════════════════════════════╗"
Write-Host "║ Limpando cache do sistema..." -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════╝"
Remove-Item -Path "C:\Windows\System32\DriverStore\FileRepository\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# Limpar histórico de arquivos recentes
Write-Host "╔════════════════════════════════════════════════════════════╗"
Write-Host "║ Limpando histórico de arquivos recentes..." -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════╝"
Clear-Content -Path "$env:APPDATA\Microsoft\Windows\Recent\*" -Force

# Limpeza de arquivos de log
Write-Host "╔════════════════════════════════════════════════════════════╗"
Write-Host "║ Limpando arquivos de log do sistema..." -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════╝"
Remove-Item -Path "C:\Windows\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue

# Finalizando a limpeza
Write-Host "╔════════════════════════════════════════════════════════════╗"
Write-Host "║ Limpeza pós-remoção concluída com sucesso!" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════╝"
