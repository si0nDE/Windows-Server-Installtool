    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

Clear-Host
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
$wsi_source  = "https://github.com/si0nDE/Windows-Server-Installtool/archive/master.zip"
$wpkt_source = "https://github.com/si0nDE/Windows-Product-Key-Tool/archive/master.zip"
$btsu_source = "https://github.com/si0nDE/Win-SystemUser/archive/master.zip"

function wsi_herunterladen {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Aktuellste Version (Windows Server Installtool) wird heruntergeladen...  ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        $error.Clear()
        try{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri $wsi_source -OutFile "$installpath\wsi.zip"}
        catch{
            Start-Sleep -Milliseconds 1500
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Das Windows Server Installtool konnte nicht heruntergeladen werden.  ║"
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

function wpkt_herunterladen {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Aktuellste Version (Windows Product Key Tool) wird heruntergeladen...    ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        $error.Clear()
        try{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri $wpkt_source -OutFile "$installpath\wpkt.zip"}
        catch{
            Start-Sleep -Milliseconds 1500
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Das Windows Product Key Tool konnte nicht heruntergeladen werden.    ║"
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

function btsu_herunterladen {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Aktuellste Version (Win-SystemUser) wird heruntergeladen...              ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        $error.Clear()
        try{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri $btsu_source -OutFile "$installpath\btsu.zip"}
        catch{
            Start-Sleep -Milliseconds 1500
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Win-SystemUser konnte nicht heruntergeladen werden.                  ║"
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
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Updates werden entpackt...                                               ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        $error.Clear()
        try{Unzip "$installpath\wsi.zip" "$installpath"}
        catch{
            Start-Sleep -Milliseconds 1500
            Remove-Item "$installpath\wsi.zip"
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Das Windows Server Installtool konnte nicht entpackt werden.         ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte starten Sie dieses Script als Administrator erneut!        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
        try{Unzip "$installpath\wpkt.zip" "$installpath"}
        catch{
            Start-Sleep -Milliseconds 1500
            Remove-Item "$installpath\wpkt.zip"
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Das Windows Product Key Tool konnte nicht entpackt werden.           ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte starten Sie dieses Script als Administrator erneut!        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
        try{Unzip "$installpath\btsu.zip" "$installpath"}
        catch{
            Start-Sleep -Milliseconds 1500
            Remove-Item "$installpath\btsu.zip"
            Write-Host ""
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Win-SystemUser konnte nicht entpackt werden.                         ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte starten Sie dieses Script als Administrator erneut!        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
        Start-Sleep -Milliseconds 1000
        Remove-Item "$installpath\wsi.zip"
        Remove-Item "$installpath\wpkt.zip"
        Remove-Item "$installpath\btsu.zip"
}

function update_installieren {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Updates werden installiert...                                            ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Remove-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\update.ps1"
        Remove-Item "$installpath\scripts\" -Recurse
        Start-Sleep -Milliseconds 3000
        New-Item "$installpath\scripts\" -ItemType directory | Out-Null
        Move-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\scripts\*" "$installpath\scripts\" -Force
        Move-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\*" "$installpath" -Force
        Move-Item "$installpath\Windows-Product-Key-Tool-master\Windows-Product-Key-Tool.ps1" "$installpath\scripts\tool_productkey.ps1"
        Move-Item "$installpath\Win-SystemUser-master\Win-SystemUser\Be_the_System.ps1" "$installpath\scripts\script_win-systemUser.ps1"
}

function update_aufraeumen {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Aufräumen...                                                             ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 1000
        Remove-Item "$installpath\Windows-Server-Installtool-master\" -Recurse
        Remove-item "$installpath\Windows-Product-Key-Tool-master\" -Recurse
        Remove-Item "$installpath\Win-SystemUser-master\" -Recurse
}

function update_fertigstellen {
    Clear-Host
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
    Clear-Host
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
    Clear-Host
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
    wsi_herunterladen
    Start-Sleep -Milliseconds 1500
    wpkt_herunterladen
    Start-Sleep -Milliseconds 1500
    btsu_herunterladen
    Start-Sleep -Milliseconds 1500
    update_entpacken
    Start-Sleep -Milliseconds  500
    update_installieren
    Start-Sleep -Milliseconds 1500
    update_aufraeumen
    Start-Sleep -Milliseconds 1500
    update_fertigstellen
}