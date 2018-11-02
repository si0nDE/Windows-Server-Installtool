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

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory

### Netzwerkkonfiguration ändern - Menü ###
function netzwerktool {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Netzwerkkonfiguration ändern                                              ║"
            Write-Host "   ╠════════════════════════════════                                           ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Bitte wählen Sie das gewünschte Internetprotokoll aus:                    ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 4 ] IPv4                         ║ [ 6 ] IPv6                           ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║ [ 1 ] Aktuelle Netzwerkkonfiguration anzeigen                             ║"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""

            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Show-NetConf}
                '4' {IPv4conf_ifIndex}
                '6' {netzwerktool_ipv6}
                'x' {wsitool} # Zurück ins Hauptmenü #
                '0' {wsitool} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### Netzwerkkonfiguration anzeigen ###
function Show-NetConf {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Aktuelle Netzwerkkonfiguration                                            ║"
        Write-Host "   ╠══════════════════════════════════                                         ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Die aktuelle Netzwerkkonfiguration wird abgerufen...                      ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Get-NetIPConfiguration
        Write-Host ""
        Write-Host ""
}

### Netzwerkkonfiguration (IPv4) ändern ###
function IPv4conf_ifIndex {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Netzwerkkonfiguration (IPv4) ändern                                       ║"
        Write-Host "   ╠═══════════════════════════════════════                                    ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Auf welchen Netzwerkport soll die Konfiguration eingerichtet werden?      ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Bitte geben Sie den 'InterfaceIndex' ein...                               ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"

        Get-NetAdapter | ft Name, ifIndex, Status, InterfaceDescription

        $InterfaceIndex = Read-Host "InterfaceIndex"
        Start-Sleep -Milliseconds  500
        IPv4conf_Menu
}

function IPv4conf_Menu {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Netzwerkkonfiguration (IPv4) ändern                                       ║"
            Write-Host "   ╠═══════════════════════════════════════                                    ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Möchten Sie eine statische oder dynamische Netzwerkkonfiguration?         ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Dynamisch (DHCP)             ║ [ 2 ] Statisch                       ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ X ] Vorgang abbrechen                                                   ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""

            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Set-IPv4conf_DHCP}
                '2' {Set-IPv4conf_Static1}
                'x' {netzwerktool} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### Netzwerkkonfiguration (IPv4) dynamisch beziehen ###
function Set-IPv4conf_DHCP {
    Set-NetIPInterface -InterfaceIndex $InterfaceIndex -DHCP Enabled
    Start-Sleep -Milliseconds 1500

    cls
    startbildschirm
        Write-Host "      ╔════════════════════════════════════════════════════════════════════════╗"
        Write-Host "      ║ Netzwerkkonfiguration (IPv4) ändern                                    ║"
        Write-Host "      ╠═══════════════════════════════════════                                 ║"
        Write-Host "      ║                                                                        ║"
        Write-Host "      ║  Die Netzwerkkonfiguration wird nun dynamisch bezogen.                 ║"
        Write-Host "      ║                                                                        ║"
        Write-Host "      ╚════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        pause
        netzwerktool
}

### IP-Adresse ###
function Set-IPv4conf_Static1 {
    cls
    startbildschirm
    IPv4conf_IP-Address1
    IPv4conf_IP-Address2
Start-Sleep -Milliseconds  500
}

function IPv4conf_IP-Address1 {
    $IP_Address = ""
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Netzwerkkonfiguration (IPv4) ändern                                       ║"
        Write-Host "   ╠═══════════════════════════════════════                                    ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Geben Sie die neue IP-Adresse für diesen Host ein...                      ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
Start-Sleep -Milliseconds  500
}

function IPv4conf_IP-Address2 {
    Write-Host ""
    $IP_Address = Read-Host "IP-Adresse"

    Set-IPv4conf_Static2
}

### Subnetzmaske ###
function Set-IPv4conf_Static2 {
    cls
    startbildschirm
    IPv4conf_Subnetmask1
    IPv4conf_Subnetmask2
Start-Sleep -Milliseconds  500
}

function IPv4conf_Subnetmask1 {
    $Subnetmask = ""
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Netzwerkkonfiguration (IPv4) ändern                                       ║"
        Write-Host "   ╠═══════════════════════════════════════                                    ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Geben Sie die Subnetzmaske ein...                                         ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║     Beispiel: 255.255.255.0                                               ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
Start-Sleep -Milliseconds  500
}

function IPv4conf_Subnetmask2 {
    Write-Host ""
    $Subnetmask = Read-Host "Subnetzmaske"

    Set-IPv4conf_Static3
}

### Standardgateway ###
function Set-IPv4conf_Static3 {
    cls
    startbildschirm
    IPv4conf_Gateway1
    IPv4conf_Gateway2
Start-Sleep -Milliseconds  500
}

function IPv4conf_Gateway1 {
    $defaultGateway = ""
    Start-Sleep -Milliseconds  500
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Netzwerkkonfiguration (IPv4) ändern                                       ║"
        Write-Host "   ╠═══════════════════════════════════════                                    ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Geben Sie den Standardgateway ein...                                      ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
}

function IPv4conf_Gateway2 {
    Write-Host ""
    $defaultGateway = Read-Host "Gateway"

    Set-IPv4conf_Static4
}

### DNS-Server ###
function Set-IPv4conf_Static4 {
    cls
    startbildschirm
    IPv4conf_DNS1
    IPv4conf_DNS2
Start-Sleep -Milliseconds  500
}

function IPv4conf_DNS1 {
    $defaultDNS = ""
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Netzwerkkonfiguration (IPv4) ändern                                       ║"
        Write-Host "   ╠═══════════════════════════════════════                                    ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Geben Sie den bevorzugten DNS-Server ein...                               ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
Start-Sleep -Milliseconds  500
}

function IPv4conf_DNS2 {
    Write-Host ""
    $defaultDNS = Read-Host "DNS-Server"

    Set-IPv4conf_Static5
}

function Set-IPv4conf_Static5 {
    Start-Sleep -Milliseconds  500
    cls
    startbildschirm
        do {
        Write-Host "      ╔════════════════════════════════════════════════════════════════════════╗"
        Write-Host "      ║ Netzwerkkonfiguration (IPv4) ändern                                    ║"
        Write-Host "      ╠═══════════════════════════════════════                                 ║"
        Write-Host "      ║                                                                        ║"
        Write-Host "      ║  Folgende Netzwerkkonfiguration wird nun eingerichtet:                 ║"
        Write-Host "      ║                                                                        ║"
        Write-Host "      ╚════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Write-Host ""
        Write-Host "   IP-Adresse:      $IP_Address"
        Write-Host "   Subnetzsmaske:   $Subnetmask"
        Write-Host "   Standardgateway: $defaultGateway"
        Write-Host ""
        Write-Host "   DNS-Server:      $defaultDNS"
        Write-Host ""
        Write-Host ""
        Write-Host "      ╔════════════════════════════════════════════════════════════════════════╗"
        Write-Host "      ║ Netzwerkkonfiguration (IPv4) ändern                                    ║"
        Write-Host "      ╠═══════════════════════════════════════                                 ║"
        Write-Host "      ║                                                                        ║"
        Write-Host "      ║  Soll diese Netzwerkkonfiguration eingerichtet werden?                 ║"
        Write-Host "      ║                                                                        ║"
        Write-Host "      ║ [ J ] Ja                          ║ [ N ] Nein                         ║"
        Write-Host "      ║                                   ║                                    ║"
        Write-Host "      ╚═══════════════════════════════════╩════════════════════════════════════╝"
        Write-Host ""
        $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                'J' {
                    netsh interface ip set address name=$InterfaceIndex static $IP_Address $Subnetmask $defaultGateway
                    Start-Sleep -Milliseconds 500
                    Set-DnsClientServerAddress -InterfaceIndex $InterfaceIndex -ServerAddresses $defaultDNS | Out-Null
                    Start-Sleep -Milliseconds 1000
                    cls
                    startbildschirm
                    Write-Host "      ╔════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "      ║ Netzwerkkonfiguration (IPv4) ändern                                    ║"
                    Write-Host "      ╠═══════════════════════════════════════                                 ║"
                    Write-Host "      ║                                                                        ║"
                    Write-Host "      ║  Die Netzwerkkonfiguration wurde geändert!                             ║"
                    Write-Host "      ║                                                                        ║"
                    Write-Host "      ╚════════════════════════════════════════════════════════════════════════╝"
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
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Netzwerkkonfiguration ändern                                              ║"
        Write-Host "   ╠════════════════════════════════                                           ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Diese Funktion ist derzeit noch in der Entwicklung!                       ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
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
netzwerktool