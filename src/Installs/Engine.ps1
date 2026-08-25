# ==============================================================================
# winutil-project - Active Winget Deployment Core Pipeline Engine
# Handles silent background installations and status window routing
# ==============================================================================

function Start-AppDeploymentPipeline {
    param (
        [array]$SelectedAppIDs
    )

    if ($SelectedAppIDs.Count -eq 0) {
        Log-Engine "Deployment cancelled: Selection queue contains 0 entries." "WARN"
        return $false
    }

    Log-Engine "Software deployment sequence locked. Processing $($SelectedAppIDs.Count) target packages..." "INFO"

    foreach ($AppID in $SelectedAppIDs) {
        Log-Engine "Initializing package handshake stream for: $AppID" "INFO"
        
        try {
            # Execute active background winget installer silenty without system prompt overrides
            $Process = Start-Process winget -ArgumentList "install --id $AppID --silent --accept-source-agreements --accept-package-agreements" -NoNewWindow -PassThru -Wait
            
            if ($Process.ExitCode -eq 0) {
                Log-Engine "Successfully deployed package sequence: $AppID" "SUCCESS"
            } else {
                Log-Engine "Winget returned a warning or dependency exit error code [$($Process.ExitCode)] for $AppID" "WARN"
            }
        } catch {
            Log-Engine "Critical engine fault encountered while calling Winget payload for: $AppID" "ERROR"
        }
    }

    Log-Engine "All scheduled installations inside the active stack have been concluded." "SUCCESS"
    return $true
}
