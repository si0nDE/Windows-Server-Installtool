    ###    Simon Fieber IT-Services    ###
    ###     Coded by: Simon Fieber     ###
    ###     Visit:  simonfieber.it     ###

Clear-Host
### Fehlermeldungen unterdrücken ###
### Mögliche Fehlermeldungen: Dateien oder Ordner können nicht gelöscht werden, da diese nicht existieren. ###
$ErrorActionPreference = "SilentlyContinue"

### Startbildschirm ###
function startbildschirm {
    Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗"
    Write-Host "║ Windows Server Install Update-Tool                                           ║"
    Write-Host "║                                                                              ║"
    Write-Host "║                                                       (c) www.simonfieber.it ║"
    Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝"
}

### Root-Verzeichnis ermitteln, zum öffnen des Programmcodes ###
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
#$installpath = Get-ScriptDirectory
$installpath = Get-ScriptDirectory

### Funktion zum Entpacken einer ZIP-Datei ###
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

### Updateroutine ###
$wsi_source  = "https://github.com/si0nDE/Windows-Server-Installtool/archive/master.zip"
$wpkt_source = "https://github.com/si0nDE/Windows-Product-Key-Tool/archive/master.zip"
$btsu_source = "https://github.com/si0nDE/Win-SystemUser/archive/master.zip"

function wsi_herunterladen {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Aktuellste Version (Windows Server Installtool) wird heruntergeladen...  ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        $error.Clear()
        try{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri $wsi_source -OutFile "$installpath\wsi.zip"}
        catch{
            Start-Sleep -Milliseconds 1500
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Das Windows Server Installtool konnte nicht heruntergeladen werden.  ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte überprüfen Sie Ihre Internetverbindung und                 ║"
            Write-Host "        ║     versuchen Sie es erneut!                                         ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Sollten Sie kein Problem feststellen können, prüfen Sie bitte    ║"
            Write-Host "        ║     auf GitHub, ob die Updateroutine ein Update erhalten hat.        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
}

function wpkt_herunterladen {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Aktuellste Version (Windows Product Key Tool) wird heruntergeladen...    ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        $error.Clear()
        try{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri $wpkt_source -OutFile "$installpath\wpkt.zip"}
        catch{
            Start-Sleep -Milliseconds 1500
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Das Windows Product Key Tool konnte nicht heruntergeladen werden.    ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte überprüfen Sie Ihre Internetverbindung und                 ║"
            Write-Host "        ║     versuchen Sie es erneut!                                         ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Sollten Sie kein Problem feststellen können, prüfen Sie bitte    ║"
            Write-Host "        ║     auf GitHub, ob die Updateroutine ein Update erhalten hat.        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
}

function btsu_herunterladen {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Aktuellste Version (Win-SystemUser) wird heruntergeladen...              ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        $error.Clear()
        try{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri $btsu_source -OutFile "$installpath\btsu.zip"}
        catch{
            Start-Sleep -Milliseconds 1500
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Win-SystemUser konnte nicht heruntergeladen werden.                  ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte überprüfen Sie Ihre Internetverbindung und                 ║"
            Write-Host "        ║     versuchen Sie es erneut!                                         ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Sollten Sie kein Problem feststellen können, prüfen Sie bitte    ║"
            Write-Host "        ║     auf GitHub, ob die Updateroutine ein Update erhalten hat.        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
}

function update_entpacken {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Updates werden entpackt...                                               ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        $error.Clear()
        try{Unzip "$installpath\wsi.zip" "$installpath"}
        catch{
            Start-Sleep -Milliseconds 1500
            Remove-Item "$installpath\wsi.zip"
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Das Windows Server Installtool konnte nicht entpackt werden.         ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte starten Sie dieses Script als Administrator erneut!        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
        try{Unzip "$installpath\wpkt.zip" "$installpath"}
        catch{
            Start-Sleep -Milliseconds 1500
            Remove-Item "$installpath\wpkt.zip"
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Das Windows Product Key Tool konnte nicht entpackt werden.           ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte starten Sie dieses Script als Administrator erneut!        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
        try{Unzip "$installpath\btsu.zip" "$installpath"}
        catch{
            Start-Sleep -Milliseconds 1500
            Remove-Item "$installpath\btsu.zip"
            Write-Host ""
            Write-Host "        ╔══════════════════════════════════════════════════════════════════════╗"
            Write-Host "        ║ Win-SystemUser konnte nicht entpackt werden.                         ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ║     Bitte starten Sie dieses Script als Administrator erneut!        ║"
            Write-Host "        ║                                                                      ║"
            Write-Host "        ╚══════════════════════════════════════════════════════════════════════╝"
            Start-Sleep -Milliseconds 3500
            update_fehlgeschlagen
        }
        Start-Sleep -Milliseconds 1000
        Remove-Item "$installpath\wsi.zip"
        Remove-Item "$installpath\wpkt.zip"
        Remove-Item "$installpath\btsu.zip"
}

function update_installieren {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Updates werden installiert...                                            ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Remove-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\update.ps1"
        Remove-Item "$installpath\scripts\" -Recurse
        Start-Sleep -Milliseconds 3000
        New-Item "$installpath\scripts\" -ItemType directory | Out-Null
        Move-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\scripts\*" "$installpath\scripts\" -Force
        Move-Item "$installpath\Windows-Server-Installtool-master\Windows-Server-Installtool\*" "$installpath" -Force
        Move-Item "$installpath\Windows-Product-Key-Tool-master\Windows-Product-Key-Tool.ps1" "$installpath\scripts\tool_productkey.ps1"
        Move-Item "$installpath\Win-SystemUser-master\Win-SystemUser\Be_the_System.ps1" "$installpath\scripts\script_win-systemUser.ps1"
}

function update_aufraeumen {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Aufräumen...                                                             ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 1000
        Remove-Item "$installpath\Windows-Server-Installtool-master\" -Recurse
        Remove-item "$installpath\Windows-Product-Key-Tool-master\" -Recurse
        Remove-Item "$installpath\Win-SystemUser-master\" -Recurse
}

function update_fertigstellen {
    Clear-Host
    startbildschirm
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Update fertiggestellt!                                                   ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ║     Programm wird beendet...                                             ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 5000
    [Environment]::Exit(1)
}

function update_fehlgeschlagen {
        Write-Host "            ╔══════════════════════════════════════════════════════════════════╗"
        Write-Host "            ║ Programm wird beendet...                                         ║"
        Write-Host "            ║                                                                  ║"
        Write-Host "            ╚══════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 5000
    [Environment]::Exit(1)
}

if($installpath -like "*\GitHub\Windows-Server-Installtool\*") {
    Clear-Host
    startbildschirm
        Start-Sleep -Milliseconds 500
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Update scheint in der Entwicklungsumgebung ausgeführt zu werden.         ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ║     Programm wird beendet...                                             ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 5000
        [Environment]::Exit(1)
} elseif($PSVersionTable.PSVersion -lt "3.0") {
    Clear-Host
    startbildschirm
        Start-Sleep -Milliseconds 500
        Write-Host "    ╔══════════════════════════════════════════════════════════════════════════╗"
        Write-Host "    ║ Das Update-Tool benötigt PowerShell-Version 3.0 oder höher.              ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ║ Bitte aktualisieren Sie Ihre PowerShell-Umgebung oder laden Sie das      ║"
        Write-Host "    ║ Update manuell von GitHub herunter: https://github.com/si0nDE/           ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ║     Programm wird beendet...                                             ║"
        Write-Host "    ║                                                                          ║"
        Write-Host "    ╚══════════════════════════════════════════════════════════════════════════╝"
        Start-Sleep -Milliseconds 5000
        [Environment]::Exit(1)
} else {
    Start-Sleep -Milliseconds  500
    wsi_herunterladen
    Start-Sleep -Milliseconds 1500
    wpkt_herunterladen
    Start-Sleep -Milliseconds 1500
    btsu_herunterladen
    Start-Sleep -Milliseconds 1500
    update_entpacken
    Start-Sleep -Milliseconds  500
    update_installieren
    Start-Sleep -Milliseconds 1500
    update_aufraeumen
    Start-Sleep -Milliseconds 1500
    update_fertigstellen
}
# SIG # Begin signature block
# MIIRXQYJKoZIhvcNAQcCoIIRTjCCEUoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUYIUVsLdRzh/Foxm1/wdSqbF+
# AVSggg28MIIGuTCCBKGgAwIBAgIRAJmjgAomVTtlq9xuhKaz6jkwDQYJKoZIhvcN
# AQEMBQAwgYAxCzAJBgNVBAYTAlBMMSIwIAYDVQQKExlVbml6ZXRvIFRlY2hub2xv
# Z2llcyBTLkEuMScwJQYDVQQLEx5DZXJ0dW0gQ2VydGlmaWNhdGlvbiBBdXRob3Jp
# dHkxJDAiBgNVBAMTG0NlcnR1bSBUcnVzdGVkIE5ldHdvcmsgQ0EgMjAeFw0yMTA1
# MTkwNTMyMThaFw0zNjA1MTgwNTMyMThaMFYxCzAJBgNVBAYTAlBMMSEwHwYDVQQK
# ExhBc3NlY28gRGF0YSBTeXN0ZW1zIFMuQS4xJDAiBgNVBAMTG0NlcnR1bSBDb2Rl
# IFNpZ25pbmcgMjAyMSBDQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
# AJ0jzwQwIzvBRiznM3M+Y116dbq+XE26vest+L7k5n5TeJkgH4Cyk74IL9uP61ol
# RsxsU/WBAElTMNQI/HsE0uCJ3VPLO1UufnY0qDHG7yCnJOvoSNbIbMpT+Cci75sc
# Cx7UsKK1fcJo4TXetu4du2vEXa09Tx/bndCBfp47zJNsamzUyD7J1rcNxOw5g6FJ
# g0ImIv7nCeNn3B6gZG28WAwe0mDqLrvU49chyKIc7gvCjan3GH+2eP4mYJASflBT
# Q3HOs6JGdriSMVoD1lzBJobtYDF4L/GhlLEXWgrVQ9m0pW37KuwYqpY42grp/kSY
# E4BUQrbLgBMNKRvfhQPskDfZ/5GbTCyvlqPN+0OEDmYGKlVkOMenDO/xtMrMINRJ
# S5SY+jWCi8PRHAVxO0xdx8m2bWL4/ZQ1dp0/JhUpHEpABMc3eKax8GI1F03mSJVV
# 6o/nmmKqDE6TK34eTAgDiBuZJzeEPyR7rq30yOVw2DvetlmWssewAhX+cnSaaBKM
# Ej9O2GgYkPJ16Q5Da1APYO6n/6wpCm1qUOW6Ln1J6tVImDyAB5Xs3+JriasaiJ7P
# 5KpXeiVV/HIsW3ej85A6cGaOEpQA2gotiUqZSkoQUjQ9+hPxDVb/Lqz0tMjp6RuL
# SKARsVQgETwoNQZ8jCeKwSQHDkpwFndfCceZ/OfCUqjxAgMBAAGjggFVMIIBUTAP
# BgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBTddF1MANt7n6B0yrFu9zzAMsBwzTAf
# BgNVHSMEGDAWgBS2oVQ5AsOgP46KvPrU+Bym0ToO/TAOBgNVHQ8BAf8EBAMCAQYw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMwMAYDVR0fBCkwJzAloCOgIYYfaHR0cDovL2Ny
# bC5jZXJ0dW0ucGwvY3RuY2EyLmNybDBsBggrBgEFBQcBAQRgMF4wKAYIKwYBBQUH
# MAGGHGh0dHA6Ly9zdWJjYS5vY3NwLWNlcnR1bS5jb20wMgYIKwYBBQUHMAKGJmh0
# dHA6Ly9yZXBvc2l0b3J5LmNlcnR1bS5wbC9jdG5jYTIuY2VyMDkGA1UdIAQyMDAw
# LgYEVR0gADAmMCQGCCsGAQUFBwIBFhhodHRwOi8vd3d3LmNlcnR1bS5wbC9DUFMw
# DQYJKoZIhvcNAQEMBQADggIBAHWIWA/lj1AomlOfEOxD/PQ7bcmahmJ9l0Q4SZC+
# j/v09CD2csX8Yl7pmJQETIMEcy0VErSZePdC/eAvSxhd7488x/Cat4ke+AUZZDtf
# Cd8yHZgikGuS8mePCHyAiU2VSXgoQ1MrkMuqxg8S1FALDtHqnizYS1bIMOv8znyJ
# jZQESp9RT+6NH024/IqTRsRwSLrYkbFq4VjNn/KV3Xd8dpmyQiirZdrONoPSlCRx
# CIi54vQcqKiFLpeBm5S0IoDtLoIe21kSw5tAnWPazS6sgN2oXvFpcVVpMcq0C4x/
# CLSNe0XckmmGsl9z4UUguAJtf+5gE8GVsEg/ge3jHGTYaZ/MyfujE8hOmKBAUkVa
# 7NMxRSB1EdPFpNIpEn/pSHuSL+kWN/2xQBJaDFPr1AX0qLgkXmcEi6PFnaw5T17U
# dIInA58rTu3mefNuzUtse4AgYmxEmJDodf8NbVcU6VdjWtz0e58WFZT7tST6EWQm
# x/OoHPelE77lojq7lpsjhDCzhhp4kfsfszxf9g2hoCtltXhCX6NqsqwTT7xe8LgM
# kH4hVy8L1h2pqGLT2aNCx7h/F95/QvsTeGGjY7dssMzq/rSshFQKLZ8lPb8hFTmi
# GDJNyHga5hZ59IGynk08mHhBFM/0MLeBzlAQq1utNjQprztZ5vv/NJy8ua9AGbwk
# MWkOMIIG+zCCBOOgAwIBAgIQK+f7Uy5kD1jz1bwdP/CqHjANBgkqhkiG9w0BAQsF
# ADBWMQswCQYDVQQGEwJQTDEhMB8GA1UEChMYQXNzZWNvIERhdGEgU3lzdGVtcyBT
# LkEuMSQwIgYDVQQDExtDZXJ0dW0gQ29kZSBTaWduaW5nIDIwMjEgQ0EwHhcNMjEw
# ODA0MTAyOTMyWhcNMjIwODA0MTAyOTMyWjCBoDELMAkGA1UEBhMCREUxDzANBgNV
# BAgMBkJheWVybjEWMBQGA1UEBwwNR3VlbnRlcnNsZWJlbjEhMB8GA1UECgwYU2lt
# b24gRmllYmVyIElULVNlcnZpY2VzMSEwHwYDVQQDDBhTaW1vbiBGaWViZXIgSVQt
# U2VydmljZXMxIjAgBgkqhkiG9w0BCQEWE2luZm9Ac2ltb25maWViZXIuaXQwggIi
# MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDm+xOZMZ4kHCyDIUYBA8szgRqt
# HWixxhwkF/eA7Jn2bMvbqCraMaLCAawWrPS+5z+Fj0tRt7hShS015AtGIDRC3PLr
# XHZbpgAWMxNr2F8VKCtYckK0wCJgUjSIFa0BkyUMBdlX5Qb1WKGTDdpdLXRqmPB1
# 4RxkHO6hb6IzSIq9GYoIETi+bk5JKoIgQjOT6FiLTfS84U2Ji+g79iPVGL9YXezQ
# iXByxRnimQQwgjfV12dIos84eT15lWZ1fX/MqH4ueDLeAWfUNW32otNfcXDjksf7
# iZphw16HeFrI2HTrcos0qFuM7zVwpnt7aEV0NIq0fOmvgbHfq36pRHRugseUXTi9
# Osbg7AIQK09JKO6Fcrf3EVGeiJXlvfI/zmZ2YpejCCbo+mta3lZOCkvnsIPkGVek
# RqquOYmqjPrAqt0aSsL/eKkEot/oZjnxfv0KbkH/WSJSTALFHfQnyK1luwtLFv4F
# +hJ9RLEA17EjhFBqi6HsQpncK+x6OW986M6jWUnH1r4xmkmersruOatodyCARaFt
# 20syCwwIgiWVAwiin3iRhtu122DyG/THxAuGhDqW4akLQ7MVYyRy+ecpv0/qsMPQ
# HYnX37sniVKcTD8I3fwQsoCsde12ybPMqxOW0O5pGlWumD2FUzhiuoeUWvKIcuNX
# PVrrCnOMkArwm2I6mQIDAQABo4IBeDCCAXQwDAYDVR0TAQH/BAIwADA9BgNVHR8E
# NjA0MDKgMKAuhixodHRwOi8vY2NzY2EyMDIxLmNybC5jZXJ0dW0ucGwvY2NzY2Ey
# MDIxLmNybDBzBggrBgEFBQcBAQRnMGUwLAYIKwYBBQUHMAGGIGh0dHA6Ly9jY3Nj
# YTIwMjEub2NzcC1jZXJ0dW0uY29tMDUGCCsGAQUFBzAChilodHRwOi8vcmVwb3Np
# dG9yeS5jZXJ0dW0ucGwvY2NzY2EyMDIxLmNlcjAfBgNVHSMEGDAWgBTddF1MANt7
# n6B0yrFu9zzAMsBwzTAdBgNVHQ4EFgQUIzrD/5N54VPjxHO768m1ymTqLV0wSwYD
# VR0gBEQwQjAIBgZngQwBBAEwNgYLKoRoAYb2dwIFAQQwJzAlBggrBgEFBQcCARYZ
# aHR0cHM6Ly93d3cuY2VydHVtLnBsL0NQUzATBgNVHSUEDDAKBggrBgEFBQcDAzAO
# BgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQADggIBAI/KUDeMk8Idqgld5ZcB
# QWK739RntT3JqhWk7dsRYT0XLQHGRrQylhtiAh4ZhaTilsk5VDSjH2jRBgGj6XcU
# /q5WMDVn2UG3jdTVgDa7PWmHC2H3t6OC+b1MF/94wFT3uJrMdv7iCWrH4EDqh4lv
# BHUlzw/NuhFm8xvHyqqYmkvXYb9OZuoZ6JdlXWha0cvDf43aTimhE253u4KIbfGA
# mGyip7T28FLB2Jufw7hFVFMfxKCw+0oMeA8livvv3C56w+BaHh5uLY2qUmIK13CC
# 44NwM0Yv5Zd6VJsJL1XY54GI14UjyM0RsbEzVCGYMVra4GQhp8VFVOKdWTxNqQuX
# 97F+M0VJ5GO+SCQr/SHDUen1lp1+0Qq3hDN6YeyKu0BjWrYYv1+MzCWgdI5pcMgg
# F+A63Hg3YeJHRWzHCLvrEpwsL9m+Q6fas5PXexfCKTYY9IhQskGbJ85t8psvOJsl
# fVU3FOgTKrpwgFoGHdTeSoJcw6phf8fWYKoKzv7s1yzo1hMnmE5u2ku4hXeDSVV8
# 1moKrA3Gm3Icbib72Ph15zUP56SWdEoaVNhuHxd4jNxF2dpwr7gkh9i85BDaKXhA
# ZQ5f4imYzCyGXNysWseNdNuUXEWxqcIoa5VBXGjjU3XM43Oh6GvdMU/uq8wg7UaM
# oNhpHDcLf+7hygjhADo/sfB9MYIDCzCCAwcCAQEwajBWMQswCQYDVQQGEwJQTDEh
# MB8GA1UEChMYQXNzZWNvIERhdGEgU3lzdGVtcyBTLkEuMSQwIgYDVQQDExtDZXJ0
# dW0gQ29kZSBTaWduaW5nIDIwMjEgQ0ECECvn+1MuZA9Y89W8HT/wqh4wCQYFKw4D
# AhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwG
# CisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZI
# hvcNAQkEMRYEFN4QyJJSxdatAM7CUjYUbFZcJ1dMMA0GCSqGSIb3DQEBAQUABIIC
# ALB5erAWP62roPf51w/d/7lqLQmyOkr8bRxt8qZxUpnFV1xx9C8jZHYpxiIndsAU
# NHq/nXd+/SJqysW6mPFR4S/KFWEymIIfcaw3VJD2FxFYu4Fdtp1vxh6mCFJpcVgb
# XKZ39NpX42Cryct36IayiB1lkVr4OwjYdN7Rs2kWLDxspdY7SC9+gQtMQCi2KxGH
# C+as7kgVuWT8w8v02Yn3pRjNnoWJX+wJaINVGTYjKpfppChnwo4aiu0pmI05FqgR
# ObG0uYPtMNKMJQqwxpOig4zu1VfHtQbsUFyDOWkaMsGb9xPh7xdyC0Pi2WW5WtyL
# /TvpCWvhlayZZguOcpXts7S1HG6tOeFG174lEKOxVObgbb0CxVHvQOuYFGGvHZZf
# n+hZ9r9SIGS/TpvVqOhUVslt8+/aAnDZg7Js/3xcIcbs5PzfgRa20B3HiaPj3Wsd
# GhedEpSOjB2TLtEK0lcW6orFl7JoBSjspJe5/eRGnbd9S6iG13VsApXuH5wNngdG
# L8pTLjLJXqt5hFjn8TwplH0Os9Z1PGxWW7F3rIgD9lJJML+D+u2Om/rIazVNLSlm
# VdQlTfEgb/e4o5lk3f9A2RPshmOi+lR1j2V56NzJoZqnn3GCmQuRWWX2jdx+MRhU
# 4aEtyYA3mWrH37z2vygXJofiGmcuHmGrYLsXQZQmlXMQ
# SIG # End signature block
