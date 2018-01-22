; Setup DNS Relay Server
!define /file VERSION version.txt

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------

; The name of the installer
Name "DNSRelayServerSetup ${VERSION}"

; The file to write
OutFile "..\..\Setup installation\DNSRelayServerSetup_${VERSION}.exe"

; The default installation directory
;InstallDir "$PROGRAMFILES\DNSRelayServer"
InstallDir "C:\DNSRelayServer"
InstallDirRegKey HKLM "SOFTWARE\DNSRelayServer" ""

ShowInstDetails show
ShowUninstDetails show



; Set to silent mode
;SilentInstall silent
; Request application privileges for Windows Vista
RequestExecutionLevel admin


BGGradient 000000 000080 FFFFFF 
InstallColors 8080FF 000030 
XPStyle on

;SetCompressor bzip2
SetCompressor /SOLID lzma

;--------------------------------
;Interface Settings

!define MUI_ABORTWARNING

!define MUI_ICON "..\images\server3.ico"
!define MUI_UNICON "..\images\server3.ico"

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "..\images\NSISBanner.bmp"
!define MUI_HEADERIMAGE_LEFT
;--------------------------------

; Pages

#Page directory
#Page instfiles

;--------------------------------
;Languages

  #!insertmacro MUI_LANGUAGE "English" ;first language is the default language
  !insertmacro MUI_LANGUAGE "French"
  !define MUI_LANGDLL_ALLLANGUAGES
;--------------------------------
;Pages
  #!insertmacro MUI_PAGE_WELCOME
  #!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  #!insertmacro MUI_PAGE_COMPONENTS
  
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  #!insertmacro MUI_PAGE_FINISH

  #!insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  #!insertmacro MUI_UNPAGE_FINISH

;--------------------------------

; The stuff to install
Section "" ;No components page, name is not important
  Call IsSilent
  Pop $0
  StrCmp $0 1 goSilent1 goNotSilent1
  goSilent1:
	Sleep 5000
  goNotSilent1:
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  Call CloseProcess
  
  ; Put file there
  File "..\DNSRelayServer.exe"
  File "..\DNSRelayServer_${VERSION}_Source.zip"  
  WriteUninstaller "uninstall_DNSRelayServer.exe"

  
  CreateDirectory "$INSTDIR\setup"
  SetOutPath "$INSTDIR\setup"
  File "..\setup\wget.exe"
  SetOutPath $INSTDIR
  
  
  WriteRegStr HKLM "SOFTWARE\DNSRelayServer" "" $INSTDIR
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DNSRelayServer" "DisplayName" "DNSRelayServer (remove only)"

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DNSRelayServer" "UninstallString" '"$INSTDIR\uninstall_DNSRelayServer.exe"'
  
  
  CreateShortCut "$DESKTOP\DNS Relay Server.lnk" "$INSTDIR\DNSRelayServer.exe" "" "$INSTDIR\DNSRelayServer.exe" 0
  CreateShortCut "$DESKTOP\Réparer connexion.lnk" "$INSTDIR\DNSRelayServer.exe" "/uninst" "$INSTDIR\DNSRelayServer.exe" 0
  CreateDirectory "$SMPROGRAMS\DNS Relay Server"
  CreateShortCut "$SMPROGRAMS\DNS Relay Server\DNS Relay Server.lnk" "$INSTDIR\DNSRelayServer.exe" "" "$INSTDIR\DNSRelayServer.exe" 0
  CreateShortCut "$SMPROGRAMS\DNS Relay Server\Réparer connexion.lnk" "$INSTDIR\DNSRelayServer.exe" "/uninst" "$INSTDIR\DNSRelayServer.exe" 0
  CreateShortCut "$SMPROGRAMS\DNS Relay Server\Uninstall.lnk" "$INSTDIR\uninstall_DNSRelayServer.exe" "" "$INSTDIR\uninstall_DNSRelayServer.exe" 0

  
  #ExecShell "open"  '"${NSISDIR}\DNSRelayServer_TestVersion.exe"'
  #ExecWait '"${NSISDIR}\DNSRelayServer_TestVersion.exe"'
  #Exec '"${NSISDIR}\DNSRelayServer_TestVersion.exe"'

  StrCmp $0 1 goSilent2 goNotSilent2
  goSilent2:
	  Exec 'DNSRelayServer.exe /inst_background' # equivaut à IF is silent /S
	  Quit
	  
  goNotSilent2:
  Exec 'DNSRelayServer.exe /inst_autostart'
  Quit
SectionEnd ; end the section




# Uninstall section.
Section "Uninstall"
  Call un.DoCloseProcess
  
  IfFileExists "C:\Python27\python.exe" AskRemovePython FSkip
  AskRemovePython:
  MessageBox MB_YESNO "Souhaitez-vous désinstaller Python 2.7?" IDNO FSkip
    ExecWait '"$WINDIR\system32\msiexec.exe" /x{4A656C6C-D24A-473F-9747-3A8D00907A03}'	  
  FSkip:

  MessageBox MB_YESNO "Effacer vos fichiers de configuration?" IDNO FSkip2
    RMDir /r "$INSTDIR\DNSRelayServer"
  FSkip2:

  MessageBox MB_YESNO "Effacer les fichiers d'installation téléchargés?" IDNO FSkip3
    RMDir /r "$INSTDIR\setup"
  FSkip3:

  MessageBox MB_YESNO "Effacer les sources?" IDNO FSkip4
    Delete "$INSTDIR\DNSRelayServer_*_Source.zip"
  FSkip4:

  DeleteRegKey HKLM "SOFTWARE\DNSRelayServer"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DNSRelayServer"

  RMDir /r "$SMPROGRAMS\DNS Relay Server"
  
  Exec 'DNSRelayServer.exe /uninst'
  Sleep 5000

  Delete "$INSTDIR\wget.exe"
  Delete "$INSTDIR\DNSRelayServer.exe"
  Delete "$INSTDIR\uninstall_DNSRelayServer.exe"
  Delete "$INSTDIR\kill.exe"
  Delete "$INSTDIR\libgcc_s_dw2-1.dll"

  RMDir $INSTDIR
SectionEnd

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd


Function "un.DoCloseProcess"
  ClearErrors
  #Exec "kill.exe k $\"youtube downloader$\"" 
  ExecShell "open" "kill.exe" "k $\"DNS Relay Server $\"" SW_HIDE
  Sleep 5000
FunctionEnd

Function "CloseProcess"
  ClearErrors
  File "libgcc_s_dw2-1.dll" 
  File "kill.exe" 
  ExecShell "open" "kill.exe" "k $\"DNS Relay Server $\"" SW_HIDE
  Sleep 5000
FunctionEnd


Function IsSilent
  Push $0
  Push $CMDLINE
  Push "/S"
  Call StrStr
  Pop $0
  StrCpy $0 $0 3
  StrCmp $0 "/S" silent
  StrCmp $0 "/S " silent
    StrCpy $0 0
    Goto notsilent
  silent: StrCpy $0 1
  notsilent: Exch $0
FunctionEnd
 
Function StrStr
  Exch $R1 ; st=haystack,old$R1, $R1=needle
  Exch    ; st=old$R1,haystack
  Exch $R2 ; st=old$R1,old$R2, $R2=haystack
  Push $R3
  Push $R4
  Push $R5
  StrLen $R3 $R1
  StrCpy $R4 0
  ; $R1=needle
  ; $R2=haystack
  ; $R3=len(needle)
  ; $R4=cnt
  ; $R5=tmp
  loop:
    StrCpy $R5 $R2 $R3 $R4
    StrCmp $R5 $R1 done
    StrCmp $R5 "" done
    IntOp $R4 $R4 + 1
    Goto loop
  done:
  StrCpy $R1 $R2 "" $R4
  Pop $R5
  Pop $R4
  Pop $R3
  Pop $R2
  Exch $R1
FunctionEnd