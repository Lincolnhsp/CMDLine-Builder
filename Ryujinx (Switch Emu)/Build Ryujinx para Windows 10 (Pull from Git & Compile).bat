@echo off

:: Pré-Reqs
ECHO Para compilar o Ryujinx mais recente, direto do GITHub, voce precisa ter instalado:
ECHO - .NET SDK (superior a versao 5)
ECHO - Cliente GIT (integrado a linha de comando)
TIMEOUT /T 5 /NOBREAK
CLS

:: Efetuar download do código fonte mais recente do Ryujinx, utilizando o GIT
Echo Baixando o codigo fonte mais recente do repositorio do Ryujinx
git clone https://github.com/Ryujinx/Ryujinx
TIMEOUT /T 3 /NOBREAK

:: Copiar o arquivo JSON alterado, sem pedir confirmação. Sobrescrever o arquivo original, para permitir compilação utilizando o Dotnet 6 mais recente - trabalhar neste item
Echo Sobrescrevendo configuracao do .NET SDK para permitir v6 Preview
copy global.json .\Ryujinx\ /y
TIMEOUT /T 3 /NOBREAK

:: Chamar diretorio com o fonte
cd Ryujinx

:: Atualizar submódulos por precauçao
Echo Atualizando submodulos
git submodule update --init
TIMEOUT /T 3 /NOBREAK

:: Limpar builds anteriores
dotnet clean
TIMEOUT /T 3 /NOBREAK

:: Compilar Ryujinx utilizando a configuração de Release para Windows 10, auto contido e com Trimm habilitado.
Echo Compilando Ryujinx, aguarde!
dotnet publish -c Release -r win10-x64 --self-contained true  /p:PublishTrimmed=true
TIMEOUT /T 3 /NOBREAK

:: Limpar os símbolos da compilação, desnecessários para o Relase.
Echo Limpando simbolos da compilacao (PDB)
del .\Ryujinx\bin\Release\net6.2\win10-x64\publish\*.pdb /F /Q
del .\Ryujinx\bin\Release\net6.1\win10-x64\publish\*.pdb /F /Q
del .\Ryujinx\bin\Release\net6.0\win10-x64\publish\*.pdb /F /Q
TIMEOUT /T 3 /NOBREAK

Echo Uma janela ira abrir com todos os arquivos do emulador, mova para onde desejar!
TIMEOUT /T 3 /NOBREAK
explorer .\Ryujinx\bin\Release\net6.2\win10-x64\publish\
explorer .\Ryujinx\bin\Release\net6.1\win10-x64\publish\
explorer .\Ryujinx\bin\Release\net6.0\win10-x64\publish\