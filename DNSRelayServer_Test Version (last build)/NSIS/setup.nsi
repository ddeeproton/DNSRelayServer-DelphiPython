; example1.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of example1.nsi
; there. 

;--------------------------------

; The name of the installer
Name "Example1"

; The file to write
OutFile "DNSRelayServerSetup_0.4.5.exe"

; The default installation directory
;InstallDir "$PROGRAMFILES\DNSRelayServer"
InstallDir "C:\DNSRelayServer"
ShowInstDetails show
; Set to silent mode
;SilentInstall silent
; Request application privileges for Windows Vista
RequestExecutionLevel admin

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
  File "..\DNSRelayServer_TestVersion.exe"
  
  #ExecShell "open"  '"${NSISDIR}\DNSRelayServer_TestVersion.exe"'
  #ExecWait '"${NSISDIR}\DNSRelayServer_TestVersion.exe"'
  #Exec '"${NSISDIR}\DNSRelayServer_TestVersion.exe"'
  Exec '"C:\DNSRelayServer\DNSRelayServer_TestVersion.exe"'
  Quit
SectionEnd ; end the section
