unit DNSManager;

interface

uses
  //for TStrings
  Classes,
  // for ecrireDansUnFichier
  FilesManager,
  // For SW_SHOWNORMAL SW_HIDE
  Windows,
  // for LaunchAndWait
  ProcessManager,
  // For ExtractFilePath
  SysUtils,
  // For Application
  Forms,
  // For AnsiReplaceStr
  StrUtils,
  // Pour la function DNS Resolve
  IdDNSResolver, IdStack,
  IdException;

  procedure setDNS(Servers: string);
  procedure setDNSList(Servers: TStrings);
  function resolveDNS(ADomain, AHost : string): string;

implementation


procedure setDNS(Servers: string);
var
  scriptVBS, dirPath: string;
begin
  dirPath := ExtractFilePath(Application.ExeName)+AnsiReplaceStr(ExtractFileName(Application.ExeName), '.exe', '')+'\';

  scriptVBS :=     '''Example: '#13#10+
    ''' Set IP DNS'#13#10+
    '''   wscript.exe this.vbs 127.0.0.1 192.168.0.1'#13#10+
    ''''#13#10+
    ''' Automatic DNS '#13#10+
    '''   wscript.exe this.vbs '#13#10+
    ''#13#10+
    'setDNS(ArgumentsToArray())'#13#10+
    ''#13#10+
    'function ArgumentsToArray()'#13#10+
    '  Dim i, res()'#13#10+
    '  i = 0'#13#10+
    '  redim res(WScript.Arguments.Count-1)'#13#10+
    '  For Each arg in WScript.Arguments'#13#10+
    '    if Replace(arg," ","") <> "" Then'#13#10+
    '      res(i) = arg'#13#10+
    '      i = i + 1'#13#10+
    '    End If'#13#10+
    '  Next'#13#10+
    '  ArgumentsToArray = res'#13#10+
    'End function'#13#10+
    ''#13#10+
    'function setDNS(listIP)'#13#10+
    '    Dim res,objNetCard,arrDNSServers,objWMIService,colNetCards'#13#10+
    '    res = False'#13#10+
    '    Call GetAdminPrivilege()'#13#10+
    '    Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")'#13#10+
    '    Set colNetCards = objWMIService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")'#13#10+
    '    For Each objNetCard in colNetCards'#13#10+
    '      objNetCard.SetDNSServerSearchOrder(listIP)'#13#10+
    '      If Err = 0 Then res = True'#13#10+
    '    Next'#13#10+
    '    setDNS = res'#13#10+
    'End function'#13#10+
    ''#13#10+
    'sub GetAdminPrivilege()'#13#10+
    '  Dim WMI, OS, Value, Shell'#13#10+
    '  do while WScript.Arguments.Count = 0 and WScript.Version >= 5.7'#13#10+
    '    Set WMI = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")'#13#10+
    '    Set OS = WMI.ExecQuery("SELECT *FROM Win32_OperatingSystem")'#13#10+
    '    For Each Value in OS'#13#10+
    '      if left(Value.Version, 3) < 6.0 then exit do'#13#10+
    '    Next'#13#10+
    '    Set Shell = CreateObject("Shell.Application")'#13#10+
    '    Shell.ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ uac", "", "runas"'#13#10+
    '    WScript.Quit'#13#10+
    '  loop'#13#10+
    'end sub';
    ecrireDansUnFichier(dirPath+'setDNS.vbs', scriptVBS);
    ExecAndWait('wscript.exe', ' "'+dirPath+'setDNS.vbs" '+Servers, SW_SHOWNORMAL);
end;


procedure setDNSList(Servers: TStrings);
var
  i: Integer;
  iplist: String;
begin
  iplist := '';
  for i := 0 to Servers.Count -1 do
  begin
    iplist := iplist + ' ' + Servers.Strings[i];
  end;
  setDNS(iplist);
end;


function resolveDNS(ADomain, AHost: string): string;
var
  i,x : integer;
  LDomainPart : String;
  DNSResolver: TIdDNSResolver;
  LMXRecord : TMXRecord;
  DnsResource : TResultRecord;
  qtar : TARecord;
begin
  result := '';
  try  
  DNSResolver := TIdDNSResolver.Create(nil);
  DNSResolver.QueryRecords := [qtA];
  DNSResolver.Host := AHost;
  DNSResolver.ReceiveTimeout := 5000; // 5 seconds timeout
  DNSResolver.Resolve(ADomain);

  for i := 0 to DNSResolver.QueryResult.Count - 1 do
  begin
    DnsResource := DNSResolver.QueryResult[i];
    qtar := TARecord(DnsResource);
    //result := result + #13#10 + DnsResource.Name+'->'+DnsResource.DisplayName+'->'+qtar.IPAddress;
    result := qtar.IPAddress;
    DNSResolver.Free;
    exit;
  end;

  DNSResolver.Free;

  except
    on E: EIdSocketError do exit;
  end;
end;


end.
