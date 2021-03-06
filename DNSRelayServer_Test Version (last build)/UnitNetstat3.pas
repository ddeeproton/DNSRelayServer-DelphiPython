unit UnitNetstat3;
interface

uses
  windows, sysutils;

const
  PROTOCOL_TCP = 0;
  PROTOCOL_UDP = 1;

  TcpConnectionStates :
    array[0..12] of string =
    (
      '', 'CLOSED', 'LISTENING', 'SYN SENT', 'SYN RECIEVED', 'ESTABLISHED', 'FIN WAIT1', 'FIN WAIT2', 'CLOSE WAIT',
      'CLOSING', 'LAST ACKNOWLEDGMENT', 'TIME WAIT', 'DELETE TCP'
    );

type
  TConnection = record
    Protocol : Byte;
    ConnectionState: Cardinal;
    LocalAddress : Cardinal;
    LocalRawPort : Cardinal;
    RemoteAddress : Cardinal;
    RemoteRawPort : Cardinal;
    ProcessID : Cardinal;
  end;
  TConnectionArray = array of TConnection;

  PPileElem = ^TPileElem;
  TPileElem = record
    Connection: TConnection;
    Suiv: PPileElem;
  end;


  Netstat = class
  private
    { Private declarations }
  public
    { Public declarations }
    class function GetConnections(var ConnectionArray : TConnectionArray) : boolean;
    class function CloseConnection(var Connection : TConnection) : boolean;
    class function IpAddressToString(IpAddress : DWORD) : string;
    class function ConvertRawPortToRealPort(RawPort : DWORD) : DWORD;
    class function FindConnection(Connection: TConnection; Connections: TConnectionArray) : Boolean;
    class function GetConnectionsPile(var Pile: PPileElem) : boolean;
    class procedure DestroyConnections(var Pile: PPileElem);
    class procedure CopyConnections(Pile: PPileElem;var CopyPile: PPileElem);
    class function FindConnectionPile(Connection: TConnection; Pile: PPileElem) : Boolean;
  end;


const
  TCPIP_OWNING_MODULE_SIZE = 16;
  AF_INET = 2;

type
  TTcpTableClass = (
    TCP_TABLE_BASIC_LISTENER,
    TCP_TABLE_BASIC_CONNECTIONS,
    TCP_TABLE_BASIC_ALL,
    TCP_TABLE_OWNER_PID_LISTENER,
    TCP_TABLE_OWNER_PID_CONNECTIONS,
    TCP_TABLE_OWNER_PID_ALL,
    TCP_TABLE_OWNER_MODULE_LISTENER,
    TCP_TABLE_OWNER_MODULE_CONNECTIONS,
    TCP_TABLE_OWNER_MODULE_ALL) ;

  TUdpTableClass = (
    UDP_TABLE_BASIC,
    UDP_TABLE_OWNER_PID,
    UDP_TABLE_OWNER_MODULE );

  _MIB_TCPROW_OWNER_PID = packed record
    dwState: LongInt;
    dwLocalAddr: DWORD;
    dwLocalPort: DWORD;
    dwRemoteAddr: DWORD;
    dwRemotePort: DWORD;
    dwOwningPid: DWORD;
  end;
  TMibTcpRowOwnerPID = _MIB_TCPROW_OWNER_PID;
  PMibTcpRowOwnerPID = ^_MIB_TCPROW_OWNER_PID;

  _MIB_TCPTABLE_OWNER_PID = packed record
    dwNumEntries: DWORD;
    table: array[0..0] of TMibTcpRowOwnerPID;
  end;
  TMibTcpTableOwnerPID = _MIB_TCPTABLE_OWNER_PID;
  PMibTcpTableOwnerPID = ^_MIB_TCPTABLE_OWNER_PID;

  _MIB_UDPROW_OWNER_PID = packed record
    dwLocalAddr: DWORD;
    dwLocalPort: DWORD;
    dwOwningPid: DWORD;
  end;
  TMibUdpRowOwnerPID = _MIB_UDPROW_OWNER_PID;
  PMibUdpRowOwnerPID = ^_MIB_UDPROW_OWNER_PID;

  _MIB_UDPTABLE_OWNER_PID = packed record
    dwNumEntries: DWORD;
    table: Array[0..0] of TMibUdpRowOwnerPID;
  end;
  TMibUdpTableOwnerPID = _MIB_UDPTABLE_OWNER_PID;
  PMibUdpTableOwnerPID = ^_MIB_UDPTABLE_OWNER_PID;

  _MIB_TCPROW = packed record
    dwState: LongInt;
    dwLocalAddr: DWORD;
    dwLocalPort: DWORD;
    dwRemoteAddr: DWORD;
    dwRemotePort: DWORD;
  end;
  TMibTcpRow = _MIB_TCPROW;
  PMibTcpRow = ^_MIB_TCPROW;

  function GetTcpConnections(var ConnectionArray : TConnectionArray) : boolean; forward;
  function GetUdpConnections(var ConnectionArray : TConnectionArray) : boolean; forward;

  function GetExtendedTcpTable(pTcpTable: Pointer; pdwSize: PDWORD; bOrder: BOOL; ulAf: LongWord;
    TableClass: TTcpTableClass; Reserved: LongWord): DWORD; stdcall; external 'iphlpapi.dll';

  function GetExtendedUdpTable( pUdpTable: Pointer; pdwSize: PDWORD; bOrder: BOOL; ulAf: LongWord;
    TableClass: TUdpTableClass; Reserved: LongWord): LongInt; stdcall; external 'iphlpapi.dll';

  function SetTcpEntry(pTcpRow : PMibTcpRow) : DWORD; stdcall; external 'iphlpapi.dll';


//var Pile: PPileElem;

implementation



procedure addConnection(Connection: TConnection;var Pile: PPileElem);
var
  temp: PPileElem;
begin
  new(temp);
  temp^.Connection := Connection;
  temp^.Suiv := Pile;
  Pile := temp;
end;


class procedure Netstat.CopyConnections(Pile: PPileElem;var CopyPile: PPileElem);
var
  temp: PPileElem;
begin
  CopyPile := nil;
  temp := Pile;
  while temp <> nil do
  begin
    addConnection(temp^.Connection, CopyPile);
    temp := temp^.Suiv;
  end;
end;

class procedure Netstat.DestroyConnections(var Pile: PPileElem);
var
  temp: PPileElem;
begin
  while Pile <> nil do
    if Pile <> nil then
    begin
      temp := Pile^.Suiv;
      Dispose(Pile);
      Pile := temp;
    end
    else
      Pile := nil;
end;


function GetTcpConnectionsPile(var Pile: PPileElem) : boolean;
var
  TcpTable : PMibTcpTableOwnerPID;
  Size : DWORD;
  i : Integer;
  Connection: TConnection;
begin
  GetExtendedTcpTable(nil, @size, FALSE, AF_INET, TCP_TABLE_OWNER_PID_ALL, 0);
  GetMem(TcpTable, size);
  if not GetExtendedTcpTable(TcpTable, @size, FALSE, AF_INET, TCP_TABLE_OWNER_PID_ALL, 0) = NO_ERROR then
  begin
    FreeMem(TcpTable);
    Result := FALSE;
    exit;
  end;
  Result := TRUE;
  for i := 0 to TcpTable^.dwNumEntries - 1 do
  begin
    with Connection do
    begin
      Protocol := PROTOCOL_TCP;
      ConnectionState := TcpTable^.table[i].dwState;
      LocalAddress := TcpTable^.table[i].dwLocalAddr;
      LocalRawPort := TcpTable^.table[i].dwLocalPort;
      RemoteAddress := TcpTable^.table[i].dwRemoteAddr;
      RemoteRawPort := TcpTable^.table[i].dwRemotePort;
      ProcessID := TcpTable^.table[i].dwOwningPid;
    end;
    addConnection(Connection, Pile);
  end;
  FreeMem(TcpTable);
end;


function GetUdpConnectionsPile(var Pile: PPileElem) : boolean;
var
  UdpTable : PMibUdpTableOwnerPID;
  Size : DWORD;
  i : Integer;
  Connection: TConnection;
begin
  GetExtendedUdpTable(nil, @size, FALSE, AF_INET, UDP_TABLE_OWNER_PID, 0);
  GetMem(UdpTable, size);
  if GetExtendedUdpTable(UdpTable, @size, FALSE, AF_INET, UDP_TABLE_OWNER_PID, 0) = NO_ERROR then
  begin
    FreeMem(UdpTable);
    Result := FALSE;
    Exit;
  end;
  Result := TRUE;
  for i := 0 to UdpTable^.dwNumEntries - 1 do
  begin
    with Connection do
    begin
      Protocol := PROTOCOL_UDP;
      ConnectionState := 0;
      LocalAddress := UdpTable^.table[i].dwLocalAddr;
      LocalRawPort := UdpTable^.table[i].dwLocalPort;
      RemoteAddress := 0;
      RemoteRawPort := 0;
      ProcessID := UdpTable^.table[i].dwOwningPid;
    end;    
    addConnection(Connection, Pile);
  end;
  FreeMem(UdpTable);
end;


class function Netstat.GetConnectionsPile(var Pile: PPileElem) : boolean;
begin
  Result := GetTcpConnectionsPile(Pile) and GetUdpConnectionsPile(Pile);
end;



class function Netstat.FindConnectionPile(Connection: TConnection; Pile: PPileElem) : Boolean;
var
  //i : Integer;
  temp: PPileElem;
begin
  Result := False;
  temp := Pile;
  while temp <> nil do
  begin
    if (temp^.Connection.Protocol = Connection.Protocol)
    and (temp^.Connection.ConnectionState = Connection.ConnectionState)
    and (temp^.Connection.LocalAddress = Connection.LocalAddress)
    and (temp^.Connection.LocalRawPort = Connection.LocalRawPort)
    and (temp^.Connection.RemoteAddress = Connection.RemoteAddress)
    and (temp^.Connection.RemoteRawPort = Connection.RemoteRawPort)
    and (temp^.Connection.ProcessID = Connection.ProcessID) then
    begin
      Result := True;
      Exit;
    end;
    temp := temp^.Suiv;
  end;
  //if (Connections <> nil) and (Length(Connections) > 0) then FreeMem(Connections);
end;

// ============

class function Netstat.GetConnections(var ConnectionArray : TConnectionArray) : boolean;
begin
  Result := GetTcpConnections(ConnectionArray) and GetUdpConnections(ConnectionArray);
end;



function GetTcpConnections(var ConnectionArray : TConnectionArray) : boolean;
var
  TcpTable : PMibTcpTableOwnerPID;
  Size : DWORD;
  i : Integer;
begin
  GetExtendedTcpTable(nil, @size, FALSE, AF_INET, TCP_TABLE_OWNER_PID_ALL, 0);
  GetMem(TcpTable, size);
  if not GetExtendedTcpTable(TcpTable, @size, FALSE, AF_INET, TCP_TABLE_OWNER_PID_ALL, 0) = NO_ERROR then
  begin
    FreeMem(TcpTable);
    Result := FALSE;
    exit;
  end;
  Result := TRUE;
  for i := 0 to TcpTable^.dwNumEntries - 1 do
  begin
    SetLength(connectionArray, Length(connectionArray) + 1);
    with connectionArray[Length(connectionArray) - 1] do
    begin
      Protocol := PROTOCOL_TCP;
      ConnectionState := TcpTable^.table[i].dwState;
      LocalAddress := TcpTable^.table[i].dwLocalAddr;
      LocalRawPort := TcpTable^.table[i].dwLocalPort;
      RemoteAddress := TcpTable^.table[i].dwRemoteAddr;
      RemoteRawPort := TcpTable^.table[i].dwRemotePort;
      ProcessID := TcpTable^.table[i].dwOwningPid;
    end;
  end;
  FreeMem(TcpTable);
end;

function GetUdpConnections(var ConnectionArray : TConnectionArray) : boolean;
var
  UdpTable : PMibUdpTableOwnerPID;
  Size : DWORD;
  i : Integer;
begin
  GetExtendedUdpTable(nil, @size, FALSE, AF_INET, UDP_TABLE_OWNER_PID, 0);
  GetMem(UdpTable, size);
  if GetExtendedUdpTable(UdpTable, @size, FALSE, AF_INET, UDP_TABLE_OWNER_PID, 0) = NO_ERROR then
  begin
    FreeMem(UdpTable);
    Result := FALSE;
    Exit;
  end;
  Result := TRUE;
  for i := 0 to UdpTable^.dwNumEntries - 1 do
  begin
    SetLength(connectionArray, Length(connectionArray) + 1);
    with connectionArray[Length(connectionArray) - 1] do
    begin
      Protocol := PROTOCOL_UDP;
      ConnectionState := 0;
      LocalAddress := UdpTable^.table[i].dwLocalAddr;
      LocalRawPort := UdpTable^.table[i].dwLocalPort;
      RemoteAddress := 0;
      RemoteRawPort := 0;
      ProcessID := UdpTable^.table[i].dwOwningPid;
    end;
  end;
  FreeMem(UdpTable);
end;

class function Netstat.IpAddressToString(IpAddress : DWORD) : string;
type
  TIpAddressAsArray = array[0..3] of byte;
  PIpAddressAsArray = ^TIpAddressAsArray;
begin
  Result := Format('%d.%d.%d.%d', [
    PIpAddressAsArray(@IpAddress)^[0],
    PIpAddressAsArray(@IpAddress)^[1],
    PIpAddressAsArray(@IpAddress)^[2],
    PIpAddressAsArray(@IpAddress)^[3]
  ]);
end;

class function Netstat.CloseConnection(var Connection : TConnection) : boolean;
const
  MIB_TCP_STATE_DELETE_TCB = 12;
var
  ConnectionToDelete : TMibTcpRow;
begin
  if not Connection.Protocol = PROTOCOL_TCP then
  begin
    Result := FALSE;
    Exit;
  end;

  ConnectionToDelete.dwState := MIB_TCP_STATE_DELETE_TCB;
  ConnectionToDelete.dwLocalAddr := Connection.LocalAddress;
  ConnectionToDelete.dwLocalPort := Connection.LocalRawPort;
  ConnectionToDelete.dwRemoteAddr := Connection.RemoteAddress;
  ConnectionToDelete.dwRemotePort := Connection.RemoteRawPort;
  Result := SetTcpEntry(@ConnectionToDelete) = NO_ERROR;
end;

class function Netstat.ConvertRawPortToRealPort(RawPort : DWORD) : DWORD;
begin
  Result := (RawPort div 256) + (RawPort mod 256) * 256;
end;


class function Netstat.FindConnection(Connection: TConnection; Connections: TConnectionArray) : Boolean;
var
  i : Integer;
begin
  Result := False;
  for i:=0 to Length(Connections) - 1 do
  begin
    if (Connections[i].Protocol = Connection.Protocol)
    and (Connections[i].ConnectionState = Connection.ConnectionState)
    and (Connections[i].LocalAddress = Connection.LocalAddress)
    and (Connections[i].LocalRawPort = Connection.LocalRawPort)
    and (Connections[i].RemoteAddress = Connection.RemoteAddress)
    and (Connections[i].RemoteRawPort = Connection.RemoteRawPort)
    and (Connections[i].ProcessID = Connection.ProcessID) then
    begin
      SetLength(Connections, 0);
      Result := True;
      Exit;
    end;
  end;
  SetLength(Connections, 0);
  //if (Connections <> nil) and (Length(Connections) > 0) then FreeMem(Connections);
end;

end.
