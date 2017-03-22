cls

### Startbildschirm ###
    function startbildschirm {
        Write-Host "╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "║ Windows Server-Manager Tool v2.0.1α                                           ║"
        Write-Host "║                                                                               ║"
        Write-Host "╚═══════════════════════════════════════════════════════════════════════════════╝"
    }

### Menü ###
    function menue {
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Welche Rollen möchten Sie verwalten?                                          ║"
        Write-Host "   ╠════════════════════════════════════════                                       ║"
        Write-Host "   ║                                                                               ║"
        Write-Host "   ║ [   ] Active Directory               ║ [   ] .NET Framework 3.5               ║"
        Write-Host "   ║ [   ] DHCP-Server                    ║ [   ] .NET Framework 4.6               ║"
        Write-Host "   ║ [   ] DNS-Server                     ║ [   ] Windows Server Sicherung         ║"
        Write-Host "   ║ [   ] Hyper-V                        ║                                        ║"
        Write-Host "   ║ [   ] Remotedesktopdienste           ║                                        ║"
        Write-Host "   ║ [   ] Webserver (IIS)                ║                                        ║"
        Write-Host "   ║ [   ] Windows Server Update Services ║                                        ║"
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
                'x' {wsitool}
            } pause }
        until ($input -eq 'x')
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory
$scriptpath = "\start.ps1"
$fullscriptpath = $installpath + $scriptpath

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
startbildschirm
menue
menueauswahl