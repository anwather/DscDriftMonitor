# DscDriftMonitor

This module contains the resource **DscDriftConfiguration** and **DscMonitor** for monitoring when configuration drift is detected when the LCM mode is set to "ApplyandAutoCorrect"

## Resources
***
### DscDriftConfiguration

* **Ensure**: Set to **Present** to enable monitoring or **Absent** to disable monitoring. If disabled the **DscDriftMonitor** resource will not report events.

### DscDriftMonitor

* **EventID**: Event Id to be reported if configuration drift is detected. By default this is 4999 and written to the Application Log with a source of DSC.

If the LCM configuration mode is not set to ApplyandAutoCorrect an error will be thrown and the configuration will not apply. If detection of resources not in the desired state is necessary using other LCM modes then do not use this resource, use the reporting from the pull server or Test-DscConfiguration or the Dsc Environment Analyser. 

## Versions
***
### Unreleased

## 1.0.0.0

* Original Release