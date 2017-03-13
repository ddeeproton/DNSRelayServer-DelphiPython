unit UnitInstallation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  // Pour le registre
  Registre,
  // Pour download
  UrlMon,
  // pour FindExecutable
  ShellAPI,
  // Pour lire écrire dans un fichier
  FilesManager;

function LaunchAndWait(sFile: String; wShowWin: Word): Boolean;

type
  TFormInstall = class(TForm)
    Notebook1: TNotebook;
    Panel1: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    LabelPython: TLabel;
    LabelDNSResolver: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    LabelSetuptools: TLabel;
    LabelWget: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    ButtonStep1Next: TButton;
    Panel2: TPanel;
    Image1: TImage;
    Label5: TLabel;
    Label7: TLabel;
    Label16: TLabel;
    Label9: TLabel;
    ButtonContinueWgetManuallyDownload: TButton;
    Edit1: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    EditCurrentDir: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    TimerWatchThread: TTimer;
    procedure ButtonStep1NextClick(Sender: TObject);
    procedure CheckInstallation();
    function getPythonPath():string;
    procedure installPython();
    procedure installDNS();
    procedure installWget();
    procedure installSetuptools();

    procedure FormCreate(Sender: TObject);
    procedure ButtonContinueWgetManuallyDownloadClick(Sender: TObject);
    procedure DoInstall();
    procedure TimerWatchThreadTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  TInstall = class(TThread)
  protected
    procedure Execute; override;
  public
    LabelWget: string;
    LabelPython: string;
    LabelDNSResolver: string;
    LabelSetuptools: string;
  end;
var
  FormInstall: TFormInstall;
  launchAndWWindow: Word = SW_HIDE;      //SW_SHOWNORMAL    SW_HIDE
  PythonPath: string = '';
  isPythonInstalled: bool = false;
  isDNSInstalled: bool = false;
  isSetuptoolInstalled: bool = false;
  isWgetInstalled: bool = false;
  installThread: TInstall = nil;
  installDirectoryPath: string = 'setup\';
implementation

{$R *.dfm}

function TFormInstall.getPythonPath():string;
begin
  result := ReadString(HKEY_LOCAL_MACHINE, 'SOFTWARE\Python\PythonCore\2.7\InstallPath', '');
  if (result = '') and FileExists('c:\Python27\python.exe') then result := 'c:\Python27\';
end;




procedure TFormInstall.CheckInstallation();
var r: string;
begin
  PythonPath := getPythonPath();

  isPythonInstalled := FileExists(PythonPath+'python.exe');
  isDNSInstalled := FileExists(PythonPath+'Lib\site-packages\dnspython-1.15.0-py2.7.egg-info')
                  or FileExists(PythonPath+'Lib\site-packages\dnspython-1.15.0-py2.7.egg');
  isWgetInstalled := FileExists(ExtractFilePath(Application.ExeName)+installDirectoryPath+'wget.exe');
  isSetuptoolInstalled := FileExists(PythonPath+'Lib\site-packages\setuptools-20.0-py2.7.egg-info')
                      or FileExists(PythonPath+'Lib\site-packages\setuptools-20.0-py2.7.egg')
                      or FileExists(PythonPath+'Lib\site-packages\setuptools-20.0.dev0-py2.7.egg');

  if isWgetInstalled then
    r := 'Installé'
  else
    if (installThread = nil) or (installThread.LabelWget = '') then
      r := 'Non installé'
    else
      r := installThread.LabelWget;
  LabelWget.Caption := PChar(r);

  if isPythonInstalled then
    r := 'Installé'
  else
    if (installThread = nil) or (installThread.LabelPython = '') then
      r := 'Non installé'
    else
      r := installThread.LabelPython;
  LabelPython.Caption := PChar(r);

  if isDNSInstalled then
    r := 'Installé'
  else
    if (installThread = nil) or (installThread.LabelDNSResolver = '') then
      r := 'Non installé'
    else
      r := installThread.LabelDNSResolver;
  LabelDNSResolver.Caption := PChar(r);

  if isSetuptoolInstalled then
    r := 'Installé'
  else
    if (installThread = nil) or (installThread.LabelSetuptools = '') then
      r := 'Non installé'
    else
      r := installThread.LabelSetuptools;
  LabelSetuptools.Caption := PChar(r);

  if (installThread <> nil) and not installThread.Terminated then
  begin
    installThread.LabelWget := LabelWget.Caption;
    installThread.LabelPython := LabelPython.Caption;
    installThread.LabelDNSResolver := LabelDNSResolver.Caption;
    installThread.LabelSetuptools := LabelSetuptools.Caption;
  end;
end;

procedure TInstall.Execute;
begin
  FormInstall.DoInstall();
  installThread.Terminate;
end;

procedure TFormInstall.ButtonStep1NextClick(Sender: TObject);
begin
  ButtonStep1Next.Enabled := False;
  TimerWatchThread.Enabled := True;
  installThread := TInstall.Create(False);
  if (installThread <> nil) and not installThread.Terminated then
  begin
    installThread.LabelWget := LabelWget.Caption;
    installThread.LabelPython := LabelPython.Caption;
    installThread.LabelDNSResolver := LabelDNSResolver.Caption;
    installThread.LabelSetuptools := LabelSetuptools.Caption;
  end;
end;

procedure TFormInstall.DoInstall();
begin
  if not isWgetInstalled then installWget();
  if not isWgetInstalled then begin ButtonStep1Next.Enabled := True; Application.ProcessMessages; exit; end;
  if not isPythonInstalled then installPython();
  if not isPythonInstalled then begin ButtonStep1Next.Enabled := True; Application.ProcessMessages; exit; end;
  if not isSetuptoolInstalled then installSetuptools();
  if not isDNSInstalled then installDNS();
end;


procedure TFormInstall.installWget();
var
  exePath, url: string;
begin
  installThread.LabelWget := PChar('Downloading...');
  exePath := ExtractFilePath(Application.ExeName)+installDirectoryPath+'wget.exe';
  url := 'http://eternallybored.org/misc/wget/current/wget.exe';
  if URLDownloadToFile(nil, PChar(url), PChar(exePath), 0 , nil) <> 0 then
    if not FileExists(exePath) then
      installThread.LabelWget := 'Error';
      //Notebook1.PageIndex := 1;
end;


procedure TFormInstall.installPython();
var
  exePath, url, wget: string;
begin
  installThread.LabelPython := PChar('Downloading...');
  exePath := ExtractFilePath(Application.ExeName)+installDirectoryPath+'python-2.7.13.msi';
  url := 'https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi';

  if not FileExists(exePath) then
  begin
    wget := ExtractFilePath(Application.ExeName)+installDirectoryPath+'wget.exe';
    if not FileExists(wget) then begin CheckInstallation(); exit; end;
    ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloadPython.bat', '"'+wget+'" -O "'+exePath+'" "'+url+'" --no-check-certificate');
    LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloadPython.bat',  launchAndWWindow);
  end;                    
  installThread.LabelPython := PChar('Installation...');
  if not FileExists(exePath) then begin CheckInstallation(); exit; end;
  ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installPython27.bat', 'msiexec /i "'+exePath+'" TARGETDIR="c:\Python27" /qb');
  LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installPython27.bat', launchAndWWindow);

  // msiexec /i "python-2.7.13.msi" TARGETDIR="c:\Python27" /qb!
  // https://www.python.org/downloads/
  {
    //https://www.python.org/download/releases/2.4/msi/
  ALLUSERS=1
  /qn - No interface
  /qb - Basic interface - just a small progress dialog
  /qb! - Like /qb, but hide the Cancel button
  /qr - Reduced interface - display all dialogs that don't require user interaction (skip all modal dialogs)
  /qn+ - Like /qn, but display "Completed" dialog at the end
  /qb+ - Like /qb, but display "Completed" dialog at the end
  }

end;

procedure TFormInstall.installDNS();
var
  exePath, url, wget, vbs, outdir, bat: string;
begin
  LabelDNSResolver.Caption := PChar('cheking...');
  Application.ProcessMessages;

  exePath := ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0.zip';
  outdir :=  ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0';
  url := 'http://www.dnspython.org/kits/1.15.0/dnspython-1.15.0.zip';

  wget := ExtractFilePath(Application.ExeName)+installDirectoryPath+'wget.exe';
  if not FileExists(wget) then begin CheckInstallation(); exit; end;

  if not FileExists(exePath) then
  begin
    installThread.LabelDNSResolver := PChar('Downloading...');
    Application.ProcessMessages;
    ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloaddns.bat', '"'+wget+'" -O "'+exePath+'" "'+url+'" --no-check-certificate');
    LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloaddns.bat', launchAndWWindow);
  end;
  if not FileExists(exePath) then exit;

  installThread.LabelDNSResolver := PChar('Unzipping...');
  vbs := 'Sub UnZip(ZipFile, ExtractTo)'#13#10+
    '	Set fso = CreateObject("Scripting.FileSystemObject")'#13#10+
    '	If NOT fso.FolderExists(ExtractTo) Then'#13#10+
    '		fso.CreateFolder(ExtractTo)'#13#10+
    '	End If'#13#10+
    '	set objShell = CreateObject("Shell.Application")'#13#10+
    '	set FilesInZip=objShell.NameSpace(ZipFile).items'#13#10+
    '	objShell.NameSpace(ExtractTo).CopyHere(FilesInZip)'#13#10+
    '	Set fso = Nothing'#13#10+
    '	Set objShell = Nothing'#13#10+
    'End Sub'#13#10+
    'UnZip WScript.Arguments(0), WScript.Arguments(1)'#13#10;
  ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzip.vbs', vbs);
  ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzip.vbs.bat', 'wscript.exe "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzip.vbs" "'+exePath+'" "'+outdir+'"');
  LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzip.vbs.bat', launchAndWWindow);

  installThread.LabelDNSResolver := PChar('Installation...');
  if FileExists(exePath) then
  begin
    bat := 'cd  "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0\dnspython-1.15.0"'#13#10+
      '"'+PythonPath+'python.exe" "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0\dnspython-1.15.0\setup.py" install';
    ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installDNS.bat', bat);
    LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installDNS.bat', launchAndWWindow);
  end;

end;


procedure TFormInstall.installSetuptools();
var
  exePath, url, wget, vbs, outdir, bat: string;
begin
  installThread.LabelSetuptools := PChar('cheking...');
  Application.ProcessMessages;

  exePath := ExtractFilePath(Application.ExeName)+installDirectoryPath+'setuptools-20.0.zip';
  outdir :=  ExtractFilePath(Application.ExeName)+installDirectoryPath+'setuptools-20.0';
  url := 'https://github.com/pypa/setuptools/archive/20.0.zip';
  
  wget := ExtractFilePath(Application.ExeName)+installDirectoryPath+'wget.exe';
  if not FileExists(wget) then begin CheckInstallation(); exit; end;

  if not FileExists(exePath) then
  begin
    installThread.LabelSetuptools := PChar('Downloading...');
    Application.ProcessMessages;
    ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloadsetuptools.bat', '"'+wget+'" -O "'+exePath+'" "'+url+'" --no-check-certificate');
    LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloadsetuptools.bat', launchAndWWindow);
  end;
  if not FileExists(exePath) then exit;

  installThread.LabelSetuptools := PChar('Unzipping...');
  vbs := 'Sub UnZip(ZipFile, ExtractTo)'#13#10+
    '	Set fso = CreateObject("Scripting.FileSystemObject")'#13#10+
    '	If NOT fso.FolderExists(ExtractTo) Then'#13#10+
    '		fso.CreateFolder(ExtractTo)'#13#10+
    '	End If'#13#10+
    '	set objShell = CreateObject("Shell.Application")'#13#10+
    '	set FilesInZip=objShell.NameSpace(ZipFile).items'#13#10+
    '	objShell.NameSpace(ExtractTo).CopyHere(FilesInZip)'#13#10+
    '	Set fso = Nothing'#13#10+
    '	Set objShell = Nothing'#13#10+
    'End Sub'#13#10+
    'UnZip WScript.Arguments(0), WScript.Arguments(1)'#13#10;
  ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzipst.vbs', vbs);
  ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzipst.vbs.bat', 'wscript.exe "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzipst.vbs" "'+exePath+'" "'+outdir+'"');
  LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzipst.vbs.bat', launchAndWWindow);

  installThread.LabelSetuptools := PChar('Installation...');
  if FileExists(exePath) then
  begin
    bat := 'cd  "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'setuptools-20.0\setuptools-20.0"'#13#10+
      '"'+PythonPath+'python.exe" "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'setuptools-20.0\setuptools-20.0\setup.py" install'#13#10+
      '';
    ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installst.bat', bat);
    LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installst.bat', launchAndWWindow);
  end;

end;






function LaunchAndWait(sFile: String; wShowWin: Word): Boolean;
var
  cExe: array [0..255] of Char;
  sExe: string;
  pcFile: PChar;
  StartInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  Result:=True;

  FindExecutable(PChar(ExtractFileName(sFile)), PChar(ExtractFilePath(sFile)), cExe);
  sExe:= string(cExe);
  if UpperCase(ExtractFileName(sExe))<>UpperCase(ExtractFileName(sFile))
  then pcFile:=PChar(' "'+sFile+'"')
  else pcFile:=nil;
  ZeroMemory(@StartInfo, SizeOf(StartInfo));
  with StartInfo do begin
    cb:=SizeOf(StartInfo);
    dwFlags:=STARTF_USESHOWWINDOW;
    wShowWindow:=wShowWin;
  end;
  if CreateProcess(PChar(sExe), pcFile, nil, nil, True, 0, nil, nil, StartInfo, ProcessInfo)
  then WaitForSingleObject(ProcessInfo.hProcess, INFINITE)
  else Result:=False;
end;

procedure TFormInstall.FormCreate(Sender: TObject);
begin
  EditCurrentDir.Text := ExtractFilePath(Application.ExeName)+installDirectoryPath;
  //makeDir();
end;

procedure TFormInstall.ButtonContinueWgetManuallyDownloadClick(
  Sender: TObject);
begin
  CheckInstallation;
  Notebook1.PageIndex := 0;
end;

procedure TFormInstall.TimerWatchThreadTimer(Sender: TObject);
begin
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+installDirectoryPath) then
    makeDir(ExtractFilePath(Application.ExeName)+installDirectoryPath);
  ButtonStep1Next.Enabled := installThread.Terminated;
  if installThread.Terminated then TTimer(Sender).Enabled := False;
  if installThread.Terminated and (installThread.LabelWget = 'Error') then
  begin
    Notebook1.PageIndex := 1;
    installThread.LabelWget := 'Non installé';
  end;
  CheckInstallation();
  {
  LabelWget.Caption := PChar(installThread.LabelWget);
  LabelPython.Caption := PChar(installThread.LabelPython);
  LabelDNSResolver.Caption := PChar(installThread.LabelDNSResolver);
  LabelSetuptools.Caption := PChar(installThread.LabelSetuptools);
   }
  Application.ProcessMessages;
end;

end.
