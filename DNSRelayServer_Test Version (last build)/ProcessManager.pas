unit ProcessManager;

interface

uses Windows, SysUtils, Messages,
  // Pour FProcessEntry32
  Tlhelp32,
  // Pour ShellExecute
  // Pour FindExecutable
  ShellAPI,
  Forms,
  FilesManager;

function ExecAndWait(sExe, sFile: String; wShowWin: Word): Boolean;
function ExecAndBringToFront(sExe, sFile: String): Boolean;
function LaunchAndWait(sExe, sFile: String; wShowWin: Word): Boolean; //wShowWin => SW_SHOWNORMAL | SW_HIDE

function KillTask(ExeFileName: string): Integer;
function CloseTaskPID(ExeFileName: string; pid: Integer): Integer;
procedure CloseProcessPID(pid: Integer);
procedure KillProcess(hWindowHandle: HWND);

function IsUserAnAdmin(): Boolean; external shell32;

procedure downloadFile(url, filepath: string);

implementation

uses UnitInstallation;

function ExecAndWait(sExe, sFile: String; wShowWin: Word): Boolean;
var
  h: Cardinal;
  operation: PChar;
begin
  if IsUserAnAdmin() then operation := 'open' else operation := 'runas';
  ShellExecute(h, operation, PChar(sExe), PChar(sFile), nil,wShowWin);
  WaitForSingleObject(h, INFINITE);
end;

function ExecAndBringToFront(sExe, sFile: String): Boolean;
var
  h: Cardinal;
  operation: PChar;
begin
  if IsUserAnAdmin() then operation := 'open' else operation := 'runas';
  ShellExecute(h, operation, PChar(sExe), PChar(sFile), nil, SW_SHOW);
  FlashWindow(findwindow(nil,PChar(sExe)),true);
  ShowWindow(findwindow(nil,PChar(sExe)), SW_SHOW);
  WaitForSingleObject(h, INFINITE);
end;


function LaunchAndWait(sExe, sFile: String; wShowWin: Word): Boolean;
var
  cExe: array [0..255] of Char;
  pcFile: PChar;
  StartInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  Result:=True;
  ZeroMemory(@StartInfo, SizeOf(StartInfo));
  StartInfo.cb := SizeOf(StartInfo);
  StartInfo.dwFlags :=  STARTF_USESHOWWINDOW; 
  StartInfo.wShowWindow := wShowWin;

  if CreateProcess(PChar(sExe), PChar(sFile), nil, nil, True, 0, nil, nil, StartInfo, ProcessInfo)
  then WaitForSingleObject(ProcessInfo.hProcess, INFINITE)
  else Result:=False;
end;


function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  try
    Result := 0;
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    while Integer(ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
        UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
        UpperCase(ExeFileName))) then
        Result := Integer(TerminateProcess(
                          OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;

    CloseHandle(FSnapshotHandle);
  except
    On E : EOSError do
      exit;
  end;
end;


function CloseTaskPID(ExeFileName: string; pid: Integer): Integer;
const
  PROCESS_TERMINATE = $0001;
  max_loop = 1000;
var
  i: Integer;
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  try
    i := 0;
    Result := 0;
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    while (Integer(ContinueLoop) <> 0) and (i < max_loop) do
    begin
      if (
        (UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName))
        or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName))
        ) and (Integer(FProcessEntry32.th32ProcessID) = pid) then
        Result := Integer(TerminateProcess(
                          OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                      FProcessEntry32.th32ProcessID),
                                      0));
       ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
       inc(i);
    end;

    CloseHandle(FSnapshotHandle);
  except
    On E : EOSError do
      exit;
  end;
end;


procedure CloseProcessPID(pid: Integer);
var
  processHandle: THandle;
begin
  try
    processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION, False, pid);
    if processHandle <> 0 then
    begin
      //Terminate the process
      TerminateProcess(processHandle, 0);
      CloseHandle(ProcessHandle);
    end;
  except
    On E : EOSError do
      exit;
  end;
end;


procedure KillProcess(hWindowHandle: HWND);
var
  hprocessID: INTEGER;
  processHandle: THandle;
  DWResult: DWORD;
begin
  try
    SendMessageTimeout(hWindowHandle, WM_CLOSE, 0, 0,
    SMTO_ABORTIFHUNG or SMTO_NORMAL, 5000, DWResult);
    if isWindow(hWindowHandle) then
    begin
      // Get the process identifier for the window
      GetWindowThreadProcessID(hWindowHandle, @hprocessID);
      if hprocessID <> 0 then
      begin
        // Get the process handle
        processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION,
          False, hprocessID);
        if processHandle <> 0 then
        begin
          // Terminate the process
          TerminateProcess(processHandle, 0);
          CloseHandle(ProcessHandle);
        end;
      end;
    end;
  except
    On E : EOSError do
      exit;
  end;
end;

procedure downloadFile(url, filepath: string);
var
  wget, scriptBAT: string;
begin
  if FormInstall = nil then
  begin
    FormInstall := TFormInstall.Create(nil);
  end;
  FormInstall.CheckInstallation;
  if not FormInstall.isWgetInstalled
  then begin
    FormInstall.ButtonInstallClick(nil);
    exit;
  end;

  wget := ExtractFilePath(Application.ExeName)+'setup/wget.exe';
  if not FileExists(wget) then exit;
  scriptBAT := '"'+wget+'" -O "'+filepath+'" "'+url+'" --no-check-certificate';
  ecrireDansUnFichier(ExtractFilePath(Application.ExeName)+'setup/download.bat', scriptBAT);
  LaunchAndWait(ExtractFilePath(Application.ExeName)+'setup/download.bat', '', launchAndWWindow);
end;

end.
