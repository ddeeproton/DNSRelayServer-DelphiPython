unit UnitNetstat;
// Source: http://www.delphipraxis.net/136039-api-recvfrom-sendto-etc-gehookt-programm-crasht-2.html
{
How to use:

procedure TForm1.Button3Click(Sender: TObject);
var
  i: Integer;
  Connections: TConnectionArray;
  Protocol: String;
begin
  UnitNetstat.GetConnections(Connections);

  for i:=0 to Length(Connections) - 1 do
  begin
    if Connections[i].Protocol = 0 then
      Protocol := 'TCP';

    if Connections[i].Protocol = 1 then
      Protocol := 'UDP';

    Memo1.Lines.Add(
      Protocol
      +' '+Connections[i].RemoteAddress
      +' '+IntToStr(Connections[i].ProcessID)
    );
   
  end;
  //UnitNetstat.CloseConnection(Connections[0]);
end;
}
interface

uses
  windows, Winsock;

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
    LocalAddress : String;
    LocalRawPort : Cardinal;
    RemoteAddress : String;
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
    dwState: LongInt;
    dwLocalAddr: DWORD;
    dwLocalPort: DWORD;
    dwRemoteAddr: DWORD;
    dwRemotePort: DWORD;
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
    dwLocalAddr: String;
    dwLocalPort: DWORD;
    dwRemoteAddr: String;
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
  i : Integer;           
  Size : DWORD;
  IpAddress: in_addr;   
  TcpTable : PMibTcpTableOwnerPID;
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

        //LocalAddress := TcpTable^.table[i].dwLocalAddr;
        IpAddress.s_addr := TcpTable^.table[i].dwLocalAddr;
        LocalAddress := string(inet_ntoa(IpAddress));

        LocalRawPort := ntohs(TcpTable^.table[i].dwLocalPort);

        //RemoteAddress := TcpTable^.table[i].dwRemoteAddr;
        IpAddress.s_addr := TcpTable^.table[i].dwRemoteAddr;
        RemoteAddress := string(inet_ntoa(IpAddress));

        RemoteRawPort := ntohs(TcpTable^.table[i].dwRemotePort);

        ProcessID := TcpTable^.table[i].dwOwningPid;
      end;
    end;
  end else
    Result := FALSE;
  FreeMem(TcpTable);
end;

function GetUdpConnections(var ConnectionArray : TConnectionArray) : boolean;
var              
  i : Integer;
  Size : DWORD;
  IpAddress: in_addr;
  UdpTable : PMibUdpTableOwnerPID;
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

        //LocalAddress := UdpTable^.table[i].dwLocalAddr;
        IpAddress.s_addr := UdpTable^.table[i].dwLocalAddr;
        LocalAddress := string(inet_ntoa(IpAddress));

        //LocalRawPort := UdpTable^.table[i].dwLocalPort;
        LocalRawPort := ntohs(UdpTable^.table[i].dwLocalPort);

        IpAddress.s_addr := UdpTable^.table[i].dwRemoteAddr;
        RemoteAddress := string(inet_ntoa(IpAddress));

        RemoteRawPort := ntohs(UdpTable^.table[i].dwRemotePort);
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
  Result := Format('%d.%d.%d.%d', [
    PIpAddressAsArray(@IpAddress)^[0],
    PIpAddressAsArray(@IpAddress)^[1],
    PIpAddressAsArray(@IpAddress)^[2],
    PIpAddressAsArray(@IpAddress)^[3]
  ]);
end;

function CloseConnection(var Connection : TConnection) : boolean;
const
  MIB_TCP_STATE_DELETE_TCB = 12;
var
  ConnectionToDelete : TMibTcpRow;
begin
  if Connection.Protocol = PROTOCOL_TCP then
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