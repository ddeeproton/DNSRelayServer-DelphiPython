unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, ComCtrls, ToolWin, Menus,
  UnitHost,  Systray, Registry, md5, ListViewManager, HostParser, //XPMan,
  Spin, Buttons, TabNotBk, NetworkManager, DNSManager, UnitAlert, PythonDNS,
  UrlMon, FilesManager, Registre, UnitInstallation, StrUtils, ProcessManager;

var CurrentApplicationVersion: string = '0.4.73';

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Quitter1: TMenuItem;
    N1: TMenuItem;
    Masquer1: TMenuItem;
    Afficher1: TMenuItem;
    ImageList2: TImageList;
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
    GroupBox3: TGroupBox;
    ListBoxIpClients: TListBox;
    GroupBox4: TGroupBox;
    ListView1: TListView;
    Timer1: TTimer;
    GroupBox6: TGroupBox;
    Memo1: TMemo;
    N2: TMenuItem;
    StartDNS1: TMenuItem;
    StopDNS1: TMenuItem;
    ImageList4: TImageList;
    TimerUpdateOnLoad: TTimer;
    TimerAfterFormCreate: TTimer;
    Mettrejour1: TMenuItem;
    N3: TMenuItem;
    TimerCheckUpdate: TTimer;
    TabbedNotebook1: TTabbedNotebook;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButtonUpdateDNSMaster: TToolButton;
    ToolButtonEraseDNSMaster: TToolButton;
    ToolButtonDownDNSMaster: TToolButton;
    ToolButtonUpDNSMaster: TToolButton;
    ListBoxDNSMaster: TListBox;
    CheckBoxUpdate: TCheckBox;
    ButtonUpdate: TButton;
    CheckBoxUpdateIntervall: TCheckBox;
    SpinTimeCheckUpdate: TSpinEdit;
    CheckBoxUpdateSilent: TCheckBox;
    GroupBox7: TGroupBox;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CBoxDNSServerSlaveIP: TComboBox;
    ButtonRefreshNetCard: TBitBtn;
    SpinPort: TSpinEdit;
    EditFilehost: TEdit;
    ButtonSelectFilehost: TButton;
    CheckBoxStartWithWindows: TCheckBox;
    CheckBoxAutostartDNSOnBoot: TCheckBox;
    Label7: TLabel;
    Panel4: TPanel;
    ButtonNetCardDesintegration: TButton;
    ButtonNetCardIntegration: TButton;
    Panel2: TPanel;
    Label9: TLabel;
    CheckBoxAllowModifyNetCard: TCheckBox;
    GroupBox5: TGroupBox;
    MemoLogs: TMemo;
    Splitter1: TSplitter;
    PopupMenuDNSMaster: TPopupMenu;
    Ajouter1: TMenuItem;
    Modifier2: TMenuItem;
    Supprimer1: TMenuItem;
    N4: TMenuItem;
    Monter1: TMenuItem;
    Descendre1: TMenuItem;
    Panel6: TPanel;
    TimerStartInBackground: TTimer;
    toujoursenavant1: TMenuItem;
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    CheckBoxSwitchTheme: TCheckBox;
    CheckBoxAlertEventsKnown: TCheckBox;
    CheckBoxAlertEventDisallowed: TCheckBox;
    CheckBoxAlertEventsUnknown: TCheckBox;
    TimerRestart: TTimer;
    TimerResetAlertPosition: TTimer;
    Panel5: TPanel;
    ToolBar3: TToolBar;
    ToolButton11: TToolButton;
    ToolButton8: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton5: TToolButton;
    procedure ButtonStartClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButtonEraseDNSMasterClick(Sender: TObject);
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
    procedure TimerUpdateOnLoadTimer(Sender: TObject);
    procedure ButtonRefreshNetCardClick(Sender: TObject);
    procedure TimerAfterFormCreateTimer(Sender: TObject);
    procedure CheckBoxUpdateIntervallClick(Sender: TObject);
    procedure CheckBoxUpdateSilentClick(Sender: TObject);
    procedure SpinTimeCheckUpdateChange(Sender: TObject);
    procedure CheckBoxAllowModifyNetCardClick(Sender: TObject);
    procedure ButtonNetCardIntegrationClick(Sender: TObject);
    procedure ButtonNetCardDesintegrationClick(Sender: TObject);
    procedure TimerCheckUpdateTimer(Sender: TObject);
    procedure CheckBoxAutostartDNSOnBootClick(Sender: TObject);
    procedure ListBoxDNSMasterContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure Mettrejour1Click(Sender: TObject);
    procedure TimerStartInBackgroundTimer(Sender: TObject);
    procedure toujoursenavant1Click(Sender: TObject);
    procedure setTheme(color, bg:TColor);
    procedure CheckBoxSwitchThemeClick(Sender: TObject);
    procedure CheckBoxAlertEventsKnownClick(Sender: TObject);
    procedure CheckBoxAlertEventsUnknownClick(Sender: TObject);
    procedure CheckBoxAlertEventDisallowedClick(Sender: TObject);
    procedure TimerRestartTimer(Sender: TObject);
    procedure TimerResetAlertPositionTimer(Sender: TObject);
    procedure StartDNS1Click(Sender: TObject);
    procedure StopDNS1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PythonPath: String;
    DataDirectoryPath: String;

    ServerDoStart: Boolean;
    ServerFailStartCount: Integer;

    isServerStarted: Boolean;
    SelectedListItem:TListItem;
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
  listThreads: array of TSauvegarde;
  ThreadUpdate: TUpdate;

  MasterDNSFile: string = 'MasterDNSFile.cfg';
  SlaveDNSProcesslist: string = 'SlaveDNSProcesslist.cfg';
  FilehostPathConfig: string = 'FileHostPath.cfg';
  SlaveDNSIPConfig: string = 'SlaveDNSIP.cfg';
  SlaveDNSPortConfig: string = 'SlaveDNSPort.cfg';
  TimeCheckUpdateFile: string = 'TimeCheckUpdate.cfg';
  BlackListCfgFile: string = 'blackhost.txt';

  FormAlertLastShow: string = '';

  DNSMasterSerialized: string = '';
  LastPositionFormAlertTop: integer = 0;
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
  isNew, isRepeated: Boolean;
  sl: TStringList;
  // 04.03.17; 09:33:09; 127.0.0.1; 185.22.116.72; tf1.fr.
  date, time, ipclient, ipdomain, domain, ip:string;
  FormAlert: TFormAlert;
begin
  txt := StringReplace(txt, #13, '', [rfReplaceAll, rfIgnoreCase]);
  txt := StringReplace(txt, #10, '', [rfReplaceAll, rfIgnoreCase]);
  if txt = '' then exit;

  isRepeated := True;
  if (MemoLogs.Lines.Count = 0) or (Pos(txt, MemoLogs.Lines.Strings[MemoLogs.Lines.Count - 1]) = 0) then
  begin
    isRepeated := False;
    MemoLogs.Lines.Add(txt);
  end;
  //MemoLogs.Text := MemoLogs.Text + txt;
  sl:=TStringList.Create;
  SplitStr(txt,';',sl);
  //form1.MemoLogs.Lines.Add(sl.Text);
  //form1.MemoLogs.Lines.Add(IntToStr(sl.Count));
  if sl.Count >= 5 then
  begin
    date := onlyChars(sl.Strings[0]);
    time := onlyChars(sl.Strings[1]);
    ipclient := onlyChars(sl.Strings[2]);
    ipdomain := onlyChars(sl.Strings[3]);
    domain := onlyChars(sl.Strings[4]);
    SetLength(domain, Length(domain)-1);


    if form1.ListBoxIpClients.Items.IndexOf(ipclient) = -1 then
    begin
      form1.ListBoxIpClients.Items.Add(ipclient);
    end;

    isNew := true;
    for i := 0 to form1.ListView1.Items.Count-1 do
    begin
      //if form1.ListView1.Items[i].SubItems[0] =  domain then isNew := false;
      if form1.ListView1.Items[i].Caption =  domain then isNew := false;
    end;

      //ip := getDomain(Form1.EditFilehost.Text, domain);
      ip := ipdomain;
      ip := onlyChars(ip);
      if ip = '' then imgIndex := 0
      else if ip = '127.0.0.1' then imgIndex := 3
      else if ip = ' 127.0.0.1' then imgIndex := 3
      else imgIndex := 1;

    if isNew then
    begin
      EditerLigne2(form1.ListView1, -1, imgIndex, domain, ipdomain, imgIndex = 3);
      //i := form1.ListView1.Items.Count;
      //EditerLigne2(form1.ListView1, i, imgIndex, ipdomain, domain, imgIndex = 3);
      Form1.refreshListView1Click();
    end;

    if not isRepeated and (imgIndex > 0) and (FormAlertLastShow <> domain) then
    begin
        FormAlertLastShow := domain;
        if (imgIndex = 0) and CheckBoxAlertEventsKnown.Checked then // inconnu
        begin
          FormAlert := TFormAlert.Create(nil);
          FormAlert.PanelAllowed.Visible := True;
          FormAlert.PanelDisallowed.Visible := False;
          FormAlert.Label1.Caption := domain;
          FormAlert.Label2.Caption := domain;
          FormAlert.FormCreate(nil);
          TimerResetAlertPosition.Enabled := False;
          TimerResetAlertPosition.Interval := FormAlert.TimerAfterCreate.Interval + 1;
          TimerResetAlertPosition.Enabled := True;
          FormAlert.Show;
          LastPositionFormAlertTop := LastPositionFormAlertTop - FormAlert.Height;
          if LastPositionFormAlertTop <= 0 then
            LastPositionFormAlertTop := Screen.WorkAreaHeight - FormAlert.Height;
          FormAlert.Top := LastPositionFormAlertTop;
        end;
        if (imgIndex = 1) and CheckBoxAlertEventsUnknown.Checked then // connu
        begin
          FormAlert := TFormAlert.Create(nil);
          FormAlert.PanelAllowed.Visible := True;
          FormAlert.PanelDisallowed.Visible := False;
          FormAlert.Label1.Caption := domain;
          FormAlert.Label2.Caption := domain;
          FormAlert.FormCreate(nil);
          TimerResetAlertPosition.Enabled := False;
          TimerResetAlertPosition.Interval := FormAlert.TimerAfterCreate.Interval + 1000;
          TimerResetAlertPosition.Enabled := True;
          FormAlert.Show;
          LastPositionFormAlertTop := LastPositionFormAlertTop - FormAlert.Height;
          if LastPositionFormAlertTop <= 0 then
            LastPositionFormAlertTop := Screen.WorkAreaHeight - FormAlert.Height;
          FormAlert.Top := LastPositionFormAlertTop;

        end;
        if (imgIndex = 3) and CheckBoxAlertEventDisallowed.Checked then // bloqué
        begin
          FormAlert := TFormAlert.Create(nil);
          FormAlert.PanelAllowed.Visible := False;
          FormAlert.PanelDisallowed.Visible := True;
          FormAlert.Label1.Caption := domain;
          FormAlert.Label2.Caption := domain;
          FormAlert.FormCreate(nil);
          TimerResetAlertPosition.Enabled := False;
          TimerResetAlertPosition.Interval := FormAlert.TimerAfterCreate.Interval + 1000;
          TimerResetAlertPosition.Enabled := True;
          FormAlert.Show;
          LastPositionFormAlertTop := LastPositionFormAlertTop - FormAlert.Height;
          if LastPositionFormAlertTop <= 0 then
            LastPositionFormAlertTop := Screen.WorkAreaHeight - FormAlert.Height;
          FormAlert.Top := LastPositionFormAlertTop;
        end;
     end;
  end
  else begin
    if Pos('Error: Port  53  already used', txt) > 0 then
    begin
      if MessageDlg(PChar('Le port 53 est déjà utilisé. Désirez-vous forcer la fermerture des processus python et essayer à nouveau?'#13#13'(si ce message persiste, soit le port 53 est utilisé par un autre processus, soit vous avez indiqué une mauvaise adresse IP.'),  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
      begin
        Form1.MemoLogs.Lines.Add('Close all python.exe process');
        KillTask('python.exe');
        Form1.ButtonRefreshNetCardClick(nil);
        ServerDoStart := True;
        Form1.ButtonStartClick(nil);
      end;
    end;
  end;
  if sl <> nil then
    sl.Free;
end;

procedure TSauvegarde.onCreate;
begin
//
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
  if CheckBoxAllowModifyNetCard.Checked then
  begin
    ButtonNetCardIntegrationClick(nil);
  end;
  ImageList4.GetIcon(3, Application.Icon);
  Systray.ModifIconeTray(Caption, Application.Icon.Handle);
  ToolButton11.ImageIndex := 8;
  ToolButton11.Caption := 'Arrêter';
  isServerStarted := True;
  ToolButton11.Enabled := True;
  ToolButton11.Hint := 'Arrêter le serveur DNS';
  ServerFailStartCount := 0;
  TimerRestart.Enabled := False;
  ServerDoStart := True;
end;

procedure TForm1.onServerDNSStop();
begin
  if ServerDoStart then
  begin
    inc(ServerFailStartCount);
    TimerRestart.Enabled := True;
    exit;
  end;
  isServerStarted := False;

  if CheckBoxAllowModifyNetCard.Checked then
  begin
    ButtonNetCardDesintegrationClick(nil);
  end;
  if not ServerDoStart then
  begin
    ImageList4.GetIcon(1, Application.Icon);
    Systray.ModifIconeTray(Caption, Application.Icon.Handle);
    ToolButton11.ImageIndex := 7;
    ToolButton11.Caption := 'Démarrer';
    ToolButton11.Enabled := True;
    ToolButton11.Hint := 'Démarrer le serveur DNS';
  end;

end;


procedure TForm1.setDNSOnBoot(enabled: Boolean);
var
  Reg: TRegistry;
var
  scriptVBS, scriptBAT, dirPath: string;
begin
  dirPath := ExtractFilePath(Application.ExeName)+AnsiReplaceStr(ExtractFileName(Application.ExeName), '.exe', '')+'\';

  scriptVBS := '''Example: '#13#10+
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
    '    WScript.Echo "Script de réparation de connexion réseau. Veuillez répondre oui au dialogue suivant afin de réparer votre connexion Internet. Et non, si le serveur DNS Relai s''est déjà lancé et que vous voulez continuer à l''utiliser."'#13#10+
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



procedure TForm1.ButtonStartClick(Sender: TObject);
var
  i: Integer;
  filepath: string;
  dns: string;
  script: string;
begin
  Splitter1.Visible := True;
  GroupBox5.Visible := True;
  if Form1.Top > Screen.WorkAreaHeight - Form1.Height then
    Form1.Top := Screen.WorkAreaHeight - Form1.Height;

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
    if ServerDoStart then TimerRestart.Enabled := True;
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





  ecrireDansUnFichier(BlackListCfgFile, 'gstatic.com'#13#10+
                                        'www.youtube-nocookie.com'#13#10+
                                        'www.googleapis.com'#13#10+
                                        'clients1.google.com'#13#10+
                                        'clients2.google.com'#13#10+
                                        'clients3.google.com'#13#10+
                                        'clients4.google.com'#13#10+
                                        'youtubei.youtube.com'#13#10+
                                        'serving-sys.com'#13#10+
                                        'atdmt.com'#13#10+
                                        'googleadservices.com'#13#10+
                                        'doubleclick.net'#13#10+
                                        'googlesyndication.com'#13#10+
                                        '9an6.googlevideo.com'#13#10+
                                        '9ans.googlevideo.com'#13#10+
                                        '9anz.googlevideo.com');

  if not FileExists(filepath) then
  begin
    MemoLogs.Lines.Add('Erreur: Lancement annulé.');
    MemoLogs.Lines.Add('   Le chemin du fichier host est introuvable.');
    MemoLogs.Lines.Add('   Veuillez définir le chemin du fichier host en cliquant sur le bouton "Config"');
    ToolButton11.Enabled := True;
    if ServerDoStart then TimerRestart.Enabled := True;
    exit;
  end;




  ToolButton11.Enabled := True;
  MemoLogs.Lines.Add('Test DNS Master...');
  DNSMasterSerialized := '';
  for i := 0 to ListBoxDNSMaster.Items.Count -1 do
  begin
    dns := ListBoxDNSMaster.Items.Strings[i];
    MemoLogs.Lines.Add('Master '+ dns +'... ');
    if resolveDNSByPython('a.root-servers.net', dns) = '' then
    begin
      DNSMasterSerialized := '';
      MemoLogs.Lines.Add('Erreur: Lancement annulé.');
      MemoLogs.Lines.Add('   Impossible d''atteindre le serveur DNS Master '+dns);
      MemoLogs.Lines.Add('   Veuillez vous connecter à Internet et essayer à nouveau');
      MemoLogs.Lines.Add('   ou indiquer un autre serveur DNS dans la section "DNS Master"');
      if ServerDoStart then TimerRestart.Enabled := True;
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
    if ServerDoStart then TimerRestart.Enabled := True;
    exit;
  end;

  //MemoLogs.Lines.Delete(MemoLogs.Lines.Count - 1);
  //MemoLogs.Lines.Add('Test DNS Master... DNS is OK :)');

  createVBScript();

  if PythonPath = '' then PythonPath := getPythonPath();

  //if not FileExists(DataDirectoryPath + 'relayDNS.pyo') then
  //begin
    script := '"'+PythonPath+'python.exe" -O -m py_compile "'+DataDirectoryPath + 'relayDNS.py"';
    filepath := ExtractFilePath(Application.ExeName)+installDirectoryPath+'compile_relayDNS.bat';
    ecrireDansUnFichier(filepath, script);
    LaunchAndWait(filepath,'', launchAndWWindow);
  //end;

  if not FileExists(DataDirectoryPath + 'relayDNS.pyo') then
  begin
    MemoLogs.Lines.Add('Erreur: Lancement annulé');
    MemoLogs.Lines.Add('   La compilation du serveur à échoué. Mauvaise installation de Python 2.7?');
    if ServerDoStart then TimerRestart.Enabled := True;
    exit;
  end;

  i := Length(listThreads);
  SetLength(listThreads, i+1);
  listThreads[0] := Unit1.TSauvegarde.Create(True);
  listThreads[0].cmd := '"'+PythonPath+'python.exe" "'+DataDirectoryPath + 'relayDNS.pyo" config_dnsip "'+CBoxDNSServerSlaveIP.Text+'" hostfile "'+EditFilehost.Text+'" blackhost "'+BlackListCfgFile+'"';
  //MemoLogs.Lines.Add(listThreads[i].cmd);
  listThreads[0].output := TStringList.Create;
  listThreads[0].EnMemo := MemoLogs;
  listThreads[0].indexThread := i;
  listThreads[0].Suspended := False;

  //MemoLogs.Lines.Add('Flushdns');
  LaunchAndWait('ipconfig.exe','/flushdns', SW_HIDE);

  ToolButton11.Enabled := False;
  //Notebook1.PageIndex := 3;
  //ToolButton6.Down := True;


  {
  listThreads[1] := Unit1.TSauvegarde.Create(True);
  listThreads[1].cmd := 'ipconfig.exe /flushdns';
  listThreads[1].EnMemo := nil;
  listThreads[1].Suspended := False;
   }
  //listThreads[0].Terminate;
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
  //Notebook1.PageIndex := 4;
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
  if isServerStarted then TimerRestart.Enabled := True;
end;

// Erase  DNS MASTER
procedure TForm1.ToolButtonEraseDNSMasterClick(Sender: TObject);
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
  if MessageDlg(Pchar('Effacer "' + txt + '"?'),mtConfirmation, mbOKCancel, 0)  = mrOK then
  begin
    ListBoxDNSMaster.DeleteSelected;
    ListBoxDNSMaster.ItemIndex := 1 - 1;
    ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
    if isServerStarted then TimerRestart.Enabled := True;
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
  if isServerStarted then TimerRestart.Enabled := True;
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
  if isServerStarted then TimerRestart.Enabled := True;
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
  if isServerStarted then TimerRestart.Enabled := True;
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
  autostarted: Boolean;
begin
  ServerDoStart := False;
  ServerFailStartCount := 0;

  // Masque la fenêtre de la taskbar
  SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);


  Form1.Width := Form1.Constraints.MinWidth + 50;
  Form1.Height := Form1.Constraints.MinHeight + 50;

  Form1.Top := Screen.WorkAreaHeight - Form1.Height;
  Form1.Left := Screen.WorkAreaWidth - Form1.Width;

  //ShowMessage(ExecAndRead('ping.exe 127.0.0.1'));

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
  Memo1.Text := 'Veuillez lire les modalités et les conditions suivantes avant l''utilisation de ce logiciel.  L''utilisation de ce logiciel indique l''acceptation des termes et conditions de la licence.'+#13#10#13#10+
                '1. Déni de garantie'+#13#10#13#10+
                '"DNS Relay Server" est fourni "tel-que", et aucune garantie de quelque sorte n''est exprimée ou impliquée, incluant sans limitation, toute garantie de valeur marchande ou format physique pour un but particulier.'+#13#10#13#10+
                'Dans aucun cas, l''auteur de ce logiciel ne sera jugé responsable de la perte de données, des dommages, du manque à gagner ou de n''importe quel autre genre de perte par l''utilisation correcte ou non de ce logiciel.'+#13#10#13#10+
                'Le logiciel peut-être modifié. Le code source est fourni dans le setup d''installation.'+#13#10#13#10+
                ''+#13#10#13#10+
                '2. Licence'+#13#10#13#10+
                '"DNS Relay Server" est fourni en tant que logiciel open source.'+#13#10#13#10+
                'Dans ce cas, Vous avez le droit d''utiliser, de le modifier et de le distribuer comme vous voulez.'+#13#10#13#10+
                'L''installation et l''utilisation de ce logiciel signifie l''acceptation des termes et conditions de la license.'+#13#10#13#10+
                ''+#13#10#13#10+
                '3. Fonctionnement'+#13#10#13#10+
                '"DNS Relay Server" peut modifier la configuration de vos cartes réseau afin de pouvoir faciliter son intégration dans le système et filtrer Internet au niveau des noms de domaines (DNS).'+#13#10#13#10+
                'Au lancement du serveur, l''adresse des serveurs DNS sont modifiés par l''IP de votre propre machine.'+#13#10#13#10+
                'A la fermeture du serveur, vos cartes réseau repassent en mode automatique (mode DHCP).'+#13#10#13#10+
                'Si vous êtiez en configuration IP manuelle, vous risquez de changer d''IP.'+#13#10#13#10+
                'Donc si vous lancez ce programme sur un serveur distant, vous risquez de perdre la connexion avec celui-ci.'+#13#10#13#10+
                'Soyez conscient de ce risque.'+#13#10#13#10+
                'Par mesure de sécurité, un script VBS est placé au lancement de Windows afin de réparer la connexion Internet en cas de plantage ou redémarrage du PC.'+#13#10#13#10+
                'Ce script ne se lance pas si vous avez déjà configuré ce serveur pour qu''il redémarre avec Windows. Ce script ne réparera pas la connexion qui a été cassé par un autre programme.'+#13#10#13#10+
                'Pour la détection d''une connexion cassé par cette application, le script va vérifier au redémarrage du PC si l''addresse IP est indentique à celle du serveur DNS, si oui, alors il restaure la carte réseau en DHCP. Si non, il ne fait rien.'+#13#10#13#10+
                'Vous êtes en version beta-test, ce qui signifie que ce programme n''a pas été encore testé partout. Il peut y avoir encore des bugs non-répertoriés.'+#13#10#13#10+
                'Pour fonctionner le serveur DNS a besoin de Python 2.7 et de quelques librairies pour fonctionner. Ces dépendances seront téléchargés et installés automatiquement au lancement du serveur.  Une connexion Internet sera nécessaire.';


  Panel1.Align := alClient;
  GroupBox2.Align := alClient;
  GroupBox3.Align := alClient;
  GroupBox4.Align := alClient;
  //GroupBox5.Align := alClient;
  GroupBox6.Align := alClient;
  Notebook1.Align := alClient;
  TabbedNotebook1.Align := alClient;




  TabbedNotebook1.PageIndex := 0;
  Notebook1.PageIndex := 5;

  DataDirectoryPath := ExtractFilePath(Application.ExeName)+AnsiReplaceStr(ExtractFileName(Application.ExeName), '.exe', '')+'\';
  if not DirectoryExists(DataDirectoryPath) then makeDir(DataDirectoryPath);

  FilehostPathConfig := DataDirectoryPath + FilehostPathConfig ;
  SlaveDNSIPConfig := DataDirectoryPath + SlaveDNSIPConfig;
  SlaveDNSPortConfig := DataDirectoryPath + SlaveDNSPortConfig;
  MasterDNSFile := DataDirectoryPath + MasterDNSFile;
  SlaveDNSProcesslist := DataDirectoryPath + SlaveDNSProcesslist;
  TimeCheckUpdateFile :=  DataDirectoryPath + TimeCheckUpdateFile;
  BlackListCfgFile := DataDirectoryPath + BlackListCfgFile;


  if EditFilehost.Text = '' then EditFilehost.Text := DataDirectoryPath + 'host.txt';

  PythonPath := getPythonPath();
  if FileExists(MasterDNSFile) then
    ListBoxDNSMaster.Items.LoadFromFile(MasterDNSFile);

  if FileExists(FilehostPathConfig) then
    EditFilehost.Text := lireFichier(FilehostPathConfig);

  if FileExists(SlaveDNSIPConfig) then
    CBoxDNSServerSlaveIP.Text := lireFichier(SlaveDNSIPConfig);

  if FileExists(SlaveDNSPortConfig) then
    SpinPort.Value := StrToInt(lireFichier(SlaveDNSPortConfig));

  if FileExists(TimeCheckUpdateFile) then
    SpinTimeCheckUpdate.Value := StrToInt(lireFichier(TimeCheckUpdateFile));




  CheckBoxAutostartDNSOnBoot.Checked := FileExists(DataDirectoryPath + 'checkAutostartDNS.cfg');
  CheckBoxUpdate.Checked := FileExists(DataDirectoryPath + 'checkupdate.cfg');
  CheckBoxUpdateIntervall.Checked := FileExists(DataDirectoryPath + 'checkupdateIntervall.cfg');
  CheckBoxUpdateSilent.Checked := FileExists(DataDirectoryPath + 'checkupdateSilent.cfg');
  TimerCheckUpdate.Enabled := Form1.CheckBoxUpdateIntervall.Checked;
  TimerCheckUpdate.Interval := SpinTimeCheckUpdate.Value * 3600000;
  CheckBoxAllowModifyNetCard.Checked := FileExists(DataDirectoryPath + 'checkAllowModifyNetcard.cfg');
  CheckBoxSwitchTheme.Checked := FileExists(DataDirectoryPath + 'checkSwitchTheme.cfg');
  CheckBoxSwitchThemeClick(CheckBoxSwitchTheme);
  Systray.AjouteIconeTray(Handle,Application.Icon.Handle,Self.Caption);
  ButtonRefreshNetCardClick(nil);
  CheckBoxAlertEventsKnown.Checked := FileExists(DataDirectoryPath + 'checkAlertEventsKnow.cfg');
  CheckBoxAlertEventsUnknown.Checked := FileExists(DataDirectoryPath + 'checkAlertEventsUnknown.cfg');
  CheckBoxAlertEventDisallowed.Checked := FileExists(DataDirectoryPath + 'checkAlertEventDisallowed.cfg');

  startedInBackground := False;
  autostarted := False;
  for i:=0 to ParamCount() do
  begin
    if ParamStr(i) = '/background' then
    begin
      ServerDoStart := True;
      ButtonStartClick(nil);
      startedInBackground := True;
      autostarted := True;
      TimerStartInBackground.Enabled := True;
    end;
    if ParamStr(i) = '/autostart' then
    begin
      ServerDoStart := True;
      ButtonStartClick(nil);
      autostarted := True;
    end;
  end;

  ListViewCreate(ListView1);
  ListView1.Clear;
  getDomains(EditFilehost.Text, ListView1);

  if CheckBoxAutostartDNSOnBoot.Checked and not autostarted then
  begin
    //ServerDoStart := True;
    TimerRestart.Enabled := True;
  end;

  TimerAfterFormCreate.Enabled := not startedInBackground;
  TimerUpdateOnLoad.Enabled := CheckBoxUpdate.Enabled;
  //setTheme(RGB(10,30,40), RGB(220,155,220));
end;

procedure TForm1.setTheme(color, bg:TColor);
begin

  Form1.Color := bg;
  ToolBar3.Color := bg;
  GroupBox2.Color := bg;
  GroupBox3.Color := bg;
  GroupBox4.Color := bg;
  GroupBox5.Color := bg;
  GroupBox6.Color := bg;
  ToolBar2.Color := bg;
  ListView1.Color := bg;
  Splitter1.Color := bg;

  Memo1.Color := bg;
  MemoLogs.Color := bg;
  ListBoxIpClients.Color := bg;
  Panel1.Color := bg;
  Panel2.Color := bg;
  Panel3.Color := bg;
  Panel4.Color := bg;
  Panel5.Color := bg;
  Panel6.Color := bg;
  ToolBar1.Color := bg;
  ListBoxDNSMaster.Color := bg;
  CBoxDNSServerSlaveIP.Color := bg;
  SpinPort.Color := bg;
  EditFilehost.Color := bg;
  CheckBoxStartWithWindows.Color := bg;
  CheckBoxAutostartDNSOnBoot.Color := bg;

  Panel1.Font.Color := color;
  Form1.Font.Color := color;
  ListView1.Font.Color := color;
  Memo1.Font.Color := color;
  MemoLogs.Font.Color := color;
  ListBoxIpClients.Font.Color := color;
  ListBoxDNSMaster.Font.Color := color;
  CBoxDNSServerSlaveIP.Font.Color := color;
  SpinPort.Font.Color := color;
  EditFilehost.Font.Color := color;
  GroupBox2.Font.Color := color;
  GroupBox3.Font.Color := color;
  GroupBox4.Font.Color := color;
  GroupBox5.Font.Color := color;
  GroupBox6.Font.Color := color;
  GroupBox7.Font.Color := color;
  Label1.Font.Color := color;
  Label2.Font.Color := color;
  Label3.Font.Color := color;
  Label4.Font.Color := color;
  Label5.Font.Color := color;
  Label6.Font.Color := color;
  Label7.Font.Color := color;
  CheckBoxStartWithWindows.Font.Color := color;
  CheckBoxAutostartDNSOnBoot.Font.Color := color;
  CheckBoxUpdate.Font.Color := color;
  CheckBoxUpdateIntervall.Font.Color := color;
  SpinTimeCheckUpdate.Font.Color := color;
  CheckBoxUpdateSilent.Font.Color := color;
  CheckBoxAllowModifyNetCard.Font.Color := color;
  Label9.Font.Color := color;
  Label7.Font.Color := color;

end;

procedure TUpdate.Execute;
begin
  if FileExists(Form1.DataDirectoryPath + 'checkupdate.cfg') then
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



procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  Pos:TPoint;
begin
  //action kan on clique
  GetCursorPos(Pos);//positon de la souris;
  case X of
    WM_LBUTTONDBLCLK: Afficher1Click(nil); //Double klik gauche
    WM_LBUTTONDOWN:  Afficher1Click(nil);    //Bouton gauche pousse
    WM_LBUTTONUP: ; //PopupMenu1.Popup(Pos.X,Pos.Y); //Bouton gauche lève
    WM_RBUTTONDBLCLK:; //Double klik droit
    WM_RBUTTONDOWN:;    //Bouton droit pousse
    WM_RBUTTONUP:PopupMenu1.Popup(Pos.X,Pos.Y); //Bouton droite lève: Popup
  end;
end;

procedure TForm1.Masquer1Click(Sender: TObject);
begin
  Self.Hide;
end;

procedure TForm1.Afficher1Click(Sender: TObject);
begin
  Self.Show;
  Application.Restore;
  Application.BringToFront;
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
  if Form1.Width < 370 then Form1.Width := 370;
  if Splitter1.Visible then
  begin
    if Form1.Height < 440 then
    begin
      GroupBox5.Height := 80;
      Form1.Height := 440;

    end;
  end else begin
    if Form1.Height < 350 then Form1.Height := 350;
  end;
  if Form1.Top > Screen.WorkAreaHeight - Form1.Height then
    Form1.Top := Screen.WorkAreaHeight - Form1.Height;

  if Form1.Left > Screen.WorkAreaWidth - Form1.Width then
    Form1.Left := Screen.WorkAreaWidth - Form1.Width;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
  //Notebook1.PageIndex := 1;
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
    TimerSaveChange.Enabled := True;
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
  if MessageDlg(PChar('Ce bouton est un bouton d''aide. Vous allez voir quelques messages qui vont vous expliquer les boutons qui se trouvent à côté de celui que vous venez de cliquer. Voulez-vous continuer?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
    ShowMessage(PChar('Cliquez sur le premier bouton pour effacer les domaines inconnus (boule noire) et ne garder que ceux qui sont connus.'));
    ShowMessage(PChar('Cliquez sur le deuxième bouton pour éditer manuellement le fichier host'#13#13
    +'Edition du fichier host'#13#13
    +'Exemple:'#13
    +'127.0.0.1  localhost'#13#13
    +'Règle: '#13
    +'Un ligne par domaine et ip.'#13
    +'D''abord l''ip ensuite le domaine.'#13
    +'L''ip et le domaine doivent être séparé par une tabulation (touche TAB).'#13#13
    +'Une fois les changements terminés, redémarrez le serveur (avec le bouton Start) pour appliquer les modifications.'));
    ShowMessage(PChar('Cliquer bouton droit sur une IP de la liste (colone gauche) pour afficher le menu.'));
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
  ecrireDansUnFichier(TimeCheckUpdateFile, IntToStr(SpinTimeCheckUpdate.Value));
end;

procedure TForm1.ToolButton10Click(Sender: TObject);
begin
  if MessageDlg(PChar('Effacer les domaines inconnus (ceux avec une boule noir) ?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
  ListView1.OnChange := nil;
  ListView1.Clear;
  getDomains(EditFilehost.Text, ListView1);
  ListView1.OnChange := ListView1Change;
end;

procedure TForm1.Bloquerledomaine1Click(Sender: TObject);
begin
  if not Assigned(SelectedListItem) then exit;
  //setDomain( EditFilehost.Text, SelectedListItem.SubItems.Strings[0], '127.0.0.1');
  setDomain(EditFilehost.Text, SelectedListItem.Caption, '127.0.0.1');
  SelectedListItem.SubItems.Strings[0] := '127.0.0.1';
  refreshListView1Click();
  if isServerStarted then TimerRestart.Enabled := True; //ButtonStartClick(nil);
end;

procedure TForm1.Autoriser1Click(Sender: TObject);
begin
  if not Assigned(SelectedListItem) then exit;
  if (SelectedListItem.SubItems.Strings[0] = '') then exit;
  //delDomain(EditFilehost.Text, SelectedListItem.SubItems.Strings[0]);
  delDomain(EditFilehost.Text, SelectedListItem.Caption);
  SelectedListItem.Delete;
  refreshListView1Click();
  if isServerStarted then TimerRestart.Enabled := True; //ButtonStartClick(nil);
end;

procedure TForm1.Modifier1Click(Sender: TObject);
var
  txt:string;
begin
  if not Assigned(SelectedListItem) then exit;
  txt := InputBox('Update IP Domain', 'Exemple: pour bloquer 127.0.0.1', SelectedListItem.SubItems.Strings[0]);
  if (txt = '') or  (SelectedListItem.SubItems.Strings[0] = txt) then exit;
  //setDomain( EditFilehost.Text, SelectedListItem.SubItems.Strings[0], txt);
  setDomain( EditFilehost.Text, SelectedListItem.Caption, txt);
  SelectedListItem.SubItems.Strings[0] := txt;
  refreshListView1Click();
  if isServerStarted then TimerRestart.Enabled := True; //ButtonStartClick(nil);
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
  {if ToolBar3.Align = alTop then
  begin}
    LeftOffset := 20;
    TopOffset := 142;
  {end
  else begin
    LeftOffset := 115;
    TopOffset := 78;
  end;
  }

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

  //if isServerStarted then
  if ServerDoStart then
  begin
    //if MessageDlg('Arrêter le serveur?',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    //begin
      ServerDoStart := False;
      ToolButton11.Enabled := False;
      ButtonCloseClick(nil);
    //end;
  end
  else begin
    //if MessageDlg('Démarrer le serveur?',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    //begin
      ImageList4.GetIcon(2, Application.Icon);
      Systray.ModifIconeTray(Caption, Application.Icon.Handle);
      ToolButton11.ImageIndex := 13;
      ToolButton11.Caption := 'Arrêter';
      ToolButton11.Enabled := True;
      ToolButton11.Hint := 'Arrêter le serveur DNS';

      ServerDoStart := True;
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
  lastversion, lastverFile, url, wget, msg: string;
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

  //url := 'https://raw.gith4ubusercontent.com/ddeeproton/DNSRelayServer-DelphiPython/master/Special version/BlackEdition/lastversion.txt';
  url := 'https://github.com/ddeeproton/DNSRelayServer-DelphiPython/raw/master/lastversion.txt?'+DateTimeToStr(Now);
  lastverFile := ExtractFilePath(Application.ExeName)+installDirectoryPath+'lastversion.txt';
  if FileExists(lastverFile) then DeleteFile(lastverFile);
  if FileExists(lastverFile) then
  begin
    if isSilent then
      //Form1.MemoLogs.Lines.Add('Error Update: Problème de connexion au serveur de mise à jour.')
    else
      ShowMessage('Error Update: Impossible d''effacer le fichier temporaire suivant:'+#13#13+lastverFile);
    exit;
  end;
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
    msg := 'Mise à jour version "'+lastversion+'" disponible :)'+#13+'Mettre à jour?';
    if (isSilent and Form1.CheckBoxUpdateSilent.Checked) or (MessageDlg(PChar(msg),  mtConfirmation, [mbYes, mbNo], 0) = IDYES) then
    begin
      url := 'https://github.com/ddeeproton/DNSRelayServer-DelphiPython/raw/master/Setup installation/DNSRelayServerSetup_'+lastversion+'.exe';
      lastverFile := ExtractFilePath(Application.ExeName)+installDirectoryPath+'DNSRelayServerSetup_'+lastversion+'.exe';
      downloadFile(url, lastverFile);
      if FileExists(lastverFile) and (FileSize(lastverFile) > 0) then
      begin
        //if (isSilent and Form1.CheckBoxUpdateSilent.Checked) or (MessageDlg(PChar('Le serveur va redémarrer. Continuer?'),  mtConfirmation, [mbYes, mbNo], 0) = IDYES) then
        //begin
          if Form1.CheckBoxUpdateSilent.Checked then
            ExecAndWait(lastverFile, '/S', SW_HIDE)
          else
            ExecAndWait(lastverFile, '', SW_SHOWNORMAL);

          canClose := True;
          Form1.FormCloseQuery(nil, canClose);
          Application.Terminate;

        //end;
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

procedure TForm1.TimerUpdateOnLoadTimer(Sender: TObject);
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

procedure TForm1.TimerAfterFormCreateTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
    Application.ShowMainForm := true;
    Form1.BringToFront;
    Application.BringToFront;
    Application.ModalFinished;
    Self.Show;
    BringToFront;
    SetFocus;
    FlashWindow(Application.Handle, true);
    ShowWindow(Application.Handle, SW_SHOW);
end;

procedure TForm1.CheckBoxUpdateIntervallClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    ecrireDansUnFichier(DataDirectoryPath + 'checkupdateIntervall.cfg', '1')
  else DeleteFile(DataDirectoryPath + 'checkupdateIntervall.cfg');

  TimerCheckUpdate.Interval := SpinTimeCheckUpdate.Value * 3600000;
  TimerCheckUpdate.Enabled := TCheckBox(Sender).Checked;

end;

procedure TForm1.CheckBoxUpdateSilentClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    ecrireDansUnFichier(DataDirectoryPath + 'checkupdateSilent.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkupdateSilent.cfg');
end;

procedure TForm1.SpinTimeCheckUpdateChange(Sender: TObject);
begin
  TimerCheckUpdate.Enabled := False;
  TimerCheckUpdate.Interval := SpinTimeCheckUpdate.Value * 3600000;
  TimerCheckUpdate.Enabled := True;
  EditFilehostChange(nil);
end;

procedure TForm1.CheckBoxAllowModifyNetCardClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    ecrireDansUnFichier(DataDirectoryPath + 'checkAllowModifyNetcard.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAllowModifyNetcard.cfg');
end;


procedure TForm1.CheckBoxAutostartDNSOnBootClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    ecrireDansUnFichier(DataDirectoryPath + 'checkAutostartDNS.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAutostartDNS.cfg');
end;


procedure TForm1.ButtonNetCardIntegrationClick(Sender: TObject);
begin
  if Sender <> nil then
  begin
    ToolButton8.Down := False;
    //ToolButton3.Down := True;
    ToolButton6Click(nil);
  end;
  setIPToDHCP();
  MemoLogs.Lines.Add('Set DNS '+CBoxDNSServerSlaveIP.Text);
  setDNS(CBoxDNSServerSlaveIP.Text);
  setDNSOnBoot(not CheckBoxStartWithWindows.Checked);
end;

procedure TForm1.ButtonNetCardDesintegrationClick(Sender: TObject);
begin
  if Sender <> nil then
  begin
    ToolButton8.Down := False;
    //ToolButton3.Down := True;
    ToolButton6Click(nil);
  end;
  MemoLogs.Lines.Add('Go to DHCP');
  setDNS('');
  setDNSOnBoot(False);
  setIPToDHCP();
end;

procedure TForm1.TimerCheckUpdateTimer(Sender: TObject);
begin
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
  ThreadUpdate.DoUpdate(True);
end;

procedure TForm1.ListBoxDNSMasterContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  Point : TPoint;
begin
  //On prend les coordonnées du curseur de souris...
  GetCursorPos(Point);

  //Cette ensemble de procédure permet de simuler le click.
  //Un click gauche est constitué de deux clicks : quand le
  //bouton est en haut, et quand le bouton est en bas.
  Mouse_Event(MOUSEEVENTF_LEFTDOWN, Point.X, Point.Y, 0, 0);
  Mouse_Event(MOUSEEVENTF_LEFTUP, Point.X, Point.Y, 0, 0);
  Application.ProcessMessages;
end;

procedure TForm1.Mettrejour1Click(Sender: TObject);
begin
  ButtonUpdateClick(ButtonUpdate);
end;

procedure TForm1.TimerStartInBackgroundTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  Masquer1Click(nil);
end;

procedure TForm1.toujoursenavant1Click(Sender: TObject);
begin
  toujoursenavant1.Checked := not toujoursenavant1.Checked;
  if toujoursenavant1.Checked then Form1.FormStyle := fsStayOnTop
  else Form1.FormStyle := fsNormal;
  Systray.EnleveIconeTray;
  Systray.AjouteIconeTray(Handle,Application.Icon.Handle,Self.Caption);
end;

procedure TForm1.CheckBoxSwitchThemeClick(Sender: TObject);
begin
  if TCheckbox(Sender).Checked then
    setTheme(clWhite, clBlack)
  else
    setTheme(clBlack, clWhite);
  if TCheckBox(Sender).Checked then
    ecrireDansUnFichier(DataDirectoryPath + 'checkSwitchTheme.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkSwitchTheme.cfg');
end;



procedure TForm1.CheckBoxAlertEventsKnownClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    ecrireDansUnFichier(DataDirectoryPath + 'checkAlertEventsKnow.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAlertEventsKnow.cfg');
end;

procedure TForm1.CheckBoxAlertEventsUnknownClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    ecrireDansUnFichier(DataDirectoryPath + 'checkAlertEventsUnknown.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAlertEventsUnknown.cfg');
end;

procedure TForm1.CheckBoxAlertEventDisallowedClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    ecrireDansUnFichier(DataDirectoryPath + 'checkAlertEventDisallowed.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAlertEventDisallowed.cfg');
end;


procedure TForm1.TimerRestartTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  ButtonStartClick(nil);
end;

procedure TForm1.TimerResetAlertPositionTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  LastPositionFormAlertTop := 0;
end;

procedure TForm1.StartDNS1Click(Sender: TObject);
begin
  ServerDoStart := True;
  ButtonStartClick(nil);
end;

procedure TForm1.StopDNS1Click(Sender: TObject);
begin
  ServerDoStart := False;
  ButtonCloseClick(nil);
end;

end.
