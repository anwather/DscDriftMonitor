Configuration TestDSCDrift {
    Import-DSCResource -ModuleName psDEsiredStateConfiguration
    Import-DscResource -MOduleNAme DSCdriftMonitor

    Node localhost {
        
    }
}