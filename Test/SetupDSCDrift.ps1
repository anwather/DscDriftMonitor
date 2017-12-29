Configuration TestDSCDrift {

    Import-DSCResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -MOduleName DscDriftMonitor -ModuleVersion 1.0.0.0 

    Node localhost {

        LocalConfigurationManager {
            ConfigurationMode = "ApplyAndAutoCorrect"
            AllowModuleOverwrite = $true
        }

        DscDriftConfiguration DC {
            Ensure = "Present"
        }
    }


}

Set-Location $env:Temp

TestDSCDrift

Set-DscLocalConfigurationManager .\TestDSCDrift -Verbose

Start-DscConfiguration .\TestDSCDrift -Wait -Verbose -Force