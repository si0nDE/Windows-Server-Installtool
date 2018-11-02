    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

cls
### Fehlermeldungen unterdrücken ###
### Mögliche Fehlermeldungen: Dateien oder Ordner können nicht gelöscht werden, da diese nicht existieren. ###
$ErrorActionPreference = "SilentlyContinue"

### Startbildschirm ###
function startbildschirm {
    Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗"
    Write-Host "║ Windows Server Install Update-Tool                                           ║"
    Write-Host "║                                                                              ║"
    Write-Host "║                                                       (c) www.simonfieber.it ║"
    Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝"
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
#$installpath = Get-ScriptDirectory
$installpath = Get-ScriptDirectory

### Funktion zum Entpacken einer ZIP-Datei ###
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

### Updateroutine ###
$source = "https://github.com/si0nDE/Windows-Server-Installtool/archive/master.zip"

function update_herunterladen {
    cls
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Update wird heruntergeladen...                                           ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        $error.Clear()
        try{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri $source -OutFile "$installpath\update.zip"}
        catch{
            Start-Sleep -Milliseconds 1500
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Das Update konnte nicht heruntergeladen werden.                      ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte überprüfen Sie Ihre Internetverbindung und                 ║"
            Write-Host "        ║     versuchen Sie es erneut!                                         ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Sollten Sie kein Problem feststellen können, prüfen Sie bitte    ║"
            Write-Host "        ║     auf GitHub, ob die Updateroutine ein Update erhalten hat.        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
}

function update_entpacken {
    cls
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Update wird entpackt...                                                  ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        $error.Clear()
        try{Unzip "$installpath\update.zip" "$installpath"}
        catch{
            Start-Sleep -Milliseconds 1500
            Remove-Item "$installpath\update.zip"
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Das Update konnte nicht entpackt werden.                             ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte starten Sie dieses Script als Administrator erneut!        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
        Start-Sleep -Milliseconds 1000
        Remove-Item "$installpath\update.zip"
}

function update_installieren {
    cls
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Update wird installiert...                                               ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Remove-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\update.ps1"
        Remove-Item "$installpath\scripts\" -Recurse
        Start-Sleep -Milliseconds 3000
        New-Item "$installpath\scripts\" -ItemType directory | Out-Null
        Move-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\scripts\*" "$installpath\scripts\" -Force
        Move-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\*" "$installpath" -Force
}

function update_aufraeumen {
    cls
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Aufräumen...                                                             ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Remove-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\" -Recurse
        Remove-Item "$installpath\Windows-Server-Installtool-master\.gitattributes"
        Remove-Item "$installpath\Windows-Server-Installtool-master\.gitignore"
        Remove-Item "$installpath\Windows-Server-Installtool-master\_config.yml"
        Remove-Item "$installpath\Windows-Server-Installtool-master\Geplante Features.txt"
        Remove-Item "$installpath\Windows-Server-Installtool-master\README.md"
        Start-Sleep -Milliseconds 1000
        Remove-Item "$installpath\Windows-Server-Installtool-master\"
}

function update_fertigstellen {
    cls
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Update fertiggestellt!                                                   ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ║     Programm wird beendet...                                             ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 5000
    [Environment]::Exit(1)
}

function update_fehlgeschlagen {
        Write-Host "            ╔══════════════════════════════════════════════════════════════════╗"
        Write-Host "            ║ Programm wird beendet...                                         ║"
        Write-Host "            ║                                                                  ║"
        Write-Host "            ╚══════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 5000
    [Environment]::Exit(1)
}

if($installpath -like "*\GitHub\Windows-Server-Installtool\*") {
    cls
    startbildschirm
        Start-Sleep -Milliseconds 500
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Update scheint in der Entwicklungsumgebung ausgeführt zu werden.         ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ║     Programm wird beendet...                                             ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 5000
        [Environment]::Exit(1)
} elseif($PSVersionTable.PSVersion -lt "3.0") {
    cls
    startbildschirm
        Start-Sleep -Milliseconds 500
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Das Update-Tool benötigt PowerShell-Version 3.0 oder höher.              ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ║ Bitte aktualisieren Sie Ihre PowerShell-Umgebung oder laden Sie das      ║"
        Write-Host "    ║ Update manuell von GitHub herunter: https://github.com/si0nDE/           ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ║     Programm wird beendet...                                             ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 5000
        [Environment]::Exit(1)
} else {
    Start-Sleep -Milliseconds  500
    update_herunterladen
    Start-Sleep -Milliseconds 1500
    update_entpacken
    Start-Sleep -Milliseconds  500
    update_installieren
    Start-Sleep -Milliseconds 1500
    update_aufraeumen
    Start-Sleep -Milliseconds 1500
    update_fertigstellen
}