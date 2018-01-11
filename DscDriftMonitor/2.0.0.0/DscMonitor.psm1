[DscResource()]
Class DscMonitor {
    [DscProperty(Key)]
    [int] $EventID = 4999

    [void] Set() {
        throw "Configuration Mode must be set to ApplyAndAutoCorrect for this resource to function"
    }

    [bool] Test() {
        # This should always run
        $metamof = "$env:windir\System32\Configuration\MetaConfig.mof"
        $configurationMode = Select-String -Path $metamof -Pattern "C\So\Sr\Sr\Se\Sc\St" -Quiet
        
        if (!($configurationMode)) {
            return $false
        }
        else {Write-Verbose -Message "Configuration Mode is ApplyAndAutoCorrect"}

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
            if ($Matches.ResourceType -ne $null) {
                Write-Verbose -Message "Set event detected for resource type $($Matches.ResourceType) with name $($Matches.ResourceName)"
                New-EventLog -LogName Application -Source DSC -ErrorAction SilentlyContinue
                Write-EventLog -LogName Application -Source DSC -EventId $using:EventId -EntryType Warning -Message "Set event detected for resource type $($Matches.ResourceType) with name $($Matches.ResourceName)"
            }
        }

        return $True
    }

    

    [DscMonitor] Get() {
        return $this
    }
}