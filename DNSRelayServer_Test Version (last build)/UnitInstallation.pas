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
  FilesManager,
  // Pour LaunchAndWait
  ProcessManager;



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
    procedure ButtonInstallClick(Sender: TObject);
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
    isPythonInstalled: bool;
    isDNSInstalled: bool;
    isSetuptoolInstalled: bool;
    isWgetInstalled: bool;
    procedure CheckInstallation();    
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

  installThread: TInstall = nil;
  installDirectoryPath: string = 'setup\';
  setOutputInForm1: bool = False;
  isDebug: bool = False;
implementation

uses Unit1;

{$R *.dfm}

function TFormInstall.getPythonPath():string;
begin
  result := '';
  if ReadStringExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Python\PythonCore\2.7\InstallPath', '') then
    result := ReadString(HKEY_LOCAL_MACHINE, 'SOFTWARE\Python\PythonCore\2.7\InstallPath', '');
  if (result = '') and FileExists('c:\Python27\python.exe') then result := 'c:\Python27\';
end;




procedure TFormInstall.CheckInstallation();
var
  r: string;

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
  FormInstall.CheckInstallation();
  FormInstall.DoInstall();
//FormInstall.LabelDNSResolver.Caption := PChar('a5');
  installThread.Terminate;
end;

procedure TFormInstall.ButtonInstallClick(Sender: TObject);
begin
  //if ButtonInstall.Enabled = False then exit;
  //ButtonInstall.Enabled := False;
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
  TimerWatchThread.Enabled := True;
  CheckInstallation();
  if not isWgetInstalled      then installWget();
  if not isWgetInstalled      then begin installThread.LabelWget := Pchar('Err DoInstall() 1'); Application.ProcessMessages; exit; end;
  if not isPythonInstalled    then installPython();
  if not isPythonInstalled    then begin installThread.LabelWget := Pchar('Err DoInstall() 2'); Application.ProcessMessages; exit; end;
  if not isSetuptoolInstalled then installSetuptools();
  if not isDNSInstalled       then installDNS();
  TimerWatchThread.Enabled := False;
end;


procedure TFormInstall.installWget();
var
  exePath, url: string;
begin
  installThread.LabelWget := PChar('Downloading...');
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+installDirectoryPath) then
    makeDir(ExtractFilePath(Application.ExeName)+installDirectoryPath);
  exePath := ExtractFilePath(Application.ExeName)+installDirectoryPath+'wget.exe';
  url := 'http://eternallybored.org/misc/wget/current/wget.exe';
  if URLDownloadToFile(nil, PChar(url), PChar(exePath), 0 , nil) <> 0 then
    if not FileExists(exePath) then
      installThread.LabelWget := 'Error';
  Sleep(2000);
  Application.ProcessMessages;
  CheckInstallation();
  DoInstall();
      //Notebook1.PageIndex := 1;
end;


procedure TFormInstall.installPython();
var
  exePath, url, wget: string;
begin
  exePath := ExtractFilePath(Application.ExeName)+installDirectoryPath+'python-2.7.13.msi';
  url := 'https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi';
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+installDirectoryPath) then
    makeDir(ExtractFilePath(Application.ExeName)+installDirectoryPath);
  if not FileExists(exePath) then
  begin
    installThread.LabelPython := PChar('Downloading...');
    wget := ExtractFilePath(Application.ExeName)+installDirectoryPath+'wget.exe';
    if not FileExists(wget) then begin CheckInstallation(); exit; end;
    LaunchAndWait(wget, ' -O "'+exePath+'" "'+url+'" --no-check-certificate', launchAndWWindow);
    //'"'+wget+'" -O "'+exePath+'" "'+url+'" --no-check-certificate'
    //ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloadPython.bat', '"'+wget+'" -O "'+exePath+'" "'+url+'" --no-check-certificate');
    //LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloadPython.bat',  launchAndWWindow);
  end;
  installThread.LabelPython := PChar('Installation... [1)');
  if not FileExists(exePath) then begin CheckInstallation(); exit; end;
  installThread.LabelPython := PChar('Installation... [2)');
  //ExecAndWait('msiexec.exe', '/i "'+exePath+'" TARGETDIR="c:\Python27" /qb', launchAndWWindow);
  WriteInFile(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installPython27.bat', 'msiexec /i "'+exePath+'" TARGETDIR="c:\Python27" /qb');
  LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installPython27.bat','', launchAndWWindow);
  installThread.LabelPython := PChar('Installation... [3)');

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
  CheckInstallation();
  DoInstall();
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
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+installDirectoryPath) then
    makeDir(ExtractFilePath(Application.ExeName)+installDirectoryPath);
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+installDirectoryPath+'setuptools-20.0\setuptools-20.0') then begin

  wget := ExtractFilePath(Application.ExeName)+installDirectoryPath+'wget.exe';
  if not FileExists(wget) or (FileSize(wget) = 0) then begin CheckInstallation(); exit; end;

  if not FileExists(exePath) or (FileSize(exePath) = 0) then
  begin
    if FileExists(exePath) then DeleteFile(exePath);
    installThread.LabelSetuptools := PChar('Downloading...');
    Application.ProcessMessages;

    //LaunchAndWait(wget, '-O "'+exePath+'" "'+url+'" --no-check-certificate', launchAndWWindow);

    WriteInFile(
      ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloadsetuptools.bat',
      '"'+wget+'" -O "'+exePath+'" "'+url+'" --no-check-certificate'
    );
    LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloadsetuptools.bat','', launchAndWWindow);
  end;

  if FileExists(exePath) and (FileSize(exePath) = 0) then DeleteFile(exePath);

  if not FileExists(exePath) or (FileSize(exePath) = 0) then begin
    installThread.LabelSetuptools := PChar('Downloaded file not found.');
    exit;
  end;


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

  if DirectoryExists(outdir) then RemoveDir(outdir);

  WriteInFile(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzipst.vbs', vbs);

  //LaunchAndWait('wscript.exe', '"'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzipst.vbs" "'+exePath+'" "'+outdir+'"', launchAndWWindow);
  WriteInFile(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzipst.vbs.bat', 'wscript.exe "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzipst.vbs" "'+exePath+'" "'+outdir+'"');
  LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzipst.vbs.bat','', launchAndWWindow);

  end;
  
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+installDirectoryPath+'setuptools-20.0\setuptools-20.0') then begin
    if FileExists(exePath) then DeleteFile(exePath);
    installSetuptools();
    exit;
  end;


  installThread.LabelSetuptools := PChar('Installation...');
  if FileExists(exePath) or (FileSize(exePath) = 0) then
  begin
    //SetCurrentDir(ExtractFilePath(Application.ExeName)+installDirectoryPath+'setuptools-20.0\setuptools-20.0');
    //LaunchAndWait(PythonPath+'python.exe', '"'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'setuptools-20.0\setuptools-20.0\setup.py" install', launchAndWWindow);


    bat := 'cd  "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'setuptools-20.0\setuptools-20.0"'#13#10+
      '"'+PythonPath+'python.exe" "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'setuptools-20.0\setuptools-20.0\setup.py" install'#13#10+
      '';
    if isDebug then bat := bat + #13#10 + '@pause';
    WriteInFile(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installst.bat', bat);
    LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installst.bat','', launchAndWWindow);

  end;
  CheckInstallation();
  DoInstall();
end;




procedure TFormInstall.installDNS();
var
  exePath, url, wget, vbs, outdir, bat: string;
begin

  installThread.LabelDNSResolver := PChar('cheking...');
  Application.ProcessMessages;

  exePath := ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0.zip';
  outdir :=  ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0';
  url := 'http://www.dnspython.org/kits/1.15.0/dnspython-1.15.0.zip';
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+installDirectoryPath) then
    makeDir(ExtractFilePath(Application.ExeName)+installDirectoryPath);
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0\dnspython-1.15.0') then
  begin

    wget := ExtractFilePath(Application.ExeName)+installDirectoryPath+'wget.exe';
    if not FileExists(wget) or (FileSize(wget) = 0) then begin
      CheckInstallation();
      installThread.LabelDNSResolver := PChar('wget.exe not found');
      exit;
    end;

    if not FileExists(exePath) or (FileSize(exePath) = 0) then
    begin
      if FileExists(exePath) then DeleteFile(exePath);
      installThread.LabelDNSResolver := PChar('Downloading...');
      Application.ProcessMessages;
      //LaunchAndWait(wget, '-O "'+exePath+'" "'+url+'" --no-check-certificate', launchAndWWindow);
      WriteInFile(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloaddns.bat', '"'+wget+'" -O "'+exePath+'" "'+url+'" --no-check-certificate');
      LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'downloaddns.bat','', launchAndWWindow);
    end;

    if FileExists(exePath) and (FileSize(exePath) = 0) then DeleteFile(exePath);
    if not FileExists(exePath) or (FileSize(exePath) = 0) then exit;

    Sleep(2000);
    installThread.LabelDNSResolver := PChar('Unzipping... 1');
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
    WriteInFile(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzip.vbs', vbs);
    WriteInFile(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzip.vbs.bat', 'wscript.exe "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzip.vbs" "'+exePath+'" "'+outdir+'"'+#13#10+'@rem pause');
    installThread.LabelDNSResolver := PChar('Unzipping... 2');
    LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzip.vbs.bat', '', launchAndWWindow);
    installThread.LabelDNSResolver := PChar('Unzipping... 3');
    //LaunchAndWait('wscript.exe', '"'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'unzip.vbs" "'+exePath+'" "'+outdir+'"', launchAndWWindow);

    {
    if DirectoryExists(outdir) then RemoveDir(outdir);
    if DirectoryExists(outdir) then begin
      exit;
    end;
    }
    installThread.LabelDNSResolver := PChar('Unzip done...');
    Sleep(2000);
  end;

  if not DirectoryExists(ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0\dnspython-1.15.0') then begin
    if FileExists(exePath) then DeleteFile(exePath);
      installDNS();
    installThread.LabelDNSResolver := PChar('error not found lib dir "dnspython"');
    ShowMessage(PChar('error not found lib dir "dnspython"'));
    exit;
  end;

  installThread.LabelDNSResolver := PChar('Installation...');
  if FileExists(exePath) or (FileSize(exePath) = 0) then
  begin
    //SetCurrentDir(ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0\dnspython-1.15.0');
    //LaunchAndWait(PythonPath+'python.exe', '"'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0\dnspython-1.15.0\setup.py" install', launchAndWWindow);


    bat := 'cd  "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0\dnspython-1.15.0"'#13#10+
      '"'+PythonPath+'python.exe" "'+ExtractFilePath(Application.ExeName)+installDirectoryPath+'dnspython-1.15.0\dnspython-1.15.0\setup.py" install';
    if isDebug then bat := bat + #13#10 + '@pause';
    WriteInFile(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installDNS.bat', bat);
    LaunchAndWait(ExtractFilePath(Application.ExeName)+installDirectoryPath+'installDNS.bat','', launchAndWWindow);
    Sleep(2000);
  end;

  CheckInstallation;
  Form1.ButtonStartClick(nil);

end;



procedure TFormInstall.FormCreate(Sender: TObject);
begin
  isPythonInstalled := false;
  isDNSInstalled := false;
  isSetuptoolInstalled := false;
  isWgetInstalled := false;

  EditCurrentDir.Text := ExtractFilePath(Application.ExeName)+installDirectoryPath;
  //makeDir();
  if isDebug then
  begin
    launchAndWWindow := SW_SHOWNORMAL;
    
  end;
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
  //ButtonInstall.Enabled := installThread.Terminated;
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

