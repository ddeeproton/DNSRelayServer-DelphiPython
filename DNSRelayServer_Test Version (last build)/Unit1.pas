unit Unit1;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, ComCtrls, ToolWin, Menus,
  UnitHost, XPMan, Systray, Registry, md5, ListViewManager, HostParser,
  NetworkManager, DNSManager,
  // url Download
  UrlMon,
  // Pour lire écrire dans un fichier
  FilesManager,
  // Pour FProcessEntry32
  Tlhelp32,
  // Pour le registre
  Registre,
  // POur l'installation
  UnitInstallation,
  // Pour AnsiReplaceStr
  StrUtils,
  // Pour LaunchAndWait
  ProcessManager, Spin, Buttons;

var CurrentApplicationVersion: string = '0.4.11';

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Quitter1: TMenuItem;
    N1: TMenuItem;
    Masquer1: TMenuItem;
    Afficher1: TMenuItem;
    ToolBar3: TToolBar;
    ToolButton3: TToolButton;
    ImageList2: TImageList;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    SaveDialog1: TSaveDialog;
    ImageList3: TImageList;
    TimerSaveChange: TTimer;
    PopupMenuListView: TPopupMenu;
    Bloquerledomaine1: TMenuItem;
    Autoriser1: TMenuItem;
    Modifier1: TMenuItem;
    Panel1: TPanel;
    Notebook1: TNotebook;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditFilehost: TEdit;
    CheckBoxStartWithWindows: TCheckBox;
    ButtonSelectFilehost: TButton;
    GroupBox1: TGroupBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButtonUpdateDNSMaster: TToolButton;
    ToolButton2: TToolButton;
    ToolButtonDownDNSMaster: TToolButton;
    ToolButtonUpDNSMaster: TToolButton;
    ListBoxDNSMaster: TListBox;
    GroupBox3: TGroupBox;
    ListBoxIpClients: TListBox;
    GroupBox4: TGroupBox;
    ToolBar2: TToolBar;
    ToolButton10: TToolButton;
    ToolButtonEditHost: TToolButton;
    ToolButton9: TToolButton;
    ListView1: TListView;
    GroupBox5: TGroupBox;
    MemoLogs: TMemo;
    CBoxDNSServerSlaveIP: TComboBox;
    Timer1: TTimer;
    SpinPort: TSpinEdit;
    ToolButton8: TToolButton;
    GroupBox6: TGroupBox;
    Memo1: TMemo;
    N2: TMenuItem;
    StartDNS1: TMenuItem;
    StopDNS1: TMenuItem;
    ImageList4: TImageList;
    ToolButton11: TToolButton;
    CheckBoxUpdate: TCheckBox;
    ButtonUpdate: TButton;
    TimerUpdate: TTimer;
    ButtonRefreshNetCard: TBitBtn;
    procedure ButtonStartClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButtonDownDNSMasterClick(Sender: TObject);
    procedure ToolButtonUpDNSMasterClick(Sender: TObject);
    procedure ToolButtonUpdateDNSMasterClick(Sender: TObject);
    procedure ToolButtonEditHostClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoLogsChange(Sender: TObject);
    procedure onProcessCreated(h: Cardinal);
    procedure closeProcessCreated();
    function isPythonInstalled(PythonDirPath: string):bool;
    function getPythonPath():string;
    procedure ButtonInstallClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Masquer1Click(Sender: TObject);
    procedure Afficher1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure refreshCheckBox(Checkbox:TCheckBox);
    procedure CheckBoxStartWithWindowsClick(Sender: TObject);
    procedure ButtonSelectFilehostClick(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    function KillTask(ExeFileName: string): Integer;
    procedure ToolButton9Click(Sender: TObject);
    procedure EditFilehostChange(Sender: TObject);
    procedure TimerSaveChangeTimer(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure Bloquerledomaine1Click(Sender: TObject);
    procedure Autoriser1Click(Sender: TObject);
    procedure ListView1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Modifier1Click(Sender: TObject);
    procedure refreshListView1Click();
    procedure CheckBoxToggleMenuTitleClick(Sender: TObject);
    procedure CheckBoxMenuPositionClick(Sender: TObject);
    procedure onServerDNSStart();
    procedure onServerDNSStop();
    procedure Timer1Timer(Sender: TObject);
    procedure OnOutput(txt:String);
    procedure ToolButton8Click(Sender: TObject);
    procedure ButtonForceStartClick(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ButtonUpdateClick(Sender: TObject);
    procedure CheckBoxUpdateClick(Sender: TObject);
    procedure setDNSOnBoot(enabled: Boolean);
    procedure TimerUpdateTimer(Sender: TObject);
    procedure ButtonRefreshNetCardClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSauvegarde = class(TThread)
    cmd:String;
    EnMemo:TMemo;
    h: Cardinal;
    indexThread: Integer;
    output: TStringList;
  protected
    procedure Execute(); override;
  public
    procedure onCreate();
    procedure Execute2(cmd:String; EnMemo:TMemo);
    procedure RunDosInMemo(Que:String;EnMemo:TMemo);
  end;


  TUpdate = class(TThread)
  private
  protected
    procedure Execute; override;
  public
    procedure DoUpdate(isSilent: Boolean);
  end;

var
  Form1: TForm1;
  FormHost: TFormHost;
  FormInstall:  TFormInstall = nil;
  SelectedListItem:TListItem;
  listThreads: array of TSauvegarde;
  ThreadUpdate: TUpdate;

  MasterDNSFile: string = 'MasterDNSFile.cfg';
  SlaveDNSProcesslist: string = 'SlaveDNSProcesslist.cfg';
  FilehostPathConfig: string = 'FileHostPath.cfg';
  SlaveDNSIPConfig: string = 'SlaveDNSIP.cfg';
  SlaveDNSPortConfig: string = 'SlaveDNSPort.cfg';

  PythonPath: string = '';
  DataDirectoryPath: string = '';
  DNSMasterSerialized: string = '';
  isServerStarted: boolean = True;
implementation

{$R *.dfm}


procedure SplitStr(const Source, Delimiter: String; var DelimitedList: TStringList);
var
  s: PChar;
  DelimiterIndex: Integer;
  Item: String;
begin
  s:=PChar(Source);
  repeat
    DelimiterIndex:=Pos(Delimiter, s);
    if DelimiterIndex=0 then Break;
    Item:=Copy(s, 1, DelimiterIndex-1);
    DelimitedList.Add(Item);
    inc(s, DelimiterIndex + Length(Delimiter)-1);
  until DelimiterIndex = 0;
  DelimitedList.Add(s);
end;


procedure TForm1.OnOutput(txt:String);
var
  i, imgIndex: integer;
  isNew: Boolean;
  sl: TStringList;
  // 04.03.17; 09:33:09; 127.0.0.1; 185.22.116.72; tf1.fr.
  date, time, ipclient, ipdomain, domain, ip:string;
begin
  txt := StringReplace(txt, #13, '', [rfReplaceAll, rfIgnoreCase]);
  txt := StringReplace(txt, #10, '', [rfReplaceAll, rfIgnoreCase]);
  if txt = '' then exit;

  if Pos(txt, MemoLogs.Lines.Strings[MemoLogs.Lines.Count - 1]) = 0 then
    MemoLogs.Lines.Add(txt);
  //MemoLogs.Text := MemoLogs.Text + txt;
  sl:=TStringList.Create;
  SplitStr(txt,';',sl);
  //form1.MemoLogs.Lines.Add(sl.Text);
  //form1.MemoLogs.Lines.Add(IntToStr(sl.Count));
  if sl.Count >= 5 then
  begin
    date := sl.Strings[0];
    time := sl.Strings[1];
    ipclient := sl.Strings[2];
    ipdomain := sl.Strings[3];
    domain := sl.Strings[4];
    SetLength(domain, Length(domain)-1);


    if form1.ListBoxIpClients.Items.IndexOf(ipclient) = -1 then
    begin
      form1.ListBoxIpClients.Items.Add(ipclient);
    end;

    isNew := true;
    for i := 0 to form1.ListView1.Items.Count-1 do
    begin
      if form1.ListView1.Items[i].SubItems[0] =  domain then isNew := false;
    end;

    if isNew then
    begin

      ip := getDomain(Form1.EditFilehost.Text, domain);
      if ip = '' then imgIndex := 0
      else if ip = '127.0.0.1' then imgIndex := 3
      else if ipdomain = '127.0.0.1' then imgIndex := 3
      else imgIndex := 1;

      EditerLigne2(form1.ListView1, -1, imgIndex, ipdomain, domain, imgIndex = 3);
      //i := form1.ListView1.Items.Count;
      //EditerLigne2(form1.ListView1, i, imgIndex, ipdomain, domain, imgIndex = 3);
      Form1.refreshListView1Click();
    end;

  end
  else begin
    if Pos('Error: Port  53  already used', txt) > 0 then
    begin
      if MessageDlg('Le port 53 est déjà utilisé. Désirez-vous forcer la fermerture des processus python et essayer à nouveau?'#13#13'(si ce message persiste, soit le port 53 est utilisé par un autre processus, soit vous avez indiqué une mauvaise adresse IP.',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
      begin
        Form1.MemoLogs.Lines.Add('Close all python.exe process');
        Form1.KillTask('python.exe');
        Form1.ButtonRefreshNetCardClick(nil);
        Form1.ButtonStartClick(nil);
      end;
    end;
  end;
  if sl <> nil then
    sl.Free;
end;

procedure TSauvegarde.onCreate;
begin
  
end;

procedure TSauvegarde.RunDosInMemo(Que:String;EnMemo:TMemo);
const
  CUANTOBUFFER = 2000;
var
  Seguridades         : TSecurityAttributes;
  PaLeer,PaEscribir   : THandle;
  start               : TStartUpInfo;
  ProcessInfo         : TProcessInformation;
  Buffer              : Pchar;
  BytesRead           : DWord;
  CuandoSale          : DWord;
  tb                  : PDWord;

  procedure readFromPipe;
  var
    i: integer;
    sl: TStringList;
    txt: string;
  begin
    repeat

      BytesRead := 0;
      {Llenamos un troncho de la pipe, igual a nuestro buffer}
      PeekNamedPipe(PaLeer, nil, 0, nil, tb, nil);
      if tb^=0 then
        break;
      ReadFile(PaLeer,Buffer[0],CUANTOBUFFER,BytesRead,nil);
      {La convertimos en una string terminada en cero}
      Buffer[BytesRead]:= #0;
      {Convertimos caracteres DOS a ANSI}
      OemToAnsi(Buffer,Buffer);

      txt := StringReplace(String(Buffer), ';EOL;', '', [rfReplaceAll, rfIgnoreCase]);
      //form1.MemoLogs.Lines.Text := form1.MemoLogs.Lines.Text + txt;

      {
      if Pos(';EOL;', txt) = 0 then
      begin
        output.Add(txt);
      end
      else begin
      }
      sl:=TStringList.Create;
      SplitStr(String(Buffer),';EOL;',sl);
      for i:=0 to sl.Count-1 do
      begin
        txt := String(sl.Strings[i]);
        txt := StringReplace(txt, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
        output.Add(txt);
        //OnOut0put(txt);
      end;
      form1.Timer1.Enabled := True;
      //end;


      //EnMemo.Lines.Add(String(Buffer));
      //form1.Memo1MemoLogs.Lines.Add(String(Buffer));
    until (BytesRead < CUANTOBUFFER);
  end;

begin
  with Seguridades do
  begin
    nlength              := SizeOf(TSecurityAttributes);
    binherithandle       := true;
    lpsecuritydescriptor := nil;
  end;
  {Creamos el pipe...}
  if Createpipe (PaLeer, PaEscribir, @Seguridades, 0) then
  begin
    Buffer  := AllocMem(CUANTOBUFFER + 1);
    FillChar(Start,Sizeof(Start),#0);
    start.cb          := SizeOf(start);
    start.hStdOutput  := PaEscribir;
    start.hStdInput   := PaLeer;
    start.hStdError   := PaEscribir;
    start.dwFlags     := STARTF_USESTDHANDLES +
                         STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    if CreateProcess(nil,
      PChar(Que),
      @Seguridades,
      @Seguridades,
      true,
      NORMAL_PRIORITY_CLASS,
      nil,
      nil,
      start,
      ProcessInfo)
    then
    begin
      try
        form1.onServerDNSStart();
        h := ProcessInfo.hProcess;

    	  form1.onProcessCreated(ProcessInfo.dwProcessId);
        {Espera a que termine la ejecucion}
        new(tb);
        repeat
          CuandoSale := WaitForSingleObject( ProcessInfo.hProcess,100);
          readFromPipe;
          Application.ProcessMessages;
        until (CuandoSale <> WAIT_TIMEOUT);
        {Leemos la Pipe}
        dispose(tb);
      except
        On E : EOSError do
          exit;
      end;
    end;
    FreeMem(Buffer);
    try
      if ProcessInfo.hProcess <> 0 then CloseHandle(ProcessInfo.hProcess);
      if ProcessInfo.hThread <> 0 then CloseHandle(ProcessInfo.hThread);
      if PaLeer <> 0 then CloseHandle(PaLeer);
      if PaEscribir <> 0 then CloseHandle(PaEscribir);
    except
      On E : EOSError do
        exit
    end;

    Form1.onServerDNSStop();


    if EnMemo <> nil then
      EnMemo.Lines.Add(String('Stoped'));

  end;
end;

procedure TSauvegarde.Execute();
begin
  //RunDosInMemo('ping.exe 127.0.0.1', Form1.Memo1MemoLogs);
  Sleep(1000);
  RunDosInMemo(cmd, EnMemo);
end;

procedure TSauvegarde.Execute2(cmd:String; EnMemo:TMemo);
begin
  RunDosInMemo(cmd, EnMemo);
end;

procedure TForm1.onServerDNSStart();
begin
  setIPToDHCP();
  setDNS(CBoxDNSServerSlaveIP.Text);
  MemoLogs.Lines.Add('Set DNS '+CBoxDNSServerSlaveIP.Text);
  
  ImageList4.GetIcon(2, Application.Icon);
  Systray.ModifIconeTray(Caption, Application.Icon.Handle);
  //ToolButton7.ImageIndex := 7;
  ToolButton11.ImageIndex := 8;
  ToolButton11.Caption := 'DNS Démarré';
  isServerStarted := True;

  ToolButton11.Enabled := True;
  ToolButton11.Hint := 'Click pour arrêter';
  setDNSOnBoot(not CheckBoxStartWithWindows.Checked);
end;

procedure TForm1.onServerDNSStop();
begin
  MemoLogs.Lines.Add('Go to DHCP');
  setDNS('');
  setIPToDHCP();

  ImageList4.GetIcon(1, Application.Icon);
  Systray.ModifIconeTray(Caption, Application.Icon.Handle);
  //ToolButton7.ImageIndex := 6;

  ToolButton11.ImageIndex := 7;
  //setDNS(DNSMasterSerialized);
  //MemoLogs.Lines.Add('Set DNS '+DNSMasterSerialized);

  ToolButton11.Caption := 'DNS Arrêté';
  isServerStarted := False;

  ToolButton11.Enabled := True;
  ToolButton11.Hint := 'Click pour démarrer';

  setDNSOnBoot(not CheckBoxStartWithWindows.Checked);
end;


procedure TForm1.setDNSOnBoot(enabled: Boolean);
var
  Reg: TRegistry;
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
    '      if left(Value.Version, 3) < 6.0 then exit do'#13#10+
    '    Next'#13#10+
    '    WScript.Echo "Veuillez répondre oui au dialogue suivant afin de réparer votre connexion Internet."'#13#10+
    '    Set Shell = CreateObject("Shell.Application")'#13#10+
    '    Shell.ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ uac", "", "runas"'#13#10+
    '    WScript.Quit'#13#10+
    '  loop'#13#10+
    'end sub';
    if enabled then ecrireDansUnFichier(dirPath+'setDNSOnBoot.vbs', scriptVBS);

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


  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  try
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
  begin
    if enabled then
      Reg.WriteString(ExtractFileName(Application.ExeName)+'_restoreNet_'+md5string(Application.ExeName), dirPath+'setDNSOnBoot.vbs')
    else begin
      if Reg.ValueExists(ExtractFileName(Application.ExeName)+'_restoreNet_'+md5string(Application.ExeName)) then
        Reg.DeleteValue(ExtractFileName(Application.ExeName)+'_restoreNet_'+md5string(Application.ExeName));
    end;
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;


end;

procedure createVBScript();
var
  i: integer;
  script, dnsMaster: string;
begin


  dnsMaster := '';
  for i := 0 to form1.ListBoxDNSMaster.Items.Count -1 do
  begin
    if not (dnsMaster = '') then dnsMaster := dnsMaster + ',';
    dnsMaster := dnsMaster + '''' + form1.ListBoxDNSMaster.Items.Strings[i] + '''';
  end;

  script :=   '#!/usr/bin/env python'#13#10+
  'import sys, subprocess'#13#10+
  'import socket'#13#10+
  'import dns.resolver'#13#10+
  'from dns.exception import DNSException'#13#10+
  'import time'#13#10+
  'import sys'#13#10+
  ''#13#10+
  '#import MySQLdb'#13#10+
  ''#13#10+
  '#============================='#13#10+
  '# FastDNS version 0.1'#13#10+
  '#============================='#13#10+
  '# Requirements:'#13#10+
  '# [Pyhton]'#13#10+
  '#  http://www.python.org/getit/'#13#10+
  '#'#13#10+
  '# [dnspython]'#13#10+
  '#  http://www.dnspython.org/'#13#10+
  '#'#13#10+
  '# [MySQL-python]'#13#10+
  '#  http://sourceforge.net/projects/mysql-python/'#13#10+
  '#'#13#10+
  '# [MySQL server]'#13#10+
  '#  http://dev.mysql.com/downloads/'#13#10+
  '#'#13#10+
  '# Create table SQL'#13#10+
  '# CREATE TABLE IF NOT EXISTS `dnscache` (`domain` varchar(255) NOT NULL,`ip` varchar(15) NOT NULL,`banned` tinyint(1) NOT NULL, UNIQUE KEY `domain` (`domain`)) TYPE=InnoDB;'#13#10+
  '#============================='#13#10+
  ''#13#10+
  '#============================='#13#10+
  '# CONFIGURATION'#13#10+
  '#============================='#13#10+
  ''#13#10+
  ''#13#10+
  '# MySQL'#13#10+
  'config_dbhost = "192.168.0.1"'#13#10+
  'config_dbuser = "root2"'#13#10+
  'config_dbpasswd = ""'#13#10+
  'config_dbname = "DNSdata"'#13#10+
  'config_dbtable = "dnscache"'#13#10+
  'config_dbport = 33006'#13#10+
  ''#13#10+
  '# Relay DNS'#13#10+
  '#config_dnsrelay = [''209.244.0.3'',''209.244.0.4'']'#13#10+
  'config_dnsrelay = ['+dnsMaster+']'#13#10+
  'config_dnstimeout = 5'#13#10+
  ''#13#10+
  '#Client DNS'#13#10+
  'config_cache_sql = 0  # [ 0 | 1 ] utilise la base MySQL en priorite'#13#10+
  'config_cache_memory = 1 # [ 0 | 1 ] utilise la memoire pour stocker les resolutions'#13#10+
  ''#13#10+
  '# Server DNS'#13#10+
  'config_dnsip = ''0.0.0.0'''#13#10+
  'if len(sys.argv) > 1:'#13#10+
  '	if sys.argv[1] == ''config_dnsip'':'#13#10+
  '		if len(sys.argv) > 2:'#13#10+
  '			config_dnsip = sys.argv[2]'#13#10+
  '			'#13#10+
  '# hostfile = ''hosts ''+config_dnsip+''.txt'''#13#10+
  'hostfile = ''hosts.txt'''#13#10+
  'if len(sys.argv) > 3:'#13#10+
  '	if sys.argv[3] == ''hostfile'':'#13#10+
  '		if len(sys.argv) > 2:'#13#10+
  '			hostfile = sys.argv[4]'#13#10+
  ''#13#10+
  'config_dnsport = '+IntToStr(Form1.SpinPort.Value)+#13#10+
  'config_delayerror = 1'#13#10+
  ''#13#10+
  'config_display = True'#13#10+
  ''#13#10+
  '# Banned countries'#13#10+
  '#config_banned_countries = [''us'',''uk'',''il'',''ie'']'#13#10+
  '#config_banned_countries = [''il'']'#13#10+
  'config_banned_countries = []'#13#10+
  ''#13#10+
  'cache_domains = []'#13#10+
  'cache_ips = []'#13#10+
  ''#13#10+
  '#============================='#13#10+
  '# SQL'#13#10+
  '#============================='#13#10+
  ''#13#10+
  ''#13#10+
  ''#13#10+
  ''#13#10+
  'class DNSClient:'#13#10+
  '	def __init__(self, nameservers, timeout):'#13#10+
  '		self.res = dns.resolver.Resolver()'#13#10+
  '		self.res.nameservers = nameservers'#13#10+
  '		self.res.timeout = timeout'#13#10+
  ''#13#10+
  '	def dnsResolve(self, domain):'#13#10+
  '		res = 0'#13#10+
  '		try:'#13#10+
  '			answer = self.res.query(domain, "A")'#13#10+
  '			res = "%s" % answer[0]'#13#10+
  '		except dns.resolver.NoAnswer:'#13#10+
  '			#print "Error: No AAAA record for", dnss.domain," ", data'#13#10+
  '			sys.stdout.flush()'#13#10+
  '		except dns.resolver.NXDOMAIN:'#13#10+
  '			#print "Error: The name ", dnss.domain, " does not exist"'#13#10+
  '			sys.stdout.flush()'#13#10+
  '		except DNSException:'#13#10+
  '			#print ''Error: DNS Exception: '', dnss.domain'#13#10+
  '			sys.stdout.flush()'#13#10+
  '		return res'#13#10+
  ''#13#10+
  'class DNSServer:'#13#10+
  '	def __init__(self, ip, port, delayerror):'#13#10+
  '		self.udps = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)'#13#10+
  '		try:'#13#10+
  '			self.udps.bind((ip,port))'#13#10+
  '		except:'#13#10+
  '			print "Error: Port ",port," already used (wait ",delayerror," seconds before close)"'#13#10+
  '			sys.stdout.flush()'#13#10+
  '			time.sleep(delayerror)'#13#10+
  '			sys.exit(0)'#13#10+
  ''#13#10+
  '	def recieveQuery(self):'#13#10+
  '		try:'#13#10+
  '			return self.udps.recvfrom(1024)'#13#10+
  '		except:'#13#10+
  '			#print "Error: recieving data on UDP server"'#13#10+
  '			sys.stdout.flush()'#13#10+
  ''#13#10+
  '	def sendQuery(self, answer, addr):'#13#10+
  '		self.udps.sendto(answer, addr)'#13#10+
  ''#13#10+
  '	def close(self):'#13#10+
  '		self.udps.close()'#13#10+
  '		print ''Close'''#13#10+
  '		sys.stdout.flush()'#13#10+
  ''#13#10+
  'class DNSQuery:'#13#10+
  '	def __init__(self, data):'#13#10+
  '		try:'#13#10+
  '			self.data=data'#13#10+
  '			self.domain='''''#13#10+
  '			#tipo : Opcode query type =  [ standard (0) | inverse (1) | server status (2) ]'#13#10+
  '			tipo = (ord(data[2]) >> 3) & 15	 # Opcode bits'#13#10+
  '			if tipo == 0:					 # Standard query'#13#10+
  '				ini=12'#13#10+
  '				lon=ord(data[ini])'#13#10+
  '				while lon != 0:'#13#10+
  '					self.domain+=data[ini+1:ini+lon+1]+''.'''#13#10+
  '					ini+=lon+1'#13#10+
  '					lon=ord(data[ini])'#13#10+
  '		except:'#13#10+
  '			return ""'#13#10+
  ''#13#10+
  '	def dnsAnswer(self, ip):'#13#10+
  '		packet='''''#13#10+
  '		if self.domain and len(self.domain) > 0:'#13#10+
  '			packet+=self.data[:2] + "\x81\x80"'#13#10+
  '			packet+=self.data[4:6] + self.data[4:6] + ''\x00\x00\x00\x00''	 # Questions and Answers Counts'#13#10+
  '			packet+=self.data[12:]											 # Original Domain Name Question'#13#10+
  '			packet+=''\xc0\x0c''												 # Pointer to domain name'#13#10+
  '			packet+=''\x00\x01\x00\x01\x00\x00\x00\x3c\x00\x04''				 # Response type, ttl and resource data length -> 4 bytes'#13#10+
  '			try:'#13#10+
  '				packet+=str.join('''',map(lambda x: chr(int(x)), ip.split(''.''))) 	 # 4bytes of IP'#13#10+
  '			except:'#13#10+
  '				return ""'#13#10+
  '		return packet'#13#10+
  ''#13#10+
  '	def checkHost(self, domain):'#13#10+
  '		domain = domain[:-1]'#13#10+
  '		res = '''';'#13#10+
  '		#fp = open(''C:\WINDOWS\system32\drivers\etc\hosts'', ''r'')'#13#10+
  '		fp = open(hostfile, ''r'')'#13#10+
  '		#fp = open(''/mnt/sdcard2/!prog/hosts'', ''r'')'#13#10+
  '		for line in fp.readlines():'#13#10+
  '			#print line'#13#10+
  '			if "	"+domain in line:'#13#10+
  '				res = line.split("	")[0]'#13#10+
  '			if " "+domain in line:'#13#10+
  '				res = line.split("	")[0]'#13#10+
  '		fp.close()'#13#10+
  '		if res <> "":'#13#10+
  '			if res[0] == "#":'#13#10+
  '				res = '''';'#13#10+
  '		return res'#13#10+
  ''#13#10+
  '	def onlyDomain(self, domain):'#13#10+
  '		d = domain[:-1]'#13#10+
  '		data = d.split(".")'#13#10+
  '		if len(data) <= 2:'#13#10+
  '			return d'#13#10+
  '		result=""'#13#10+
  '		start = len(data) - 2'#13#10+
  '		for i in range(start,len(data),1):'#13#10+
  '			result = result + data[i] + "."'#13#10+
  '		if result <> '''':'#13#10+
  '			return result[:-1]'#13#10+
  ''#13#10+
  ''#13#10+
  '	def resolveDomain(self, domain, idstatus):'#13#10+
  '	'#13#10+
  '		if config_cache_memory == 1:'#13#10+
  '			if domain in cache_domains:'#13#10+
  '				i = cache_domains.index(domain)'#13#10+
  '				return cache_ips[i]'#13#10+
  '			else:'#13#10+
  '				cache_domains.append(domain)'#13#10+
  '				'#13#10+
  '		if ".in-addr.arpa" in domain:'#13#10+
  '			if config_display:'#13#10+
  '				print "ARPA"'#13#10+
  '			if config_cache_memory == 1:'#13#10+
  '				cache_ips.append("127.0.0.1")'#13#10+
  '			return "127.0.0.1"'#13#10+
  '			'#13#10+
  '		IPHost = dnss.checkHost(domain)'#13#10+
  '		if IPHost <> '''':'#13#10+
  '			if config_display:'#13#10+
  '				print "Host file domain:"'#13#10+
  '			if config_cache_memory == 1:'#13#10+
  '				cache_ips.append(IPHost)'#13#10+
  '			return IPHost'#13#10+
  ''#13#10+
  ''#13#10+
  '			'#13#10+
  '		d = dnss.onlyDomain(domain)'#13#10+
  '		#print d'#13#10+
  '		nameservers = config_dnsrelay'#13#10+
  '		ip = dnsc.dnsResolve(domain) # Ask the Primary DNS server'#13#10+
  '		if ip == 0:'#13#10+
  '			if config_cache_memory == 1:'#13#10+
  '				cache_ips.append("127.0.0.1")'#13#10+
  '			return "127.0.0.1"'#13#10+
  '			'#13#10+
  '		#db.sqlsetdomain(domain, ip) # Add IP in database'#13#10+
  '		if config_cache_memory == 1:'#13#10+
  '			cache_ips.append(ip)'#13#10+
  '		return ip'#13#10+
  ''#13#10+
  '		'#13#10+
  ''#13#10+
  'class SQLConnexion:'#13#10+
  '	def __init__(self, dbhost, dbport, dbuser, dbpasswd, dbname, dbtable):'#13#10+
  ''#13#10+
  '                time.sleep(5)'#13#10+
  '		self.db = MySQLdb.connect(host=dbhost, port=dbport, user=dbuser, passwd=dbpasswd, db=dbname)'#13#10+
  '		self.cur = self.db.cursor()'#13#10+
  '		self.tablecache = dbtable '#13#10+
  '		try:'#13#10+
  '			time.sleep(5)'#13#10+
  '			self.db = MySQLdb.connect(host=dbhost, port=dbport, user=dbuser, passwd=dbpasswd, db=dbname)'#13#10+
  '			self.cur = self.db.cursor()'#13#10+
  '			self.tablecache = dbtable    '#13#10+
  '		except:'#13#10+
  '			print "Error connexion database MySQL"'#13#10+
  '			sys.stdout.flush()'#13#10+
  '			time.sleep(5)'#13#10+
  '			sys.exit(0)'#13#10+
  ''#13#10+
  '	def close(self):'#13#10+
  '		self.cur.close()'#13#10+
  '		self.db.close()'#13#10+
  ''#13#10+
  '	def sqlquery(self, query):'#13#10+
  '		try:'#13#10+
  '			self.cur.execute(query)'#13#10+
  '		except MySQLdb.Error, e:'#13#10+
  '			print "Error %d: %s" % (e.args[0], e.args[1])'#13#10+
  '			print "Query SQL \n %s" % query'#13#10+
  '			sys.stdout.flush()'#13#10+
  '			self.db.rollback()'#13#10+
  '			time.sleep(5)'#13#10+
  ''#13#10+
  '	def sqlgetdomain(self, domain):'#13#10+
  '		res = 0'#13#10+
  '		self.sqlquery("SELECT * FROM `"+self.tablecache+"` WHERE `domain` = ''"+domain[:-1]+"'';")'#13#10+
  '		resultcount = int(self.cur.rowcount)'#13#10+
  '		if resultcount > 0:'#13#10+
  '			q = self.cur.fetchall()'#13#10+
  '			ip = q[0][1]'#13#10+
  '			banned = q[0][2]'#13#10+
  '			if banned == 1:'#13#10+
  '				res = "127.0.0.1"'#13#10+
  '			else:'#13#10+
  '				res = ip'#13#10+
  '		return res'#13#10+
  ''#13#10+
  '	def sqlsetdomain(self, domain, ip):'#13#10+
  '		self.sqlquery("DELETE FROM `"+self.tablecache+"` WHERE `domain` = ''"+domain[:-1]+"'';")'#13#10+
  '		self.db.commit()'#13#10+
  '		self.sqlquery("INSERT INTO `"+self.tablecache+"` (`domain` ,`ip` ,`banned`) VALUES (''"+domain[:-1]+"'', ''"+ip+"'', ''0'');")'#13#10+
  '		self.db.commit()'#13#10+
  ''#13#10+
  '	def sqlgetcountry(self, ip):'#13#10+
  '		self.sqlquery("SELECT country FROM ip2nation WHERE ip < INET_ATON(''"+ip+"'') ORDER BY ip DESC LIMIT 0,1;")'#13#10+
  '		resultcount = int(self.cur.rowcount)'#13#10+
  '		if resultcount > 0:'#13#10+
  '			q = self.cur.fetchall()'#13#10+
  '			country = q[0][0]'#13#10+
  '			return country'#13#10+
  '		else:'#13#10+
  '			return "unkown"'#13#10+
  ''#13#10+
  '	def sqlgetcountryname(self, ip):'#13#10+
  '		self.sqlquery("SELECT c.country FROM ip2nationCountries c, ip2nation i WHERE i.ip < INET_ATON(''"+ip+"'') AND  c.code = i.country ORDER BY i.ip DESC LIMIT 0,1;")'#13#10+
  '		resultcount = int(self.cur.rowcount)'#13#10+
  '		if resultcount > 0:'#13#10+
  '			q = self.cur.fetchall()'#13#10+
  '			country = q[0][0]'#13#10+
  '			return country'#13#10+
  '		else:'#13#10+
  '			return "unkown"'#13#10+
  ''#13#10+
  'if __name__ == ''__main__'':'#13#10+
  '	print ''Started;EOL;'''#13#10+
  '	sys.stdout.flush()'#13#10+
  '	if config_cache_sql == 1:'#13#10+
  '                db = SQLConnexion(config_dbhost, config_dbport, config_dbuser, config_dbpasswd, config_dbname, config_dbtable) # SQL Connexion'#13#10+
  '	dnsc = DNSClient(config_dnsrelay, config_dnstimeout) # DNS Client'#13#10+
  '	udps = DNSServer(config_dnsip, config_dnsport, config_delayerror) # DNS Server'#13#10+
  '	'#13#10+
  '	try:'#13#10+
  '		while 1:'#13#10+
  '			req = udps.recieveQuery() # recieve UDP data (usually on port 53)'#13#10+
  '			if not req:'#13#10+
  '				continue'#13#10+
  '			data, addr = req # recieve UDP data (usually on port 53)'#13#10+
  '			dnss = DNSQuery(data) # Parse DNS query'#13#10+
  '			'#13#10+
  '			isArpa = ".in-addr.arpa" in dnss.domain'#13#10+
  '			country = ''unkown'''#13#10+
  '			answer = ''127.0.0.1'''#13#10+
  '			if isArpa:'#13#10+
  '				print ''isArpa'''#13#10+
  '				ip = dnss.domain.split(".") '#13#10+
  '				answer = ip[3]+"."+ip[2]+"."+ip[1]+"."+ip[0]'#13#10+
  '				#country = db.sqlgetcountry(answer)'#13#10+
  '				#countryname = db.sqlgetcountryname(answer)'#13#10+
  '				#if country in config_banned_countries:'#13#10+
  '				#answer = answer+"."+country+"."+countryname'#13#10+
  '				#TEST'#13#10+
  '				#answer = ''127.0.0.1'''#13#10+
  '				#print "arpa adress"'#13#10+
  '			else:'#13#10+
  '				#print "normal domain"'#13#10+
  '				'#13#10+
  ''#13#10+
  '				if config_cache_sql == 1: # if domain exists'#13#10+
  ''#13#10+
  '					#UPDATE d''adresse deja existante'#13#10+
  '					#answer = dnsc.dnsResolve(dnss.domain) # Ask the Primary DNS server'#13#10+
  '					#db.sqlsetdomain(dnss.domain, answer) # Add IP in database'#13#10+
  '					answer = db.sqlgetdomain(dnss.domain) # Check if domain exists in database'#13#10+
  '					countryname = db.sqlgetcountryname(answer)'#13#10+
  '					country = db.sqlgetcountry(answer)'#13#10+
  '					if country in config_banned_countries and addr[0] == ''8.8.8.20'':'#13#10+
  '						answer = ''127.0.0.1'''#13#10+
  ''#13#10+
  '					udps.sendQuery(dnss.dnsAnswer(answer), addr) # Send IP to the user'#13#10+
  ''#13#10+
  '				else: # if it''s a new domain'#13#10+
  '					#print "New domain:"'#13#10+
  '					answer = dnss.resolveDomain(dnss.domain, 2) # Ask the Primary DNS server'#13#10+
  '					#answer = dnsc.dnsResolve(dnss.domain) # Ask the Primary DNS server'#13#10+
  '					if answer == 0 :'#13#10+
  '						answer = "127.0.0.1"'#13#10+
  '					else:'#13#10+
  '						#db.sqlsetdomain(dnss.domain, answer) # Add IP in database'#13#10+
  '						#countryname = db.sqlgetcountryname(answer)'#13#10+
  '						#country = db.sqlgetcountry(answer)'#13#10+
  ''#13#10+
  '						#if country in config_banned_countries and addr[0] == ''8.8.8.20'':'#13#10+
  '						#	answer = ''127.0.0.1'''#13#10+
  ''#13#10+
  '						udps.sendQuery(dnss.dnsAnswer(answer), addr) # Send IP to the user'#13#10+
  ''#13#10+
  '			# Display log'#13#10+
  '			heure = time.strftime(''%d.%m.%y; %H:%M:%S'',time.localtime())'#13#10+
  ''#13#10+
  '			'#13#10+
  '			#if answer == ''127.0.0.1'':'#13#10+
  '			#	countryname = '''''#13#10+
  '			#	country = ''local'''#13#10+
  '			#else:'#13#10+
  '			#if answer != ''127.0.0.1'':'#13#10+
  '			#	db.sqlsetdomain(dnss.domain, answer) # Add IP in database'#13#10+
  '			print ''%s; %s; %s; %s;EOL;'' % (heure, addr[0], answer, dnss.domain)'#13#10+
  '			sys.stdout.flush()'#13#10+
  '	except KeyboardInterrupt:'#13#10+
  '		udps.close()'#13#10;
  ecrireDansUnFichier(DataDirectoryPath + 'relayDNS.py', script);
end;



procedure TForm1.ButtonStartClick(Sender: TObject);
var
  i: Integer;
  filepath: string;
  dns: string;
begin
  ToolButton11.Enabled := False;
  ToolButton3Click(ToolButton3);
  ToolButton3.Down := True;

  if FormInstall = nil then
  begin
    FormInstall := TFormInstall.Create(Self);
  end;

  FormInstall.CheckInstallation;

  if not FormInstall.isPythonInstalled
  or not FormInstall.isDNSInstalled
  or not FormInstall.isSetuptoolInstalled
  then begin
    FormInstall.Show;
    FormInstall.ButtonInstallClick(nil);
    ToolButton11.Enabled := True;
    FormInstall.TimerWatchThread.Enabled := True;
    exit;
  end
  else begin
    FormInstall.Close;
  end;


  ButtonCloseClick(nil);
  closeProcessCreated;

  filepath := String(EditFilehost.Text);
  if FileExists(filepath) = False then
    ecrireDansUnFichier(filepath, '127.0.0.1	localhost');

  if not FileExists(filepath) then
  begin
    MemoLogs.Lines.Add('Erreur: Lancement annulé.');
    MemoLogs.Lines.Add('   Le chemin du fichier host est introuvable.');
    MemoLogs.Lines.Add('   Veuillez définir le chemin du fichier host en cliquant sur le bouton "Config"');
    ToolButton11.Enabled := True;
    exit;
  end;

  ToolButton11.Enabled := True;
  MemoLogs.Lines.Add('Test DNS Master...');
  DNSMasterSerialized := '';
  for i := 0 to ListBoxDNSMaster.Items.Count -1 do
  begin
    dns := ListBoxDNSMaster.Items.Strings[i];
    MemoLogs.Lines.Add('Master '+ dns +'... ');
    if resolveDNS('google.com', dns) = '' then
    begin
      DNSMasterSerialized := '';
      MemoLogs.Lines.Add('Erreur: Lancement annulé.');
      MemoLogs.Lines.Add('   Impossible d''atteindre le serveur DNS Master '+dns);
      MemoLogs.Lines.Add('   Veuillez vous connecter à Internet et essayer à nouveau');
      MemoLogs.Lines.Add('   ou indiquer un autre serveur DNS dans la section "DNS Master"');
      exit;
    end;
    if DNSMasterSerialized <> '' then DNSMasterSerialized := DNSMasterSerialized + ' ';
    DNSMasterSerialized := DNSMasterSerialized + dns;
    MemoLogs.Lines.Delete(MemoLogs.Lines.Count - 1);
    MemoLogs.Lines.Add('Master '+ dns +'... OK');
  end;
  ToolButton11.Enabled := False;

  if DNSMasterSerialized = '' then
  begin
    MemoLogs.Lines.Add('Erreur: Lancement annulé');
    MemoLogs.Lines.Add('   Vous n''avez aucun DNS Master dans votre liste.');
    MemoLogs.Lines.Add('   Veuillez définir un Master DNS dans votre liste (exemple 209.244.0.3)');
    ToolButton11.Enabled := True;
    exit;
  end;

  //MemoLogs.Lines.Delete(MemoLogs.Lines.Count - 1);
  //MemoLogs.Lines.Add('Test DNS Master... DNS is OK :)');

  createVBScript();

  if PythonPath = '' then PythonPath := getPythonPath();

  i := Length(listThreads);
  SetLength(listThreads, i+1);
  listThreads[0] := Unit1.TSauvegarde.Create(True);
  listThreads[0].cmd := '"'+PythonPath+'python.exe" "'+DataDirectoryPath + 'relayDNS.py" config_dnsip "'+CBoxDNSServerSlaveIP.Text+'" hostfile "'+EditFilehost.Text+'"';
  //MemoLogs.Lines.Add(listThreads[i].cmd);
  listThreads[0].output := TStringList.Create;
  listThreads[0].EnMemo := MemoLogs;
  listThreads[0].indexThread := i;
  listThreads[0].Suspended := False;

  //MemoLogs.Lines.Add('Flushdns');
  LaunchAndWait('ipconfig.exe','/flushdns', SW_HIDE);

  
  {
  listThreads[1] := Unit1.TSauvegarde.Create(True);
  listThreads[1].cmd := 'ipconfig.exe /flushdns';
  listThreads[1].EnMemo := nil;
  listThreads[1].Suspended := False;
   }
  //listThreads[0].Terminate;
end;


procedure DestroyProcess(hProcess: Cardinal);
Var
  ovExitCode: LongWord;
begin
  try
    if hProcess<>0 then
    begin
      GetExitCodeProcess(hProcess, ovExitCode);
      if (ovExitCode = STILL_ACTIVE) or (ovExitCode <> WAIT_OBJECT_0) then
        TerminateProcess(hProcess, ovExitCode);
      //CloseHandle(hProcess);
    end;
  except
  On E : EOSError do
    exit;
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
  if Length(listThreads) > 0 then onServerDNSStop();
  Systray.EnleveIconeTray();
  ButtonCloseClick(Sender);
  KillTask(ExtractFileName(Application.ExeName));
end;

procedure TForm1.ButtonCloseClick(Sender: TObject);
var
  i, max: Integer;
begin
  Notebook1.PageIndex := 4;
  max := Length(listThreads)-1;
  for i:=0 to max do
  begin
    if (listThreads[i] <> nil) and not (listThreads[i].Terminated) then
    begin
      try
        DestroyProcess(listThreads[i].h);
      except
        On E : EOSError do
          exit;
      end;
    end;
  end;
 {
  for i:=0 to Length(listThreads) do
  begin
    if Assigned(listThreads[i]) then
      if not listThreads[i].Terminated then
        listThreads[i].DoTerminate;
  end;

  for i:=0 to Length(listThreads) do
  begin
    if Assigned(listThreads[i]) then
      listThreads[i].Destroy;
  end;

           }
end;

// Add DNS MASTER
procedure TForm1.ToolButton1Click(Sender: TObject);
var txt: string;
begin
  txt := InputBox('Add DNS Master', 'Exemple 209.244.0.3', '');
  if txt = '' then exit;
  ListBoxDNSMaster.Items.Add(txt);
  ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
end;

// Erase  DNS MASTER
procedure TForm1.ToolButton2Click(Sender: TObject);
var
  i:integer;
  txt:string;
begin
  i := ListBoxDNSMaster.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord sélectionner un élément dans la liste avant de cliquer sur ce bouton');
    exit;
  end;
  txt := ListBoxDNSMaster.Items.Strings[i];
  MessageBeep(MB_OK);
  if MessageDlg('Effacer "' + txt + '"?',mtConfirmation, mbOKCancel, 0)  = mrOK then
  begin
    ListBoxDNSMaster.DeleteSelected;
    ListBoxDNSMaster.ItemIndex := 1 - 1;
    ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
    ShowMessage('Effacé');
  end;
end;

// Update DNS MASTER       
procedure TForm1.ToolButtonUpdateDNSMasterClick(Sender: TObject);
var
  i:integer;
  txt:string;
begin
  i := ListBoxDNSMaster.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord sélectionner un élément dans la liste avant de cliquer sur ce bouton');
    exit;
  end;
  txt := ListBoxDNSMaster.Items.Strings[i];
  txt := InputBox('Update DNS Master', 'Exemple 209.244.0.3', txt);
  if txt = '' then exit;
  ListBoxDNSMaster.Items.Strings[i] := txt;
  ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
end;

procedure TForm1.ToolButtonDownDNSMasterClick(Sender: TObject);
var i:integer;
begin
  i := ListBoxDNSMaster.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord sélectionner un élément dans la liste avant de cliquer sur ce bouton');
    exit;
  end;
  if i >= ListBoxDNSMaster.Items.Count -1 then exit;
  ListBoxDNSMaster.Items.Move(i, i +1);
  ListBoxDNSMaster.ItemIndex := i +1;
  ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
end;

procedure TForm1.ToolButtonUpDNSMasterClick(Sender: TObject);
var i:integer;
begin
  i := ListBoxDNSMaster.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord sélectionner un élément dans la liste avant de cliquer sur ce bouton');
    exit;
  end;
  if i > ListBoxDNSMaster.Items.Count -1 then exit;
  ListBoxDNSMaster.Items.Move(i, i - 1);
  ListBoxDNSMaster.ItemIndex := i - 1;
  ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
end;


procedure TForm1.ToolButtonEditHostClick(Sender: TObject);
var
  FormHost: TFormHost;
  filepath: string;
begin
  filepath := ExtractFilePath(Application.ExeName)+ String(EditFilehost.Text);
  if FileExists(filepath) = False then
    ecrireDansUnFichier(filepath, '127.0.0.1	localhost');

  FormHost := TFormHost.Create(Self);
  FormHost.Show;
  FormHost.Filename := EditFilehost.Text;
  FormHost.Load();
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
  param: string;
  net: tNetworkInterfaceList;
  canClose: Boolean;
  startedInBackground: Boolean;
begin
  //if IsUserAnAdmin() then ShowMessage('admin') else ShowMessage('no admin');
  if not IsUserAnAdmin() then
  begin
    param := '';
    for i:=1 to ParamCount() do
      param := param +' '+ParamStr(i);
    ExecAndBringToFront(Application.ExeName, param);
    canClose := True;
    FormCloseQuery(nil, canClose);
    Application.Terminate;
  end;

  Form1.Caption := PChar('DNS Relay Server '+CurrentApplicationVersion);

  isServerStarted := False;
  Memo1.Clear;
  Memo1.Text := 'Veuillez lire les modalités et les conditions suivantes avant l''utilisation de ces logiciels.  L''utilisation de ce logiciel indique l''acceptation des termes et conditions de la licence.'+#13#10#13#10+
                '1. Déni de garantie'+#13#10#13#10+
                '"DNS Relay Server" est fourni "tel-que", et aucune garantie de quelque sorte n''est exprimée ou impliquée, incluant sans limitation, toute garantie de valeur marchande ou format physique pour un but particulier.'+#13#10#13#10+
                'Dans aucun cas, l''auteur de ce logiciel ne sera jugé responsable de la perte de données, des dommages, du manque à gagner ou de n''importe quel autre genre de perte par l''utilisation correcte ou non de ce logiciel.'+#13#10#13#10+
                'Le logiciel peut être modifié. Le code source est fourni dans le setup d''installation.'+#13#10#13#10+
                ''+#13#10#13#10+
                '2. Licence'+#13#10#13#10+
                '"DNS Relay Server" est fourni en tant que logiciel open source.'+#13#10#13#10+
                'Dans ce cas, Vous avez le droit d''utiliser, de le modifier et de le distribuer comme vous voulez.'+#13#10#13#10+
                'L''installation et l''utilisation de ce logiciel signifie l''acceptation des termes et conditions de la license.'+#13#10#13#10+
                ''+#13#10#13#10+
                '3. Fonctionnement'+#13#10#13#10+
                '"DNS Relay Server" modifie la configuration de vos cartes réseau afin de pouvoir filtrer Internet au niveau des noms de domaines (DNS).'+#13#10#13#10+
                'Au lancement du serveur, l''adresse des serveurs DNS seront modifiés sur vos cartes réseau par l''IP de votre propre machine.'+#13#10#13#10+
                'A la fermeture du serveur, vos cartes réseau repassent en mode automatique (mode DHCP).'+#13#10#13#10+
                'Si vous êtiez en configuration IP manuelle, vous risquez de perdre votre IP.'+#13#10#13#10+
                'Donc si vous lancez ce programme sur un serveur distant, vous risquez de perdre la connexion.'+#13#10#13#10+
                'Soyez conscient des risques.'+#13#10#13#10+
                'Par mesure de sécurité, un script VBS est placé au lancement de Windows afin de réparer la connexion Internet en cas de plantage du PC.'+#13#10#13#10+
                'Nous nous efforçons de fournir un programme le plus sûr possible pour l''utilisateur.'+#13#10#13#10+
                'Vous êtes en version beta-test, ce qui signifie que ce programme n''a pas été encore testé partout. Il peut y avoir encore des bugs non-répertoriés.'+#13#10#13#10+
                'Pour fonctionner le serveur DNS a besoin de Python 2.7 et de quelques librairies pour fonctionner. Ces dépendances seront téléchargés et installés automatiquement au lancement du serveur.  Une connexion Internet sera nécessaire.'+#13#10#13#10+
                'A la fin de l''installation, le serveur sera lancé automatiquement.'+#13#10#13#10+
                'L''installation et l''utilisation de ce logiciel signifie l''acceptation des termes et conditions de la license.';


  ToolBar3.DoubleBuffered := True;
  ListView1.DoubleBuffered := True;
  MemoLogs.DoubleBuffered := True;
  Panel1.Align := alClient;
  GroupBox1.Align := alClient;
  GroupBox2.Align := alClient;
  GroupBox3.Align := alClient;
  GroupBox4.Align := alClient;
  GroupBox5.Align := alClient;
  GroupBox6.Align := alClient;
  Notebook1.Align := alClient;

  Notebook1.PageIndex := 5;
  //ToolButton7.Click;
  //ToolButton7.Down := True;

  DataDirectoryPath := ExtractFilePath(Application.ExeName)+AnsiReplaceStr(ExtractFileName(Application.ExeName), '.exe', '')+'\';
  FilehostPathConfig := DataDirectoryPath + FilehostPathConfig ;
  SlaveDNSIPConfig := DataDirectoryPath + SlaveDNSIPConfig;
  SlaveDNSPortConfig := DataDirectoryPath + SlaveDNSPortConfig;


  if not DirectoryExists(DataDirectoryPath) then makeDir(DataDirectoryPath);
  if EditFilehost.Text = '' then EditFilehost.Text := DataDirectoryPath + 'host.txt';
  MasterDNSFile := DataDirectoryPath+MasterDNSFile;
  SlaveDNSProcesslist := DataDirectoryPath+SlaveDNSProcesslist;
  PythonPath := getPythonPath();
  if FileExists(MasterDNSFile) then
    ListBoxDNSMaster.Items.LoadFromFile(MasterDNSFile);

  if FileExists(FilehostPathConfig) then
    EditFilehost.Text := lireFichier(FilehostPathConfig);

  Systray.AjouteIconeTray(Handle,Application.Icon.Handle,Self.Caption);

  //if not startedInBackground then


    ListViewCreate(ListView1);
    getDomains(EditFilehost.Text, ListView1);
    ListView1.OnChange := ListView1Change;
  {
  // Add at the end
  EditerLigne2(ListView1, ListView1.Items.Count, 3, 'yes','nice');
  // Add at the begining
  EditerLigne2(ListView1, -1, 0, 'cool','nice');
  ShowMessage(getDomain(EditFilehost.Text, 'localhost'));
  }
  //result := ReadString(HKEY_LOCAL_MACHINE, 'SOFTWARE\Python\PythonCore\2.7\InstallPath', '');
  //if (result = '') and FileExists('c:\Python27\python.exe') then result := 'c:\Python27\';

  //MemoLogs.Lines.Add(resolveDNS('google.com', '127.0.0.1')); // 209.244.0.3
  //MemoLogs.Lines.Add(resolveDNS('google.com', '209.244.0.3'));

  ButtonRefreshNetCardClick(nil);


  for i:=0 to ParamCount() do
  begin
    if ParamStr(i) = '/background' then
    begin
      Masquer1Click(nil);
      ButtonStartClick(nil);
    end;
    if ParamStr(i) = '/autostart' then
    begin
      ButtonStartClick(nil);
    end;
  end;

  if FileExists(DataDirectoryPath + 'checkupdate.cfg') then
  begin
    Form1.CheckBoxUpdate.Checked := true;
  end;
  // Do Update
  //TUpdate.Create(false);
  TimerUpdate.Enabled := True;
end;

procedure TUpdate.Execute;
begin
  if FileExists(DataDirectoryPath + 'checkupdate.cfg') then
  begin
    DoUpdate(True);
  end;
end;

function TForm1.getPythonPath():string;
begin
  result := '';
  if ReadStringExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Python\PythonCore\2.7', 'InstallPath') then
    result := ReadString(HKEY_LOCAL_MACHINE, 'SOFTWARE\Python\PythonCore\2.7', 'InstallPath');
  if (result = '') and FileExists('c:\Python27\python.exe') then result := 'c:\Python27\';
end;


function TForm1.isPythonInstalled(PythonDirPath: string):bool;
begin
  result := DirectoryExists(PythonDirPath) and FileExists(PythonDirPath+'python.exe');
end;


procedure TForm1.MemoLogsChange(Sender: TObject);
var LineCount: Integer;
begin
  //if not CheckBoxScrollLogs.Checked then exit;
  LineCount := TMemo(Sender).Perform(EM_GETLINECOUNT, 0, 0) - 1;
  SendMessage(TMemo(Sender).Handle, EM_LINESCROLL, 0, LineCount);
end;


function TForm1.KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  try
    CloseHandle(FSnapshotHandle);
  except
    On E : EOSError do
      exit;
  end;
end;


function CloseTaskPID(ExeFileName: string; pid: Integer): Integer;
const
  PROCESS_TERMINATE = $0001;
  max_loop = 1000;
var
  i: Integer;
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  i := 0;
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while (Integer(ContinueLoop) <> 0) and (i < max_loop) do
  begin
    if (
      (UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName))
      or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName))
      ) and (Integer(FProcessEntry32.th32ProcessID) = pid) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
     inc(i);
  end;
  try
    CloseHandle(FSnapshotHandle);
  except
    On E : EOSError do
      exit;
  end;
end;


procedure CloseProcessPID(pid: Integer);
var
  processHandle: THandle;
begin
  try
    processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION, False, pid);
    if processHandle <> 0 then
    begin
      { Terminate the process }
      TerminateProcess(processHandle, 0);
      CloseHandle(ProcessHandle);
    end;
  except
    On E : EOSError do
      exit;
  end;
end;


procedure KillProcess(hWindowHandle: HWND);
var
  hprocessID: INTEGER;
  processHandle: THandle;
  DWResult: DWORD;
begin
  try
    SendMessageTimeout(hWindowHandle, WM_CLOSE, 0, 0,
    SMTO_ABORTIFHUNG or SMTO_NORMAL, 5000, DWResult);
    if isWindow(hWindowHandle) then
    begin
      { Get the process identifier for the window}
      GetWindowThreadProcessID(hWindowHandle, @hprocessID);
      if hprocessID <> 0 then
      begin
        { Get the process handle }
        processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION,
          False, hprocessID);
        if processHandle <> 0 then
        begin
          { Terminate the process }
          TerminateProcess(processHandle, 0);
          CloseHandle(ProcessHandle);
        end;
      end;
    end;
  except
    On E : EOSError do
      exit;
  end;
end;

procedure TForm1.onProcessCreated(h: Cardinal);
//var txt: string;
begin
  ecrireDansUnFichier(SlaveDNSProcesslist, IntToStr(h));
  {
  exit;
  txt := '';
  if FileExists(SlaveDNSProcesslist) then
    txt := txt + lireFichier(SlaveDNSProcesslist);
  if txt <> '' then
    txt := txt + ';';
  ecrireDansUnFichier(SlaveDNSProcesslist, txt+IntToStr(h));
  }
end;

procedure TForm1.closeProcessCreated();
var
  i: integer;
  txt: string;
  sl: TStringList;
  h: Cardinal;

begin
  if not FileExists(SlaveDNSProcesslist) then exit;

  txt := LireFichier(SlaveDNSProcesslist);
  if txt = '' then exit;
  h := StrToInt(txt);
  CloseTaskPID('python.exe',h);
  exit;

  sl:=TStringList.Create;
  txt := LireFichier(SlaveDNSProcesslist);
  SplitStr(txt,';',sl);
  if sl.Count > 0 then
  begin
    for i := 0 to sl.Count -1 do
    begin
      try
        h := StrToInt(sl[i]);
        //ShowMessage(sl[i]);
        //CloseProcessPID(h);
        CloseTaskPID('python.exe',h);
      except
        On E : EOSError do
          exit;
      end;
    end;
  end;
  DeleteFile(SlaveDNSProcesslist);
  sl.Free;
end;



procedure TForm1.ButtonInstallClick(Sender: TObject);
begin
  if FormInstall = nil then
    FormInstall := TFormInstall.Create(Self);
  FormInstall.Show;
  FormInstall.CheckInstallation;
end;



procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Pos:TPoint;
begin
  //action kan on clique
  GetCursorPos(Pos);//positon de la souris;
  case X of
    WM_LBUTTONDBLCLK: Show; //Double klik gauche
    WM_LBUTTONDOWN:  Show;    //Bouton gauche pousse
    WM_LBUTTONUP: ; //PopupMenu1.Popup(Pos.X,Pos.Y); //Bouton gauche lève
    WM_RBUTTONDBLCLK:; //Double klik droit
    WM_RBUTTONDOWN:;    //Bouton droit pousse
    WM_RBUTTONUP:PopupMenu1.Popup(Pos.X,Pos.Y); //Bouton droite lève: Popup
  end;
end;

procedure TForm1.Masquer1Click(Sender: TObject);
begin
  Self.Hide;
  ShowWindow(Application.Handle, SW_HIDE);
  Application.ShowMainForm := false;
end;

procedure TForm1.Afficher1Click(Sender: TObject);
begin
  Self.Show;
  ShowWindow(Application.Handle, SW_SHOW);
  Application.ShowMainForm := true; 
end;

procedure TForm1.Quitter1Click(Sender: TObject);
var CanClose: Boolean;
begin
  FormCloseQuery(Form1, CanClose);
  Application.Terminate;
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
  Notebook1.PageIndex := 5;
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
  Notebook1.PageIndex := 0;
  refreshCheckBox(CheckBoxStartWithWindows);
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
  Notebook1.PageIndex := 1;
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  Notebook1.PageIndex := 2;
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
  Notebook1.PageIndex := 3;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  Notebook1.PageIndex := 4;
end;



procedure TForm1.refreshCheckBox(Checkbox:TCheckBox);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
  begin
    Checkbox.Checked := Reg.ValueExists(ExtractFileName(Application.ExeName)+'_'+md5string(Application.ExeName));
    Reg.CloseKey;
  end;
  Reg.Free;
end;



procedure TForm1.CheckBoxStartWithWindowsClick(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  try
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
  begin
    if TCheckBox(Sender).Checked then
      Reg.WriteString(ExtractFileName(Application.ExeName)+'_'+md5string(Application.ExeName), '"'+Application.ExeName+'" /background')
    else
      Reg.DeleteValue(ExtractFileName(Application.ExeName)+'_'+md5string(Application.ExeName));
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;

end;

procedure TForm1.ButtonSelectFilehostClick(Sender: TObject);
begin
  if DirectoryExists(ExtractFilePath(EditFilehost.Text)) then
    SaveDialog1.InitialDir := ExtractFilePath(EditFilehost.Text);

  if SaveDialog1.Execute then
  begin
    EditFilehost.Text := SaveDialog1.FileName;
    ListView1.OnChange := nil;
    getDomains(EditFilehost.Text, ListView1);
    ListView1.OnChange := ListView1Change;
  end;
end;

procedure TForm1.ListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if not ListView1.IsEditing then exit;
  if (Item.Caption <> '') and (Item.SubItems.Count > 0) then
  begin
    setDomain(EditFilehost.Text, Item.SubItems.Strings[0], Item.Caption);
    refreshListView1Click();
  end;

end;

procedure TForm1.ToolButton9Click(Sender: TObject);
begin
  if MessageDlg('Ce bouton est un bouton d''aide. Vous allez voir quelques messages qui vont vous expliquer les boutons qui se trouvent à côté de celui que vous venez de cliquer. Voulez-vous continuer?',  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
    ShowMessage('Cliquez sur le premier bouton pour effacer les domaines inconnus (boule noire) et ne garder que ceux qui sont connus.');
    ShowMessage('Cliquez sur le deuxième bouton pour éditer manuellement le fichier host'#13#13
    +'Edition du fichier host'#13#13
    +'Exemple:'#13
    +'127.0.0.1  localhost'#13#13
    +'Règle: '#13
    +'Un ligne par domaine et ip.'#13
    +'D''abord l''ip ensuite le domaine.'#13
    +'L''ip et le domaine doivent être séparé par une tabulation (touche TAB).'#13#13
    +'Une fois les changements terminés, redémarrez le serveur (avec le bouton Start) pour appliquer les modifications.');
    ShowMessage('Cliquer bouton droit sur une IP de la liste (colone gauche) pour afficher le menu.');
end;

procedure TForm1.EditFilehostChange(Sender: TObject);
begin
  TimerSaveChange.Enabled := False;
  TimerSaveChange.Enabled := True;
end;

procedure TForm1.TimerSaveChangeTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  ecrireDansUnFichier(FilehostPathConfig, EditFilehost.Text);
  ecrireDansUnFichier(SlaveDNSIPConfig, CBoxDNSServerSlaveIP.Text);
  ecrireDansUnFichier(SlaveDNSPortConfig, IntToStr(SpinPort.Value));
end;

procedure TForm1.ToolButton10Click(Sender: TObject);
begin
  if MessageDlg('Effacer les domaines inconnus (ceux avec une boule noir) ?',  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
  ListView1.OnChange := nil;
  ListView1.Clear;
  getDomains(EditFilehost.Text, ListView1);
  ListView1.OnChange := ListView1Change;
end;

procedure TForm1.Bloquerledomaine1Click(Sender: TObject);
begin
  if not Assigned(SelectedListItem) then exit;
  setDomain( EditFilehost.Text, SelectedListItem.SubItems.Strings[0], '127.0.0.1');
  refreshListView1Click();
end;

procedure TForm1.Autoriser1Click(Sender: TObject);
begin
  if not Assigned(SelectedListItem) then exit;
  if (SelectedListItem.SubItems.Strings[0] = '') then exit;
  delDomain(EditFilehost.Text, SelectedListItem.SubItems.Strings[0]);
  refreshListView1Click();
end;

procedure TForm1.Modifier1Click(Sender: TObject);
var
  txt:string;
begin
  if not Assigned(SelectedListItem) then exit;
  txt := InputBox('Update IP Domain', 'Exemple: pour bloquer 127.0.0.1', SelectedListItem.Caption);
  if txt = '' then exit;
  setDomain( EditFilehost.Text, SelectedListItem.SubItems.Strings[0], txt);
  SelectedListItem.Caption := txt;
  refreshListView1Click();
end;

procedure TForm1.ListView1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  ListItem:TListItem;
  CurPos:TPoint;
  TopOffset, LeftOffset:integer;
begin

  // Si on clique dans la case à cocher, on séléctionne la ligne
  // Donc on récupère la position de la souris sur l'écran
  GetcursorPos(MousePos);
  // on indique sa position en fonction du ListView
  CurPos:=TListView(Sender).ScreenToClient(MousePos);
  // On récupère la ligne du listView où se trouve la souris
  ListItem:=TListView(Sender).GetItemAt(CurPos.x,CurPos.y);
  // Si on récupère bien une ligne et pas un espace blanc
  if ToolBar3.Align = alTop then
  begin
    LeftOffset := 20;
    TopOffset := 142
  end
  else begin
    LeftOffset := 115;
    TopOffset := 78;
  end;
  if Assigned(ListItem) then
  begin
    SelectedListItem := ListItem;
    PopupMenuListView.Popup(Left+CurPos.x+Notebook1.Left+LeftOffset,Top+CurPos.y+Notebook1.Top+TopOffset);
  end;
end;


procedure TForm1.refreshListView1Click();
var
  i:integer;
  ip:string;
begin
  for i := 0 to ListView1.items.count - 1 do
  begin

    ip := getDomain(EditFilehost.Text, ListView1.Items.Item[i].SubItems.Strings[0]);
    ip := onlyChars(ip);
    //ShowMessage('"'+ip+'"');
    if ip = '' then ListView1.Items.Item[i].ImageIndex := 0
    else if ip = '127.0.0.1' then ListView1.Items.Item[i].ImageIndex := 3
    else ListView1.Items.Item[i].ImageIndex := 1;

    // On coche la case du proxy actuel (si actif) et decoche les autres
    ListView1.Items.Item[i].Checked := ListView1.Items.Item[i].ImageIndex > 0;
  end;

end;

procedure TForm1.CheckBoxToggleMenuTitleClick(Sender: TObject);
begin
  ToolBar3.ShowCaptions := TCheckBox(Sender).Checked;
end;

procedure TForm1.CheckBoxMenuPositionClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    ToolBar3.Align := alTop
  else
    ToolBar3.Align := alLeft;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i: Integer;
begin
  Timer1.Enabled := False;
  if listThreads = nil then exit;
  if Length(listThreads) = 0 then exit;
  if listThreads[0].output.Count = 0 then exit;
  for i := 0 to listThreads[0].output.Count -1 do
  begin
    OnOutput(listThreads[0].output[i]);
  end;
  listThreads[0].output := TStringList.Create;
end;



procedure TForm1.ButtonForceStartClick(Sender: TObject);
begin
  KillTask('python.exe');
  ButtonStartClick(nil);
end;

procedure TForm1.ToolButton11Click(Sender: TObject);
begin
  if isServerStarted then
  begin
    //if MessageDlg('Arrêter le serveur?',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    //begin
      ToolButton11.Enabled := False;
      ButtonCloseClick(nil);
    //end;
  end
  else begin
    //if MessageDlg('Démarrer le serveur?',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    //begin
      ToolButton11.Enabled := False;
      ButtonStartClick(nil);
    //end;
  end;
end;

procedure TForm1.ButtonUpdateClick(Sender: TObject);
begin
  TButton(Sender).Enabled := False;

  if FormInstall = nil then
  begin
    FormInstall := TFormInstall.Create(Form1);
  end;
  FormInstall.CheckInstallation;
  if not FormInstall.isWgetInstalled
  then begin
    FormInstall.ButtonInstallClick(Self);
    exit;
  end;

  if ThreadUpdate = nil then ThreadUpdate := TUpdate.Create(True);
  ThreadUpdate.DoUpdate(False);
  TButton(Sender).Enabled := True;
end;

procedure TUpdate.DoUpdate(isSilent: Boolean);
var
  lastversion, lastverFile, url, wget: string;
  canClose: Boolean;
begin
 {
  if FormInstall = nil then
  begin
    FormInstall := TFormInstall.Create(Form1);
  end;
  FormInstall.CheckInstallation;
  if not FormInstall.isWgetInstalled
  then begin
    FormInstall.ButtonInstallClick(Self);
    exit;
  end;
   }
  //if isSilent then Form1.MemoLogs.Lines.Add('Recherche de Mise à jour...');

  url := 'https://github.com/ddeeproton/DNSRelayServer-DelphiPython/raw/master/lastversion.txt';
  lastverFile := ExtractFilePath(Application.ExeName)+installDirectoryPath+'lastversion.txt';
  if FileExists(lastverFile) then DeleteFile(lastverFile);
  downloadFile(url, lastverFile);

  if not FileExists(lastverFile) then
  begin
    if isSilent then
      //Form1.MemoLogs.Lines.Add('Error Update: Problème de connexion au serveur de mise à jour.')
    else
      ShowMessage('Error Update: Problème de connexion au serveur de mise à jour.');
    exit;
  end;
  lastversion := lireFichier(lastverFile);
  if Pos(CurrentApplicationVersion, lastversion) = 1 then
  begin
    if isSilent then
      //Form1.MemoLogs.Lines.Add('Vous êtes à jour')
    else
      ShowMessage('Vous êtes à jour')
  end
  else begin
    if lastversion = '' then
    begin
      if isSilent then
        //Form1.MemoLogs.Lines.Add('Le téléchargement a échoué.')
      else
        ShowMessage('Le téléchargement a échoué.'+#13+url);

      exit;
    end;
    if MessageDlg('Mise à jour version "'+lastversion+'" disponible :)'+#13+'Mettre à jour?',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    begin
      url := 'https://github.com/ddeeproton/DNSRelayServer-DelphiPython/raw/master/Setup installation/DNSRelayServerSetup_'+lastversion+'.exe';
      lastverFile := ExtractFilePath(Application.ExeName)+installDirectoryPath+'DNSRelayServerSetup_'+lastversion+'.exe';
      downloadFile(url, lastverFile);
      if FileExists(lastverFile) and (FileSize(lastverFile) > 0) then
      begin
        if MessageDlg('La mise à jour est prête à être installé. Le serveur va s''arrêter et lancer le setup d''installation. Continuer?',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
        begin
          ExecAndWait(lastverFile, '', SW_SHOWNORMAL);

          canClose := True;
          Form1.FormCloseQuery(nil, canClose);
          Application.Terminate;

        end;
      end
      else begin
        if isSilent then
          //Form1.MemoLogs.Lines.Add('La mise à jour à échoué.')
        else
          ShowMessage('La mise à jour à échoué. '+#13+url);
      end;
    end;
  end;
end;

procedure TForm1.CheckBoxUpdateClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    ecrireDansUnFichier(DataDirectoryPath + 'checkupdate.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkupdate.cfg');

  setDNSOnBoot(not CheckBoxStartWithWindows.Checked);
end;

procedure TForm1.TimerUpdateTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;

  if FormInstall = nil then
  begin
    FormInstall := TFormInstall.Create(Form1);
  end;
  FormInstall.CheckInstallation;
  if not FormInstall.isWgetInstalled
  then begin
    FormInstall.ButtonInstallClick(Self);
    exit;
  end;

  ThreadUpdate := TUpdate.Create(false);
end;

procedure TForm1.ButtonRefreshNetCardClick(Sender: TObject);
var
  i: Integer;
  net: tNetworkInterfaceList;
begin
  CBoxDNSServerSlaveIP.Clear;
  if GetNetworkInterfaces(net) then
  begin
    for i := 0 to High (net) do
    begin
      if net[i].AddrIP <> '127.0.0.1' then
        CBoxDNSServerSlaveIP.Items.Add(net[i].AddrIP);
    end;
  end;
  if CBoxDNSServerSlaveIP.Items.Count > 0 then
    CBoxDNSServerSlaveIP.ItemIndex := 0;

end;

end.
