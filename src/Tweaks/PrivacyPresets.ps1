# ==============================================================================
# winutil-project - Advanced Privacy & Telemetry Decimation Suite
# Hardens privacy parameters across universal background system layers
# ==============================================================================

function Invoke-ApexPrivacyTweaks {
    Log-Engine "Severing system background telemetry data tracking chains..." "INFO"
    
    try {
        # 1. Kill Central Diagnostics & Telemetry Collections
        $DataCollectionPaths = @(
            "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
        )
        foreach ($Path in $DataCollectionPaths) {
            if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
            Set-ItemProperty -Path $Path -Name "AllowTelemetry" -Value 0 -Force
        }
        Log-Engine "[Privacy] Universal telemetry telemetry keys modified to restricted values." "SUCCESS"
        
        # 2. Sever AI Cortana Assistant System Footprint
        $CortanaPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
        if (-not (Test-Path $CortanaPath)) { New-Item -Path $CortanaPath -Force | Out-Null }
        Set-ItemProperty -Path $CortanaPath -Name "AllowCortana" -Value 0 -Force
        Log-Engine "[Privacy] Cortana assistant background processing systems neutralized." "SUCCESS"
        
        # 3. Disable Consumer Advertising ID Tracking Loops
        $AdvertPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
        if (-not (Test-Path $AdvertPath)) { New-Item -Path $AdvertPath -Force | Out-Null }
        Set-ItemProperty -Path $AdvertPath -Name "Enabled" -Value 0 -Force
        Log-Engine "[Privacy] Application Advertising ID collection hooks stripped." "SUCCESS"
        
        return $true
    } catch {
        Log-Engine "Privacy sub-system adjustments failed during administrative write." "ERROR"
        return $false
    }
}
