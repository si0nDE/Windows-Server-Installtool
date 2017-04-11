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
                'N' {wsitool} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'N')
}

### Zurück zum Windows Server Installtool ###
function wsitool {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows Server Installtool                                                    ║"
        Write-Host "   ╠═══════════════════════════════                                                ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ Das Programm wird erneut geöffnet...                                          ║"
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

### Windows neustarten ###
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
startbildschirm
neustarten