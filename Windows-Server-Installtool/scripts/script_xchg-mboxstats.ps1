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
function mboxstats {
    do {
        Clear-Host
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Mailbox-Statistiken                                                       ║"
            Write-Host "   ╠═══════════════════════                                                    ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Was möchten Sie tun?                                                      ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Mailbox-Statistiken abrufen  ║ [    ]                               ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Start-MboxStats}
                '2' {netframework-uninstall}
                'x' {xchg-server} # Zurück ins Hauptmenü #
                '0' {xchg-server} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### Menü: Mailbox-Statistiken abrufen ###
function Start-MboxStats {
    do {
        Clear-Host
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Mailbox-Statistiken abrufen                                               ║"
            Write-Host "   ╠═══════════════════════════════                                            ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Möchten Sie die Statistiken nur anzeigen oder als .txt-Datei exportieren? ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Anzeigen                     ║ [ 2 ] Speichern                      ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
                $input = Read-Host "Bitte wählen Sie"

                switch ($input) {
                    '1' {Get-MboxStats}
                    '2' {Save-MboxStats}
                    'x' {wsitool} # Zurück ins Hauptmenü #
                    '0' {wsitool} # Zurück ins Hauptmenü #
                } pause }
            until ($input -eq 'x')
}

### Mailbox-Statistiken abrufen ###
function Get-MboxStats {
    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Mailbox-Statistiken abrufen                                               ║"
        Write-Host "   ╠═══════════════════════════════                                            ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Mailbox-Statistiken werden abgerufen...                                   ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 1500
        Add-PSSnapin Microsoft.Exchange.Management.PowerShell.*
        Get-MailboxDatabase | Get-MailboxStatistics | Select-Object displayname,totalitemsize | Sort-Object totalitemsize -Descending | Format-Table -AutoSize
    pause
    Start-MboxStats
}

### Mailbox-Statistiken speichern ###
function Save-MboxStats {
    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Mailbox-Statistiken abrufen                                               ║"
        Write-Host "   ╠═══════════════════════════════                                            ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Wo sollen die Mailbox-Statistiken gespeichert werden?                     ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║    Beispiel: C:\mbox-stats.txt                                            ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $speicherort = Read-Host "Speicherort"
        Start-Sleep -Milliseconds 1500
        Add-PSSnapin Microsoft.Exchange.Management.PowerShell.*
        Get-MailboxDatabase | Get-MailboxStatistics | Select-Object displayname,totalitemsize | Sort-Object totalitemsize -Descending | Format-Table -AutoSize | Out-File -PSPath $speicherort
        
        Clear-Host
        startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Mailbox-Statistiken abrufen                                               ║"
        Write-Host "   ╠═══════════════════════════════                                            ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Mailbox-Statistiken wurden gespeichert!                                   ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Start-Sleep -Milliseconds 1500
    Start-MboxStats
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory
$scriptpath = "\tool_xchg-server.ps1"
$fullscriptpath = $installpath + $scriptpath

### Zurück zum Windows Server Installtool ###
function xchg-server {
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
mboxstats