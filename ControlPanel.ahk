#Requires AutoHotkey v1.1
#SingleInstance Force
SetBatchLines -1

INSTALLDIR := A_ScriptDir

; --- GUI ---
Gui, -Resize +MinSize300x250  ; Janela normal, sem estilo toolbox
Gui, Color, C0C0C0            ; Cinza Win9x
Gui, Font, s9, MS Sans Serif  ; A alma do Windows 95/98

Gui, Add, Text, x15 y15, This is the Control Panel for MemPatch11.

Gui, Add, GroupBox, x10 y35 w280 h150, Options
Gui, Font, s9, MS Sans Serif

Gui, Add, Button, x25 y60  w250 h25 gOpenPerformanceSettings, Open Performance Settings
Gui, Add, Button, x25 y90  w250 h25 gApplyClassicTheme, Apply Classic Theme
Gui, Add, Button, x25 y120 w250 h25 gShowMemoryInfo, Show Memory Info
Gui, Add, Button, x25 y150 w250 h25 gAboutWindow, About

Gui, Add, Button, x100 y200 w100 h28 gDoExit, Exit

Gui, Show,, MemPatch11 Control Panel
Return

; --- LABELS ---

AboutWindow:
    MsgBox, 64, About, MemPatch11 Control Panel`nVersion 0.1.0`nMade by OakyMacintosh
Return

OpenPerformanceSettings:
    Run, ms-settings:performance
Return

ApplyClassicTheme:
    Run, "%INSTALLDIR%\sct.exe"
    Sleep 600
    SendInput, {Enter}
Return

ShowMemoryInfo:
    text := "Total Physical Memory: " . A_TotalPhysicalMemory . " bytes`n"
    text .= "Available Physical Memory: " . A_AvailablePhysicalMemory . " bytes`n"
    text .= "Total Virtual Memory: " . A_TotalVirtualMemory . " bytes`n"
    text .= "Available Virtual Memory: " . A_AvailableVirtualMemory . " bytes"
    MsgBox, 64, Memory Info, %text%
Return

DoExit:
    ExitApp
Return
