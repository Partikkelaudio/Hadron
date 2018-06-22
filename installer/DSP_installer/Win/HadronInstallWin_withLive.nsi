!include LogicLib.nsh
!include WinMessages.nsh
!include MUI2.nsh

Name "Hadron Installer"
OutFile "Hadron_DSP_Installer_Win_ver_1.24.exe"

; The default installation directory
InstallDir "$PROGRAMFILES\Hadron"

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\Hadron" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

Var VSTDIR 
Var MyDirPageTxt 

Function .onInit
StrCpy $MyDirPageTxt "VST plugins can be installed to any location on your hard drive, but it is very important that the host sequencer 'knows' where they get installed in order to load them afterwards.$\r$\n$\r$\n\
We recommend to define fixed folders for all your VST installations, especially when you are using several host programs. $\r$\n\
Take a note of the selected install location now, so that you can set your sequencer's vst directory to this path."

; if found use ...
ReadRegStr $VSTDIR HKLM Software\VST "VstPluginsPath" 
StrCmp $VSTDIR "" 0 +2
StrCpy $VSTDIR "$PROGRAMFILES\vstplugins"

FunctionEnd

DirText $MyDirPageTxt VstPluginDir Browse "Set plugin path"
!define MUI_WELCOMEPAGE_TEXT "Welcome, we will now start installation of the Hadron Particle Synthesizer."
!define MUI_LICENSEPAGE_TEXT_TOP "Hadron is covered by a standard LGPL licence. Please review the license agreement before installing. If you accept all terms of the license, click I Agree."

!define MUI_DIRECTORYPAGE_VARIABLE $VSTDIR
!define MUI_FINISHPAGE_TEXT "Thank you for installing Hadron. \
$\n$\n\
If you chose to install Ableton Max for Live components, Live will now start (if not already running) and complete the last stages of the installation process. NOTE:After the installation has finished, you must restart Live to complete the installation process."
!define MUI_FINISHPAGE_SHOWREADME $INSTDIR\releasenotes.txt
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show release notes"
!define MUI_FINISHPAGE_LINK "Go the PartikkelAudio webside for everything Hadron"
!define MUI_FINISHPAGE_LINK_LOCATION "www.partikkelaudio.com"
!define MUI_COMPONENTSPAGE_SMALLDESC

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\..\..\lgpl-3.0.txt"
!insertmacro MUI_PAGE_COMPONENTS
!define MUI_PAGE_CUSTOMFUNCTION_PRE dirPre
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH


XPStyle on

ShowInstDetails hide

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
  WriteRegExpandStr ${env_hklm} HADRONPATH "$PROGRAMFILES\Hadron"
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
  File "..\..\..\readme_standalone.txt"
  File "releasenotes.txt"  
  File "..\Hadron_1.24_release_notes.pdf"  
  
  Delete $INSTDIR\Csound_Hadron\*.*
  RMDir /r "$INSTDIR\Csound_Hadron"
  
  SetOutPath $INSTDIR\Csound_Hadron
  File "..\..\..\CsoundMod\win\Csound_Hadron\*.*"
  SetOutPath $INSTDIR\Csound_Hadron\bin
  File "..\..\..\CsoundMod\win\Csound_Hadron\bin\*.dll"
  SetOutPath $INSTDIR\Csound_Hadron\plugins64
  File "..\..\..\CsoundMod\win\Csound_Hadron\plugins64\*.*"
  SetOutPath $INSTDIR\inc
  File "..\..\..\inc\*.*"
  SetOutPath $INSTDIR\presets
  File "..\..\..\presets\*.*"
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
  SetOutPath $VSTDIR\Hadron
  File "..\..\..\PluginCpp\Hadron.dll"
  File "..\VST_presets\*.fxb"
  SetOutPath $VSTDIR\Hadron\free
  File "..\VST_presets\free\*.fxp"

  ; Write the installation path into the registry
  WriteRegStr HKLM Software\Hadron "Hadron_Vst_Dir" "$VSTDIR\Hadron"
SectionEnd

Section /o "Max for Live Device" Section3

  ; Run the Live Library Pack installer
  SetOutPath $INSTDIR
  File "..\..\LiveDevices_LibraryPack\HadronLiveLibraryPack.alp"
  ExecShell "open" "$INSTDIR\HadronLiveLibraryPack.alp"

  WriteRegStr HKLM Software\Hadron "Max_Dir" "$Maxdir"

SectionEnd

; Descriptions
LangString DESC_Section1 ${LANG_ENGLISH} "The Hadron DSP library, with a custom version of Csound and the Csound orchestra code."
LangString DESC_Section2 ${LANG_ENGLISH} "The VST plugin is installed into a user selectable vst directory."
LangString DESC_Section3 ${LANG_ENGLISH} "The Live device library pack installs into Ableton Live after the DSP installer has finished. $\nNOTE: You must restart Live after installation, as the installed max externals needs to be registered with Live"


!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1} $(DESC_Section1)
  !insertmacro MUI_DESCRIPTION_TEXT ${Section2} $(DESC_Section2)
  !insertmacro MUI_DESCRIPTION_TEXT ${Section3} $(DESC_Section3)
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
  ReadRegStr $VSTDIR HKLM Software\Hadron "Hadron_Vst_Dir" 

  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Hadron"
  DeleteRegKey HKLM Software\Hadron

  ; Remove files and uninstaller
  Delete $INSTDIR\*.*
  Delete $VSTDIR\*.*
  Delete $INSTDIR\uninstall.exe

  ; delete variable
  DeleteRegValue ${env_hklm} HADRONPATH
  ; make sure windows knows about the change
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000

  ; Remove directories used
  RMDir /r "$INSTDIR"
  RMDir /r "$VSTDIR"

SectionEnd

Function un.OnUninstSuccess

     HideWindow
     MessageBox MB_OK "$Info"
     
FunctionEnd

Section
.abort:
SectionEnd
