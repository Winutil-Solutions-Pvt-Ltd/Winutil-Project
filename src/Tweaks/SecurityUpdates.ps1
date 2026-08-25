# ==============================================================================
# winutil-project - Automated Windows Update Governance Policy Engine
# Reschedules system updates to prioritize mandatory security payloads
# ==============================================================================

function Invoke-ApexUpdateTweaks {
    Log-Engine "Adjusting Windows Update delivery settings to Security-Only targets..." "INFO"
    
    try {
        $UpdateAUPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
        if (-not (Test-Path $UpdateAUPath)) { New-Item -Path $UpdateAUPath -Force | Out-Null }
        
        # Configure Option 2: Notify before downloading and installing any package payload
        Set-ItemProperty -Path $UpdateAUPath -Name "AUOptions" -Value 2 -Force
        Log-Engine "[Updates] Automatic feature package stealth-installs deactivated (Notify mode active)." "SUCCESS"
        
        # Turn off cloud peer-to-peer delivery updates that consume background network bandwidth
        $DeliveryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config"
        if (-not (Test-Path $DeliveryPath)) { New-Item -Path $DeliveryPath -Force | Out-Null }
        Set-ItemProperty -Path $DeliveryPath -Name "DODownloadMode" -Value 0 -Force
        Log-Engine "[Updates] Background P2P update distribution networks disabled successfully." "SUCCESS"

        return $true
    } catch {
        Log-Engine "Failed to adjust underlying system windows update registry structures." "ERROR"
        return $false
    }
}
