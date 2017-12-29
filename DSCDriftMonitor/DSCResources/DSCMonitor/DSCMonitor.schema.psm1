Configuration DSCMonitor {
    Param(
        [int]$EventID,
        [int]$Interval=15)
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Script DSCMon {
        GetScript = {return @{Result=$true}}
        SetScript = {
            # This never runs
        }
        TestScript = {
            # This should always run
            $consistencyHash = @{
                LogName = "Microsoft-Windows-DSC/Analytic"
                Id = "4098"
            }
            
            $consistencyCheckStart = (Get-WinEvent -FilterHashtable $consistencyHash -Oldest -ErrorAction SilentlyContinue | Where-Object {$_.Message -match "Starting consistency"} | Sort-Object -Property TimeCreated -Descending | Select-Object -First 1).TimeCreated
            
            $jobHash = @{
                LogName = "Microsoft-Windows-DSC/Analytic"
                Id = "4100"
            }
            
            $jobEvents = Get-WinEvent -FilterHashtable $jobHash -Oldest -ErrorAction SilentlyContinue | Where-Object {($_.TimeCreated -gt $consistencyCheckStart) -and ($_.Message -match "Start  Set") }
            
            foreach ($job in $jobEvents) {
                $message = $job.Message
                $message -match "\[\[(?<ResourceType>\w+)\](?<ResourceName>\w+)\]" | Out-Null
                Write-Verbose -Message "Set event detected for resource type $($Matches.ResourceType) with name $($Matches.ResourceName)"
            }

            return $True
        }
    }

}