@echo off

set v=0.4.30

echo Version %v%

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
copy /Y images\* DNSRelayServer_%v%_Source\images\mainmenu\
copy /Y images\* DNSRelayServer_%v%_Source\NSIS\

del /Q DNSRelayServer_%v%_Source\DNSRelayServer.exe

NSIS\7za920\7za.exe a DNSRelayServer_%v%_Source.zip DNSRelayServer_%v%_Source 

del /Q DNSRelayServer_%v%_Source\NSIS\*
del /Q DNSRelayServer_%v%_Source\images\mainmenu\*
del /Q DNSRelayServer_%v%_Source\images\*
del /Q DNSRelayServer_%v%_Source\*

rmdir DNSRelayServer_%v%_Source\NSIS
rmdir DNSRelayServer_%v%_Source\images\mainmenu
rmdir DNSRelayServer_%v%_Source\images
rmdir DNSRelayServer_%v%_Source



echo ==============================
echo Creation du Setup installation
echo ==============================

mkdir "..\Setup installation"
cd NSIS
"C:\Program Files\NSIS\makensis.exe" setup.nsi
del /Q ..\DNSRelayServer_%v%_Source.zip


echo ==============================
echo Done.
echo ==============================
