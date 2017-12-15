Configuration DSCDriftConfiguration {

    Param(
        [ValidateSet("Absent","Present")]
        [string]$Ensure)

    Import-DSCResource -ModuleName PowerShellModule

    PSModuleResource xDSCDiagnostics {
        Module_Name = "xDSCDiagnostics"
        Ensure = "Present"
        InstallScope = "allusers"
        MinimumVersion = "2.6.0.0"
    }

    Script ManageDiagnostics {
        SetScript = {
            if ($using:Ensure -eq "Present") {
                Update-xDscEventLogStatus -Channel Analytic -Status Enabled -Verbose
            }
            else {
                Update-xDscEventLogStatus -Channel Analytic -Status Disabled -Verbose   
            }
        }
        GetScript = {
            return @{Result = $true}
        }
        TestScript = {
            $status = (Get-WinEvent -ListLog Microsoft-Windows-DSC/Analytic).IsEnabled
            if ($using:Ensure -eq "Present") {
                if ($status) {return $true} else {return $false}
            }
            else {
                if ($status) {return $false} else {return $true} 
            }
        }
    }

}