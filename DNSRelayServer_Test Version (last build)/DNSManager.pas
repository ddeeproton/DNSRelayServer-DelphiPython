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
  //IdDNSResolver, IdStack,
  //IdException;
  Registry, md5;

type
  ActionDNS = class
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure clearCache(); 
    class procedure setIPToDHCP();
    class function resolveDNSByPython(domain, dns:String):string;
    class procedure setDNS(Servers: string);
    class procedure setDNSList(Servers: TStrings);
    class procedure setDNSOnBoot(enabled: Boolean);
    //class function resolveDNS(ADomain, AHost : string): string;
  end;
  
implementation
uses Unit1;

class procedure ActionDNS.clearCache();
var dirPath: string;
begin
  dirPath := ExtractFilePath(Application.ExeName)+AnsiReplaceStr(ExtractFileName(Application.ExeName), '.exe', '')+'\';
  WriteInFile(dirPath+'action_clear_cache.txt', ' ');
  //LaunchAndWait('ipconfig.exe','/flushdns', SW_SHOW);
  ProcessManager.ExecAndContinue('ipconfig.exe','/flushdns', SW_HIDE);

  Unit1.Form1.MemoLogs.Lines.Add('Command Clear cache sent');
end;

class procedure ActionDNS.setDNS(Servers: string);
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
    //'    Call GetAdminPrivilege()'#13#10+
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
    '  Dim WMI, OS, Value, Shell, DblValue'#13#10+
    '  do while WScript.Arguments.Count = 0 ''and WScript.Version >= 5.7'#13#10+
    '    Set WMI = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")'#13#10+
    '    Set OS = WMI.ExecQuery("SELECT *FROM Win32_OperatingSystem")'#13#10+
    '    For Each Value in OS'#13#10+
    '      DblValue = Trim(left(Value.Version, 3))'#13#10+
    '      if WScript.Version <> "5.8" and CDbl(DblValue) < 6.0 then exit do End If'#13#10+
    '      DblValue = replace(DblValue, "." , ",")'#13#10+
    '      if WScript.Version = "5.7" and CDbl(DblValue) < 6.0 then exit do End If'#13#10+
    '    Next'#13#10+
    '    Set Shell = CreateObject("Shell.Application")'#13#10+
    '    Shell.ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ uac", "", "runas"'#13#10+
    '    WScript.Quit'#13#10+
    '  loop'#13#10+
    'end sub';
    //if not FileExists(dirPath+'setDNS.vbs') or (FileSize(dirPath+'setDNS.vbs') = 0) then
    WriteInFile(dirPath+'setDNS.vbs', scriptVBS);
    ProcessManager.ExecAndWait('wscript.exe', ' "'+dirPath+'setDNS.vbs" '+Servers, SW_HIDE);
    //scriptBAT := 'wscript.exe "'+dirPath+'setDNS.vbs" '+Servers;
    //ecrireDansUnFichier(dirPath+'setDNS.bat', scriptBAT);
    //ProcessManager.LaunchAndWait(dirPath+'setDNS.bat', '', SW_HIDE);
end;


class procedure ActionDNS.setDNSList(Servers: TStrings);
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




class function ActionDNS.resolveDNSByPython(domain, dns:String):string;
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
    '			sys.stdout.write('''')'#13#10+
    '		except dns.resolver.NXDOMAIN:'#13#10+
    '			sys.stdout.write('''')'#13#10+
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
    '	if ip == 0:'#13#10+
    '		ip = dnsc.dnsResolve(config_domain)'#13#10+
    '	if ip == 0:'#13#10+
    '		ip = dnsc.dnsResolve(config_domain)'#13#10+
    '	if ip <> 0:'#13#10+
    '		sys.stdout.write(ip)';
  WriteInFile(Form1.DataDirectoryPath + 'checkDNS.py', scriptPython);
  if Form1.PythonPath = '' then Form1.PythonPath := Form1.getPythonPath();
  result := ExecAndRead('"'+Form1.PythonPath+'python.exe" "'+Form1.DataDirectoryPath + 'checkDNS.py" server "'+dns+'" domain "'+domain+'"');
end;

{
class function ActionDNS.resolveDNS(ADomain, AHost: string): string;
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
}
class procedure ActionDNS.setIPToDHCP();
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
    //'  Call GetAdminPrivilege()'#13#10+
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
    '      DblValue = Trim(left(Value.Version, 3))'#13#10+
    '      if WScript.Version <> "5.8" and CDbl(DblValue) < 6.0 then exit do End If'#13#10+
    '      if not isNumeric(DblValue) then DblValue = replace(DblValue, "." , ",")'#13#10+
    '      if WScript.Version = "5.7" and CDbl(DblValue) < 6.0 then exit do End If'#13#10+
    '    Next'#13#10+
    '    Set Shell = CreateObject("Shell.Application")'#13#10+
    '    Shell.ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ uac", "", "runas"'#13#10+
    '    WScript.Quit'#13#10+
    '  loop'#13#10+
    'end sub'#13#10+
    ''#13#10+
    'EnableDHCP '#13#10+
    '';
    if not FileExists(dirPath+'setDHCP.vbs') or (FileSize(dirPath+'setDHCP.vbs') = 0) then WriteInFile(dirPath+'setDHCP.vbs', scriptVBS);
    scriptBAT := 'wscript.exe "'+dirPath+'setDHCP.vbs"';

    ProcessManager.ExecAndWait('wscript.exe', ' "'+dirPath+'setDHCP.vbs"', SW_HIDE);

    //ecrireDansUnFichier(dirPath+'setDHCP.bat', scriptBAT);
    //ProcessManager.ExecAndWait(dirPath+'setDHCP.bat', '', SW_HIDE);
end;


class procedure ActionDNS.setDNSOnBoot(enabled: Boolean);
var
  Reg: TRegistry;
  scriptVBS, dirPath: string;
begin
  dirPath := ExtractFilePath(Application.ExeName)+AnsiReplaceStr(ExtractFileName(Application.ExeName), '.exe', '')+'\';

  scriptVBS := '''Example: '#13#10+
    ''' Set IP DNS'#13#10+
    '''   wscript.exe this.vbs 127.0.0.1 192.168.0.1'#13#10+
    ''''#13#10+
    ''' Automatic DNS '#13#10+
    '''   wscript.exe this.vbs '#13#10+
    ''#13#10+
    'WScript.Sleep 20000'#13#10+
    'if isManualDNS Then setDNS(ArgumentsToArray())'#13#10+
    ''#13#10+
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
    '	  objNetCard.SetDNSServerSearchOrder(listIP)'#13#10+
    '      If Err = 0 Then res = True'#13#10+
    '    Next'#13#10+
    '    setDNS = res'#13#10+
    'End function'#13#10+
    ''#13#10+
    'function isManualDNS()'#13#10+
    '    Dim res,objNetCard,arrDNSServers,objWMIService,colNetCards, netDNS'#13#10+
    '    res = False'#13#10+
    '    ''Call GetAdminPrivilege()'#13#10+
    '    Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")'#13#10+
    '    Set colNetCards = objWMIService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")'#13#10+
    '    For Each objNetCard in colNetCards'#13#10+
    '	''  if objNetCard.DHCPEnabled = False then res = True'#13#10+
    '		strDNSServerSearchOrder = ""'#13#10+
    '		If Not IsNull(objNetCard.DNSServerSearchOrder) Then'#13#10+
    '			For Each strDNSServer In objNetCard.DNSServerSearchOrder'#13#10+
    '				if strDNSServerSearchOrder <> "" then strDNSServerSearchOrder = strDNSServerSearchOrder & ","'#13#10+
    '				strDNSServerSearchOrder = strDNSServerSearchOrder & strDNSServer'#13#10+
    '			Next'#13#10+
    '		End If'#13#10+
    '		strIPAddresses = ""'#13#10+
    '		If Not IsNull(objNetCard.IPAddress) Then'#13#10+
    '			For Each strIPAddress In objNetCard.IPAddress'#13#10+
    '				if strIPAddresses <> "" then strIPAddresses = strIPAddresses & ","'#13#10+
    '				strIPAddresses = strIPAddresses & strIPAddress'#13#10+
    '			Next'#13#10+
    '		End If'#13#10+
    '		if strDNSServerSearchOrder = strIPAddresses then res = True'#13#10+
    '		''Wscript.echo "''" & strDNSServerSearchOrder & "'' = ''" & strIPAddresses & "''"'#13#10+
    '    Next'#13#10+
    '    isManualDNS = res'#13#10+
    'End function'#13#10+
    ''#13#10+
    ''#13#10+
    'sub GetAdminPrivilege()'#13#10+
    '  Dim WMI, OS, Value, Shell'#13#10+
    '  do while WScript.Arguments.Count = 0 and WScript.Version >= 5.7'#13#10+
    '    Set WMI = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")'#13#10+
    '    Set OS = WMI.ExecQuery("SELECT *FROM Win32_OperatingSystem")'#13#10+
    '    For Each Value in OS'#13#10+
    '      DblValue = Trim(left(Value.Version, 3))'#13#10+
    '      if WScript.Version <> "5.8" and CDbl(DblValue) < 6.0 then exit do End If'#13#10+
    '      if not isNumeric(DblValue) then DblValue = replace(DblValue, "." , ",")'#13#10+
    '      if WScript.Version = "5.7" and CDbl(DblValue) < 6.0 then exit do End If'#13#10+
    '    Next'#13#10+
    '    WScript.Echo "Script de réparation de connexion réseau. Veuillez répondre oui au dialogue suivant afin de réparer votre connexion Internet. Et non, si le serveur DNS Relai s''est déjà lancé et que vous voulez continuer à l''utiliser."'#13#10+
    '    Set Shell = CreateObject("Shell.Application")'#13#10+
    '    Shell.ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ uac", "", "runas"'#13#10+
    '    WScript.Quit'#13#10+
    '  loop'#13#10+
    'end sub';
    if enabled then WriteInFile(dirPath+'setDNSOnBoot.vbs', scriptVBS);

  // For versions equal or less than <= 0.4.7
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  try
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
  begin
    if Reg.ValueExists(ExtractFileName(Application.ExeName)+'_restoreNet_'+md5string(Application.ExeName)) then
      Reg.DeleteValue(ExtractFileName(Application.ExeName)+'_restoreNet_'+md5string(Application.ExeName));
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;

  // For versions equal or less than <= 0.4.47
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  try
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
  begin
      if Reg.ValueExists(ExtractFileName(Application.ExeName)+'_restoreNet_'+md5string(Application.ExeName)) then
        Reg.DeleteValue(ExtractFileName(Application.ExeName)+'_restoreNet_'+md5string(Application.ExeName));
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;



  // New version
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  try
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
  begin
    if enabled then
      Reg.WriteString(ExtractFileName(Application.ExeName)+'_restoreNet', dirPath+'setDNSOnBoot.vbs')
    else begin
      if Reg.ValueExists(ExtractFileName(Application.ExeName)+'_restoreNet') then
        Reg.DeleteValue(ExtractFileName(Application.ExeName)+'_restoreNet');
    end;
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;
end;



end.
