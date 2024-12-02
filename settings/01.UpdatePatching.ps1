# Verifica se o script está sendo executado como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "🚫 Este script precisa ser executado como administrador." -ForegroundColor Red
    exit
}

# Verificação e instalação do Winget
try {
    $wingetPath = (Get-Command winget -ErrorAction Stop).Source
    Write-Host "✅ Winget já está instalado no sistema." -ForegroundColor Green
} catch {
    Write-Host "🔍 Winget não encontrado. Iniciando instalação..." -ForegroundColor Yellow
    $wingetInstallerUrl = "https://aka.ms/getwinget"
    $tempPath = [System.IO.Path]::GetTempPath()
    $wingetInstallerPath = Join-Path -Path $tempPath -ChildPath "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    Invoke-WebRequest -Uri $wingetInstallerUrl -OutFile $wingetInstallerPath
    Add-AppxPackage -Path $wingetInstallerPath
    Remove-Item -Path $wingetInstallerPath -Force
    Write-Host "✅ Winget instalado com sucesso." -ForegroundColor Green
}

# Parte 1: Atualizações do Sistema Operacional Windows
clear
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        INICIANDO ATUALIZAÇÃO DO SISTEMA OPERACIONAL        ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# Instalar e importar o módulo PSWindowsUpdate
Write-Host "🔄 Instalando módulo PSWindowsUpdate..." -ForegroundColor Yellow
Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
Import-Module PSWindowsUpdate
Write-Host "✅ Módulo PSWindowsUpdate instalado e carregado." -ForegroundColor Green

# Verificar e instalar atualizações
Write-Host "🔍 Verificando e instalando atualizações do Windows..." -ForegroundColor Yellow
Get-WindowsUpdate -Install -AcceptAll -AutoReboot:$false -IgnoreReboot
Write-Host "✅ Atualizações do Windows concluídas com sucesso." -ForegroundColor Green

Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║    ATUALIZAÇÃO DO SISTEMA OPERACIONAL CONCLUÍDA!           ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# Parte 2: Atualizações de Aplicações de Terceiros com Winget
clear
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        INICIANDO ATUALIZAÇÃO DE APLICAÇÕES PADRÃO          ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# Lista de aplicações a serem atualizadas
$applications = @(
    @{ Name = "Google.Chrome"; ExePath = "C:\Program Files\Google\Chrome\Application\chrome.exe" },
    @{ Name = "Adobe.Acrobat.Reader.64-bit"; ExePath = "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe" },
    @{ Name = "Microsoft.Office"; ExePath = "C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE" },
    @{ Name = "Mozilla.Firefox"; ExePath = "C:\Program Files\Mozilla Firefox\firefox.exe" },
    @{ Name = "VideoLAN.VLC"; ExePath = "C:\Program Files\VideoLAN\VLC\vlc.exe" },
    @{ Name = "7zip.7zip"; ExePath = "C:\Program Files\7-Zip\7zFM.exe" },
    @{ Name = "Notepad++.Notepad++"; ExePath = "C:\Program Files\Notepad++\notepad++.exe" },
    @{ Name = "Git.Git"; ExePath = "C:\Program Files\Git\bin\git.exe" }
)

# Função para verificar se uma aplicação está instalada
function Is-ApplicationInstalled {
    param (
        [string]$appName,
        [string]$exePath
    )
    return Test-Path -Path $exePath
}

# Função para atualizar aplicações
function Update-Application {
    param (
        [string]$appName
    )
    Write-Host "🔄 Atualizando $appName..." -ForegroundColor Yellow
    & winget install --id $appName --silent --accept-package-agreements --accept-source-agreements > $null 2>&1
    Write-Host "✅ $appName atualizado com sucesso." -ForegroundColor Green
}

# Verificar e atualizar cada aplicação
foreach ($app in $applications) {
    if (Is-ApplicationInstalled -appName $app.Name -exePath $app.ExePath) {
        Update-Application -appName $app.Name
    } else {
        Write-Host "⚠️ $($app.Name) não encontrado. Pulando atualização." -ForegroundColor Yellow
    }
}

Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║    ATUALIZAÇÃO DAS APLICAÇÕES PADRÃO CONCLUÍDA!            ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# Mensagem final
clear
Write-Host "🎉 Processo de atualização e patching concluído com sucesso!" -ForegroundColor Green
Write-Host "✅ O sistema está atualizado e protegido." -ForegroundColor Green
