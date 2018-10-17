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

### Verstärkte Sicherheitskonfiguration für IE - Menü ###
function Start-IExplorer-Sicherheit {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE                                ║"
            Write-Host "   ╠══════════════════════════════════════════════                             ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Wählen Sie den Benutzer, für den Sie die Sicherheitskonfiguration ändern  ║"
            Write-Host "   ║ möchten:                                                                  ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Administratoren              ║ [ 2 ] Benutzer                       ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {iexplorer_adminsicherheit}
                '2' {iexplorer_usersicherheit}
                'x' {wsitool} # Zurück ins Hauptmenü #
                '0' {wsitool} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x' -or "0")
}

### Verstärkte Sicherheitskonfiguration für IE - Administratoren###
function iexplorer_adminsicherheit {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Administratoren              ║"
            Write-Host "   ╠════════════════════════════════════════════════════════════════           ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Möchten Sie die verstärkte Sicherheitskonfiguration aktivieren            ║"
            Write-Host "   ║ oder deaktivieren?                                                        ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Aktivieren (empfohlen)       ║ [ 2 ] Deaktivieren                   ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ X ] Zurück zur Benutzerauswahl                                          ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value "1"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Administratoren              ║"
                    Write-Host "   ╠════════════════════════════════════════════════════════════════           ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ Die Sicherheitskonfiguration für Administratoren wurde aktiviert!         ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    Start-IExplorer-Sicherheit}
                '2' {Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value "0"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Administratoren              ║"
                    Write-Host "   ╠════════════════════════════════════════════════════════════════           ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ Die Sicherheitskonfiguration für Administratoren wurde deaktiviert!       ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    Start-IExplorer-Sicherheit}
                'x' {Start-IExplorer-Sicherheit} # Zurück zur Benutzerauswahl #
                '0' {Start-IExplorer-Sicherheit} # Zurück zur Benutzerauswahl #
            } pause }
        until ($input -eq 'x' -or "0")
}

### Verstärkte Sicherheitskonfiguration für IE - Benutzer###
function iexplorer_usersicherheit {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Benutzer                     ║"
            Write-Host "   ╠═════════════════════════════════════════════════════════                  ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Möchten Sie die verstärkte Sicherheitskonfiguration aktivieren            ║"
            Write-Host "   ║ oder deaktivieren?                                                        ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Aktivieren (empfohlen)       ║ [ 2 ] Deaktivieren                   ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ X ] Zurück zur Benutzerauswahl                                          ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value "1"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Benutzer                     ║"
                    Write-Host "   ╠═════════════════════════════════════════════════════════                  ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ Die Sicherheitskonfiguration für Benutzer wurde aktiviert!                ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    Start-IExplorer-Sicherheit}
                '2' {Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value "0"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Benutzer                     ║"
                    Write-Host "   ╠═════════════════════════════════════════════════════════                  ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ Die Sicherheitskonfiguration für Benutzer wurde deaktiviert!              ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    Start-IExplorer-Sicherheit}
                'x' {Start-IExplorer-Sicherheit} # Zurück zur Benutzerauswahl #
                '0' {Start-IExplorer-Sicherheit} # Zurück zur Benutzerauswahl #
            } pause }
        until ($input -eq 'x' -or "0")
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
Start-IExplorer-Sicherheit