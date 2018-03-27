@echo off

@rem set v=0.4.39
set /p v=<version.txt




echo Compilation Version %v%

@pause

echo NSIS version 3.01 est requis
echo http://prdownloads.sourceforge.net/nsis/nsis-3.01-setup.exe


cd ..
echo ==============================
echo Creation du fichier source ZIP
echo ==============================
mkdir DNSRelayServer_%v%_Source
mkdir DNSRelayServer_%v%_Source\images
mkdir DNSRelayServer_%v%_Source\images\mainmenu
mkdir DNSRelayServer_%v%_Source\NSIS\

del /Q *.~ddp
del /Q *.~dfm
del /Q *.~pas
del /Q *.dcu
del /Q *.ddp
del /Q *.dof

copy /Y * DNSRelayServer_%v%_Source
copy /Y images\* DNSRelayServer_%v%_Source\images\
copy /Y images\mainmenu\* DNSRelayServer_%v%_Source\images\mainmenu\
copy /Y NSIS\* DNSRelayServer_%v%_Source\NSIS\

del /Q DNSRelayServer_%v%_Source\DNSRelayServer.exe

NSIS\7za920\7za.exe a DNSRelayServer_%v%_Source.zip DNSRelayServer_%v%_Source 

if not exist DNSRelayServer_%v%_Source.zip echo Compression fail! DNSRelayServer_%v%_Source.zip
if not exist DNSRelayServer_%v%_Source.zip @pause
if not exist DNSRelayServer_%v%_Source.zip exit


del /Q DNSRelayServer_%v%_Source\NSIS\*
del /Q DNSRelayServer_%v%_Source\images\mainmenu\*
del /Q DNSRelayServer_%v%_Source\images\*
del /Q DNSRelayServer_%v%_Source\*

rmdir DNSRelayServer_%v%_Source\NSIS
rmdir DNSRelayServer_%v%_Source\images\mainmenu
rmdir DNSRelayServer_%v%_Source\images
rmdir DNSRelayServer_%v%_Source


set ns64="C:\Program Files\NSIS\makensis.exe"
set ns86="C:\Program Files (x86)\NSIS\makensis.exe"

set ns=%ns64%
if not exist %ns64% set ns=%ns86%

if not exist %ns% echo ============================== 
if not exist %ns% echo !! NSIS: is not found !!
if not exist %ns% echo %ns64% (not found)
if not exist %ns% echo %ns86% (not found)
if not exist %ns% echo ============================== 
if not exist %ns% @pause

echo ==============================
echo Creation du Setup installation
echo ==============================

set si="..\Setup installation"
if not exist %si% mkdir %si%
cd "NSIS"

%ns% setup.nsi

copy /Y "..\DNSRelayServer_%v%_Source.zip" "..\..\Sources"
del /Q "..\DNSRelayServer_%v%_Source.zip"


echo ==============================
echo Done.
echo ==============================

del /Q "..\..\Setup installation\DNSRelayServerSetup.exe"
copy "..\..\Setup installation\DNSRelayServerSetup_%v%.exe" "..\..\Setup installation\DNSRelayServerSetup.exe"

"..\..\Setup installation\DNSRelayServerSetup_%v%.exe"

@rem pause