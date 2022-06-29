    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

Clear-Host

### Startbildschirm ###
function startbildschirm {
    Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗"
    Write-Host "║ Windows Server Installtool v1.8.9                                            ║"
    Write-Host "║                                                                              ║"
    Write-Host "║                                                       (c) www.simonfieber.it ║"
    Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝"
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory

### Administrationsrechte prüfen und ggf. anfordern ###
function adminrechte {
Start-Sleep -Milliseconds 1000
    Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
    Write-Host "        ║ Administrationsrechte werden angefordert...                          ║"
    Write-Host "        ║                                                                      ║"
    Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
    Start-Sleep -Milliseconds 1500
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = "$installpath\scripts\tool_server.ps1"
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
    & "$installpath\scripts\tool_server.ps1"
}

### Start ###
startbildschirm
adminrechte