# Contributing to WinUtil Apex Core

We welcome contributions! To maintain code stability and security, please follow these guidelines:

## Code Guidelines
* **Modularity:** Do not add raw registry commands directly to `Main.ps1`. Create discrete function blocks within the `src/Tweaks/` directory.
* **Logging:** Use the centralized `Log-Engine` function rather than raw `Write-Host` or `Write-Output`.
* **Testing:** Every new feature or optimization tweak must have a corresponding validation block added to `tests/SystemTests.ps1`.

## Development Workflow
1. Fork the repository and create your branch (`git checkout -b feature/AmazingFeature`).
2. Run localized syntax checkers and verification scripts (`.\compile.ps1 -Type Check`).
3. Open a Pull Request detailing your hardware testing performance metrics.
