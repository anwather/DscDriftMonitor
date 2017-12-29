Configuration TestDSCDrift {

    Import-DSCResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -MOduleNAme DSCDriftMonitor

    Node localhost {
        File TestFolder {
            Ensure = "Present"
            DestinationPath = "C:\Test"
            Type = 'Directory'
        }

        DSCMonitor DMon {

        }
    }
}

Set-Location $env:Temp

TestDSCDrift

Start-DscConfiguration .\TestDSCDrift -Wait -Verbose