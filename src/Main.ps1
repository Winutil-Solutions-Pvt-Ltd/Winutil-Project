# ==============================================================================
# winutil-project - Advanced Master Runtime Engine Loader
# ==============================================================================

# 1. CORE LAYER COMPONENT INJECTION IMPORTS (FIXED WITH PSSCRIPTROOT)
. "$PSScriptRoot\Core\Privileges.ps1"
. "$PSScriptRoot\Core\Logging.ps1"

# 2. ENFORCE ELEVATED SYSTEM CONTROL RIGHTS VIA CORE INTERCEPTOR
Assert-AdministrativePrivileges

# 3. RUNTIME DEPENDENCY STACK IMPORTS
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms
. "$PSScriptRoot\Installs\Manifests.ps1"
. "$PSScriptRoot\Installs\Engine.ps1"

# Load the comprehensive modular tweaks structure
. "$PSScriptRoot\Tweaks\PerformancePresets.ps1"
. "$PSScriptRoot\Tweaks\PrivacyPresets.ps1"
. "$PSScriptRoot\Tweaks\SecurityUpdates.ps1"
. "$PSScriptRoot\Tweaks\windev.ps1"

# 4. PARSE DYNAMIC GRAPHICS FRAME FILE LAYER
if (-not (Test-Path "$PSScriptRoot\UI\MainLayout.xaml")) {
    Write-Error "Critical Fault: Structural UI layout file missing from folder path."
    Exit
}

[xml]$xamlContent = Get-Content -Path "$PSScriptRoot\UI\MainLayout.xaml" -Raw
$reader = New-Object System.Xml.XmlNodeReader $xamlContent
$Global:Form = [Windows.Markup.XamlReader]::Load($reader)

# Map Dynamic UI Component Engine Node References
$GlobalStatus = $Form.FindName("GlobalStatus")
$TerminalMonitor = $Form.FindName("TerminalMonitor")

# 5. ASSIGN INTERACTION EVENT PACKETS TO ELEMENTS

# Multi-Application Bulk Deployment Routing Hook
$Form.FindName("BtnInstallGroup").Add_Click({
    $GlobalStatus.Text = "Running Software Deployment Engine..."
    $Queue = @()
    
    # Safely evaluate app checkboxes against our centralized dictionary manifests
    if ($Form.FindName("AppChrome").IsChecked)     { $Queue += $Global:AppManifestCatalog.Browsers["Google Chrome"] }
    if ($Form.FindName("AppBrave").IsChecked)      { $Queue += $Global:AppManifestCatalog.Browsers["Brave Browser"] }
    if ($Form.FindName("AppFirefox").IsChecked)    { $Queue += $Global:AppManifestCatalog.Browsers["Mozilla Firefox"] }
    
    if ($Form.FindName("App7Zip").IsChecked)       { $Queue += $Global:AppManifestCatalog.Utilities["7-Zip Archiver"] }
    if ($Form.FindName("AppTerminal").IsChecked)   { $Queue += $Global:AppManifestCatalog.Utilities["Windows Terminal"] }
    if ($Form.FindName("AppPowerToys").IsChecked)  { $Queue += $Global:AppManifestCatalog.Utilities["MS PowerToys"] }
    if ($Form.FindName("AppBleach").IsChecked)     { $Queue += $Global:AppManifestCatalog.Utilities["BleachBit Cleaner"] }
    
    if ($Form.FindName("AppVSC").IsChecked)        { $Queue += $Global:AppManifestCatalog.Development["VS Code Studio"] }
    if ($Form.FindName("AppGit").IsChecked)        { $Queue += $Global:AppManifestCatalog.Development["Git Deployment"] }
    if ($Form.FindName("AppNotepad").IsChecked)    { $Queue += $Global:AppManifestCatalog.Development["Notepad++ Editor"] }
    
    $Success = Start-AppDeploymentPipeline -SelectedAppIDs $Queue
    if ($Success) { 
        $GlobalStatus.Text = "Deployment matrix run succeeded!" 
    } else {
        $GlobalStatus.Text = "Deployment run cancelled or incomplete."
    }
})

# Macro Preset Controls
$Form.FindName("PresetPerformance").Add_Click({ 
    $GlobalStatus.Text = "Deploying Performance Presets..."
    if (Invoke-ApexPerformanceTweaks) { $GlobalStatus.Text = "Performance Profile Active!" } 
})

$Form.FindName("PresetPrivacy").Add_Click({ 
    $GlobalStatus.Text = "Deploying Privacy Presets..."
    if (Invoke-ApexPrivacyTweaks) { $GlobalStatus.Text = "Privacy Isolation Profile Injected!" } 
})

$Form.FindName("PresetUndo").Add_Click({ 
    $GlobalStatus.Text = "Initiating profile rollback..."
    if (Invoke-ApexSafetyRollback) { $GlobalStatus.Text = "System parameters standardized." } 
})

# Micro-Switch Control Overrides
$Form.FindName("TweakTelemetry").Add_Click({ 
    $GlobalStatus.Text = "Stripping telemetry databases..."
    if (Invoke-ApexPrivacyTweaks) { $GlobalStatus.Text = "Telemetry channels purged." }
})

$Form.FindName("TweakHibernation").Add_Click({ 
    $GlobalStatus.Text = "Modifying hibernation profiles..."
    Log-Engine "Deactivating hardware sleep hibernation storage states..." "INFO"
    powercfg /hibernate off
    Log-Engine "Hibernation block disabled successfully." "SUCCESS"
    $GlobalStatus.Text = "Disk Space Unlocked!"
})

$Form.FindName("TweakUpdates").Add_Click({ 
    $GlobalStatus.Text = "Hardening Update policies..."
    if (Invoke-ApexUpdateTweaks) { $GlobalStatus.Text = "Security Update Mode Locked!" }
})

$Form.FindName("TweakStorage").Add_Click({ 
    $GlobalStatus.Text = "Purging system caches..."
    if (Invoke-ApexStorageScrubbing) { $GlobalStatus.Text = "Storage optimization finalized." }
})

# Advanced Developer Environment Configuration Override Hook
$Form.FindName("TweakDevMode").Add_Click({ 
    $GlobalStatus.Text = "Running Advanced Developer Setup Engine..."
    if (Invoke-ApexDeveloperSetup) { 
        $GlobalStatus.Text = "Developer Environment Optimizations Injected!" 
    } else {
        $GlobalStatus.Text = "Developer setup encountered an exception."
    }
})

# 6. INITIALIZE USER DISPLAY ENGAGEMENT WINDOW
Log-Engine "Engine Core online. Visual UI frames drawn successfully." "SUCCESS"
$Form.ShowDialog() | Out-Null
