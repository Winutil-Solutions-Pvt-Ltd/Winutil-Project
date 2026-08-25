# ==============================================================================
# winutil-project - Automated Unit Verification Matrix (Pester v5+)
# Validates core functions and safeguards against broken registry loops
# ==============================================================================

# 1. SETUP ENVIRONMENT DEPENDENCIES
$ProjectRoot = Resolve-Path "$PSScriptRoot\..\src"

# Mock the GUI logger so functions can execute cleanly inside a testing sandbox
function Log-Engine {
    param([string]$Message, [string]$Type="INFO")
    # Silently pipe logs to the testing terminal without needing a real WPF window
    Write-Host "[MockLog] [$Type] -> $Message" -ForegroundColor Gray
}

# Import the active performance codebase to evaluate its methods
. "$ProjectRoot\Tweaks\PerformancePresets.ps1"

# 2. DEFINE THE TEST DISPATCH SUITE
Describe "WinUtil Apex Core Tweak Engine Tests" {
    
    Context "Validation of Individual Functional Pipelines" {
        
        It "Should execute the Apex Performance Tweak module without throwing script crashes" {
            # Run the optimization block and confirm it completes safely
            { $Result = Invoke-ApexPerformanceTweaks } | Should -Not -Throw
            $Result | Should -Be $true
        }

        It "Should apply Privacy & Telemetry isolation tweaks accurately" {
            # Confirm structural privacy adjustments resolve to true
            { $Result = Invoke-ApexPrivacyTweaks } | Should -Not -Throw
            $Result | Should -Be $true
        }

        It "Should clear temporary storage cache sectors smoothly" {
            # Test the file-system cleaner script loop
            { $Result = Invoke-ApexStorageScrubbing } | Should -Not -Throw
            $Result | Should -Be $true
        }

        It "Should possess a functional emergency safety valve rollback mechanism" {
            # Verify the default-restoring loop returns a true boolean value
            { $Result = Invoke-ApexSafetyRollback } | Should -Not -Throw
            $Result | Should -Be $true
        }
    }
}
