enum Ensure {
    Absent
    Present
}

[DSCResource()]
Class DscDriftConfiguration {
    [DscProperty(Key)]
    [Ensure] $Ensure

    [void] Set() { 
        if ($this.Ensure -eq "Present") {
            $eventLogFullName = "Microsoft-Windows-DSC/Analytic"
            $statusEnabled = $true
            $commandToExecute = "wevtutil set-log $eventLogFullName /e:$statusEnabled /q:$statusEnabled"
            Write-Verbose -Message "Changing status of the log $eventLogFullName to Enabled"
            Invoke-Expression $commandToExecute
            #Update-xDscEventLogStatus -Channel Analytic -Status Enabled -Verbose
        }
        else {
            $eventLogFullName = "Microsoft-Windows-DSC/Analytic"
            $statusEnabled = $false
            $commandToExecute = "wevtutil set-log $eventLogFullName /e:$statusEnabled /q:$statusEnabled"
            Write-Verbose -Message "Changing status of the log $eventLogFullName to Disabled"
            Invoke-Expression $commandToExecute
            #Update-xDscEventLogStatus -Channel Analytic -Status Enabled -Verbose 
        }    
    }

    [bool] Test() {
        $status = (Get-WinEvent -ListLog Microsoft-Windows-DSC/Analytic).IsEnabled
            if ($this.Ensure -eq "Present") {
                if ($status) {return $true} else {return $false}
            }
            else {
                if ($status) {return $false} else {return $true} 
            }
    }

    [DscDriftConfiguration] Get() {
        return $this
    }

}