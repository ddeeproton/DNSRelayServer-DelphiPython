unit UnitNetstat2;
interface

uses
  windows;

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

function GetConnections(var ConnectionArray : TConnectionArray) : boolean;
function CloseConnection(var Connection : TConnection) : boolean;
function IpAddressToString(IpAddress : DWORD) : string;
function ConvertRawPortToRealPort(RawPort : DWORD) : DWORD;

implementation

uses
  sysutils;

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

function GetExtendedTcpTable(pTcpTable: Pointer; pdwSize: PDWORD; bOrder: BOOL; ulAf: LongWord;
  TableClass: TTcpTableClass; Reserved: LongWord): DWORD; stdcall; external 'iphlpapi.dll';

function GetExtendedUdpTable( pUdpTable: Pointer; pdwSize: PDWORD; bOrder: BOOL; ulAf: LongWord;
  TableClass: TUdpTableClass; Reserved: LongWord): LongInt; stdcall; external 'iphlpapi.dll';

function SetTcpEntry(pTcpRow : PMibTcpRow) : DWORD; stdcall; external 'iphlpapi.dll';

function GetTcpConnections(var ConnectionArray : TConnectionArray) : boolean; forward;
function GetUdpConnections(var ConnectionArray : TConnectionArray) : boolean; forward;

function GetConnections(var ConnectionArray : TConnectionArray) : boolean;
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
  if GetExtendedTcpTable(TcpTable, @size, FALSE, AF_INET, TCP_TABLE_OWNER_PID_ALL, 0) = NO_ERROR then
    begin
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
    end else
      Result := FALSE;
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
    end else
      Result := FALSE;
  FreeMem(UdpTable);
end;

function IpAddressToString(IpAddress : DWORD) : string;
type
  TIpAddressAsArray = array[0..3] of byte;
  PIpAddressAsArray = ^TIpAddressAsArray;
begin
  Result := Format('%d.%d.%d.%d', [PIpAddressAsArray(@IpAddress)^[0], PIpAddressAsArray(@IpAddress)^[1],
    PIpAddressAsArray(@IpAddress)^[2], PIpAddressAsArray(@IpAddress)^[3]]);
end;

function CloseConnection(var Connection : TConnection) : boolean;
const
  MIB_TCP_STATE_DELETE_TCB = 12;
var
  ConnectionToDelete : TMibTcpRow;
begin
  if Connection.Protocol = PROTOCOL_TCP
    then
      begin
        ConnectionToDelete.dwState := MIB_TCP_STATE_DELETE_TCB;
        ConnectionToDelete.dwLocalAddr := Connection.LocalAddress;
        ConnectionToDelete.dwLocalPort := Connection.LocalRawPort;
        ConnectionToDelete.dwRemoteAddr := Connection.RemoteAddress;
        ConnectionToDelete.dwRemotePort := Connection.RemoteRawPort;
        Result := SetTcpEntry(@ConnectionToDelete) = NO_ERROR;
      end
    else Result := FALSE;
end;

function ConvertRawPortToRealPort(RawPort : DWORD) : DWORD;
begin
  Result := (RawPort div 256) + (RawPort mod 256) * 256;
end;


end.
