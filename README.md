<h1>WinSec Harden Suite</h1>


WinSecHardenSuite é um conjunto de scripts PowerShell desenvolvido para realizar tarefas de hardening em sistemas operacionais Windows. Ele fornece um menu centralizado para executar configurações e atualizações críticas, garantindo que o sistema esteja protegido e em
conformidade com boas práticas de segurança cibernética.<br>
<hr>


<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
</head>
<body>
    <h1>Funcionalidades</h1>
    <p>O WinSecHardenSuite oferece as seguintes funcionalidades:</p>
    <ul>
        <li><strong>Atualização e Patching:</strong> Aplica atualizações do sistema operacional e garante que todos os patches de segurança estejam instalados.</li>
        <li><strong>Configuração de Contas e Privilégios:</strong> Gerencia contas de usuário e privilégios, aplicando políticas de privilégios mínimos.</li>
        <li><strong>Configuração de Firewall:</strong> Define regras de firewall para proteger o tráfego de rede e evitar acessos não autorizados.</li>
        <li><strong>Remoção de Serviços Desnecessários:</strong> Desativa serviços que não são necessários, reduzindo a superfície de ataque.</li>
        <li><strong>Antivírus e Antimalware:</strong> Configura soluções de antivírus e antimalware para proteção contra ameaças.</li>
        <li><strong>Auditoria e Monitoramento:</strong> Implementa auditoria de eventos e monitoramento contínuo de atividades no sistema.</li>
        <li><strong>Criptografia:</strong> Habilita e configura criptografia para proteger dados sensíveis.</li>
        <li><strong>Eliminação de Protocolos e Aplicações Inseguras:</strong> Remove protocolos e softwares inseguros, como SMBv1 e aplicativos obsoletos.</li>
        <li><strong>Ativação do Windows:</strong> Realiza a ativação do Windows usando uma chave de licença válida.</li>
        <li><strong>Verificação do Status de Ativação:</strong> Exibe o status atual de ativação do Windows, incluindo informações detalhadas.</li>
    </ul>
    <h1>Requisitos</h1>
    <ul>
        <li>Windows PowerShell (recomendado: versão 5.1 ou superior)</li>
        <li>Privilégios de administrador</li>
        <li>Conexão com a internet para instalação de módulos e atualizações</li>            
    </ul>
    <h1>Como Usar</h1>
    <p>Clone o repositório:</p>
    <pre><code>git clone https://github.com/seuusuario/WinSecHardenSuite.git</code></pre>
    <p>Navegue até o diretório do projeto:</p>
    <pre><code>cd WinSecHardenSuite</code></pre>
    <p>Execute o script principal:</p>
    <pre><code>.\WinSecHardenSuite.ps1</code></pre>
    <p>Use o menu interativo para selecionar as opções de hardening desejadas.</p>
    <h1>Exemplo de Execução</h1>
    <p>Ao iniciar o script principal WinSecHardenSuite.ps1, você verá o seguinte menu:</p>
    <pre><code>
╔════════════════════════════════════════════════════════════╗
║                   HARDENING DO WINDOWS v1.0               ║
╚════════════════════════════════════════════════════════════╝
              Developed by Paulo Sena (S3N4)
============================================================
[01] 🔄 Atualização e Patching
[02] 👥 Configuração de Contas e Privilégios
[03] 🔥 Configuração de Firewall e Filtro de Tráfego
[04] 🛠️  Remoção de Serviços Desnecessários
[05] 🛡️  Configuração de Antivirus e Antimalware
[06] 🕵️  Auditoria e Monitoramento
[07] 🔒 Configuração de Criptografia
[08] ❌ Eliminação de Protocolos ou Aplicações Inseguras
[09] 🖥️  Ativação do Windows
[10] 📄 Verificar Status de Ativação do Windows
[00] 🚪 Sair
============================================================
    </code></pre>
    <p>Basta digitar o número correspondente à funcionalidade desejada e seguir as instruções na tela.</p>
    <h1>Licença</h1>
    <p>Este projeto está licenciado sob a MIT License. Consulte o arquivo LICENSE para mais detalhes.</p>
    <h1>Contribuições</h1>
    <p>Contribuições são bem-vindas! Se você deseja melhorar este projeto, siga estas etapas:</p>
    <ul>
        <li>Faça um fork do repositório.</li>
        <li>Crie uma branch para sua modificação:</li>
        <pre><code>git checkout -b feature/minha-modificacao</code></pre>
        <li>Commit suas mudanças:</li>
        <pre><code>git commit -m "Adiciona nova funcionalidade"</code></pre>
        <li>Envie suas alterações:</li>
        <pre><code>git push origin feature/minha-modificacao</code></pre>
        <li>Abra um Pull Request.</li>
    </ul>
</body>
</html>

    

    
