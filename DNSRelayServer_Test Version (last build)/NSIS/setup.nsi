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
OutFile "DNSRelayServerSetup.exe"

; The default installation directory
InstallDir $DESKTOP\DNSRelay
ShowInstDetails show
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
  nsExec::Exec '"${NSISDIR}\DNSRelayServer_TestVersion.exe"'
	Pop $0 # return value/error/timeout
SectionEnd ; end the section
