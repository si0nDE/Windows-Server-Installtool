﻿    ###    Simon Fieber IT-Services    ###
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
# SIG # Begin signature block
# MIIRXQYJKoZIhvcNAQcCoIIRTjCCEUoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU7KdaWEOCJnUxk2bHYuqYY5cB
# XjGggg28MIIGuTCCBKGgAwIBAgIRAJmjgAomVTtlq9xuhKaz6jkwDQYJKoZIhvcN
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
# hvcNAQkEMRYEFOqScmX0Egah6hLV4lX/IbJXKUTrMA0GCSqGSIb3DQEBAQUABIIC
# ANOroW2aRUrbpMxg9n2IUaCF/Y2Prpnt5fmLJq5pWJJHYrEv5NthtH2ZhVWwwf/K
# FC1yMXcAI++hQ9ZZrF5EaVWIjw0+sXFg/3FOqw972sndL91XVOeFY6qjrvxND1ma
# dUfWxEpNzkqcBGm1msqzlP9mHL7ze9IVtUFdPlilwLTPiYHgyLSbne6G8UOg/N6X
# /ENWdLgDmOzKEkp8a2sNj1TDQ49CdolNlT5dp6UAh52ldHo0rUhMoQDUSFlnasyk
# 3HXmWRQVUqUQP1VegN40HqmfuKjEwnoFWppBXFqWBxyoXXfUCtk5gk+FL75AoYQm
# IObIw9NQ0X+bsu77ZjJOcBdr9wYlPmIVh7l5CCPzlv0FHgO4k4TkdjP+oeNHuFMn
# 9MHGDh2O0iWJoQ9rCCVenk4k1Zyxb9ikL7GXpXc9n7UlRf7e4AuF3TAxUgqy4EvW
# IbYN5gNzdfJLwtzztVBZLHKD6NYYz5vSm3BUeTHPyZ4S4cUMw1Sv7sMIlSL9yZ4Y
# uYuEu1QmEsqacegdpWPdf2jFE55JIWDnitqCTz2QMi4HSPuY4TAFSFNEs3xaipys
# eE2GYP9PO1IkFpiiRPZUaSjVVgBkv/tVl+q5ONdBarZmwgq31f2za53h+MByhhtW
# YVI0pNncA2Ggac7+yVpqme9fLtswW5eAb+TGow7qmS99
# SIG # End signature block
