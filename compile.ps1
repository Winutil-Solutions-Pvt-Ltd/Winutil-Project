<#
.SYNOPSIS
    WinUtil compilation, testing, and formatting controller script.
#>
param(
    [ValidateSet("Check", "Build")][string]$Action = "Check"
)

switch ($Action) {
    "Check" {
        Write-Host "[i] Executing syntax checking and testing suite..." -ForegroundColor Cyan
        if (Get-Module -ListAvailable Pester) {
            Invoke-Pester -Path ".\tests\SystemTests.ps1" -Output Detailed
        } else {
            Write-Host "[!] Pester framework missing. Skipping testing array." -ForegroundColor Yellow
        }
    }
    "Build" {
        Write-Host "[i] Compiling solution code down into standalone executable..." -ForegroundColor Cyan
        if (-not (Get-Module -ListAvailable ps2exe)) { Install-Module ps2exe -Force -Scope CurrentUser }
        New-Item -ItemType Directory -Path ".\dist" -Force | Out-Null
        Invoke-ps2exe -inputFile ".\src\Main.ps1" -outputFile ".\dist\winutil-apex.exe" -noConsole -x86
        Write-Host "[✓] Executable output written cleanly to .\dist\winutil-apex.exe" -ForegroundColor Green
    }
}
