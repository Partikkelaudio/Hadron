!include LogicLib.nsh
!include WinMessages.nsh
!include MUI2.nsh

Name "Hadron Installer"
OutFile "Hadron_DSP_Installer_Win_ver_1.3.31.exe"

; The default installation directory
InstallDir "$PROGRAMFILES64\Hadron"

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
;InstallDirRegKey HKLM "Software\Hadron" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

Var VSTDIR64 
Var VSTDIR32 
Var MyDirPageTxt32 
Var MyDirPageTxt64
Var INSTDIR_OLD
Var TempStates

Function .onInit

  ReadRegStr $INSTDIR_OLD HKLM Software\Hadron "Install_Dir" 
  StrCmp $INSTDIR_OLD $PROGRAMFILES64\Hadron done
  StrCpy $TempStates "C:\hadron_temp"
  ; If we are moving from a 32 bit install to a 64 bit install, we want to copy any states and docs, so save them to a temporary location

  CopyFiles "$INSTDIR_OLD\docs\*.*" "$TempStates\docs"
  CopyFiles "$INSTDIR_OLD\states\*.*" "$TempStates\states"

  ReadRegStr $R0 HKLM \
  "Software\Microsoft\Windows\CurrentVersion\Uninstall\Hadron" \
  "UninstallString"
  StrCmp $R0 "" done
 
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
  "An old version of Hadron is already installed. To enable correct installation of this version we need to uninstall the old one before proceeding. $\n$\nClick `OK` to remove the \
  previous version or `Cancel` to cancel this upgrade." \
  IDOK uninst
  Abort
 
;Run the uninstaller
uninst:
  ClearErrors
  ExecWait '$R0 _?=$INSTDIR' ;Do not copy the uninstaller to a temp file
 
  IfErrors no_remove_uninstaller done
    ;You can either use Delete /REBOOTOK in the uninstaller or add some code
    ;here to remove the uninstaller. Use a registry key to check
    ;whether the user has chosen to uninstall. If you are using an uninstaller
    ;components page, make sure all sections are uninstalled.
  no_remove_uninstaller:

; skip uninstallling altogether
NoUninst: 
done:

StrCpy $MyDirPageTxt64 "SET PATH FOR 64 bit VST $\r$\n\ 
VST plugins can be installed to any location on your hard drive, but it is very important that the host sequencer 'knows' where they get installed in order to load them afterwards.$\r$\n$\r$\n\
We recommend to define fixed folders for all your VST installations, especially when you are using several host programs. $\r$\n\
Take a note of the selected install location now, so that you can set your sequencer's vst directory to this path."

StrCpy $MyDirPageTxt32 "SET PATH FOR 32 bit VST $\r$\n\ 
... $\r$\n\
Take a note of the selected install location now, so that you can set your sequencer's vst directory to this path."

;ReadRegStr $VSTDIR64 HKLM Software\Wow6432Node\VST "VSTPluginsPath" 
StrCmp $VSTDIR64 "" 0 +2
StrCpy $VSTDIR64 "$PROGRAMFILES64\Vstplugins"

;ReadRegStr $VSTDIR32 HKLM Software\VST "VstPluginsPath" 
StrCmp $VSTDIR32 "" 0 +2
StrCpy $VSTDIR32 "$PROGRAMFILES\Vstplugins"

FunctionEnd


!define MUI_WELCOMEPAGE_TEXT "Welcome, we will now start installation of the Hadron Particle Synthesizer."
!define MUI_LICENSEPAGE_TEXT_TOP "Hadron is covered by a standard LGPL licence. Please review the license agreement before installing. If you accept all terms of the license, click I Agree."


!define MUI_FINISHPAGE_TEXT "Thank you for installing Hadron."
!define MUI_FINISHPAGE_SHOWREADME $INSTDIR\releasenotes.txt
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show release notes"
!define MUI_FINISHPAGE_LINK "Go the PartikkelAudio webside for everything Hadron"
!define MUI_FINISHPAGE_LINK_LOCATION "www.partikkelaudio.com"
!define MUI_COMPONENTSPAGE_SMALLDESC

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\..\..\lgpl-3.0.txt"
!insertmacro MUI_PAGE_COMPONENTS
!define MUI_PAGE_CUSTOMFUNCTION_PRE dirPre

!define MUI_DIRECTORYPAGE_TEXT_TOP "Set 64 bit VST plugin path"
!define MUI_DIRECTORYPAGE_VARIABLE $VSTDIR64
;DirText $MyDirPageTxt64 VstPluginDir Browse "Set 64 bit plugin path"
!insertmacro MUI_PAGE_DIRECTORY

!define MUI_DIRECTORYPAGE_TEXT_TOP "Set 32 bit VST plugin path"
!define MUI_DIRECTORYPAGE_VARIABLE $VSTDIR32
;DirText $MyDirPageTxt32 VstPluginDir Browse "Set 32 bit plugin path"
!insertmacro MUI_PAGE_DIRECTORY


!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH


XPStyle on

ShowInstDetails show

Var /GLOBAL MaxDir

Section "HadronDSP library(required)" Section1
SectionIn RO
  
  ; set system variable 	
  ; include for some of the windows messages defines
  !include "winmessages.nsh"
  ; HKLM (all users) vs HKCU (current user) defines
  !define env_hklm 'HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"'
  !define env_hkcu 'HKCU "Environment"'
  ; set variable
  WriteRegExpandStr ${env_hklm} HADRONPATH "$PROGRAMFILES64\Hadron"
  ; make sure windows knows about the change
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000

  ; Copy files to C:\Program Files\Hadron
  SetOutPath $INSTDIR
  File "..\..\..\Hadron.orc"
  File "..\..\..\Hadron.sco"
  File "..\..\..\lgpl-3.0.txt"
  File "..\..\..\licence_HadronParticleSynthesizer.txt"
  File "..\..\..\Hadron_Csound_Standalone.csd"
  File "..\..\..\hadron_cs_standalone_sco.inc"
  File "..\..\..\default_preset.table"
  File "..\..\..\readme_standalone.txt"
  File "..\Release notes\releasenotes.txt"  
  File "..\Release notes\Hadron_1.3_release_notes.pdf"  
  
  Delete $INSTDIR\Csound_Hadron\*.*
  RMDir /r "$INSTDIR\Csound_Hadron"
  
  SetOutPath $INSTDIR\Csound_Hadron
  File "..\..\..\CsoundMod\win\Csound_Hadron\*.*"
  SetOutPath $INSTDIR\Csound_Hadron\bin
  File "..\..\..\CsoundMod\win\Csound_Hadron\bin32\*.dll"
  File "..\..\..\CsoundMod\win\Csound_Hadron\bin64\*.dll"
  ;SetOutPath $INSTDIR\Csound_Hadron\plugins64
  ;File "..\..\..\CsoundMod\win\Csound_Hadron\plugins64\*.*"
  SetOutPath $INSTDIR\inc
  File "..\..\..\inc\*.*"
  ;SetOutPath $INSTDIR\presets
  ;File "..\..\..\presets\*.*"
  SetOutPath $INSTDIR\states
  File "..\..\..\states\free\*.*"
  SetOutPath $INSTDIR\samples
  File "..\..\..\samples-release\*.*"
  SetOutPath $INSTDIR\docs
  File "..\..\..\docs\*.htm" 
  File "..\..\..\docs\*.html"
  File "..\..\..\docs\hadron.css"
  SetOutPath $INSTDIR\docs\images
  File "..\..\..\docs\images\*.*"
  SetOutPath $INSTDIR\docs\images\pagetitles
  File "..\..\..\docs\images\pagetitles\*.*"

  ; If we are moving from a 32 bit install to a 64 bit install, we want to copy any states and docs
  StrCmp $TempStates "" skipCopyOldStates
  StrCpy $0 $TempStates
  CopyFiles "$TempStates\states\*.*" "$INSTDIR\states"
  CopyFiles "$TempStates\docs\*.*" "$INSTDIR\docs"
  RMDir /r $TempStates
  skipCopyOldStates:

  ; Write the installation path into the registry
  WriteRegStr HKLM Software\Hadron "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Hadron" "DisplayName" "PartikkelAudio Hadron"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Hadron" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Hadron" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Hadron" "NoRepair" 1
  WriteUninstaller "uninstall.exe"

SectionEnd

Section "VST plugin" Section2
  SetOutPath $VSTDIR64\Hadron
  File "..\..\..\VST-AU\Builds\win-x64\hadron64.dll"
  File "..\VST_presets\*.fxb"
  SetOutPath $VSTDIR64\Hadron\free
  File "..\VST_presets\free\*.fxp"
  SetOutPath $VSTDIR32\Hadron
  File "..\..\..\VST-AU\Builds\win-x86\hadron32.dll"
  File "..\VST_presets\*.fxb"
  SetOutPath $VSTDIR32\Hadron\free
  File "..\VST_presets\free\*.fxp"

  ; Write the installation path into the registry
  WriteRegStr HKLM Software\Hadron "Hadron_Vst64_Dir" "$VSTDIR64\Hadron"
  WriteRegStr HKLM Software\Hadron "Hadron_Vst32_Dir" "$VSTDIR32\Hadron"
SectionEnd

;Section /o "Max for Live Device" Section3

  ; Run the Live Library Pack installer
;  SetOutPath $INSTDIR
;  File "..\..\LiveDevices_LibraryPack\HadronLiveLibraryPack.alp"
;  ExecShell "open" "$INSTDIR\HadronLiveLibraryPack.alp"

;  WriteRegStr HKLM Software\Hadron "Max_Dir" "$Maxdir"

;SectionEnd

; Descriptions
LangString DESC_Section1 ${LANG_ENGLISH} "The Hadron DSP library, with a custom version of Csound and the Csound orchestra code."
LangString DESC_Section2 ${LANG_ENGLISH} "The VST plugin is installed into a user selectable vst directory."
;LangString DESC_Section3 ${LANG_ENGLISH} "The Live device library pack installs into Ableton Live after the DSP installer has finished. $\nNOTE: You must restart Live after installation, as the installed max externals needs to be registered with Live"


!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1} $(DESC_Section1)
  !insertmacro MUI_DESCRIPTION_TEXT ${Section2} $(DESC_Section2)
;  !insertmacro MUI_DESCRIPTION_TEXT ${Section3} $(DESC_Section3)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function dirPre
  ${Unless} ${SectionIsSelected} ${Section2}
    Abort
  ${EndUnless}
FunctionEnd

; Uninstaller

Section "Uninstall"
  Var /GLOBAL Info
  StrCpy $Info "Hadron uninstalled successfully."

  ; get the installation paths
  ReadRegStr $INSTDIR HKLM Software\Hadron "Install_Dir" 
  ReadRegStr $VSTDIR64 HKLM Software\Hadron "Hadron_Vst_Dir64" 
  ReadRegStr $VSTDIR32 HKLM Software\Hadron "Hadron_Vst_Dir32" 

  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Hadron"
  DeleteRegKey HKLM Software\Hadron

  ; Remove files and uninstaller
  ${If} $VSTDIR64 != ''
  Delete $VSTDIR64\*.*
  RMDir /r "$VSTDIR64"
  ${EndIf}
  ${If} $VSTDIR32 != ''
  Delete $VSTDIR32\*.*
  RMDir /r "$VSTDIR32"
  ${EndIf}
  ${If} $INSTDIR != ''
  Delete $INSTDIR\*.*
  Delete $INSTDIR\uninstall.exe
  RMDir /r "$INSTDIR"
  ${EndIf}

  ; delete variable
  DeleteRegValue ${env_hklm} HADRONPATH
  ; make sure windows knows about the change
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000


SectionEnd

Function un.OnUninstSuccess

     HideWindow
     MessageBox MB_OK "$Info"
     
FunctionEnd

Section
.abort:
SectionEnd
