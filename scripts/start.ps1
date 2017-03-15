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
        Write-Host "   ║═════════════                                                                  ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ [ 1 ] Hostnamen ändern               ║ [ 0 ] Serverrollen und -features       ║"
        Write-Host "   ║ [ 2 ] Netzwerkkonfiguration ändern   ║ [ 0 ] Remotedesktop einrichten         ║"
        Write-Host "   ║ [ 0 ] Arbeitsgruppe/Domäne beitreten ║ [ 0 ]                                  ║"
        Write-Host "   ║ [ 0 ]                                ║ [ 0 ] Windows neustarten               ║"
        Write-Host "   ╠══════════════════════════════════════╩════════════════════════════════════════╣"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ [ X ] Programm beenden                                                        ║"
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
                '1' {hostnametool}
                '2' {netzwerktool}
                'x' {exit}
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

### Netzwerkkonfiguration ändern ###
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

### Start ###
startbildschirm
menue
menueauswahl