# DscDriftMonitor

This module contains the resource **DscDriftConfiguration** and **DscMonitor** for monitoring when configuration drift is detected when the LCM mode is set to "ApplyandAutoCorrect"

## Resources
***
### DscDriftConfiguration

* **Ensure**: Set to **Present** to enable monitoring or **Absent** to disable monitoring. If disabled the **DscDriftMonitor** resource will not report events.

### DscDriftMonitor

* **EventID**: Event Id to be reported if configuration drift is detected. By default this is 4999.

## Versions
***
### Unreleased

## 1.0.0.0

* Original Release