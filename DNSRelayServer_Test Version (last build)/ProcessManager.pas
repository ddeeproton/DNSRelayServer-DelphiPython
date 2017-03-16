unit ProcessManager;

interface

uses Windows, SysUtils, Messages, 
  // Pour FProcessEntry32
  Tlhelp32,
  // Pour FindExecutable
  ShellAPI;


function LaunchAndWait(sFile: String; wShowWin: Word): Boolean;  //wShowWin => SW_SHOWNORMAL | SW_HIDE

function KillTask(ExeFileName: string): Integer;
function CloseTaskPID(ExeFileName: string; pid: Integer): Integer;
procedure CloseProcessPID(pid: Integer);
procedure KillProcess(hWindowHandle: HWND);



implementation


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


end.
