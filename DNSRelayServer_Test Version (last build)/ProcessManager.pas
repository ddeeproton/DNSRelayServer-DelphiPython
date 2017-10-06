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



procedure ExecAndWait(sExe, sFile: String; wShowWin: Word);
procedure ExecAndBringToFront(sExe, sFile: String);
procedure ExecAndContinue(sExe, sFile: string; wShowWin: Word);
function ExecAndRead(Que:String):string;
function LaunchAndWait(sExe, sFile: String; wShowWin: Word): Boolean; //wShowWin => SW_SHOWNORMAL | SW_HIDE

function KillTask(ExeFileName: string): Integer;
function CloseTaskPID(ExeFileName: string; pid: Integer): Integer;
procedure CloseProcessPID(pid: Integer);
procedure KillProcess(hWindowHandle: HWND);
procedure DestroyProcess(hProcess: Cardinal);

function IsUserAnAdmin(): Boolean; external shell32;

procedure downloadFile(url, filepath: string);

implementation

uses UnitInstallation;

procedure ExecAndContinue(sExe, sFile: string; wShowWin: Word);
var
  h: Cardinal;
  operation: PChar;
begin
  if IsUserAnAdmin() then operation := 'open' else operation := 'runas';
  h := 0;
  ShellExecute(h, operation, PChar(sExe), PChar(sFile), nil,wShowWin);
end;

procedure ExecAndWait(sExe, sFile: string; wShowWin: Word);
var
  h: Cardinal;
  operation: PChar;
begin
  if IsUserAnAdmin() then operation := 'open' else operation := 'runas';
  h := 0;
  ShellExecute(h, operation, PChar(sExe), PChar(sFile), nil,wShowWin);
  WaitForSingleObject(h, INFINITE);
end;

procedure ExecAndBringToFront(sExe, sFile: String);
var
  h: Cardinal;
  operation: PChar;
begin
  if IsUserAnAdmin() then operation := 'open' else operation := 'runas';
  h := 0;
  ShellExecute(h, operation, PChar(sExe), PChar(sFile), nil, SW_SHOW);
  FlashWindow(findwindow(nil,PChar(sExe)),true);
  ShowWindow(findwindow(nil,PChar(sExe)), SW_SHOW);
  //WaitForSingleObject(h, INFINITE);
end;


function LaunchAndWait(sExe, sFile: String; wShowWin: Word): Boolean;
var
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
  Result := 0;
  try
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    while Integer(ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
        UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
        UpperCase(ExeFileName))) then

        CloseProcessPID(FProcessEntry32.th32ProcessID);
        result := 1;

        {Result := Integer(TerminateProcess(
                          OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
        }
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;

    CloseHandle(FSnapshotHandle);
  except
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
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
  Result := 0;
  try
    i := 0;
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
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
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
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
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

procedure DestroyProcess(hProcess: Cardinal);
Var
  ovExitCode: LongWord;
begin
  try
    if hProcess<>0 then
    begin
      GetExitCodeProcess(hProcess, ovExitCode);
      if (ovExitCode = STILL_ACTIVE) or (ovExitCode <> WAIT_OBJECT_0) then
        TerminateProcess(hProcess, ovExitCode);
      //CloseHandle(hProcess);
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
  scriptBAT := '"'+wget+'" --no-cache -O "'+filepath+'" "'+url+'" --no-check-certificate';
  WriteInFile(ExtractFilePath(Application.ExeName)+'setup/download.bat', scriptBAT);
  LaunchAndWait(ExtractFilePath(Application.ExeName)+'setup/download.bat', '', launchAndWWindow);
end;



function ExecAndRead(Que:String):string;
const
  CUANTOBUFFER = 2000;
var

  Seguridades         : TSecurityAttributes;
  PaLeer,PaEscribir   : THandle;
  start               : TStartUpInfo;
  ProcessInfo         : TProcessInformation;
  Buffer              : Pchar;
  BytesRead           : DWord;
  CuandoSale          : DWord;
  tb                  : PDWord;

  procedure readFromPipe;
  begin
    repeat
      BytesRead := 0;
      PeekNamedPipe(PaLeer, nil, 0, nil, tb, nil);
      if tb^=0 then
        break;
      ReadFile(PaLeer,Buffer[0],CUANTOBUFFER,BytesRead,nil);
      Buffer[BytesRead]:= #0;
      OemToAnsi(Buffer,Buffer);
      result := result + String(Buffer);
    until (BytesRead <= CUANTOBUFFER);
  end;

begin
  result := '';
  With Seguridades do
  begin
    nlength              := SizeOf(TSecurityAttributes);
    binherithandle       := true;
    lpsecuritydescriptor := nil;
  end;
  {Creamos el pipe...}
  if Createpipe (PaLeer, PaEscribir, @Seguridades, 0) then
  begin
    Buffer  := AllocMem(CUANTOBUFFER + 1);
    FillChar(Start,Sizeof(Start),#0);
    start.cb          := SizeOf(start);
    start.hStdOutput  := PaEscribir;
    start.hStdInput   := PaLeer;
    start.hStdError   := PaEscribir;
    start.dwFlags     := STARTF_USESTDHANDLES +
                         STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    if CreateProcess(nil,
      PChar(Que),
      @Seguridades,
      @Seguridades,
      true,
      NORMAL_PRIORITY_CLASS,
      nil,
      nil,
      start,
      ProcessInfo)
    then
    begin
      {Espera a que termine la ejecucion}
      new(tb);
      repeat
        CuandoSale := WaitForSingleObject( ProcessInfo.hProcess,10);
        readFromPipe;
      until (CuandoSale <> WAIT_TIMEOUT);
      {Leemos la Pipe}
      dispose(tb);
    end;
    FreeMem(Buffer);
    //CloseHandle(ProcessInfo.hProcess);
    //CloseHandle(ProcessInfo.hThread);
    //CloseHandle(PaLeer);
    //CloseHandle(PaEscribir);
   end;
end;


end.
