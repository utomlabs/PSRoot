<#
.SYNOPSIS
    New-ScriptInit -ScriptName [String]
.DESCRIPTION
    Skrypt służący do tworzenia i wstępnego wypełnienia podstawowych elementów skryptu zgodnie z przyjętymi przeze mnie standadrami.
.PARAMETER  <ScriptName>
    ScriptName 
    
    Nazwa skryptu (bez rozszerzenia).
.EXAMPLE
    New-ScriptInit -ScriptName NowySkrypt
.EXAMPLE
    New-ScriptInit -SN NowySkrypt
.EXAMPLE
    "NowySkrypt" | New-ScriptInit
.INPUTS
    Nazwa skryptu (bez rozszerzenia).
.OUTPUTS
    Obiekt związany z utworzonym plikiem.
.NOTES
    Brak
.LINK
    http://www.utom.pl
.COMPONENT
    Brak
.ROLE
    Brak
.FUNCTIONALITY
    Skrypt służący do tworzenia i wstępnego wypełnienia podstawowych elementów skryptu zgodnie z przyjętymi przeze mnie standadrami.
#>
param
    (
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, HelpMessage="Nazwa skryptu.")]
    [Alias("SN")]
    [ValidateLength(1,254)]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^\S([a-z]|[A-Z]|[0-9]|\.|-|_)*")]
    [String]$ScriptName
    )

Set-StrictMode -Version Latest

$ScriptContent = "## .ExternalHelp $(Get-Location)\$ScriptName.ps1-help.xml`n" + @'
Param
  (
    [Parameter(Mandatory=$true, ValueFromPipeline=$false, HelpMessage="P1Msg?")]
    [Alias("p1")]
    [ValidateLength(1,254)]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^\S([a-z]|[A-Z]|[0-9]|\.|-|_)*")]
    [String]$Param1,
    
    [Parameter(Mandatory=$true, ValueFromPipeline=$false, HelpMessage="P2Msg?")]
    [Alias("p2")]
    [ValidateLength(1,254)]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^\S([a-z]|[A-Z]|[0-9]|\.|-|_)*")]
    [String]$Param2
  )
  
Set-StrictMode -Version Latest

Import-LocalizedData -BindingVariable MsgTable

function Main
{
  Clear-History
  Clear-Host
  
  Init-Modules
  
'@ + '$RootLog = Start-LoggerSvc -Configuration ".\' + $ScriptName + '.ps1.config"' + @'
  
  $RootLog.Info($MsgTable.StartMsg)
  
  Write-Output "Hello World"

  $RootLog.Info($MsgTable.StopMsg)

  Stop-LoggerSvc
  Clear-Modules
}

function Helper-Function{
Param
  (
    [Parameter(Mandatory=$true, ValueFromPipeline=$false, HelpMessage="P1Msg?")]
    [Alias("p1")]
    [ValidateLength(1,254)]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^\S([a-z]|[A-Z]|[0-9]|\.|-|_)*")]
    [String]$Param1,
    
    [Parameter(Mandatory=$true, ValueFromPipeline=$false, HelpMessage="P2Msg?")]
    [Alias("p2")]
    [ValidateLength(1,254)]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^\S([a-z]|[A-Z]|[0-9]|\.|-|_)*")]
    [String]$Param2
  )
$NewScriptLog = Get-Logger -ln HlpFncLoggerName

$NewScriptLog.Info($MsgTable.HlpFncStartMsg)
# <-- tu piszę dalej kod
$NewScriptLog.Info($MsgTable.HlpFncStopMsg)
}

function Init-Modules {
  try{
    $Script:ModList = New-Object System.Collections.ArrayList
    [void] $ModList.Add(@(Import-Module -Name PSLog -ArgumentList "..\..\Libs\log4net\bin\net\3.5\release\log4net.dll" -Force -PassThru))
  }
  catch [System.Management.Automation.RuntimeException] {
    switch($_.Exception.Message){
      "Log4net library cannot be found on the path" {
        Write-Error $MsgTable.Log4NetPathMsg
      }
      default {
        Write-Error $MsgTable.DefaultNegMsg
      }
    }
  }
  catch {
    "*"*80
    $_.Exception.GetType().FullName
    $_.Exception.Message
    "*"*80
    Exit
  }
}

function Clear-Modules{
  $ModList | %{Remove-Module $_}
}

. Main
'@

New-Item -Path . -Name "$ScriptName.ps1" -ItemType "file" -Value $ScriptContent
& $home"\Documents\WindowsPowerShell\Add-Signature" ".\$ScriptName.ps1"

$HelpContent = & $home"\Documents\WindowsPowerShell\Modules\PsMAML\New-Maml" ".\$ScriptName.ps1"
$HelpContent.Declaration.ToString() | out-file ".\$ScriptName.ps1-help.xml" -encoding "UTF8"
$HelpContent.ToString() | out-file ".\$ScriptName.ps1-help.xml" -encoding "UTF8" -append

New-Item -Path . -Name "pl-PL" -ItemType "directory"
New-Item -Path .\pl-PL -Name $ScriptName".psd1" -ItemType "file" -Value "ConvertFrom-StringData @'`n`tStartMsg = Msg;Start`n`tStopMsg = Msg;Stop`n`tDefaultNegMsg = Wrrr`n`tLog4NetPathMsg = Sprawdź poprawność ścieżki dostępu do biblioteki DLL log4net.dll`n'@"

New-Item -Path . -Name "Logs" -ItemType "directory"

$LoggerCfgFileContent = @'
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
    <configSections>
        <section name="log4net" type="System.Configuration.IgnoreSectionHandler" />
    </configSections>
    <log4net>
        <appender name="LogFileAppender" type="log4net.Appender.FileAppender">
            <param name="File" value="
'@ + "$(Get-Location)\Logs\LogTest01.txt"" />`n" + @'
            <param name="AppendToFile" value="true" />
            <layout type="log4net.Layout.PatternLayout">
                <param name="ConversionPattern" value="%date [%thread] %-5level %logger [%ndc] - %message%newline" />
            </layout>
        </appender>
        <root>
            <level value="ALL" />
            <appender-ref ref="LogFileAppender" />
        </root>
        <logger name="
'@ + "$ScriptName"">`n" + @'
            <level value="ALL" />
        </logger>
    </log4net>
</configuration>
'@

New-Item -Path . -Name "$ScriptName.ps1.config" -ItemType "file" -Value $LoggerCfgFileContent

# SIG # Begin signature block
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUmuNHnlMOvYnkXsZtKGl+jV6j
# IHKgggI9MIICOTCCAaagAwIBAgIQtBirZz3Acb1BfUstCv49PTAJBgUrDgMCHQUA
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
# FDqnJD25BnG43cXfgmFMGjoLCA1aMA0GCSqGSIb3DQEBAQUABIGAWSTDv6dmmhcM
# a5X76AbZAOmnD+4psjH9Ptrx2DXLO5nwL5LUNbjiaqLWL3nedWhbDpqCTTbWg5FK
# s7H7nHL5/oCHE+aOTEUyClfOAq6itmRzgtRq+h5lv6y3rJyRLQr9t0zpKENCZTDs
# 1YwTAN7jhPGRpU7hEcR4K4dPP67OxsA=
# SIG # End signature block
