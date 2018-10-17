    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

cls

### Startbildschirm ###
    function startbildschirm {
        Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "║ Windows Server-Manager Tool                                                  ║"
        Write-Host "║                                                                              ║"
        Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝"
    }

### Menü ###
function netframework {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ .NET Framework 3.5                                                        ║"
            Write-Host "   ╠══════════════════════                                                     ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Möchten Sie .NET Framework installieren oder deinstallieren?              ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Installieren                 ║ [ 2 ] Deinstallieren                 ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {netframework-install}
                '2' {netframework-uninstall}
                'x' {wsmtool} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### .NET Framework 3.5 installieren ###
function netframework-install {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ .NET Framework 3.5                                                        ║"
        Write-Host "   ╠══════════════════════                                                     ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ .NET Framework 3.5 wird installiert...                                    ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Start-Sleep -Milliseconds 1500
        Install-WindowsFeature Net-Framework-Core -source \\network\share\sxs | Out-Null
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ .NET Framework 3.5                                                        ║"
            Write-Host "   ╠══════════════════════                                                     ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ .NET Framework 3.5 wurde erfolgreich installiert...                       ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
    netframework
}

### .NET Framework 3.5 deinstallieren ###
function netframework-uninstall {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ .NET Framework 3.5                                                        ║"
        Write-Host "   ╠══════════════════════                                                     ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ .NET Framework 3.5 wird deinstalliert...                                  ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Start-Sleep -Milliseconds 1500
        Uninstall-WindowsFeature Net-Framework-Core | Out-Null
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ .NET Framework 3.5                                                        ║"
            Write-Host "   ╠══════════════════════                                                     ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ .NET Framework 3.5 wurde erfolgreich deinstalliert...                     ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
    netframework
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory
$scriptpath = "\tool_srvmanager.ps1"
$fullscriptpath = $installpath + $scriptpath

### Zurück zum Windows Server Installtool ###
function wsmtool {
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
netframework