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

### Menü ###
    function menue {
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hauptmenü                                                                     ║"
        Write-Host "   ╠═════════════                                                                  ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ [ 1 ] Hostnamen ändern               ║ [ 5 ] Dienst verwalten: MapsBroker     ║"
        Write-Host "   ║ [ 2 ] Netzwerkkonfiguration ändern   ║ [ 6 ] Remotedesktop einrichten         ║"
        Write-Host "   ║ [ 3 ] Arbeitsgruppe/Domäne beitreten ║                                        ║"
        Write-Host "   ║ [ 4 ] IE Sicherheitskonfiguration    ║                                        ║"
        Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ [ 0 ] Windows neustarten             ║ [ S ] Serverrollen und -features       ║"
        Write-Host "   ║ [ X ] Programm beenden               ║ [ P ] Windows Product Key Tool         ║"
        Write-Host "   ╚══════════════════════════════════════╩════════════════════════════════════════╝"
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
                '1' {hostnametool}
                '2' {netzwerktool}
                '3' {workgroupdomaintool}
                '4' {iexplorer_sicherheit}
                '5' {mapsbrokertool}
                '6' {remotedesktoptool}
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
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hostnamen ändern                                                              ║"
        Write-Host "   ╠════════════════════                                                           ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ Geben Sie einen neuen Hostnamen für diesen Windows Server ein...              ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $hostname = Read-Host "Neuer Hostname"
        Write-Host ""
        Start-Sleep -Milliseconds 1500
        $computerinfo.Rename($hostname) | Out-Null
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Hostnamen ändern                                                              ║"
            Write-Host "   ╠════════════════════                                                           ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Der Hostname wurde erfolgreich geändert.                                      ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Ein Neustart ist erforderlich!                                                ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
    menueauswahl
}

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
                'x' {menueauswahl} # Zurück ins Hauptmenü #
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
                    menueauswahl
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
    menueauswahl
}

### Arbeitsgruppe/Domäne beitreten - Menü ###
function workgroupdomaintool {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Arbeitsgruppe/Domäne beitreten                                                ║"
            Write-Host "   ╠══════════════════════════════════                                             ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Möchten Sie einer Arbeitsgruppe oder einer Domäne beitreten?                  ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ 1 ] Arbeitsgruppe                  ║ [ 2 ] Domäne                           ║"
            Write-Host "   ║                                      ║                                        ║"
            Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                    ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {arbeitsgruppe_beitreten}
                '2' {domaene_beitreten}
                'x' {menueauswahl} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### Arbeitsgruppe beitreten ###
function arbeitsgruppe_beitreten {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Arbeitsgruppe beitreten                                                       ║"
        Write-Host "   ╠═══════════════════════════                                                    ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ Geben Sie die Arbeitsgruppe ein, der Sie beitreten möchten...                 ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $neuearbeitsgruppe = Read-Host "Neue Arbeitsgruppe"
        Start-Sleep -Milliseconds 1500
        $computerinfo.JoinDomainOrWorkgroup("$neuearbeitsgruppe") | Out-Null
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Arbeitsgruppe beitreten                                                       ║"
            Write-Host "   ╠═══════════════════════════                                                    ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Die Arbeitsgruppe wurde erfolgreich geändert.                                 ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Ein Neustart ist erforderlich!                                                ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
    menueauswahl
}

### Domäne beitreten ###
function domaene_beitreten {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Domäne beitreten                                                              ║"
        Write-Host "   ╠════════════════════                                                           ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ Geben Sie die Domäne ein, der Sie beitreten möchten...                        ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $neuedomaene = Read-Host "Neue Domäne"
        $benutzername = Read-Host "Benutzername"
        Start-Sleep -Milliseconds 1500
        Add-Computer -DomainName $neuedomaene -Credential $neuedomaene\$benutzername
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Domäne beitreten                                                              ║"
            Write-Host "   ╠════════════════════                                                           ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Die Domäne wurde erfolgreich geändert.                                        ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Ein Neustart ist erforderlich!                                                ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
    menueauswahl
}

### Verstärkte Sicherheitskonfiguration für IE - Menü###
function iexplorer_sicherheit {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE                                    ║"
            Write-Host "   ╠══════════════════════════════════════════════                                 ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Wählen Sie den Benutzer, für den Sie die Sicherheitskonfiguration ändern      ║"
            Write-Host "   ║ möchten:                                                                      ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ 1 ] Administratoren                ║ [ 2 ] Benutzer                         ║"
            Write-Host "   ║                                      ║                                        ║"
            Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                    ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {iexplorer_adminsicherheit}
                '2' {iexplorer_usersicherheit}
                'x' {menueauswahl} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### Verstärkte Sicherheitskonfiguration für IE - Administratoren###
function iexplorer_adminsicherheit {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Administratoren                  ║"
            Write-Host "   ╠════════════════════════════════════════════════════════════════               ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Möchten Sie die verstärkte Sicherheitskonfiguration aktivieren                ║"
            Write-Host "   ║ oder deaktivieren?                                                            ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ 1 ] Aktivieren (empfohlen)         ║ [ 2 ] Deaktivieren                     ║"
            Write-Host "   ║                                      ║                                        ║"
            Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ X ] Zurück zur Benutzerauswahl                                              ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value "1"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Administratoren                  ║"
                    Write-Host "   ╠════════════════════════════════════════════════════════════════               ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ║ Die Sicherheitskonfiguration für Administratoren wurde aktiviert!             ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    iexplorer_sicherheit}
                '2' {Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value "0"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Administratoren                  ║"
                    Write-Host "   ╠════════════════════════════════════════════════════════════════               ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ║ Die Sicherheitskonfiguration für Administratoren wurde deaktiviert!           ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    iexplorer_sicherheit}
                'x' {iexplorer_sicherheit} # Zurück zur Benutzerauswahl #
            } pause }
        until ($input -eq 'x')
}

### Verstärkte Sicherheitskonfiguration für IE - Benutzer###
function iexplorer_usersicherheit {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Benutzer                         ║"
            Write-Host "   ╠═════════════════════════════════════════════════════════                      ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Möchten Sie die verstärkte Sicherheitskonfiguration aktivieren                ║"
            Write-Host "   ║ oder deaktivieren?                                                            ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ 1 ] Aktivieren (empfohlen)         ║ [ 2 ] Deaktivieren                     ║"
            Write-Host "   ║                                      ║                                        ║"
            Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ X ] Zurück zur Benutzerauswahl                                              ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value "1"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Benutzer                         ║"
                    Write-Host "   ╠═════════════════════════════════════════════════════════                      ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ║ Die Sicherheitskonfiguration für Benutzer wurde aktiviert!                    ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    iexplorer_sicherheit}
                '2' {Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value "0"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Verstärkte Sicherheitskonfiguration für IE - Benutzer                         ║"
                    Write-Host "   ╠═════════════════════════════════════════════════════════                      ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ║ Die Sicherheitskonfiguration für Benutzer wurde deaktiviert!                  ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    iexplorer_sicherheit}
                'x' {menueauswahl} # Zurück zur Benutzerauswahl #
            } pause }
        until ($input -eq 'x')
}

### Dienst verwalten: MapsBroker ###
function mapsbrokertool {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Manager für heruntergeladene Karten (MapsBroker)                              ║"
            Write-Host "   ╠════════════════════════════════════════════════════                           ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Möchten Sie den MapsBroker-Dienst automatisch oder manuell aktivieren lassen? ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ 1 ] Automatisch (Standard)         ║ [ 2 ] Manuell                          ║"
            Write-Host "   ║                                      ║                                        ║"
            Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                    ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Set-Service MapsBroker -StartupType Automatic
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Manager für heruntergeladene Karten (MapsBroker)                              ║"
                    Write-Host "   ╠════════════════════════════════════════════════════                           ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ║ Der MapsBroker-Dienst wird nun automatisch gestartet.                         ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    mapsbrokertool}
                '2' {Set-Service MapsBroker -StartupType Manual
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Manager für heruntergeladene Karten (MapsBroker)                              ║"
                    Write-Host "   ╠════════════════════════════════════════════════════                           ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ║ Der MapsBroker-Dienst wird ab sofort nicht mehr automatisch gestartet.        ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    mapsbrokertool}
                'x' {menueauswahl} # Zurück zur Benutzerauswahl #
            } pause }
        until ($input -eq 'x')
}

### Remotedesktop einrichten ###
function remotedesktoptool {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Remotedesktop einrichten                                                      ║"
            Write-Host "   ╠════════════════════════════                                                   ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Möchten Sie die RDP-Verbindung zu diesem Server aktivieren oder deaktivieren? ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ 1 ] Aktivieren                     ║ [ 2 ] Deaktivieren                     ║"
            Write-Host "   ║                                      ║                                        ║"
            Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                    ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value "0"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Remotedesktop einrichten                                                      ║"
                    Write-Host "   ╠════════════════════════════                                                   ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ║ RDP-Verbindungen zu diesem Server wurden aktiviert!                           ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    menueauswahl}
                '2' {Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value "1"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Remotedesktop einrichten                                                      ║"
                    Write-Host "   ╠════════════════════════════                                                   ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ║ RDP-Verbindungen zu diesem Server wurden deaktiviert!                         ║"
                    Write-Host "   ║                                                                               ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════╝"
                    Start-Sleep -Milliseconds 3000
                    menueauswahl}
                'x' {menueauswahl} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory
$wsm_scriptpath = "\servermanager.ps1"
$wpk_scriptpath = "\productkey.ps1"
$wsm_fullscriptpath = $installpath + $wsm_scriptpath
$wpk_fullscriptpath = $installpath + $wpk_scriptpath

### Windows Server Installtool starten ###
function wpktool {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows Product Key Tool                                                      ║"
        Write-Host "   ╠════════════════════════════                                                   ║"
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
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows Server-Manager Tool                                                   ║"
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

### Windows neustarten - Menü ###
function neustarten {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Windows neustarten                                                            ║"
            Write-Host "   ╠══════════════════════                                                         ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ Möchten Sie Windows wirklich neustarten?                                      ║"
            Write-Host "   ║                                                                               ║"
            Write-Host "   ║ [ J ] Ja                             ║ [ N ] Nein                             ║"
            Write-Host "   ║                                      ║                                        ║"
            Write-Host "   ╚══════════════════════════════════════╩════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                'J' {neustart}
                'N' {menueauswahl} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'N')
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