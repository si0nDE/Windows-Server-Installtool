    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

Clear-Host

### Startbildschirm ###
    function startbildschirm {
        Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "║ Windows Exchange-Server Tool                                                 ║"
        Write-Host "║                                                                              ║"
        Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝"
    }

### Menü ###
    function menue {
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Welche möchten Sie tun?                                                   ║"
        Write-Host "   ╠═══════════════════════════                                                ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ [ 1 ] Mailbox-Statistiken            ║ [    ]                             ║"
        Write-Host "   ║ [   ]                                ║ [    ]                             ║"
        Write-Host "   ║ [   ]                                ║ [    ]                             ║"
        Write-Host "   ║ [   ]                                ║                                    ║"
        Write-Host "   ║ [   ]                                ║                                    ║"
        Write-Host "   ║ [   ]                                ║                                    ║"
        Write-Host "   ║ [   ]                                ║                                    ║"
        Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════╣"
        Write-Host "   ║ [ 0 ] Windows neustarten                                                  ║"
        Write-Host "   ║ [ X ] Zurück zum WSI-Tool                                                 ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
    }

### Menüauswahl ###
function menueauswahl {
    do {
        Clear-Host
        startbildschirm
        menue
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '0' {neustarten}
                '1' {xchg-mboxstats}
                '2' {entwicklung}
                '3' {entwicklung}
                '4' {entwicklung}
                '5' {entwicklung}
                '6' {entwicklung}
                '7' {entwicklung}
                '8' {entwicklung}
                '9' {entwicklung}
                '10' {entwicklung}
                'x' {wsitool}
            } pause }
        until ($input -eq 'x')
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory
$scriptpath = "\tool_server.ps1"
$restart_scriptpath = "\script_neustart.ps1"
$xchg_mboxstats_scriptpath = "\script_xchg-mboxstats.ps1"
$fullscriptpath = $installpath + $scriptpath
$restart_fullscriptpath = $installpath + $restart_scriptpath
$xchg_mboxstats_fullscriptpath = $installpath + $xchg_mboxstats_scriptpath

### .NET Framework 3.5 ###
function xchg-mboxstats {
    Clear-Host
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = $xchg_mboxstats_fullscriptpath
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
    & $xchg_mboxstats_fullscriptpath
}

### .NET Framework 4.5 ###
function netframework45 {
    Clear-Host
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = $netframework45_fullscriptpath
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
    & $netframework45_fullscriptpath
}

function entwicklung {
Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hinweis                                                                   ║"
        Write-Host "   ╠═══════════                                                                ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Diese Funktion ist derzeit noch in der Entwicklung!                       ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 3000
        menueauswahl
}

### Zurück zum Windows Server Installtool ###
function wsitool {
    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows Server Installtool                                                ║"
        Write-Host "   ╠═══════════════════════════════                                            ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Das Programm wird gewechselt...                                           ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 1500
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = $fullscriptpath
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
    & $fullscriptpath
}

### Windows neustarten ###
function neustarten {
    Clear-Host
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = $restart_fullscriptpath
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
    & $restart_fullscriptpath
}

### .NET-Framework Version ermitteln ###
if([System.Environment]::OSVersion.Version.Major -eq 10){
    $NET4 = "4.6"
        }
else {
    $NET4 = "4.5"
}

### Start ###
menueauswahl