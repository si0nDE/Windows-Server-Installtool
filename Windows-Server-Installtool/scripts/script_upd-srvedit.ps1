    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

cls

### Startbildschirm ###
function startbildschirm {
        Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "║ Windows Product Key Tool                                                     ║"
        Write-Host "║                                                                              ║"
        Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝"
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
$installpath = Get-ScriptDirectory

$UpdateEdition = ''
$WunschEdition = ''
$ProductKey = ''

function Get-Edition {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows-Edition aktualisieren                                             ║"
        Write-Host "   ╠═════════════════════════════════                                          ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Mögliche Editionen zum aktualisieren werden abgefragt...                  ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        $UpdateEdition = DISM /online /Get-TargetEditions

        edition_auswahl
}

function edition_auswahl {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows-Edition aktualisieren                                             ║"
        Write-Host "   ╠═════════════════════════════════                                          ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Wir haben folgende Rückmeldung erhalten:                                  ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $UpdateEdition
        Write-Host ""
        Start-Sleep -Milliseconds 1500
        Write-Host "      ╔════════════════════════════════════════════════════════════════════════╗"
        Write-Host "      ║ Windows-Edition aktualisieren                                          ║"
        Write-Host "      ╠═════════════════════════════════                                       ║"
        Write-Host "      ║                                                                        ║"
        Write-Host "      ║ Welche Edition möchten Sie aktualisieren?                              ║"
        Write-Host "      ║                                                                        ║"
        Write-Host "      ║ Geben Sie die gewünschte Edition genau so ein, wie sie                 ║"
        Write-Host "      ║ oben angegeben wird.                                                   ║"
        Write-Host "      ║                                                                        ║"
        Write-Host "      ╚════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $WunschEdition = Read-Host "      Gewünschte Edition"

        Start-Sleep -Milliseconds 1500
        edition_productkey
}

function edition_productkey {
    cls
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows-Edition aktualisieren                                             ║"
        Write-Host "   ╠═════════════════════════════════                                          ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Bitte geben Sie den gewünschten Product Key im folgenden Format ein:      ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║     XXXXX-XXXXX-XXXXX-XXXXX-XXXXX                                         ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $ProductKey = Read-Host "Geben Sie den Product Key für $WunschEdition ein"

        Start-Sleep -Milliseconds 1500
        edition_uebersicht
}

function edition_uebersicht {
    cls
        startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows-Edition aktualisieren                                             ║"
        Write-Host "   ╠═════════════════════════════════                                          ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Windows wird aktualisiert...                                              ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Start-Sleep -Milliseconds 1500
        Write-Host "Windows Server-Edition: $WunschEdition"
        Start-Sleep -Milliseconds 1500
        Write-Host "Windows Product-Key:    $ProductKey"

        Start-Sleep -Milliseconds 3000
        edition_update
}

function edition_update {
    cls
        startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Windows-Edition aktualisieren                                             ║"
        Write-Host "   ╠═════════════════════════════════                                          ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Windows wird aktualisiert...                                              ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Start-Sleep -Milliseconds 1500
        DISM /online /Set-Edition:$WunschEdition /ProductKey:$ProductKey /AcceptEULA
        Write-Host ""
        Write-Host ""

        pause
        backtoscript
}

### Zurück zum Script ###
function backtoscript {
    Start-Sleep -Milliseconds 1500
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)
    if(!$princ.IsInRole( `
        [System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
            $powershell = [System.Diagnostics.Process]::GetCurrentProcess()
            $psi = New-Object System.Diagnostics.ProcessStartInfo $powerShell.Path
            $script = "$installpath\tool_productkey.ps1"
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
    & "$installpath\tool_productkey.ps1"
}

### Start ###
Get-Edition