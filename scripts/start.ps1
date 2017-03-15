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
        Write-Host "   ║ [ 0 ] Netzwerkkonfiguration ändern   ║ [ 0 ] Remotedesktop einrichten         ║"
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
        cls
        startbildschirm
        menue
        menueauswahl
}

### Start ###
startbildschirm
menue
menueauswahl