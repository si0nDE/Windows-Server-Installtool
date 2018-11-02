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

### Cortana & Bing-Suche aktivieren/deaktivieren ###
function Start-Cortana-Tool {
    do {
        cls
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Cortana & Bing-Suche                                                      ║"
            Write-Host "   ╠════════════════════════                                                   ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Möchten Sie Cortana und die Bing-Suche aktivieren oder deaktivieren?      ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Aktivieren (Standard)        ║ [ 2 ] Deaktivieren                   ║"
            Write-Host "   ║                                    ║                                      ║"
            Write-Host "   ╠════════════════════════════════════╩══════════════════════════════════════╣"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Windows Search" -Name AllowCortana
                     Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name BingSearchEnabled
                     Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name CortanaConsent
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Cortana & Bing-Suche                                                      ║"
                    Write-Host "   ╠════════════════════════                                                   ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ Cortana und die Bing-Suche wurden aktiviert.                              ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Stop-Process -ProcessName explorer
                    $explorer = gwmi -computer . -query "select * from win32_process where CommandLine!='explorer.exe' And name='explorer.exe'"
                    foreach ($explorer in $explorer) {
                        $explorer.terminate()
                    }
                    Start-Sleep -Milliseconds 3000
                    wsitool}
                '2' {New-ItemProperty -Type DWord -Path "HKCU:\Software\Policies\Microsoft\Windows\Windows Search" -Name AllowCortana -value "0"
                     New-ItemProperty -Type DWord -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name BingSearchEnabled -value "0"
                     New-ItemProperty -Type DWord -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name CortanaConsent -value "0"
                    cls
                    startbildschirm
                    Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
                    Write-Host "   ║ Cortana & Bing-Suche                                                      ║"
                    Write-Host "   ╠════════════════════════                                                   ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ║ Cortana und die Bing-Suche wurden deaktiviert.                            ║"
                    Write-Host "   ║                                                                           ║"
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
                    Stop-Process -ProcessName explorer
                    $explorer = gwmi -computer . -query "select * from win32_process where CommandLine!='explorer.exe' And name='explorer.exe'"
                    foreach ($explorer in $explorer) {
                        $explorer.terminate()
                    }
                    Start-Sleep -Milliseconds 3000
                    wsitool}
                'x' {wsitool} # Zurück ins Hauptmenü #
                '0' {wsitool} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
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
Start-Cortana-Tool