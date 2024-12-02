



if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Este script precisa ser executado como administrador." -ForegroundColor Red
    exit
}

# Verifica��o se o Winget est� instalado
try {
    $wingetPath = (Get-Command winget -ErrorAction Stop).Source
    Write-Host "Winget est� instalado."
} catch {
    Write-Host "Winget n�o encontrado. Instalando Winget..."
    $wingetInstallerUrl = "https://aka.ms/getwinget"
    $tempPath = [System.IO.Path]::GetTempPath()
    $wingetInstallerPath = Join-Path -Path $tempPath -ChildPath "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    Invoke-WebRequest -Uri $wingetInstallerUrl -OutFile $wingetInstallerPath
    Add-AppxPackage -Path $wingetInstallerPath
    Remove-Item -Path $wingetInstallerPath -Force
    Write-Host "Winget instalado com sucesso."
    $wingetPath = (Get-Command winget -ErrorAction Stop).Source
}

# Parte 1: Atualiza��es do Sistema Operacional Windows
clear
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host " Iniciando atualiza��o do sistema operacional Windows..." -ForegroundColor Red #Cyan
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host ""


# Instalar o m�dulo PSWindowsUpdate
Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser

# Importar o m�dulo PSWindowsUpdate
Import-Module PSWindowsUpdate

# Verificar e instalar atualiza��es pendentes do Windows, com rein�cio autom�tico, se necess�rio
Get-WindowsUpdate -Install -AcceptAll -AutoReboot:$false -IgnoreReboot

clear
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host " Atualiza��o do sistema operacional Windows conclu�da." -ForegroundColor Red #Cyan
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host ""



# Parte 2: Atualiza��es de Aplica��es de Terceiros com Winget

clear
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host " Iniciando atualiza��o das aplica��es..." -ForegroundColor Red #Cyan
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host " "



# Fun��o para verificar se uma aplica��o est� instalada
function Is-ApplicationInstalled {
    param (
        [string]$appName,
        [string]$exePath
    )
    return Test-Path -Path $exePath
}

# Lista de aplica��es a serem atualizadas com Winget, incluindo caminhos para verifica��o
$applications = @(
    @{ Name = "Google.Chrome"; ExePath = "C:\Program Files\Google\Chrome\Application\chrome.exe" },
    @{ Name = "Adobe.Acrobat.Reader.64-bit"; ExePath = "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe" },
    @{ Name = "Microsoft.Office"; ExePath = "C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE" },
    @{ Name = "Mozilla.Firefox"; ExePath = "C:\Program Files\Mozilla Firefox\firefox.exe" },
    @{ Name = "VideoLAN.VLC"; ExePath = "C:\Program Files\VideoLAN\VLC\vlc.exe" },
    @{ Name = "7zip.7zip"; ExePath = "C:\Program Files\7-Zip\7zFM.exe" },
    @{ Name = "Notepad++.Notepad++"; ExePath = "C:\Program Files\Notepad++\notepad++.exe" },
    @{ Name = "Git.Git"; ExePath = "C:\Program Files\Git\bin\git.exe" },
    @{ Name = "Spotify.Spotify"; ExePath = "C:\Users\$env:USERNAME\AppData\Roaming\Spotify\Spotify.exe" },
    @{ Name = "SlackTechnologies.Slack"; ExePath = "C:\Users\$env:USERNAME\AppData\Local\slack\slack.exe" },
    @{ Name = "Zoom.Zoom"; ExePath = "C:\Users\$env:USERNAME\AppData\Roaming\Zoom\bin\Zoom.exe" }
    @{ Name = "WinRAR.WinRAR"; ExePath = "C:\Program Files\WinRAR\WinRAR.exe" },
    @{ Name = "TheDocumentFoundation.LibreOffice"; ExePath = "C:\Program Files\LibreOffice\program\soffice.exe" },
    @{ Name = "PuTTY.PuTTY"; ExePath = "C:\Program Files\PuTTY\putty.exe" },
    @{ Name = "Opera.Opera"; ExePath = "C:\Program Files\Opera\launcher.exe" },
    @{ Name = "Brave.Brave"; ExePath = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" },
    @{ Name = "Apple.Safari"; ExePath = "C:\Program Files (x86)\Safari\Safari.exe" },
    @{ Name = "Chris.Murphy.Lightshot"; ExePath = "C:\Program Files (x86)\Lightshot\lightshot.exe" }
)

# Fun��o para atualizar aplica��es com Winget
function Update-Application {
    param (
        [string]$appName
    )
    Write-Host "Atualizando $appName..."
    & winget install --id $appName --silent --accept-package-agreements --accept-source-agreements > $null 2>&1
    Write-Host "$appName atualizado com sucesso."
}

# Verificar e atualizar cada aplica��o na lista
foreach ($app in $applications) {
    if (Is-ApplicationInstalled -appName $app.Name -exePath $app.ExePath) {
        Update-Application -appName $app.Name
    } else {
        Write-Host "$($app.Name) n�o encontrado. Pulando atualiza��o."
    }
}

clear
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host " Atualiza��o das aplica��es padr�o conclu�da." -ForegroundColor Red #Cyan
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host " "


# Mensagem final

clear
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host " Processo de atualiza��o e patching conclu�do com sucesso." -ForegroundColor Red #Cyan
Write-Host " ========================================================================" -ForegroundColor Cyan
Write-Host " "

