    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

cls

### Startbildschirm ###
function startbildschirm {
        Write-Host "╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "║ Windows Server Installtool                                                    ║"
        Write-Host "║                                                                               ║"
        Write-Host "╚═══════════════════════════════════════════════════════════════════════════════╝"
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory
$scriptpath = "\tool_server.ps1"
$fullscriptpath = $installpath + $scriptpath

### Netzwerkkonfiguration ändern - Menü ###
function netzwerktool {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Netzwerkkonfiguration ändern                                                  ║"
            Write-Host "   ╠════════════════════════════════                                               ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Bitte wählen Sie das gewünschte Internetprotokoll aus:                        ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ 4 ] IPv4                           ║ [ 6 ] IPv6                             ║"
            Write-Host "   ║                                      ║                                        ║"
            Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
            Write-Host "   ║ [ 0 ] Aktuelle Netzwerkkonfiguration anzeigen                                 ║"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                    ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""

            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '0' {netzwerktool_anzeigen}
                '4' {netzwerktool_ipv4}
                '6' {netzwerktool_ipv6}
                'x' {wsitool} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### Netzwerkkonfiguration anzeigen ###
function netzwerktool_anzeigen {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Aktuelle Netzwerkkonfiguration                                                ║"
        Write-Host "   ╠══════════════════════════════════                                             ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ Die aktuelle Netzwerkkonfiguration wird abgerufen...                          ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        netsh interface ip show config
        Write-Host ""
        Write-Host ""
}

### Netzwerkkonfiguration (IPv4) ändern ###
function netzwerktool_ipv4 {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Netzwerkkonfiguration ändern                                                  ║"
        Write-Host "   ╠════════════════════════════════                                               ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ Um die Netzwerkkonfiguration zu ändern, benötigen Sie folgende Daten:         ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ - Name der Schnittstelle                                                      ║"
        Write-Host "   ║ - IP-Adresse                                                                  ║"
        Write-Host "   ║ - Subnetzmaske                                                                ║"
        Write-Host "   ║ - Standardgateway                                                             ║"
        Write-Host "   ║ - DNS-Server                                                                  ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Start-Sleep -Milliseconds 1000
        pause
            cls
            startbildschirm
            Write-Host "      ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "      ║ Netzwerkkonfiguration ändern                                                  ║"
            Write-Host "      ╠════════════════════════════════                                               ║"
            Write-Host "      ║                                                                               ║"
            Write-Host "      ║  Geben Sie den Namen der Schnittstelle ein, die Sie ändern möchten:           ║"
            Write-Host "      ║                                                                               ║"
            Write-Host "      ╚═══════════════════════════════════════════════════════════════════════════════╝"
            $ipv4_Schnittstelle = Read-Host "Schnittstelle"
            Start-Sleep -Milliseconds 1000
                cls
                startbildschirm
                Write-Host "      ╔═══════════════════════════════════════════════════════════════════════════════╗"
                Write-Host "      ║ Netzwerkkonfiguration ändern                                                  ║"
                Write-Host "      ╠════════════════════════════════                                               ║"
                Write-Host "      ║                                                                               ║"
                Write-Host "      ║  Geben Sie IP-Adresse für diesen Host ein:                                    ║"
                Write-Host "      ║                                                                               ║"
                Write-Host "      ╚═══════════════════════════════════════════════════════════════════════════════╝"
                $ipv4_IPAdresse = Read-Host "IP-Adresse"
                Start-Sleep -Milliseconds 1000
                    cls
                    startbildschirm
                    Write-Host "      ╔═══════════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "      ║ Netzwerkkonfiguration ändern                                                  ║"
                    Write-Host "      ╠════════════════════════════════                                               ║"
                    Write-Host "      ║                                                                               ║"
                    Write-Host "      ║  Geben Sie Subnetzmaske des Netzwerks ein:                                    ║"
                    Write-Host "      ║                                                                               ║"
                    Write-Host "      ╚═══════════════════════════════════════════════════════════════════════════════╝"
                    $ipv4_Subnetzmaske = Read-Host "Subnetzmaske"
                    Start-Sleep -Milliseconds 1000
                        cls
                        startbildschirm
                        Write-Host "      ╔═══════════════════════════════════════════════════════════════════════════════╗"
                        Write-Host "      ║ Netzwerkkonfiguration ändern                                                  ║"
                        Write-Host "      ╠════════════════════════════════                                               ║"
                        Write-Host "      ║                                                                               ║"
                        Write-Host "      ║  Geben Sie den Standardgateway ein:                                           ║"
                        Write-Host "      ║                                                                               ║"
                        Write-Host "      ╚═══════════════════════════════════════════════════════════════════════════════╝"
                        $ipv4_Standardgateway = Read-Host "Standardgateway"
                        Start-Sleep -Milliseconds 1000
                            cls
                            startbildschirm
                            Write-Host "      ╔═══════════════════════════════════════════════════════════════════════════════╗"
                            Write-Host "      ║ Netzwerkkonfiguration ändern                                                  ║"
                            Write-Host "      ╠════════════════════════════════                                               ║"
                            Write-Host "      ║                                                                               ║"
                            Write-Host "      ║  Geben Sie den DNS-Server ein:                                                ║"
                            Write-Host "      ║                                                                               ║"
                            Write-Host "      ╚═══════════════════════════════════════════════════════════════════════════════╝"
                            $ipv4_DNSServer = Read-Host "DNS-Server"
                            Start-Sleep -Milliseconds 1500
        cls
    do {
        startbildschirm
        Write-Host "      ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "      ║ Netzwerkkonfiguration ändern                                                  ║"
        Write-Host "      ╠════════════════════════════════                                               ║"
        Write-Host "      ║                                                                               ║"
        Write-Host "      ║  Folgende Netzwerkkonfiguration wird nun eingerichtet:                        ║"
        Write-Host "      ║                                                                               ║"
        Write-Host "      ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Write-Host ""
        Write-Host "   Schnittstelle:   $ipv4_Schnittstelle"
        Write-Host ""
        Write-Host "   IP-Adresse:      $ipv4_IPAdresse"
        Write-Host "   Subnetzmaske:    $ipv4_Subnetzmaske"
        Write-Host "   Standardgateway: $ipv4_Standardgateway"
        Write-Host ""
        Write-Host "   DNS-Server:      $ipv4_DNSServer"
        Write-Host ""
        Write-Host ""
        Write-Host "      ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "      ║ Netzwerkkonfiguration ändern                                                  ║"
        Write-Host "      ╠════════════════════════════════                                               ║"
        Write-Host "      ║                                                                               ║"
        Write-Host "      ║  Soll diese Netzwerkkonfiguration eingerichtet werden?                        ║"
        Write-Host "      ║                                                                               ║"
        Write-Host "      ║ [ J ] Ja                             ║ [ N ] Nein                             ║"
        Write-Host "      ║                                      ║                                        ║"
        Write-Host "      ╚══════════════════════════════════════╩════════════════════════════════════════╝"
        Write-Host ""
        $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                'J' {
                    netsh interface ip set address name=$ipv4_Schnittstelle static $ipv4_IPAdresse $ipv4_Subnetzmaske $ipv4_Standardgateway
                    Start-Sleep -Milliseconds 1500
                    cls
                    startbildschirm
                    Write-Host "      ╔═══════════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "      ║ Netzwerkkonfiguration ändern                                                  ║"
                    Write-Host "      ╠════════════════════════════════                                               ║"
                    Write-Host "      ║                                                                               ║"
                    Write-Host "      ║  Die Netzwerkkonfiguration wurde geändert!                                    ║"
                    Write-Host "      ║                                                                               ║"
                    Write-Host "      ╚═══════════════════════════════════════════════════════════════════════════════╝"
                    Write-Host ""
                    pause
                    wsitool
                    }
                'N' {netzwerktool}
            } pause }
        until ($input -eq 'N')
}

### Netzwerkkonfiguration (IPv6) ändern ###
function netzwerktool_ipv6 {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Netzwerkkonfiguration ändern                                                  ║"
        Write-Host "   ╠════════════════════════════════                                               ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ Diese Funktion ist derzeit noch in der Entwicklung!                           ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
    Start-Sleep -Milliseconds 3000
    netzwerktool
}

### Zurück zum Windows Server Installtool ###
function wsitool {
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


### Start ###
netzwerktool