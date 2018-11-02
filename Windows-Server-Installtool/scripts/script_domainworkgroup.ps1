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

### Arbeitsgruppe/Domäne beitreten - Menü ###
function Start-WorkgroupDomain-Tool {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Arbeitsgruppe/Domäne beitreten                                            ║"
            Write-Host "   ╠══════════════════════════════════                                         ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Möchten Sie einer Arbeitsgruppe oder einer Domäne beitreten?              ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Arbeitsgruppe                ║ [ 2 ] Domäne                         ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Join-Workgroup}
                '2' {Join-Domain}
                'x' {wsitool} # Zurück ins Hauptmenü #
                '0' {wsitool} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### Arbeitsgruppe beitreten ###
function Join-Workgroup {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Arbeitsgruppe beitreten                                                   ║"
        Write-Host "   ╠═══════════════════════════                                                ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Geben Sie die Arbeitsgruppe ein, der Sie beitreten möchten...             ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $neuearbeitsgruppe = Read-Host "Neue Arbeitsgruppe"
        Start-Sleep -Milliseconds 1500
        $error.Clear()
        try{$computerinfo.JoinDomainOrWorkgroup("$neuearbeitsgruppe") | Out-Null}
        catch{
            cls
            startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Arbeitsgruppe beitreten                                                   ║"
            Write-Host "   ╠═══════════════════════════                                                ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Die Arbeitsgruppe konnte nicht geändert werden.                           ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║     Bitte wenden Sie sich an Ihren Systemadministrator!                   ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
        }
        if (!$error) {
            cls
            startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Arbeitsgruppe beitreten                                                   ║"
            Write-Host "   ╠═══════════════════════════                                                ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Die Arbeitsgruppe wurde erfolgreich geändert.                             ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║     Ein Neustart ist erforderlich!                                        ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
        }
    wsitool
}

### Domäne beitreten ###
function Join-Domain {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Domäne beitreten                                                          ║"
        Write-Host "   ╠════════════════════                                                       ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Geben Sie die Domäne ein, der Sie beitreten möchten...                    ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $neuedomaene = Read-Host "Neue Domäne"
        $benutzername = Read-Host "Benutzername"
        Start-Sleep -Milliseconds 1500
        $error.Clear()
        try{Add-Computer -DomainName $neuedomaene -Credential $neuedomaene\$benutzername | Out-Null}
        catch{
            cls
            startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Domäne beitreten                                                          ║"
            Write-Host "   ╠════════════════════                                                       ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Der Domäne konnte nicht beigetreten werden.                               ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║     Bitte wenden Sie sich an Ihren Systemadministrator!                   ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
        }
        if (!$error) {
            cls
            startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Domäne beitreten                                                          ║"
            Write-Host "   ╠════════════════════                                                       ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Die Domäne wurde erfolgreich geändert.                                    ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║     Ein Neustart ist erforderlich!                                        ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3000
        }
    wsitool
        
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
Start-WorkgroupDomain-Tool