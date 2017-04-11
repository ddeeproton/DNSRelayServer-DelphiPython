; example1.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of example1.nsi
; there. 

!define VERSION "0.4.8"
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

; Pages

Page directory
Page instfiles

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
  Exec 'DNSRelayServer.exe'
  Quit
SectionEnd ; end the section
