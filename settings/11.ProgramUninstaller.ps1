# Verifica se o script está sendo executado como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "🚫 Este script precisa ser executado como administrador." -ForegroundColor Red
    exit
}
clear

# Obtém todos os programas instalados e seleciona apenas o campo 'Vendor' e 'Name' (Nome do programa)
$programs = Get-WmiObject -Class Win32_Product | Where-Object { $_.Vendor -notlike '*Microsoft*' } | Select-Object Name, Vendor


# Função para exibir a lista de programas
function Show-ProgramList {
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                   Lista de Programas Instalados            ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

    $programs | ForEach-Object {
        $id = [array]::IndexOf($programs, $_) + 1
        $formattedID = "[{0:D2}]" -f $id
        Write-Host "$formattedID $($_.Vendor) - $($_.Name)"
    }
}

# Função para remover o programa escolhido
function Remove-Program {
    param($selectedProgram)

    Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║ Removendo o programa: $($selectedProgram.Name) de $($selectedProgram.Vendor) ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

    try {
        # Remove o programa selecionado
        $program = Get-WmiObject -Class Win32_Product -Filter "Name = '$($selectedProgram.Name)'"
        $program.Uninstall()

        Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║ Programa $($selectedProgram.Name) removido com sucesso!    ║" -ForegroundColor Green
        Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    } catch {
        Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║ Erro ao remover o programa: $($selectedProgram.Name)       ║" -ForegroundColor Red
        Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    }
}

# Exibe a lista inicial de programas
Show-ProgramList

while ($true) {
    Write-Host "╔═════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║ Digite o ID do programa que deseja remover (ou 'sair' para cancelar):   ║" -ForegroundColor Green
    Write-Host "╚═════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

    # Solicita o ID do programa a ser removido
    $userChoice = Read-Host "Escolha o ID (exemplo: 01, 02, 03, 020, 034)"

    if ($userChoice -eq 'sair') {
        Write-Host "Operação cancelada." -ForegroundColor Red
        exit
    }

    # Valida a escolha do usuário e garante que a entrada seja um número válido
    if ($userChoice -match '^\d+$' -and $userChoice -gt 0 -and $userChoice -le $programs.Count) {
        # Adiciona 1 ao ID para pegar o valor correto
        $selectedProgram = $programs[$userChoice - 1]

        # Remove o programa escolhido
        Remove-Program -selectedProgram $selectedProgram

        # Exibe a lista novamente após a remoção
        Show-ProgramList
    } else {
        Write-Host "ID inválido. Tente novamente ou digite 'sair' para cancelar." -ForegroundColor Red
    }
}
