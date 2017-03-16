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
  StrUtils;

  procedure setDNS(Servers: string);
  procedure setDNSList(Servers: TStrings);

implementation


procedure setDNS(Servers: string);
var
  scriptVBS, scriptBat, dirPath: string;
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

    scriptBat := '"%windir%\system32\wscript.exe" "'+dirPath+'setDNS.vbs" '+Servers; // + #13#10+'@pause';

    ecrireDansUnFichier(dirPath+'setDNS.vbs', scriptVBS);
    ExecAndWait('wscript.exe', ' "'+dirPath+'setDNS.vbs" '+Servers, SW_SHOWNORMAL);
    //ExecAndWait('C:\WINDOWS2\System32\wscript.exe',' "'+dirPath+'setDNS.vbs" '+Servers, SW_SHOWNORMAL);
    exit;
    ecrireDansUnFichier(dirPath+'setDNS.vbs.bat', scriptBat);
    LaunchAndWait(dirPath+'setDNS.vbs.bat', SW_HIDE);
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

end.
