!include LogicLib.nsh
!include WinMessages.nsh
!include MUI2.nsh

Name "Hadron States pack installer"
OutFile "Hadron_StatesPack1_TimeDilation_VstMfl_Win.exe"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

Var VSTDIR 

!define MUI_WELCOMEPAGE_TEXT "Welcome, we will now start installation of the Time Dilation FX States Pack for the Hadron Particle Synthesizer. The pack primarily contains Hadron states, in addition it also contains VST presets, and device presets for the Hadron M4L devices."
!define MUI_LICENSEPAGE_TEXT_TOP "Hadron States Packs are covered by a proprietary licence. Please review the license agreement before installing. If you accept all terms of the license, click I Agree."
!define MUI_FINISHPAGE_TEXT "Thank you for installing this Hadron States Pack. If you chose to install Ableton Live components, Live will now start (if not already running) and complete the last stages of the installation process."
!define MUI_FINISHPAGE_LINK "Go the PartikkelAudio webside for everything Hadron"
!define MUI_FINISHPAGE_LINK_LOCATION "www.partikkelaudio.com"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\..\..\licence_States.txt"
!insertmacro MUI_PAGE_COMPONENTS
!define MUI_PAGE_CUSTOMFUNCTION_PRE dirPre
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH


XPStyle on

ShowInstDetails hide

Section "HadronDSP States pack and presets for Live Devices(required)" Section1
SectionIn RO
  
  ; get the installation paths
  ReadRegStr $INSTDIR HKLM "Software\Hadron" "Install_Dir" 
  IfErrors .abort

  ; Copy files to C:\Program Files\Hadron
  SetOutPath $INSTDIR\states
  File "..\..\..\states\statespack1\*.spst"

  SetOutPath $INSTDIR\docs
  File "..\..\..\docs\statespack1\*.htm"

  File /r "..\..\StatesPack_doc_rewrite_Win\*.*"

  SetOutPath $INSTDIR
  File "..\..\..\licence_States.txt"

  ExecWait '"$INSTDIR\docs\writeStatesDocumentation.exe"'

SectionEnd

Section "VST presets" Section2

  ; get the installation paths
  ReadRegStr $VSTDIR HKLM "Software\Hadron" "Hadron_Vst_Dir" 
  IfErrors .abort

  SetOutPath $VSTDIR\TimeDilationFX
  File "..\VST_presets\TimeDilationFX\*.fxp"
  SetOutPath $VSTDIR
  File "..\VST_presets\*.fxb"

SectionEnd
 
Section "Max for Live Device preset files, dependent on Cycling74 Max/MSP and Ableton Live" Section3

  ; Run the Live Library Pack installer
  SetOutPath $INSTDIR
  File "..\Efx1_HadronStatespack1.alp"
  ExecShell "open" "$INSTDIR\Efx1_HadronStatespack1.alp"

SectionEnd

; Descriptions
LangString DESC_Section1 ${LANG_ENGLISH} "The Hadron States and documentations installs into the Hadron DSP library." 
LangString DESC_Section2 ${LANG_ENGLISH} "Presets for the VST plugin are installed into subdirectories of the directory where the Hadron.dll was originally installed."
LangString DESC_Section3 ${LANG_ENGLISH} "Presets for (MaxFor)Live devices will be installed into Ableton Live after the DSP installer has finished."

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

Section
.abort:
SectionEnd
