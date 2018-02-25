unit UnitNetstat;

{
Use:
procedure TForm1.Button1Click(Sender: TObject);
var
  TCPList: TConnexionList;
  i: Integer;
begin
  Memo1.Clear;
  TCPList := Nestat.GetCurrentTCPConnections;
  for i := 0 to Length(TCPList)-1 do
  begin
    Memo1.Lines.Add(
      'Remote IP: '+TCPList[i][Nestat.RemoteIP]+#9
    );
  end;
end;
}

interface

uses
  Windows, Winsock, PsAPI, Classes, SysUtils;

const
  ANY_SIZE = 1;
  iphlpapi = 'iphlpapi.dll';  //For using the DLL
  TCP_TABLE_OWNER_PID_ALL = 5;

type
  //The type of the TCP table structure to retrieve.
  //This parameter can be one of the values from the TCP_TABLE_CLASS enumeration.

  TCP_TABLE_CLASS = Integer;

  PMibTcpRowOwnerPid = ^TMibTcpRowOwnerPid;
  TMibTcpRowOwnerPid  = packed record
    dwState     : DWORD;
    dwLocalAddr : DWORD;
    dwLocalPort : DWORD;
    dwRemoteAddr: DWORD;
    dwRemotePort: DWORD;
    dwOwningPid : DWORD;
  end;

  PMIB_TCPTABLE_OWNER_PID  = ^MIB_TCPTABLE_OWNER_PID;
  MIB_TCPTABLE_OWNER_PID = packed record
    dwNumEntries: DWord;
    table: array [0..ANY_SIZE - 1] OF TMibTcpRowOwnerPid;
  end;

  TConnexionList = array of TStringList;
  
  Nestat = class
  private
    { Private declarations }
  public
    { Public declarations }
    class function GetCurrentTCPConnections: TConnexionList;
    class function RemoteIP: Integer;
    class function RemotePort: Integer;
    class function LocalIP: Integer;
    class function LocalPort: Integer;
    class function PID: Integer;
    class function State: Integer;
  end;

var
  GetExtendedTcpTable:function(pTcpTable: Pointer; dwSize: PDWORD; bOrder: BOOL; lAf: ULONG; TableClass: TCP_TABLE_CLASS; Reserved: ULONG): DWord; stdcall;

implementation

class function Nestat.RemoteIP: Integer;
begin
  result := 0;
end;

class function Nestat.RemotePort: Integer;
begin
  result := 1;
end;

class function Nestat.LocalIP: Integer;
begin
  result := 2;
end;

class function Nestat.LocalPort: Integer;
begin
  result := 3;
end;

class function Nestat.PID: Integer;
begin
  result := 4;
end;

class function Nestat.State: Integer;
begin
  result := 5;
end;
 
class function Nestat.GetCurrentTCPConnections: TConnexionList;
const
  StateNames: array[0..12] of String = (
    'TIME_WAIT',
    'CLOSED',
    'LISTENING',
    'SYN_SENT',
    'SYN_RCVD',
    'ESTABLISHED',
    'FIN_WAIT1',
    'FIN_WAIT2',
    'CLOSE_WAIT',
    'CLOSING',
    'LAST_ACK',
    'TIME_WAIT',
    'DELETE_TCB'
  );
var
  Error, TableSize: DWORD;
  i: integer;
  IpAddress: in_addr;
  RemoteIP, LocalIP, PID, LocalPort, RemotePort, State : string;
  FExtendedTcpTable: PMIB_TCPTABLE_OWNER_PID;
begin
  TableSize := 0;
  SetLength(result, 0);
  try
    GetExtendedTcpTable := GetProcAddress(LoadLibrary(iphlpapi), 'GetExtendedTcpTable');
    Error := GetExtendedTcpTable(nil, @TableSize, False,AF_INET, TCP_TABLE_OWNER_PID_ALL, 0);
    if Error <> ERROR_INSUFFICIENT_BUFFER then Exit;
    GetMem(FExtendedTcpTable, TableSize);
    try
      if GetExtendedTcpTable(FExtendedTcpTable, @TableSize, TRUE,AF_INET,TCP_TABLE_OWNER_PID_ALL, 0) = NO_ERROR then
      begin
        for i := 0 to FExtendedTcpTable.dwNumEntries - 1 do
        begin
          //Remote
          IpAddress.s_addr := FExtendedTcpTable.Table[i].dwRemoteAddr;
          RemoteIP := string(inet_ntoa(IpAddress));
          RemotePort := IntToStr(ntohs(FExtendedTcpTable.Table[i].dwRemotePort));
          // Local
          IpAddress.s_addr := FExtendedTcpTable.Table[i].dwLocalAddr;
          LocalIP := string(inet_ntoa(IpAddress));
          LocalPort := IntToStr(ntohs(FExtendedTcpTable.Table[i].dwLocalPort));
          // Other
          PID := IntToStr(FExtendedTcpTable.Table[i].dwOwningPid);
          State := StateNames[FExtendedTcpTable.Table[i].dwState];
          // Return
          SetLength(result, Length(result)+1); 
          result[Length(result)-1] := TStringList.Create;
          result[Length(result)-1].Add(RemoteIP);
          result[Length(result)-1].Add(RemotePort);
          result[Length(result)-1].Add(LocalIP);
          result[Length(result)-1].Add(LocalPort);
          result[Length(result)-1].Add(PID);
          result[Length(result)-1].Add(State);
        end;
      end;
    finally
      FreeMem(FExtendedTcpTable);
    end;
  except
    on E: Exception do Exit;
  end;  
end;


end.
