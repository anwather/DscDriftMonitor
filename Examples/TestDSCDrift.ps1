Configuration TestDSCDrift {

    Import-DSCResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DscDriftMonitor -ModuleVersion 1.0.0.0

    Node localhost {
        File TestFolder {
            Ensure = "Present"
            DestinationPath = "C:\Test"
            Type = 'Directory'
        }

        DscMonitor Dm {

        }
        
    }
}

Set-Location $env:Temp

TestDSCDrift

Start-DscConfiguration .\TestDSCDrift -Wait -Verbose