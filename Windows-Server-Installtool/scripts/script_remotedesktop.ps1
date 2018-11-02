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

function Start-RemoteDesktop-Tool {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Remotedesktop einrichten                                                  ║"
            Write-Host "   ╠════════════════════════════                                               ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Möchten Sie die RDP-Verbindung zu diesem Server                           ║"
            Write-Host "   ║ aktivieren oder deaktivieren?                                             ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Aktivieren                   ║ [ 2 ] Deaktivieren                   ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value "0"
                     Enable-NetFirewallRule -DisplayGroup “Remotedesktop”
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Remotedesktop einrichten                                                  ║"
                    Write-Host "   ╠════════════════════════════                                               ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ RDP-Verbindungen zu diesem Server wurden aktiviert!                       ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    wsitool}
                '2' {Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value "1"
                     Disable-NetFirewallRule -DisplayGroup “Remotedesktop”
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Remotedesktop einrichten                                                  ║"
                    Write-Host "   ╠════════════════════════════                                               ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ RDP-Verbindungen zu diesem Server wurden deaktiviert!                     ║"
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
Start-RemoteDesktop-Tool