#Requires AutoHotkey v1.1
#SingleInstance Force
SetBatchLines -1

INSTALLDIR := A_ScriptDir

; --- Check for startup condition ---
if not A_Args {
    ; If started without arguments (e.g., double-clicked), run performance mode
    GoSub SetPerformanceMode
    GoSub ApplyClassicTheme
    ; Optional: Exit the script after applying if you don't need hotkeys running in the background
    MsgBox , Windows appearance settings set to "Performance" mode on startup.
    ExitApp
}
; If ExitApp is commented out, the script continues to run, enabling the hotkeys below.

; --- Function Definitions ---

SetPerformanceMode:
    ; 2 = Adjust for best performance
    RegWrite, REG_DWORD, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects, VisualFXSetting, 2
    RegWrite, REG_DWORD, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, TaskbarAnimations, 0
    RegWrite, REG_SZ, HKCU, Control Panel\Desktop\WindowMetrics, MinAnimate, 0
    NotifyWindows("Performance")
    return

SetDefaultMode:
    ; 1 = Adjust for best appearance (or use 0 for "Let Windows choose")
    RegWrite, REG_DWORD, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects, VisualFXSetting, 1
    RegWrite, REG_DWORD, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, TaskbarAnimations, 1 ; Enable default animation
    RegWrite, REG_SZ, HKCU, Control Panel\Desktop\WindowMetrics, MinAnimate, 1 ; Enable default animation
    NotifyWindows("Default/Appearance")
    return

; --- Helper Function to Notify Windows and User ---

NotifyWindows(mode) {
    ; Update system-wide settings immediately
    DllCall("SystemParametersInfo", UInt, 0x011, UInt, 0, UInt, 0, UInt, 0x02)
    DllCall("SystemParametersInfo", UInt, 0x2A, UInt, 0, UInt, 0, UInt, 0x02)

    MsgBox, Windows appearance settings set to "%mode%" mode.
}

ApplyClassicTheme() {
    Run "$INSTALLDIR$\sct.exe "
    Sleep 1000
    SendInput {Enter}
}