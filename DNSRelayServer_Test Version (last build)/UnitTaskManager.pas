unit UnitTaskManager;

interface

uses
  Classes, SysUtils, Tlhelp32, Windows, PsAPI;

type
  ListTProcessEntry32 = Array of TProcessEntry32;


  
  TaskManager = class
  private
    { Private declarations }
  public
    { Public declarations }
    //class function GetCurrentTCPConnections: TConnexionList;
    class procedure CloseProcessPID(pid: Integer);
    class function KillTask(ExeFileName: string): Integer;
    class function GetListTProcessEntry32(): ListTProcessEntry32;
    class function GetPathFromPID(const PID: cardinal): string;
    class function GetExeNameFromPID(const PID: cardinal): string;
    class function FindProcess(process:TProcessEntry32;list:ListTProcessEntry32):Boolean;

  end;



implementation


class function TaskManager.FindProcess(process:TProcessEntry32;list:ListTProcessEntry32):Boolean;
var
  i: integer;
begin
  for i := 0 to Length(list) - 1 do
  begin
    if (list[i].szExeFile = process.szExeFile) and (list[i].th32ProcessID = process.th32ProcessID) then
    begin
      result := true;
      exit;
    end;
  end;
  result := false;
end;


class function TaskManager.GetPathFromPID(const PID: cardinal): string;
var
  hProcess: THandle;
  path: array[0..MAX_PATH - 1] of char;
begin
  result := '';
  try
    hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, PID);
    if hProcess <> 0 then
      try
        if GetModuleFileNameEx(hProcess, 0, path, MAX_PATH) = 0 then
          RaiseLastOSError;
        result := path;
      finally
        CloseHandle(hProcess)
      end
  except
  On E : EOSError do
    exit;
  end;
  //else
  //  RaiseLastOSError;
end;

class function TaskManager.GetExeNameFromPID(const PID: cardinal): string;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := '';
  try
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    while Integer(ContinueLoop) <> 0 do
    begin
      if FProcessEntry32.th32ProcessID = PID then
      begin

        result := FProcessEntry32.szExeFile;

      end;
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;

    CloseHandle(FSnapshotHandle);
  except
    On E : EOSError do
      exit;
  end;
  //result := ExtractFileName(GetPathFromPID(PID));
end;


class procedure TaskManager.CloseProcessPID(pid: Integer);
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


class function TaskManager.KillTask(ExeFileName: string): Integer;
//const PROCESS_TERMINATE = $0001;
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
    On E : EOSError do
      exit;
  end;
end;


class function TaskManager.GetListTProcessEntry32(): ListTProcessEntry32;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  ListOfProcess : ListTProcessEntry32;
begin
  SetLength(ListOfProcess, 0);
  try
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    while Integer(ContinueLoop) <> 0 do
    begin
      SetLength(ListOfProcess, Length(ListOfProcess)+1);
      ListOfProcess[Length(ListOfProcess)-1] := FProcessEntry32;
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
    CloseHandle(FSnapshotHandle);
  except
    On E : EOSError do
      exit;
  end;
  Result := ListOfProcess;
end;


end.


