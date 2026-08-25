# Technical Specification (Spec Matrix)

## Architectural Design
* **Runtime Engine:** PowerShell Core / Windows PowerShell 5.1+
* **UI Engine:** Windows Presentation Foundation (WPF) via compiled XAML parsing layers.
* **Privilege Level:** Mandated Administrator elevation via UAC execution wrappers (`src/Core/Privileges.ps1`).

## Subsystem Boundaries
1. **Core:** System permission boundaries and synchronized visual-to-terminal logging loops.
2. **UI:** View layout layer. Completely detached from system access states.
3. **Installs:** External software deployment pipelines via native Windows Package Manager (`winget`).
4. **Tweaks:** Localized machine hive (`HKLM`) and current user hive (`HKCU`) registry modifications.
