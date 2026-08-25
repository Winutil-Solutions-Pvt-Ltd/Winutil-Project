# ==============================================================================
# winutil-project - Central Software App Manifest Repository
# Categorised lists mapping Visual Names to Winget Deployment IDs
# ==============================================================================

$Global:AppManifestCatalog = @{
    # 🌐 WEB NAVIGATORS ROW
    Browsers = @{
        "Google Chrome"    = "Google.Chrome"
        "Brave Browser"    = "Brave.Brave"
        "Mozilla Firefox"  = "Mozilla.Firefox"
        "Microsoft Edge"   = "Microsoft.Edge"
    }

    # 🛠️ HARDWARE UTILITIES & SYSTEM UTILITIES
    Utilities = @{
        "7-Zip Archiver"   = "7zip.7zip"
        "MS PowerToys"     = "Microsoft.PowerToys"
        "BleachBit Cleaner"= "BleachBit.BleachBit"
        "Rufus USB Tool"   = "Akeo.Rufus"
    }

    # 💻 DEVELOPMENT ENGINE LAYERS
    Development = @{
        "VS Code Studio"   = "Microsoft.VisualStudioCode"
        "Git Deployment"   = "Git.Git"
        "Notepad++ Editor" = "Notepad++.Notepad++"
        "Python Runtime"   = "Python.Python.3"
    }
}

Log-Engine "Software Manifest Registry mapped successfully with $($Global:AppManifestCatalog.Count) master categories." "SUCCESS"
