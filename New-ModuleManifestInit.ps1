<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER

.EXAMPLE

.INPUTS

.OUTPUTS

.NOTES
    Aby określić 'ClrVersion' środowiska, na którym moduł ma działać należy wydać komendę '[environment]::version'
    Aby określić 'DotNetFrameworkVersion' środowiska, na którym moduł ma działac należy wydać komendę `gci 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' | sort pschildname -des | foreach-object {$_.name; $_.GetValue("Version");}`
    Aby wygenerować nowy 'Guid' wydać komendę '[guid]::NewGuid()'
    Aby określić 'PowerShellHostName' środowiska, na którym moduł ma działać należy wydać komendę '$host.name'
    Aby określić 'PowerShellHostVersion' środowiska, na którym moduł ma działać należy wydać komendę '$host.version'
.LINK
    http://www.utom.pl
#>
param([string] $ModuleName = $(throw "ModuleName parameter is required."))

New-ModuleManifest -Path "$ENV:USERPROFILE\Documents\WindowsPowerShell\Modules\$ModuleName\$ModuleName.psd1" `
                   -Author "Tomasz Urbański" `
                   -CompanyName "UTOM" `
                   -Copyright "Copyright (c) 2012 UTOM. Wszelkie prawa zastrzeżone." `
                   -ModuleVersion "0.0.1.1" `
                   -DotNetFrameworkVersion "3.5.30729.01" `
                   -ClrVersion "2.0" `
                   -PowerShellHostVersion "2.0" `
                   -PowerShellVersion "2.0" `
                   -ModuleToProcess "" `
                   -FormatsToProcess[0] `
                   -TypesToProcess[0] `
                   -FileList[0] `
                   -NestedModules[0] `
                   -RequiredModules[0] `
                   -RequiredAssemblies[0]
<#
                   -FormatsToProcess[0] "$ENV:USERPROFILE\Documents\WindowsPowerShell\Modules\Project\ProjectFormats-wer.0.0.ps1xml" `
                   -ModuleList[0] "$ENV:USERPROFILE\Documents\WindowsPowerShell\Modules\Project\Project-wer.0.0.psm1" `
                   -TypesToProcess[0] "$ENV:USERPROFILE\Documents\WindowsPowerShell\Modules\Project\ProjectTypes-wer.0.0.ps1xml"
#>
# SIG # Begin signature block
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUHlCe1SqxCbDs5Ov3Ja79hE/v
# 3YugggI9MIICOTCCAaagAwIBAgIQtBirZz3Acb1BfUstCv49PTAJBgUrDgMCHQUA
# MCwxKjAoBgNVBAMTIVBvd2VyU2hlbGwgTG9jYWwgQ2VydGlmaWNhdGUgUm9vdDAe
# Fw0xMzA1MDYyMjExMTJaFw0zOTEyMzEyMzU5NTlaMBoxGDAWBgNVBAMTD1Bvd2Vy
# U2hlbGwgVXNlcjCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAitSmlTAETOy4
# uI7gmQoTK8zKCb8VEStM9gqQtVxcO2HfEgpTnl8NbcXsqwfjiRvQ+qUpJyO6dBaM
# /DU8ZxtKn4bBRofjMiYTH1VLqIDZweqHLQQFAmV9tKB28L9JxZKROqnuW6rD3+u1
# BGKdOEViA9ogRmDTif7evlloDHeKFqsCAwEAAaN2MHQwEwYDVR0lBAwwCgYIKwYB
# BQUHAwMwXQYDVR0BBFYwVIAQAT6NGGMwu5QiCSwIlq1wnaEuMCwxKjAoBgNVBAMT
# IVBvd2VyU2hlbGwgTG9jYWwgQ2VydGlmaWNhdGUgUm9vdIIQ1iyEzXrW9apItH1h
# a/owUTAJBgUrDgMCHQUAA4GBADv9uxMjxKwJzPtNjakjYKLVEFxujzkbs51SK/yb
# 1LamnYdJ7pgFYhsZH+6aRlC06V0CGlAnBvXlUksj289x/BLE3osm7Xc9UJBqrUXu
# B8svNR4vHgjs5GBqcFNtVe0xm5YVlCTzfTBNhpdO+W3HpEUZhf046Wgl+bJErIRH
# SEKDMYIBYDCCAVwCAQEwQDAsMSowKAYDVQQDEyFQb3dlclNoZWxsIExvY2FsIENl
# cnRpZmljYXRlIFJvb3QCELQYq2c9wHG9QX1LLQr+PT0wCQYFKw4DAhoFAKB4MBgG
# CisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcC
# AQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYE
# FNvgUf+tDZlwCqrLXfUXjUbrWeTwMA0GCSqGSIb3DQEBAQUABIGAISHklZ94w5Kd
# LLUgYj6jFivjoaH0mSaZnVMXuDa1DIn2Y1tecUqME8YK3CYydXxGekrSVIvZTp3I
# H+K91pG0m90HHIg0t+zFXQuHWQuJY+v92PE9VO+nQcBoLViAbyJkBYIp/Da9bITX
# RguDuZYGcnSpLRuteL1L49VsTYTSk2w=
# SIG # End signature block
