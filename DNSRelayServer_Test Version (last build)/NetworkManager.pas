unit NetworkManager;

Interface

Uses Windows, Winsock;

{
// Use
procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
  net: tNetworkInterfaceList;
begin
  If (GetNetworkInterfaces (net)) THen
  Begin
    MemoLogs.Clear;
    MemoLogs.Lines.Add (DateTimeToStr (Now)+ ' : ');
    For i := 0 to High (net) do
    Begin
      MemoLogs.Lines.Add ('');
      MemoLogs.Lines.Add ('#                          : ' + IntToStr(i));
      MemoLogs.Lines.Add ('Name                       : ' + net[i].ComputerName);
      MemoLogs.Lines.Add ('IP-Address                 : ' + net[i].AddrIP);
      MemoLogs.Lines.Add ('Subnet mask                : ' + net[i].SubnetMask);
      MemoLogs.Lines.Add ('Net address                : ' + net[i].AddrNet);
      MemoLogs.Lines.Add ('Limited broadcast address  : ' + net[i].AddrLimitedBroadcast);
      MemoLogs.Lines.Add ('Directed Broadcast address : ' + net[i].AddrDirectedBroadcast);
      MemoLogs.Lines.Add ('Interface up               : ' + BoolToStr (net[i].IsInterfaceUp, True));
      MemoLogs.Lines.Add ('Broadcast supported        : ' + BoolToStr (net[i].BroadcastSupport, True));
      MemoLogs.Lines.Add ('Loopback interface         : ' + BoolToStr (net[i].IsLoopback, True));
      MemoLogs.Lines.Add ('');
    end;
  end;
end;

}

{ Unit to identify the network interfaces
  This code requires at least Win98/ME/2K, 95 OSR 2 or NT service pack #3
  as WinSock 2 is used (WS2_32.DLL) }


// Constants found in manual on non-officially documented M$ Winsock functions
Const SIO_GET_INTERFACE_LIST = $4004747F;
      IFF_UP                 = $00000001;
      IFF_BROADCAST          = $00000002;
      IFF_LOOPBACK           = $00000004;
      IFF_POINTTOPOINT       = $00000008;
      IFF_MULTICAST          = $00000010;


Type SockAddr_Gen          = Packed Record
                               AddressIn             : SockAddr_In;
                               Padding               : Packed Array [0..7] of Byte;
                             end;

     Interface_Info        = Record
                               iiFlags               : u_Long;
                               iiAddress             : SockAddr_Gen;
                               iiBroadcastAddress    : SockAddr_Gen;
                               iiNetmask             : SockAddr_Gen;
                             end;

     tNetworkInterface     = Record
                               ComputerName          : String;
                               AddrIP                : String;
                               SubnetMask            : String;
                               AddrNet               : String;
                               AddrLimitedBroadcast  : String;
                               AddrDirectedBroadcast : String;
                               otherInfo : String;
                               IsInterfaceUp         : Boolean;
                               BroadcastSupport      : Boolean;
                               IsLoopback            : Boolean;
                             end;

     tNetworkInterfaceList = Array of tNetworkInterface;


Function WSAIoctl (aSocket              : TSocket;
                   aCommand             : DWord;
                   lpInBuffer           : Pointer;
                   dwInBufferLen        : DWord;
                   lpOutBuffer          : Pointer;
                   dwOutBufferLen       : DWord;
                   lpdwOutBytesReturned : LPDWord;
                   lpOverLapped         : Pointer;
                   lpOverLappedRoutine  : Pointer) : Integer; stdcall; external 'WS2_32.DLL';

Function GetNetworkInterfaces (Var aNetworkInterfaceList : tNetworkInterfaceList): Boolean;


implementation


Function GetNetworkInterfaces (Var aNetworkInterfaceList : tNetworkInterfaceList): Boolean;
// Returns a complete list the of available network interfaces on a system (IPv4)
// Copyright by Dr. Jan Schulz, 23-26th March 2007
// This version can be used for free and non-profit projects. In any other case get in contact
// Written with information retrieved from MSDN
// www.code10.net
Var aSocket             : TSocket;
    aWSADataRecord      : WSAData;
    NoOfInterfaces      : Integer;
    NoOfBytesReturned   : u_Long;
    InterfaceFlags      : u_Long;
    NameLength          : DWord;
    pAddrIP             : SockAddr_In;
    pAddrSubnetMask     : SockAddr_In;
    pAddrBroadcast      : Sockaddr_In;
    DirBroadcastDummy   : In_Addr;
    NetAddrDummy        : In_Addr;
    Buffer              : Array [0..30] of Interface_Info;
    i                   : Integer;
Begin
  Result := False;
  SetLength (aNetworkInterfaceList, 0);

  // Startup of old the WinSock
  // WSAStartup ($0101, aWSADataRecord);

  // Startup of WinSock2
  WSAStartup(MAKEWORD(2, 0), aWSADataRecord);

  // Open a socket
  aSocket := Socket (AF_INET, SOCK_STREAM, 0);

  // If impossible to open a socket, not worthy to go any further
  If (aSocket = INVALID_SOCKET) THen Exit;

  Try
    If WSAIoCtl (aSocket, SIO_GET_INTERFACE_LIST, NIL, 0,
                 @Buffer, 1024, @NoOfBytesReturned, NIL, NIL) <> SOCKET_ERROR THen
    Begin
      NoOfInterfaces := NoOfBytesReturned  Div SizeOf (Interface_Info);
      SetLength (aNetworkInterfaceList, NoOfInterfaces);

      // For each of the identified interfaces get:
      For i := 0 to NoOfInterfaces - 1 do
      Begin

        With aNetworkInterfaceList[i] do
        Begin

          // Get the name of the machine
          NameLength := MAX_COMPUTERNAME_LENGTH + 1;
          SetLength (ComputerName, NameLength)  ;
          If Not GetComputerName (PChar (Computername), NameLength) THen ComputerName := '';

          // Get the IP address
          pAddrIP                  := Buffer[i].iiAddress.AddressIn;
          AddrIP                   := string(inet_ntoa (pAddrIP.Sin_Addr));

          // Get the subnet mask
          pAddrSubnetMask          := Buffer[i].iiNetMask.AddressIn;
          SubnetMask               := string(inet_ntoa (pAddrSubnetMask.Sin_Addr));

          // Get the limited broadcast address
          pAddrBroadcast           := Buffer[i].iiBroadCastAddress.AddressIn;
          AddrLimitedBroadcast     := string(inet_ntoa (pAddrBroadcast.Sin_Addr));

          // Calculate the net and the directed broadcast address
          NetAddrDummy.S_addr      := Buffer[i].iiAddress.AddressIn.Sin_Addr.S_Addr;
          NetAddrDummy.S_addr      := NetAddrDummy.S_addr and Buffer[i].iiNetMask.AddressIn.Sin_Addr.S_Addr;
          DirBroadcastDummy.S_addr := NetAddrDummy.S_addr or not Buffer[i].iiNetMask.AddressIn.Sin_Addr.S_Addr;

          AddrNet                  := string(inet_ntoa ((NetAddrDummy)));
          AddrDirectedBroadcast    := string(inet_ntoa ((DirBroadcastDummy)));


          InterfaceFlags           := Buffer[i].iiFlags;  // From the evaluation of the Flags we receive more information
          IsInterfaceUp            := (InterfaceFlags and IFF_UP) = IFF_UP;   // Is the network interface up or down ?
          BroadcastSupport         := (InterfaceFlags and IFF_BROADCAST) = IFF_BROADCAST ; // Does the network interface support limited broadcasts ?
          IsLoopback               := (InterfaceFlags and IFF_LOOPBACK) = IFF_LOOPBACK; // Is the network interface a loopback interface ?
          
        end;
      end;
    end;
  Except
    //Result := False;
  end;

  // Cleanup the mess
  CloseSocket (aSocket);
  WSACleanUp;
  Result := True;
end;

end.
