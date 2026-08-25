# ==============================================================================
# winutil-project - Administrative Rights Validation Handler
# Asserts permission parameters and forces elevated context runtime spawning
# ==============================================================================

function Assert-AdministrativePrivileges {
    param (
        [string]$ScriptPath = $PSCommandPath
    )

    $Identity  = [Security.Principal.WindowsIdentity]::GetCurrent()
    $Principal = New-Object Security.Principal.WindowsPrincipal($Identity)
    $IsAdmin   = $Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (-not $IsAdmin) {
        Write-Host "======================================================" -ForegroundColor Cyan
        Write-Host "   ELEVATING WINUTIL MATRIX TO ADMINISTRATIVE ROOT    " -ForegroundColor Purple
        Write-Host "======================================================" -ForegroundColor Cyan
        Write-Host "[!] Root authorization required. Triggering Windows UAC prompt..." -ForegroundColor Yellow
        
        # Call elevated process container wrapper using execution policy bypass argument parameters
        Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`"" -Verb RunAs
        Exit
    }
}
