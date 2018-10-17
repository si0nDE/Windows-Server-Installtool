    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

cls

### Startbildschirm ###
function startbildschirm {
    Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗"
    Write-Host "║ Windows Server Installtool                                                   ║"
    Write-Host "║                                                                              ║"
    Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝"
}

### Dienst verwalten: OneSync-Synchronisierungshost ###
function Start-OneSyncSvc-Tool {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ OneSync-Synchronisierungshost (OneSyncSvc)                                ║"
            Write-Host "   ╠══════════════════════════════════════════════                             ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Möchten Sie den OneSyncSvc-Dienst automatisch oder                        ║"
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
                '1' {Set-Service -Name "OneSyncSvc" -StartupType Automatic
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ OneSync-Synchronisierungshost (OneSyncSvc)                                ║"
                    Write-Host "   ╠══════════════════════════════════════════════                             ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ Der OneSyncSvc-Dienst wird nun automatisch gestartet.                     ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    wsitool}
                '2' {Set-Service -Name "OneSyncSvc" -StartupType Manual
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ OneSync-Synchronisierungshost (OneSyncSvc)                                ║"
                    Write-Host "   ╠══════════════════════════════════════════════                             ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ Der OneSyncSvc-Dienst wird ab sofort nicht mehr automatisch gestartet.    ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    wsitool}
                'x' {wsitool} # Zurück zur Benutzerauswahl #
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
Start-OneSyncSvc-Tool