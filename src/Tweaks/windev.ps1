# ==============================================================================
# winutil-project - Windows Developer Environment Setup Matrix
# Optimizes base operating conditions for software development configurations
# ==============================================================================

function Invoke-ApexDeveloperSetup {
    Log-Engine "Configuring underlying operating layer for advanced development execution..." "INFO"
    
    try {
        # 1. Unshackle System Developer Mode
        $DevModePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
        if (-not (Test-Path $DevModePath)) { New-Item -Path $DevModePath -Force | Out-Null }
        Set-ItemProperty -Path $DevModePath -Name "AllowDevelopmentWithoutDevLicense" -Value 1 -Force
        Log-Engine "[DevMode] Windows native Developer Mode parameter enabled successfully." "SUCCESS"
        
        # 2. Expose System File Extensions inside Windows Explorer Layouts
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Force
        Log-Engine "[Explorer] Hidden file extension display rules forced active." "SUCCESS"
        
        # 3. Enable Execution of Long Paths (>260 Characters) for package managers (NPM/Cargo)
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Force
        Log-Engine "[FileSystem] System long-path limit restraints deactivated." "SUCCESS"

        return $true
    } catch {
        Log-Engine "Developer framework tuning configuration encountered an elevation exception." "ERROR"
        return $false
    }
}
