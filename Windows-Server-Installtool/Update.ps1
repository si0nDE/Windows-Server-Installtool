    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

cls
### Fehlermeldungen unterdrücken ###
### Mögliche Fehlermeldungen: Dateien oder Ordner können nicht gelöscht werden, da diese nicht existieren. ###
$ErrorActionPreference = "SilentlyContinue"

### Startbildschirm ###
function startbildschirm {
    Write-Host "╔═══════════════════════════════════════════════════════════════════════════════╗"
    Write-Host "║ Windows Server Install Update-Tool                                            ║"
    Write-Host "║                                                                               ║"
    Write-Host "║                                                     (c) github.simonfieber.it ║"
    Write-Host "╚═══════════════════════════════════════════════════════════════════════════════╝"
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
$source = "https://github.com/simonfieberIT/Windows-Server-Installtool/archive/master.zip"

function update_herunterladen {
    cls
    startbildschirm
        Write-Host "        ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "        ║ Update wird heruntergeladen...                                                ║"
        Write-Host "        ║                                                                               ║"
        Write-Host "        ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Invoke-WebRequest -Uri $source -OutFile "$installpath\update.zip"
}

function update_entpacken {
    cls
    startbildschirm
        Write-Host "        ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "        ║ Update wird entpackt...                                                       ║"
        Write-Host "        ║                                                                               ║"
        Write-Host "        ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Unzip "$installpath\update.zip" "$installpath"
        Start-Sleep -Milliseconds 1000
        Remove-Item "$installpath\update.zip"
}

function update_installieren {
    cls
    startbildschirm
        Write-Host "        ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "        ║ Update wird installiert...                                                    ║"
        Write-Host "        ║                                                                               ║"
        Write-Host "        ╚═══════════════════════════════════════════════════════════════════════════════╝"
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
        Write-Host "        ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "        ║ Aufräumen...                                                                  ║"
        Write-Host "        ║                                                                               ║"
        Write-Host "        ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Remove-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\" -Recurse
        Remove-Item "$installpath\Windows-Server-Installtool-master\.gitattributes"
        Remove-Item "$installpath\Windows-Server-Installtool-master\.gitignore"
        Remove-Item "$installpath\Windows-Server-Installtool-master\_config.yml"
        Remove-Item "$installpath\Windows-Server-Installtool-master\README.md"
        Start-Sleep -Milliseconds 1000
        Remove-Item "$installpath\Windows-Server-Installtool-master\"
}

function update_fertigstellen {
    cls
    startbildschirm
        Write-Host "        ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "        ║ Update fertiggestellt!                                                        ║"
        Write-Host "        ║                                                                               ║"
        Write-Host "        ║     Programm wird beendet...                                                  ║"
        Write-Host "        ║                                                                               ║"
        Write-Host "        ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 5000
    [Environment]::Exit(1)
}

if($installpath -like "*\GitHub\Windows-Server-Installtool\*") {
    cls
    startbildschirm
        Start-Sleep -Milliseconds 500
        Write-Host "        ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "        ║ Update scheint in der Entwicklungsumgebung ausgeführt zu werden.              ║"
        Write-Host "        ║                                                                               ║"
        Write-Host "        ║     Programm wird beendet...                                                  ║"
        Write-Host "        ║                                                                               ║"
        Write-Host "        ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 5000
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

