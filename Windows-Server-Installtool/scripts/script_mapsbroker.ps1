    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

Clear-Host

### Startbildschirm ###
function startbildschirm {
    Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗"
    Write-Host "║ Windows Server Installtool                                                   ║"
    Write-Host "║                                                                              ║"
    Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝"
}

### Dienst verwalten: MapsBroker ###
function Start-MapsBroker-Tool {
    do {
        Clear-Host
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Manager für heruntergeladene Karten (MapsBroker)                          ║"
            Write-Host "   ╠════════════════════════════════════════════════════                       ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Möchten Sie den MapsBroker-Dienst automatisch oder                        ║"
            Write-Host "   ║ manuell aktivieren lassen?                                                ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Automatisch (Standard)       ║ [ 2 ] Manuell                        ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Set-Service MapsBroker -StartupType Automatic
                    Clear-Host
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Manager für heruntergeladene Karten (MapsBroker)                          ║"
                    Write-Host "   ╠════════════════════════════════════════════════════                       ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ Der MapsBroker-Dienst wird nun automatisch gestartet.                     ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    wsitool}
                '2' {Set-Service MapsBroker -StartupType Manual
                    Clear-Host
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Manager für heruntergeladene Karten (MapsBroker)                          ║"
                    Write-Host "   ╠════════════════════════════════════════════════════                       ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ Der MapsBroker-Dienst wird ab sofort nicht mehr automatisch gestartet.    ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    wsitool}
                'x' {wsitool} # Zurück ins Hauptmenü #
                '0' {wsitool} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory

### Zurück zum Windows Product Key Tool ###
function wsitool {
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = "$installpath\tool_server.ps1"
                $prm = $script
                    foreach($a in $args) {
                        $prm += ' ' + $a
                    }
                $psi.Arguments = $prm
                $psi.Verb = "runas"
                [System.Diagnostics.Process]::Start($psi) | Out-Null
                return;
            }
    ### Falls Adminrechte nicht erfordert werden können, ###
    ### soll das Script trotzdem ausgeführt werden.      ###
    & "$installpath\tool_server.ps1"
}

### Start ###
Start-MapsBroker-Tool