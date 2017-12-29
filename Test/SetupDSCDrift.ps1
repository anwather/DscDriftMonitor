Configuration TestDSCDrift {

    Import-DSCResource -ModuleName psDEsiredStateConfiguration
    Import-DscResource -MOduleNAme DSCdriftMonitor 

    Node localhost {

        DSCDriftConfiguration DDC {
            Ensure = "Absent"
        }

    }


}

Set-Location $env:Temp

TestDSCDrift

Start-DscConfiguration .\TestDSCDrift -Wait -vERbose