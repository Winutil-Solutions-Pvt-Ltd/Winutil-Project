# ==============================================================================
# winutil-project - Advanced System Performance & Privacy Override Matrix
# Curated registry configurations and optimization modules
# ==============================================================================

# --- PERFORMANCE ENHANCEMENTS ---
function Invoke-ApexPerformanceTweaks {
    Log-Engine "Engaging visual hardware optimization protocols..." "INFO"
    
    try {
        # Force active power matrix to High/Maximum performance profile distribution
        powercfg /setactive SCHEME_MIN | Out-Null
        Log-Engine "[Registry] System power configurations locked to Max Performance profile." "SUCCESS"
        
        # Zero out desktop explorer rendering menu visual delays (Standard default is 400ms)
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Force
        Log-Engine "[Registry] Desktop navigation rendering delay cut to 0ms." "SUCCESS"
        
        # Disable tracking of recently opened apps to free up shell context memory buffers
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value 0 -Force
        Log-Engine "[Registry] Shell application history indexing loops disabled." "SUCCESS"
        
        return $true
    } catch {
        Log-Engine "Performance sub-system modifications encountered an extraction fault." "ERROR"
        return $false
    }
}

# --- TELEMETRY & PRIVACY ISOLATION ---
function Invoke-ApexPrivacyTweaks {
    Log-Engine "Severing system background telemetry data tracking chains..." "INFO"
    
    try {
        $DataCollectionPaths = @(
            "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
        )
        
        foreach ($Path in $DataCollectionPaths) {
            if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
            Set-ItemProperty -Path $Path -Name "AllowTelemetry" -Value 0 -Force
        }
        Log-Engine "[Registry] Universal telemetry data reporting pipes blocked successfully." "SUCCESS"
        
        # Break background AI assistant Cortana telemetry framework footprint values
        $CortanaPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
        if (-not (Test-Path $CortanaPath)) { New-Item -Path $CortanaPath -Force | Out-Null }
        Set-ItemProperty -Path $CortanaPath -Name "AllowCortana" -Value 0 -Force
        Log-Engine "[Registry] Cortana tracking infrastructure and indexing loops severed." "SUCCESS"
        
        return $true
    } catch {
        Log-Engine "Privacy sub-system adjustments failed during administrative write." "ERROR"
        return $false
    }
}

# --- SYSTEM CACHE SCRUBBING ENGINE ---
function Invoke-ApexStorageScrubbing {
    Log-Engine "Engaging disk cache runtime purging pipelines..." "INFO"
    
    $PurgeTargets = @($env:TEMP, "$env:SystemRoot\Temp")
    $Counter = 0
    
    foreach ($Folder in $PurgeTargets) {
        if (Test-Path $Folder) {
            Log-Engine "Scanning temporary storage sector directory: $Folder" "INFO"
            Get-ChildItem $Folder -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
                try {
                    Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
                    $Counter++
                } catch {}
            }
        }
    }
    
    Log-Engine "Cache cleanup completed. Purged $Counter system runtime cache files." "SUCCESS"
    return $true
}

# --- EMERGENCY SYSTEM SAFETY ROLLBACK VALVE ---
function Invoke-ApexSafetyRollback {
    Log-Engine "Emergency Rollback Protocol engaged. Restoring system standard defaults..." "WARN"
    
    try {
        # Restore normal windows desktop menu speed threshold limits
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "400" -Force
        Log-Engine "[Rollback] Visual rendering timings standardized back to 400ms." "SUCCESS"
        
        # Re-allow diagnostic telemetry operations
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 1 -Force -ErrorAction SilentlyContinue
        Log-Engine "[Rollback] Telemetry communications channels re-opened." "SUCCESS"
        
        return $true
    } catch {
        Log-Engine "System rollback engine encountered an administrative access block." "ERROR"
        return $false
    }
}
