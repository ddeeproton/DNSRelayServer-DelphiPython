; Setup DNS Relay Server

!define VERSION "0.4.12"

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
ShowInstDetails show
; Set to silent mode
;SilentInstall silent
; Request application privileges for Windows Vista
RequestExecutionLevel admin


BGGradient 000000 000080 FFFFFF 
InstallColors 8080FF 000030 
XPStyle on

;--------------------------------
;Interface Settings

!define MUI_ABORTWARNING

!define MUI_ICON "..\images\server3.ico"
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

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  #!insertmacro MUI_UNPAGE_FINISH

;--------------------------------

; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File "..\DNSRelayServer.exe"
  File "..\DNSRelayServer_${VERSION}_Source.zip"
  
  CreateDirectory "$SMPROGRAMS\DNS Relay Server"
  #CreateShortCut "$SMPROGRAMS\DNSRelayServer\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\DNS Relay Server\DNS Relay Server.lnk" "$INSTDIR\DNSRelayServer.exe" "" "$INSTDIR\DNSRelayServer.exe" 0
  CreateShortCut "$DESKTOP\DNS Relay Server.lnk" "$INSTDIR\DNSRelayServer.exe" "" "$INSTDIR\DNSRelayServer.exe" 0

  
  #ExecShell "open"  '"${NSISDIR}\DNSRelayServer_TestVersion.exe"'
  #ExecWait '"${NSISDIR}\DNSRelayServer_TestVersion.exe"'
  #Exec '"${NSISDIR}\DNSRelayServer_TestVersion.exe"'
  Exec 'DNSRelayServer.exe /autostart'
  Quit
SectionEnd ; end the section

Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd
