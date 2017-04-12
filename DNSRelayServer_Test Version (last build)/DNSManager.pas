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
  function resolveDNSByPython(domain, dns:String):string;
  procedure setIPToDHCP();

implementation
uses Unit1;

procedure setDNS(Servers: string);
var
  scriptVBS, scriptBAT, dirPath: string;
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
    'On Error Resume Next'#13#10+
    'function ArgumentsToArray()'#13#10+
    '  Dim i, res()'#13#10+
    '  i = 0'#13#10+
    '  redim res(WScript.Arguments.Count-1)'#13#10+
    '  For Each arg in WScript.Arguments'#13#10+
    '    arg = Replace(arg," ","")'#13#10+
    '    if arg <> "" and arg <> "uac" Then'#13#10+
    '      res(i) = arg'#13#10+
    '      i = i + 1'#13#10+
    '    End If'#13#10+
    '  Next'#13#10+
    '  if i = 0 then'#13#10+
    '    ArgumentsToArray = Array()'#13#10+
    '  else'#13#10+
    '    ArgumentsToArray = res'#13#10+ 
    '  end if'#13#10+
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
    if not FileExists(dirPath+'setDNS.vbs') or (FileSize(dirPath+'setDNS.vbs') = 0) then ecrireDansUnFichier(dirPath+'setDNS.vbs', scriptVBS);
    ProcessManager.ExecAndWait('wscript.exe', ' "'+dirPath+'setDNS.vbs" '+Servers, SW_HIDE);
    //scriptBAT := 'wscript.exe "'+dirPath+'setDNS.vbs" '+Servers;
    //ecrireDansUnFichier(dirPath+'setDNS.bat', scriptBAT);
    //ProcessManager.LaunchAndWait(dirPath+'setDNS.bat', '', SW_HIDE);
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




function resolveDNSByPython(domain, dns:String):string;
var scriptPython: String;
begin
  scriptPython :=     '#!/usr/bin/env python'#13#10+
    'import sys, subprocess'#13#10+
    'import dns.resolver'#13#10+
    'from dns.exception import DNSException'#13#10+
    ''#13#10+
    'class DNSClient:'#13#10+
    '	def __init__(self, nameservers, timeout):'#13#10+
    '		self.res = dns.resolver.Resolver()'#13#10+
    '		self.res.nameservers = nameservers'#13#10+
    '		self.res.timeout = timeout'#13#10+
    '		self.res.lifetime = timeout'#13#10+
    ''#13#10+
    '	def dnsResolve(self, domain):'#13#10+
    '		res = 0'#13#10+
    '		try:'#13#10+
    '			answer = self.res.query(domain, "A")'#13#10+
    '			res = "%s" % answer[0]'#13#10+
    '		except dns.resolver.NoAnswer:'#13#10+
    '			sys.stdout.write("")'#13#10+
    '		except dns.resolver.NXDOMAIN:'#13#10+
    '			sys.stdout.write("")'#13#10+
    '		except DNSException:'#13#10+
    '			sys.stdout.write('''')'#13#10+
    '		return res'#13#10+
    ''#13#10+
    'if __name__ == ''__main__'':'#13#10+
    ''#13#10+
    '	config_server = ''209.244.0.3'''#13#10+
    '	if len(sys.argv) > 1:'#13#10+
    '		if sys.argv[1] == ''server'':'#13#10+
    '			if len(sys.argv) > 2:'#13#10+
    '				config_server = sys.argv[2]'#13#10+
    '				'#13#10+
    '	config_domain = ''www.github.com'''#13#10+
    '	if len(sys.argv) > 3:'#13#10+
    '		if sys.argv[3] == ''domain'':'#13#10+
    '			if len(sys.argv) > 4:'#13#10+
    '				config_domain = sys.argv[4]'#13#10+
    ''#13#10+
    '	dnsc = DNSClient([config_server], 1)'#13#10+
    '	ip = dnsc.dnsResolve(config_domain)'#13#10+
    '	if ip <> 0:'#13#10+
    '		sys.stdout.write(ip)';
  ecrireDansUnFichier(Form1.DataDirectoryPath + 'checkDNS.py', scriptPython);
  if Form1.PythonPath = '' then Form1.PythonPath := Form1.getPythonPath();
  result := ExecAndRead('"'+Form1.PythonPath+'python.exe" "'+Form1.DataDirectoryPath + 'checkDNS.py" server "'+dns+'" domain "'+domain+'"');
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
    on E: EIdDnsResolverError do exit;
  end;
end;

procedure setIPToDHCP();
var
  scriptVBS, scriptBAT, dirPath: string;
begin
  dirPath := ExtractFilePath(Application.ExeName)+AnsiReplaceStr(ExtractFileName(Application.ExeName), '.exe', '')+'\';
  scriptVBS :=     'Option Explicit '#13#10+
    ' '#13#10+
    'On Error Resume Next'#13#10+
    'Function EnableDHCP '#13#10+
    '  Dim objWMIService, objNicConfig, colNicConfigs '#13#10+
    '  Dim strComputer '#13#10+
    '  Dim intReturn '#13#10+
    '  Call GetAdminPrivilege()'#13#10+
    '  Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2") '#13#10+
    '  Set colNicConfigs = objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True")  '#13#10+
    '  For Each objNicConfig In colNicConfigs '#13#10+
    '    If Not objNicConfig.DHCPEnabled Then '#13#10+
    '      intReturn = objNicConfig.EnableDHCP '#13#10+
    '      '#13#10+
    '      ''If intReturn = 0 Then '#13#10+
    '      ''  WScript.Echo VbCrLf & "DHCP enabled." '#13#10+
    '      ''Else '#13#10+
    '      ''  WScript.Echo VbCrLf & "Unable to set DHCP obtained address." '#13#10+
    '      ''  WScript.Quit conExitCodeError '#13#10+
    '      ''End If '#13#10+
    '    ''Else '#13#10+
    '      ''WScript.Echo "DHCP already enabled" & VbCrLf & "DHCP Server: " & objNicConfig.DHCPServer '#13#10+
    '    End If '#13#10+
    '  Next '#13#10+
    'End Function '#13#10+
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
    'end sub'#13#10+
    ''#13#10+
    'EnableDHCP '#13#10+
    '';
    if not FileExists(dirPath+'setDHCP.vbs') or (FileSize(dirPath+'setDHCP.vbs') = 0) then ecrireDansUnFichier(dirPath+'setDHCP.vbs', scriptVBS);
    scriptBAT := 'wscript.exe "'+dirPath+'setDHCP.vbs"';

    ProcessManager.ExecAndWait('wscript.exe', ' "'+dirPath+'setDHCP.vbs"', SW_HIDE);

    //ecrireDansUnFichier(dirPath+'setDHCP.bat', scriptBAT);
    //ProcessManager.ExecAndWait(dirPath+'setDHCP.bat', '', SW_HIDE);
end;


end.
