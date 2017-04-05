    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

cls

### Startbildschirm ###
    function startbildschirm {
        Write-Host "╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "║ Windows Server-Manager Tool v2.0.3α                                           ║"
        Write-Host "║                                                                               ║"
        Write-Host "╚═══════════════════════════════════════════════════════════════════════════════╝"
    }

### Menü ###
    function menue {
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Welche Rollen möchten Sie verwalten?                                          ║"
        Write-Host "   ╠════════════════════════════════════════                                       ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ [ 1 ] Active Directory               ║ [  8 ] .NET Framework 3.5              ║"
        Write-Host "   ║ [ 2 ] DHCP-Server                    ║ [  9 ] .NET Framework 4.6              ║"
        Write-Host "   ║ [ 3 ] DNS-Server                     ║ [ 10 ] Windows Server Sicherung        ║"
        Write-Host "   ║ [ 4 ] Hyper-V                        ║                                        ║"
        Write-Host "   ║ [ 5 ] Remotedesktopdienste           ║                                        ║"
        Write-Host "   ║ [ 6 ] Webserver (IIS)                ║                                        ║"
        Write-Host "   ║ [ 7 ] Windows Server Update Services ║                                        ║"
        Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
        Write-Host "   ║ [ 0 ] Windows neustarten                                                      ║"
        Write-Host "   ║ [ X ] Zurück zum WSI-Tool                                                     ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
    }



### Menüauswahl ###
function menueauswahl {
    do {
        cls
        startbildschirm
        menue
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '0' {neustarten}
                '1' {entwicklung}
                '2' {entwicklung}
                '3' {entwicklung}
                '4' {entwicklung}
                '5' {entwicklung}
                '6' {entwicklung}
                '7' {entwicklung}
                '8' {netframework35-menu}
                '9' {entwicklung}
                '10' {entwicklung}
                'x' {wsitool}
            } pause }
        until ($input -eq 'x')
}

### .NET Framework 3.5 ###
function netframework35-menu {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ .NET Framework 3.5                                                            ║"
            Write-Host "   ╠══════════════════════                                                         ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Möchten Sie .NET Framework installieren oder deinstallieren?                  ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ 1 ] Installieren                   ║ [ 2 ] Deinstallieren                   ║"
            Write-Host "   ║                                      ║                                        ║"
            Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                    ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {netframework35-install}
                '2' {netframework35-uninstall}
                'x' {menueauswahl} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### .NET Framework 3.5 installieren ###
function netframework35-install {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ .NET Framework 3.5                                                            ║"
        Write-Host "   ╠══════════════════════                                                         ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ .NET Framework 3.5 wird installiert...                                        ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Start-Sleep -Milliseconds 1500
        Install-WindowsFeature Net-Framework-Core -source \\network\share\sxs | Out-Null
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ .NET Framework 3.5                                                            ║"
            Write-Host "   ╠══════════════════════                                                         ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ .NET Framework 3.5 wurde erfolgreich installiert...                           ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
    menueauswahl
}

### .NET Framework 3.5 deinstallieren ###
function netframework35-uninstall {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ .NET Framework 3.5                                                            ║"
        Write-Host "   ╠══════════════════════                                                         ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ .NET Framework 3.5 wird deinstalliert...                                      ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Start-Sleep -Milliseconds 1500
        Uninstall-WindowsFeature Net-Framework-Core | Out-Null
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ .NET Framework 3.5                                                            ║"
            Write-Host "   ╠══════════════════════                                                         ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ .NET Framework 3.5 wurde erfolgreich deinstalliert...                         ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
    menueauswahl
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory
$scriptpath = "\start.ps1"
$restart_scriptpath = "\neustart.ps1"
$fullscriptpath = $installpath + $scriptpath
$restart_fullscriptpath = $installpath + $restart_scriptpath

function entwicklung {
cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hinweis                                                                       ║"
        Write-Host "   ╠═══════════                                                                    ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ Diese Funktion ist derzeit noch in der Entwicklung!                           ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 3000
        menueauswahl
}

### Zurück zum Windows Server Installtool ###
function wsitool {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows Server Installtool                                                    ║"
        Write-Host "   ╠═══════════════════════════════                                                ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ Das Programm wird gewechselt...                                               ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
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

### Windows neustarten - Menü ###
function neustart {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows neustarten                                                            ║"
        Write-Host "   ╠══════════════════════                                                         ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ Windows wird neugestartet!                                                    ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Start-Sleep -Milliseconds 5000
        Restart-Computer -Force
}

### Start ###
menueauswahl