Configuration TestDSCDrift {

    Import-DSCResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -MOduleNAme DSCDriftMonitor

    Node localhost {

        LocalConfigurationManager {
            ConfigurationMode = "ApplyAndAutoCorrect"
        }

        DSCDriftConfiguration DDC {
            Ensure = "Present"
        }
    }


}

Set-Location $env:Temp

TestDSCDrift

Set-DscLocalConfigurationManager .\TestDSCDrift -Verbose

Start-DscConfiguration .\TestDSCDrift -Wait -Verbose