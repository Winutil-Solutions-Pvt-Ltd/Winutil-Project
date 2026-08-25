# ==============================================================================
# winutil-project - Dynamic Real-Time Logging Engine
# Routes metadata packets cleanly across the graphical UI and console terminal
# ==============================================================================

function Log-Engine {
    param (
        [Required][string]$Message,
        [ValidateSet("INFO", "SUCCESS", "WARN", "ERROR")][string]$Type = "INFO"
    )

    $Timestamp = Get-Date -Format "HH:mm:ss"
    $FormattedLine = "[$Timestamp] [$Type] -> $Message`r`n"

    # 1. Update the Graphical UI Window Terminal Monitor if it exists in scope
    if ($Global:Form) {
        $TerminalMonitor = $Global:Form.FindName("TerminalMonitor")
        if ($TerminalMonitor) {
            $TerminalMonitor.AppendText($FormattedLine)
            $TerminalMonitor.ScrollToEnd()
            [System.Windows.Forms.Application]::DoEvents() # Forces immediate visual frame redrawing
        }
    }

    # 2. Parallel Route: Output colored text to the raw developer command prompt background window
    switch ($Type) {
        "SUCCESS" { Write-Host "   [✓] $Message" -ForegroundColor Green }
        "WARN"    { Write-Host "   [!] $Message" -ForegroundColor Yellow }
        "ERROR"   { Write-Host "   [X] $Message" -ForegroundColor Red }
        "INFO"    { Write-Host "   [i] $Message" -ForegroundColor Cyan }
    }
}
