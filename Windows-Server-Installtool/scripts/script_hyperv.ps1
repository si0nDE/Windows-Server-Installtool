    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

Clear-Host

### Startbildschirm ###
    function startbildschirm {
        Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "║ Windows Server-Manager Tool                                                  ║"
        Write-Host "║                                                                              ║"
        Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝"
    }

### Menü ###
function hyperv {
    do {
        Clear-Host
        startbildschirm
            Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
            Write-Host "   ║ Hyper-V                                                                   ║"
            Write-Host "   ╠═══════════                                                                ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ Was möchten Sie tun?                                                      ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ║ [ 1 ] Virtuelle Maschine erstellen                                        ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╠═══════════════════════════════════════════════════════════════════════════╣"
            Write-Host "   ║ [ X ] Zurück zum Hauptmenü                                                ║"
            Write-Host "   ║                                                                           ║"
            Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
            Write-Host ""
            $input = Read-Host "Bitte wählen Sie"

            switch ($input) {
                '1' {hyperv-createVM}
                'x' {wsitool} # Zurück ins Hauptmenü #
                '0' {wsitool} # Zurück ins Hauptmenü #
            } pause }
        until ($input -eq 'x')
}

### Virtuelle Maschine erstellen ###
function hyperv-createVM {
    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hyper-V                                                                   ║"
        Write-Host "   ╠═══════════                                                                ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Wie soll die neue virtuelle Maschine heißen?                              ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $VMname = Read-Host "Name"
        Start-Sleep -Milliseconds 1500

    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hyper-V                                                                   ║"
        Write-Host "   ╠═══════════                                                                ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Wie viel Arbeitsspeicher soll die neue virtuelle Maschine erhalten?       ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║     Bitte geben Sie einen Wert inkl. der Maßeinheit ein, z. B.:           ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║     4GB für 4 Gigabyte oder 100MB für 100 Megabyte                        ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $VMram = Read-Host "Arbeitsspeicher"
        Start-Sleep -Milliseconds 1500

    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hyper-V                                                                   ║"
        Write-Host "   ╠═══════════                                                                ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Wo soll die virtuelle Festplatte gespeichert werden?                      ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║     Bitte geben Sie den vollständigen Dateipfad an, z. B.:                ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║     D:\VHDs\Win10.vhdx                                                    ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $VMvhdpath = Read-Host "Speicherort"
        Start-Sleep -Milliseconds 1500

    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hyper-V                                                                   ║"
        Write-Host "   ╠═══════════                                                                ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Welche Generation soll die virtuelle Maschine erhalten?                   ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║     Bitte wählen Sie '1' für Generation 1 oder '2' für Generation 2.      ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        $VMgeneration = Read-Host "Generation"
        Start-Sleep -Milliseconds 1500
    
    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hyper-V                                                                   ║"
        Write-Host "   ╠═══════════                                                                ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Welcher virtuelle Switch soll der virtuellen Maschine zugewiesen werden?  ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Get-VMSwitch * | Format-Table Name
        Write-Host ""
        $VMswitch = Read-Host "Virtueller Switch"
        Start-Sleep -Milliseconds 1500
    
    Clear-Host
    startbildschirm
        Write-Host "   ╔═══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "   ║ Hyper-V                                                                   ║"
        Write-Host "   ╠═══════════                                                                ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ║ Virtuelle Maschine wird angelegt...                                       ║"
        Write-Host "   ║                                                                           ║"
        Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════╝"
        Write-Host ""
        Start-Sleep -Milliseconds 1500

        New-VM -Name $VMname -MemoryStartupBytes $VMram -BootDevice VHD -VHDPath $VMvhdpath -Generation $VMgeneration -Switch $VMswitch
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
hyperv