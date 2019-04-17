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

### Menü ###
function menue {
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hauptmenü                                                                 ║"
        Write-Host "   ╠═════════════                                                              ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ [ 1 ] Hostnamen ändern              ║ [ 5 ] Cortana & Bing-Suche verwalten║"
        Write-Host "   ║ [ 2 ] Netzwerkkonfiguration ändern  ║ [ 6 ] Dienst verwalten: MapsBroker  ║"
        Write-Host "   ║ [ 3 ] Arbeitsgruppe/Domäne beitreten║ [ 7 ] Dienst verwalten: OneSyncSvc  ║"
        Write-Host "   ║ [ 4 ] IE Sicherheitskonfiguration   ║ [ 8 ] Remotedesktop einrichten      ║"
        Write-Host "   ╠═════════════════════════════════════╩═════════════════════════════════════╣"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ [ 0 ] Windows neustarten            ║ [ S ] Serverrollen und -features    ║"
        Write-Host "   ║ [ X ] Programm beenden              ║ [ P ] Windows Product Key Tool      ║"
        Write-Host "   ╚═════════════════════════════════════╩═════════════════════════════════════╝"
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
                '1' {hostnametool}
                '2' {netzwerktool}
                '3' {workgroupdomaintool}
                '4' {iexplorer_sicherheit}
                '5' {Start-Cortana-Tool}
                '6' {Start-MapsBroker-Tool}
                '7' {Start-OneSyncSvc-Tool}
                '8' {remotedesktoptool}
                'p' {wpktool}
                's' {wsmtool}
                'x' {[Environment]::Exit(1)}
            } pause }
        until ($input -eq 'x')
}

### Computerinfo abrufen ###
$computerinfo = Get-WmiObject -class win32_computersystem

### Hostnamen ändern ###
function hostnametool {
    $hostname = ''
    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hostnamen ändern                                                          ║"
        Write-Host "   ╠════════════════════                                                       ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Geben Sie einen neuen Hostnamen für diesen Windows Server ein...          ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $hostname = Read-Host "Neuer Hostname"
        Write-Host ""
        Start-Sleep -Milliseconds 1500
        $computerinfo.Rename($hostname) | Out-Null
        Clear-Host
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Hostnamen ändern                                                          ║"
            Write-Host "   ╠════════════════════                                                       ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Der Hostname wurde erfolgreich geändert.                                  ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Ein Neustart ist erforderlich!                                            ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
    menueauswahl
}

### Netzwerkkonfiguration ändern - Menü ###
function netzwerktool {
    Clear-Host
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = $netzwerk_fullscriptpath
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
    & $netzwerk_fullscriptpath
}



### Arbeitsgruppe/Domäne beitreten - Menü ###
function workgroupdomaintool {
    Clear-Host
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = "$installpath\script_domainworkgroup.ps1"
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
    & "$installpath\script_domainworkgroup.ps1"
}


### Verstärkte Sicherheitskonfiguration für IE - Menü ###
function iexplorer_sicherheit {
    Clear-Host
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = "$installpath\script_iexplorer-sicherheit.ps1"
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
    & "$installpath\script_iexplorer-sicherheit.ps1"
}


### Cortana & Bing-Suche aktivieren/deaktivieren ###
function Start-Cortana-Tool {
    Clear-Host
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = "$installpath\script_iexplorer-sicherheit.ps1"
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
    & "$installpath\script_cortana.ps1"
}


### Dienst verwalten: MapsBroker ###
function Start-MapsBroker-Tool {
    Clear-Host
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = "$installpath\script_mapsbroker.ps1"
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
    & "$installpath\script_mapsbroker.ps1"
}

### Dienst verwalten: OneSync-Synchronisierungshost ###
function Start-OneSyncSvc-Tool {
    Clear-Host
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = "$installpath\script_onesyncsvc.ps1"
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
    & "$installpath\script_onesyncsvc.ps1"
}

### Remotedesktop einrichten ###
function remotedesktoptool {
    Clear-Host
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
        if(!$princ.IsInRole( `
            [System.Security.Principal.WindowsBuiltInRole]::Administrator))
            {
                $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
                $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
                $script = "$installpath\script_remotedesktop.ps1"
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
    & "$installpath\script_remotedesktop.ps1"
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory
$wsm_scriptpath = "\tool_srvmanager.ps1"
$wpk_scriptpath = "\tool_productkey.ps1"
$restart_scriptpath = "\script_neustart.ps1"
$netzwerk_scriptpath = "\script_netzwerk.ps1"
$wsm_fullscriptpath = $installpath + $wsm_scriptpath
$wpk_fullscriptpath = $installpath + $wpk_scriptpath
$restart_fullscriptpath = $installpath + $restart_scriptpath
$netzwerk_fullscriptpath = $installpath + $netzwerk_scriptpath

### Windows Server Installtool starten ###
function wpktool {
    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows Product Key Tool                                                  ║"
        Write-Host "   ╠════════════════════════════                                               ║"
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
                $script = $wpk_fullscriptpath
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
    & $wpk_fullscriptpath
}

### Windows Server Installtool starten ###
function wsmtool {
    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows Server-Manager Tool                                               ║"
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
                $script = $wsm_fullscriptpath
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
    & $wsm_fullscriptpath
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

### Start ###
menueauswahl