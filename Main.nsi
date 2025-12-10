!include "MUI2.nsh"
!define VERSION "0.1.0a"

Name "MemPatcher for Windows 11"
OutFile "MemPatcher_Win11_${VERSION}.exe"
InstallDir "$PROGRAMFILES\MemPatcher_Win11"
InstallDirRegKey HKLM "Software\MemPatcher11" "InstallPath"

;-------------------------------------
; Páginas do instalador
;-------------------------------------

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

;-------------------------------------
; Seção principal
;-------------------------------------

Section "Install MemPatcher" SEC01
    SetOutPath "$INSTDIR"
    File "sources\sct.exe"
    File "sources\WinPerfomance.exe"
    File "sources\ControlPanel.exe"

    WriteRegStr HKLM "Software\MemPatcher11" "InstallPath" "$INSTDIR"
    WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

;-------------------------------------
; Pós-instalação
;-------------------------------------

Function .onInstSuccess
    nsExec::Exec "$INSTDIR\WinPerfomance.exe"
    nsExec::Exec "$INSTDIR\sct.exe"
    CreateShortcut "$DESKTOP\MemPatcher Control Panel.lnk" "$INSTDIR\ControlPanel.exe"
FunctionEnd

;-------------------------------------
; Desinstalar
;-------------------------------------

Section "Uninstall"
    Delete "$INSTDIR\sct.exe"
    Delete "$INSTDIR\WinPerfomance.exe"
    Delete "$INSTDIR\ControlPanel.exe"
    Delete "$Desktop\MemPatcher Control Panel.lnk"
    Delete "$INSTDIR\Uninstall.exe"

    RMDir "$INSTDIR"
    DeleteRegKey HKLM "Software\MemPatcher11"
SectionEnd
