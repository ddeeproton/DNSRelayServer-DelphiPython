unit Unit1;
             
interface                                                      

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, ComCtrls, ToolWin, Menus,
  UnitHost, Systray, Registry, md5, ListViewManager, HostParser, XPMan,
  Spin, Buttons, NetworkManager, DNSManager, UnitAlert, UnitNetConfig, PythonDNSUnit,
  UrlMon, FilesManager, Registre, UnitInstallation, StrUtils, ProcessManager,
  CheckLst, StringManager, UnitRestartAlert, AlertManager, WindowsManager,
  UnitDialogIP, UnitManageIP;

var
  CurrentApplicationVersion: string = '0.4.267.10';
  isDevVersion: Boolean = True;

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
    TimerRestart: TTimer;
    TimerResetAlertPosition: TTimer;
    Panel5: TPanel;
    ToolBar3: TToolBar;
    ToolButton11: TToolButton;
    ToolButton8: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton5: TToolButton;
    Alertes1: TMenuItem;
    connus1: TMenuItem;
    inconnus1: TMenuItem;
    bloques1: TMenuItem;
    N5: TMenuItem;
    ToolButtonBlackwords: TToolButton;
    GroupBox1: TGroupBox;
    ListBoxBlacklist: TListBox;
    PopupMenuBlacklist: TPopupMenu;
    Ajouter2: TMenuItem;
    Modifier3: TMenuItem;
    Supprimer2: TMenuItem;
    PanelRestart: TPanel;
    ButtonClosePanelRestart: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButtonUpdateDNSMaster: TToolButton;
    ToolButtonEraseDNSMaster: TToolButton;
    ToolButtonDownDNSMaster: TToolButton;
    ToolButtonUpDNSMaster: TToolButton;
    ListBoxDNSMaster: TListBox;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Label14: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    ColorDialog1: TColorDialog;
    TabSheet6: TTabSheet;
    PopupMenuTheme: TPopupMenu;
    Ajouter3: TMenuItem;
    Modifier4: TMenuItem;
    Supprimer3: TMenuItem;
    N6: TMenuItem;
    Restaurer1: TMenuItem;
    ToolButtonDisplayGray: TToolButton;
    ToolButtonDisplayGreen: TToolButton;
    ToolButtonDisplayOrange: TToolButton;
    ToolButton9: TToolButton;
    Panel3: TPanel;
    ToolBar4: TToolBar;
    ButtonDisableBlackhost: TToolButton;
    ToolButton12: TToolButton;
    ButtonDisableHost: TToolButton;
    ButtonApplyChanges: TButton;
    Filrage1: TMenuItem;
    DsactiverlefiltragedufichierHost1: TMenuItem;
    DsactiverlefiltrageBlackword1: TMenuItem;
    ToolButtonBlockAll: TToolButton;
    N7: TMenuItem;
    toutbloquer1: TMenuItem;
    Panel7: TPanel;
    ToolBar5: TToolBar;
    ToolButton23: TToolButton;
    PopupMenuForAllDNSRules: TPopupMenu;
    AllowAll: TMenuItem;
    DisallowAll: TMenuItem;
    Toutautoriser1: TMenuItem;
    N9: TMenuItem;
    AjouterBlackworkds1: TMenuItem;
    ToolButtonMenuLogs: TToolButton;
    PopupMenuLogs: TPopupMenu;
    Afficherenhaut1: TMenuItem;
    Afficherenbas1: TMenuItem;
    Affichergauche1: TMenuItem;
    Afficherdroite1: TMenuItem;
    Dsactivertouteslesalertes1: TMenuItem;
    Activertouteslesalertes1: TMenuItem;
    Toutnormal1: TMenuItem;
    Toutnormale1: TMenuItem;
    Config1: TMenuItem;
    N8: TMenuItem;
    DNS1: TMenuItem;
    DNSMatres1: TMenuItem;
    Misejour1: TMenuItem;
    Carterseau1: TMenuItem;
    Affichage1: TMenuItem;
    Alertes2: TMenuItem;
    TimerHideMessage: TTimer;
    PanelMessage: TPanel;
    SpeedButtonCloseMessage: TSpeedButton;
    LabelMessage: TLabel;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    ScrollBox3: TScrollBox;
    GroupBox7: TGroupBox;
    Label7: TLabel;
    Label20: TLabel;
    Panel4: TPanel;
    ButtonNetCardIntegration: TButton;
    ButtonNetCardDesintegration: TButton;
    Button3: TButton;
    Panel2: TPanel;
    Label9: TLabel;
    Label13: TLabel;
    CheckBoxAllowModifyNetCard: TCheckBox;
    ScrollBox4: TScrollBox;
    ScrollBox5: TScrollBox;
    Masquer2: TMenuItem;
    GroupBox8: TGroupBox;
    Label30: TLabel;
    ComboBoxCurrentTheme: TComboBox;
    ButtonMenuTheme: TButton;
    ComboBoxPosLogs: TComboBox;
    Label15: TLabel;
    Label26: TLabel;
    SpinEditContraste: TTrackBar;
    GroupBoxUpdateTheme: TGroupBox;
    Shape2: TShape;
    Label29: TLabel;
    Label27: TLabel;
    ShapeColorText: TShape;
    Label28: TLabel;
    Shape1: TShape;
    ShapeColorBackground: TShape;
    EditThemeName: TEdit;
    ButtonUpdateTheme: TButton;
    Button2: TButton;
    GroupBox9: TGroupBox;
    SpeedButtonClosePanelUpdateTheme: TSpeedButton;
    LabelUpdateTheme: TLabel;
    N10: TMenuItem;
    TimerAlert: TTimer;
    GroupBox10: TGroupBox;
    Label1: TLabel;
    SpeedButtonRefreshNetCard: TSpeedButton;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    SpinPort: TSpinEdit;
    EditFilehost: TEdit;
    CheckBoxStartWithWindows: TCheckBox;
    CheckBoxAutostartDNSOnBoot: TCheckBox;
    CheckBoxNoTestDNSMaster: TCheckBox;
    CheckBoxNoCacheDNS: TCheckBox;
    CheckBoxPureServer: TCheckBox;
    Button1: TButton;
    CheckListBoxDNSRelayIP: TCheckListBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    Label31: TLabel;
    Label18: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    SpinEditAlertDuration: TSpinEdit;
    CheckBoxAlertEventDisallowed: TCheckBox;
    CheckBoxAlertEventsUnknown: TCheckBox;
    CheckBoxAlertEventsKnown: TCheckBox;
    Clients1: TMenuItem;
    Blacklist1: TMenuItem;
    Hostfile1: TMenuItem;
    TimerFadeIn: TTimer;
    TimerFadeOut: TTimer;
    TimerAfterFormCreateLong: TTimer;
    Panel8: TPanel;
    ButtonUpdate: TButton;
    Label34: TLabel;
    Panel9: TPanel;
    ButtonUpdateDev: TButton;
    Label35: TLabel;
    SpinTimeCheckUpdate: TSpinEdit;
    Label12: TLabel;
    CheckBoxUpdateSilent: TCheckBox;
    CheckBoxUpdateIntervall: TCheckBox;
    Label11: TLabel;
    CheckBoxUpdate: TCheckBox;
    Label10: TLabel;
    TimerRemoteAccess: TTimer;
    TabSheet7: TTabSheet;
    ScrollBox6: TScrollBox;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    CheckBoxRemoteAccess: TCheckBox;
    ButtonInstallScriptWebAdmin: TButton;
    Label39: TLabel;
    MemoHelpWebAdmin: TMemo;
    TimerCheckSystemChanges: TTimer;
    GroupBox15: TGroupBox;
    Label40: TLabel;
    Panel10: TPanel;
    Panel11: TPanel;
    Label42: TLabel;
    CheckBoxRestartOnNetworkInterfaceChange: TCheckBox;
    ComboBoxSelectIPBlackhost: TComboBox;
    Label36: TLabel;
    Label41: TLabel;
    ComboBoxSelectIPhostfile: TComboBox;
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
    procedure inconnus1Click(Sender: TObject);
    procedure connus1Click(Sender: TObject);
    procedure bloques1Click(Sender: TObject);
    procedure ToolButtonBlackwordsClick(Sender: TObject);
    procedure Ajouter2Click(Sender: TObject);
    procedure Modifier3Click(Sender: TObject);
    procedure Supprimer2Click(Sender: TObject);
    procedure ListBoxBlacklistKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonClosePanelRestartClick(Sender: TObject);
    procedure ButtonApplyChangesClick(Sender: TObject);
    procedure PageControl1DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure LabelToCheckboxClick(Sender: TObject);
    procedure LabelCheckboxMouseEnter(Sender: TObject);
    procedure LabelCheckboxMouseLeave(Sender: TObject);
    procedure setThemeFont(color:TColor);
    procedure setThemeBg(bg:TColor);
    procedure ShapeColorBackgroundMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonMenuThemeClick(Sender: TObject);
    procedure Ajouter3Click(Sender: TObject);
    procedure Modifier4Click(Sender: TObject);
    procedure Supprimer3Click(Sender: TObject);
    procedure SpeedButtonClosePanelUpdateThemeClick(Sender: TObject);
    procedure ComboBoxCurrentThemeSelect(Sender: TObject);
    procedure ButtonUpdateThemeClick(Sender: TObject);
    procedure Restaurer1Click(Sender: TObject);
    procedure ShapeColorTextMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButtonDisplayOrangeClick(Sender: TObject);
    procedure ToolButtonDisplayGreenClick(Sender: TObject);
    procedure ToolButtonDisplayGrayClick(Sender: TObject);
    procedure ButtonClearLogsClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ComboBoxPosLogsSelect(Sender: TObject);
    procedure ButtonDisableBlackhostClick(Sender: TObject);
    procedure ButtonDisableHostClick(Sender: TObject);
    procedure DsactiverlefiltragedufichierHost1Click(Sender: TObject);
    procedure DsactiverlefiltrageBlackword1Click(Sender: TObject);
    procedure ToolButtonBlockAllClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure DisallowAllClick(Sender: TObject);
    procedure AllowAllClick(Sender: TObject);
    procedure AjouterBlackworkds1Click(Sender: TObject);
    procedure ToolButtonMenuLogsClick(Sender: TObject);
    procedure Afficherenhaut1Click(Sender: TObject);
    procedure Afficherenbas1Click(Sender: TObject);
    procedure Affichergauche1Click(Sender: TObject);
    procedure Afficherdroite1Click(Sender: TObject);
    procedure Activertouteslesalertes1Click(Sender: TObject);
    procedure Dsactivertouteslesalertes1Click(Sender: TObject);
    procedure ToutNormal1Click(Sender: TObject);
    procedure RefreshModeFilter();
    procedure ResizePanelConfig();
    procedure DNS1Click(Sender: TObject);
    procedure DNSMatres1Click(Sender: TObject);
    procedure Misejour1Click(Sender: TObject);
    procedure Carterseau1Click(Sender: TObject);
    procedure Affichage1Click(Sender: TObject);
    procedure Alertes2Click(Sender: TObject);
    procedure Relancerlapplication1Click(Sender: TObject);
    procedure SpinEditAlertDurationChange(Sender: TObject);
    procedure SpeedButtonCloseMessageClick(Sender: TObject);
    procedure TimerHideMessageTimer(Sender: TObject);
    procedure CheckListBoxDNSRelayIPClickCheck(Sender: TObject);
    procedure ListView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBoxNoTestDNSMasterClick(Sender: TObject);
    procedure CheckBoxNoCacheDNSClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBoxPureServerClick(Sender: TObject);
    procedure Masquer2Click(Sender: TObject);
    procedure GotoMainPage(inexPage: Integer);
    procedure TimerAlertTimer(Sender: TObject);
    procedure TimerFadeInTimer(Sender: TObject);
    procedure TimerFadeOutTimer(Sender: TObject);
    procedure CheckSystemChangesTimer(Sender: TObject);
    procedure TimerAfterFormCreateLongTimer(Sender: TObject);
    procedure ButtonUpdateDevClick(Sender: TObject);
    procedure TimerRemoteAccessTimer(Sender: TObject);
    procedure CheckBoxRemoteAccessClick(Sender: TObject);
    procedure ButtonInstallScriptWebAdminClick(Sender: TObject);
    procedure CheckBoxRestartOnNetworkInterfaceChangeClick(
      Sender: TObject);
    procedure ComboBoxSelectIPSelect(Sender: TObject);
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

  ThreadProcess = class(TThread)
    cmd:String;
    EnMemo:TMemo;
    h: Cardinal;
    indexThread: Integer;
    output: TStringList;
  protected
    procedure Execute(); override;
  public
    procedure Execute2(cmd:String; EnMemo:TMemo);
    procedure RunDosInMemo(Que:String;EnMemo:TMemo);
  end;


  TUpdate = class(TThread)
  private
  protected
    procedure Execute; override;
  public
    procedure DoUpdate(isSilent: Boolean);
    procedure DoUpdateDevelopper(isSilent: Boolean);
    procedure UpdateUrl(urlLastVersion, urlUpdate, suffixe: string; isSilent, isDev: Boolean);
  end;

  TActionManageIP = class
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure load();
    class procedure getIPCustomHostFiles(var ComboBox: TComboBox; suffix: string);
    class function loadListIP(suffix: string = '_hostfile.txt'): TStrings;
    class procedure addIP(HideShowForm1: Boolean = False);
    class procedure eraseIP(ip: string);
  end;

var
  Form1: TForm1;
  FormHost: TFormHost;
  FormNetConfig: TFormNetConfig;
  FormInstall:  TFormInstall = nil;
  FormRestart: TFormRestart;
  listThreads: array of ThreadProcess;
  ThreadUpdate: TUpdate;
  ConfigDNSMaster: TStringList;


  MasterDNSFile: string = 'MasterDNSFile.cfg';
  SlaveDNSProcesslist: string = 'SlaveDNSProcesslist.cfg';
  FilehostPathConfig: string = 'FileHostPath.cfg';
  SlaveDNSIPConfig: string = 'SlaveDNSIP.cfg';
  SlaveDNSPortConfig: string = 'SlaveDNSPort.cfg';
  TimeCheckUpdateFile: string = 'TimeCheckUpdate.cfg';
  BlackListCfgFile: string = 'blackhost.txt';
  DirCustomHost : string = 'customhost';

  FormAlertLastShow: string = '';

  DNSMasterSerialized: string = '';
  LastPositionFormAlertTop: integer = 0;
  CountFormAlert: integer = 0;
  startedInBackground: Boolean = False;
  //currentFormStyle : TFormStyle;
  lastLogOutput: string = '';
  isApplicationLoading: Boolean = True;
  opacity: Integer = 0;
implementation

{$R *.dfm}



procedure TForm1.OnOutput(txt:String);
var
  i, imgIndex: integer;
  isNew, isRepeated: Boolean;
  sl: TStringList;
  // 04.03.17; 09:33:09; 127.0.0.1; 185.22.116.72; tf1.fr.
  date, time, ipserver, ipclient, ipdomain, domain, ip, logs, tab, status:string;
  FormAlert: TFormAlert;
  data: TRecordAlert;
begin
  txt := StringReplace(txt, #13, '', [rfReplaceAll, rfIgnoreCase]);
  txt := StringReplace(txt, #10, '', [rfReplaceAll, rfIgnoreCase]);
  if txt = '' then exit;

  isRepeated := lastLogOutput = txt;
  lastLogOutput := txt;

  sl:=TStringList.Create;
  SplitStr(txt,';',sl);
  //form1.MemoLogs.Lines.Add(sl.Text);
  if sl.Count >= 5 then
  begin
    date := onlyChars(sl.Strings[0]);
    time := onlyChars(sl.Strings[1]);
    ipserver := onlyChars(sl.Strings[2]);
    ipclient := onlyChars(sl.Strings[3]);
    ipdomain := onlyChars(sl.Strings[4]);
    domain := onlyChars(sl.Strings[5]);

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
      //if ipdomain = '' then imgIndex := 0
      //else
    if Pos('127.0.0', ip) = 0 then imgIndex := 0
    else imgIndex := 3;

    if isNew then
    begin
      EditerLigne2(form1.ListView1, -1, imgIndex, domain, ipdomain, imgIndex = 3);
      //i := form1.ListView1.Items.Count;
      //EditerLigne2(form1.ListView1, i, imgIndex, ipdomain, domain, imgIndex = 3);
      Form1.refreshListView1Click();
    end;

    if not isRepeated and (FormAlertLastShow <> domain) then  // (imgIndex > 0) and
    begin
      logs := '['+date+' '+time+'] '+ipserver+' '+ipclient+' -> '+domain;
      if Length(logs) <= 55 then tab := #9 else tab := '';
      if Length(logs) <= 63 then tab := tab+#9;
      if Length(logs) <= 71 then tab := tab+#9;
      if Length(logs) <= 79 then tab := tab+#9;
      status := 'OK';
      if ipdomain = '127.0.0.1' then status := 'BLOCKED by HostFile';
      if ipdomain = '127.0.0.3' then status := 'BLOCKED by Block ALL';
      if ipdomain = '127.0.0.4' then status := 'BLOCKED by DNS Master fail';
      if ipdomain = '127.0.0.9' then status := 'BLOCKED by BlackHost';
      logs := logs + tab+#9+' ['+status+'] -> ('+ipdomain+')';
      if form1.MemoLogs.Visible then form1.MemoLogs.Lines.Add(logs);

      
      data.domain := domain;
      data.typeAlert := imgIndex;
      {
      AlertManager.AddAlert(AlertManager.MainListAlert, data);
      }
      //TimerAlert.Enabled := True;

      if (imgIndex = 0) and CheckBoxAlertEventsKnown.Checked then // inconnu
      begin
        AlertManager.createNewAlert(FormAlert, data);
        if FormAlert <> nil then
        begin
          FormAlert.PanelAllowed.Visible := True;
          FormAlert.PanelDisallowed.Visible := False;
          FormAlert.Show;
        end;
      end;
      if (imgIndex = 1) and CheckBoxAlertEventsUnknown.Checked then // connu
      begin
        AlertManager.createNewAlert(FormAlert, data);
        if FormAlert <> nil then
        begin
          FormAlert.PanelAllowed.Visible := True;
          FormAlert.PanelDisallowed.Visible := False;
          FormAlert.Show;
        end;
      end;
      if (imgIndex = 3) and CheckBoxAlertEventDisallowed.Checked then // bloqu�
      begin
        AlertManager.createNewAlert(FormAlert, data);
        if FormAlert <> nil then
        begin
          FormAlert.PanelAllowed.Visible := False;
          FormAlert.PanelDisallowed.Visible := True;
          FormAlert.Show;
        end;
      end;
     


    end;
  end
  else begin
    if Pos('Error: Port  53  already used', txt) > 0 then
    begin
      //if MessageDlg(PChar('Le port 53 est d�j� utilis�. D�sirez-vous forcer la fermerture des processus python et essayer � nouveau?'#13#13'(si ce message persiste, soit le port 53 est utilis� par un autre processus, soit vous avez indiqu� une mauvaise adresse IP.'),  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
      //begin
        Form1.MemoLogs.Lines.Add('Close all python.exe process');
        KillTask('python.exe');
        Form1.ButtonRefreshNetCardClick(nil);
        ServerDoStart := True;
        Form1.ButtonStartClick(nil);
      //end;
    end
    else begin
        logs := StringReplace(txt, ';', '', [rfReplaceAll, rfIgnoreCase]);
        form1.MemoLogs.Lines.Add(logs);
    end;
  end;
  if sl <> nil then
    sl.Free;


end;



procedure ThreadProcess.RunDosInMemo(Que:String;EnMemo:TMemo);
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
    //if Form1.CheckBoxPureServer.Checked then exit;

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
        On E : EOSError do exit;
        On E : EAccessViolation do exit;
      end;
    end;
    FreeMem(Buffer);
    try
      if ProcessInfo.hProcess <> 0 then CloseHandle(ProcessInfo.hProcess);
      if ProcessInfo.hThread <> 0 then CloseHandle(ProcessInfo.hThread);
      if PaLeer <> 0 then CloseHandle(PaLeer);
      if PaEscribir <> 0 then CloseHandle(PaEscribir);
    except
      On E : EOSError do exit;
      On E : EAccessViolation do exit;
    end;



    try
      if Assigned(EnMemo) and (EnMemo <> nil) then
        EnMemo.Lines.Add(String('Stoped'));
      Form1.onServerDNSStop();
    except
      On E : EAccessViolation do Application.Terminate;
      On E : EListError do Application.Terminate;
    end;


  end;

end;


procedure ThreadProcess.Execute();
begin
  //RunDosInMemo('ping.exe 127.0.0.1', Form1.Memo1MemoLogs);
  Sleep(1000);
  try
    RunDosInMemo(cmd, EnMemo);
  except
    On E : EOSError do Application.Terminate;
    On E : EAccessViolation do Application.Terminate;
  end;
end;

procedure ThreadProcess.Execute2(cmd:String; EnMemo:TMemo);
begin
  RunDosInMemo(cmd, EnMemo);
end;

procedure TForm1.onServerDNSStart();
begin
  Application.ProcessMessages;
  try
  ImageList4.GetIcon(3, Application.Icon);
  Systray.ModifIconeTray(Caption, Application.Icon.Handle);
  ToolButton11.ImageIndex := 8;
  ToolButton11.Caption := 'Arr�ter';
  isServerStarted := True;
  ToolButton11.Enabled := True;
  ToolButton11.Hint := 'Arr�ter le serveur DNS';
  ServerFailStartCount := 0;
  TimerRestart.Enabled := False;
  TimerCheckSystemChanges.Enabled := CheckBoxRestartOnNetworkInterfaceChange.Checked;
  ServerDoStart := True;
  Application.ProcessMessages;
  except
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
  end;
end;

procedure TForm1.onServerDNSStop();
begin
  try
  if ServerDoStart then
  begin
    ImageList4.GetIcon(2, Application.Icon);
    Systray.ModifIconeTray(Caption, Application.Icon.Handle);
    ToolButton11.ImageIndex := 13;
    ToolButton11.Caption := 'Arr�ter';
    ToolButton11.Enabled := True;
    ToolButton11.Hint := 'Arr�ter le serveur DNS';
    inc(ServerFailStartCount);
    TimerRestart.Enabled := True;
    exit;
  end
  else begin
    ImageList4.GetIcon(1, Application.Icon);
    Systray.ModifIconeTray(Caption, Application.Icon.Handle);
    ToolButton11.ImageIndex := 7;
    ToolButton11.Caption := 'D�marrer';
    ToolButton11.Enabled := True;
    ToolButton11.Hint := 'D�marrer le serveur DNS';
    TimerCheckSystemChanges.Enabled := False;
  end;

  isServerStarted := False;

  if CheckBoxAllowModifyNetCard.Checked then
  begin
    ButtonNetCardDesintegrationClick(nil);
  end;


  Application.ProcessMessages;
  except
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
  end;
end;


procedure TForm1.setDNSOnBoot(enabled: Boolean);
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
    '    WScript.Echo "Script de r�paration de connexion r�seau. Veuillez r�pondre oui au dialogue suivant afin de r�parer votre connexion Internet. Et non, si le serveur DNS Relai s''est d�j� lanc� et que vous voulez continuer � l''utiliser."'#13#10+
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






procedure TForm1.ButtonStartClick(Sender: TObject);
var
  i, j, count: Integer;
  filepath, dns, script, config_use_host, config_use_blackhost,
  config_block_all, config_cache_memory, config_display_log: string;
  //net: tNetworkInterfaceList;
begin
  try
  //KillTask('python.exe');
  ButtonCloseClick(nil);
  //closeProcessCreated;

  ImageList4.GetIcon(2, Application.Icon);
  Systray.ModifIconeTray(Caption, Application.Icon.Handle);
  ToolButton11.ImageIndex := 13;
  ToolButton11.Caption := 'Arr�ter';
  ToolButton11.Enabled := True;
  ToolButton11.Hint := 'Arr�ter le serveur DNS';
  ServerDoStart := True;
  //PanelRestart.Visible := False;



  //Splitter1.Visible := True;
  //GroupBox5.Visible := True;



  Application.ProcessMessages;
  Sleep(1000); 
  Application.ProcessMessages;
  {
  if not ServerDoStart then
  begin
    ButtonCloseClick(nil);
    onServerDNSStop();
    exit;
  end;
  }

  //ComboBoxPosLogsSelect(ComboBoxPosLogs);

  {
  if Form1.WindowState = wsNormal then
  begin
    if Form1.Top > Screen.WorkAreaHeight - Form1.Height then
      Form1.Top := Screen.WorkAreaHeight - Form1.Height;
  end;
  }
  if FormInstall = nil then
  begin
    FormInstall := TFormInstall.Create(Self);
  end;
  Application.ProcessMessages;


  FormInstall.CheckInstallation;

  if not FormInstall.isPythonInstalled
  or not FormInstall.isDNSInstalled
  or not FormInstall.isSetuptoolInstalled
  then begin
    FormInstall.Show;
    FormInstall.ButtonInstallClick(nil);
    ToolButton11.Enabled := True;
    FormInstall.TimerWatchThread.Enabled := True;
    //if ServerDoStart then TimerRestart.Enabled := True;
    exit;
  end else
  begin
    FormInstall.Close;
  end;


  Application.ProcessMessages;
  if not ServerDoStart then
  begin
    ButtonCloseClick(nil);
    onServerDNSStop();
    exit;
  end;



  Application.ProcessMessages;

  filepath := String(EditFilehost.Text);
  if FileExists(filepath) = False then
    WriteInFile(filepath, '127.0.0.1	localhost');




  if not FileExists(BlackListCfgFile) then
    WriteInFile(BlackListCfgFile, 'doubleclick'#13#10+
                                  'godaddy'#13#10+
                                  'googleads');

  if not FileExists(filepath) then
  begin
    MemoLogs.Lines.Add('Erreur: Lancement annul�.');
    MemoLogs.Lines.Add('   Le chemin du fichier host est introuvable.');
    MemoLogs.Lines.Add('   Veuillez d�finir le chemin du fichier host en cliquant sur le bouton "Config"');
    ToolButton11.Enabled := True;
    if ServerDoStart then TimerRestart.Enabled := True;
    exit;
  end;

  Application.ProcessMessages;
  if not ServerDoStart then
  begin
    ButtonCloseClick(nil);
    onServerDNSStop();
    exit;
  end;


  count := 0;
  for i := 0 to CheckListBoxDNSRelayIP.Count -1 do
  begin
    if CheckListBoxDNSRelayIP.Checked[i] then inc(count);
  end;
  if count = 0 then
  begin
    MemoLogs.Lines.Add('Erreur: Lancement annul�');
    MemoLogs.Lines.Add('   Veuillez cocher une IP dans le panneau de config du serveur.');

    ToolButton11.Enabled := True;
    ToolButton8Click(ToolButton8);

    // bug ?
    //PageControl1.TabIndex := 0;
    //PageControl1.ActivePageIndex := PageControl1.TabIndex;

    ToolButton11.ImageIndex := 7;
    //if ServerDoStart then TimerRestart.Enabled := True;
    exit;
  end;


  ToolButton11.Enabled := True;

  {
  DNSMasterSerialized := '';
  for i := 0 to ListBoxDNSMaster.Items.Count -1 do
  begin
    dns := ListBoxDNSMaster.Items.Strings[i];
    if DNSMasterSerialized <> '' then DNSMasterSerialized := DNSMasterSerialized + ' ';
    DNSMasterSerialized := DNSMasterSerialized + dns;
  end;
  }

  DNSMasterSerialized := '';
  for i := 0 to ConfigDNSMaster.Count -1 do
  begin
    if DNSMasterSerialized <> '' then DNSMasterSerialized := DNSMasterSerialized + ' ';
    DNSMasterSerialized := DNSMasterSerialized + ConfigDNSMaster[i];
  end;


  if not CheckBoxNoTestDNSMaster.Checked then
  begin
    DNSMasterSerialized := '';
    MemoLogs.Lines.Add('Test DNS Master...');
    DNSMasterSerialized := '';
    for i := 0 to ConfigDNSMaster.Count -1 do
    begin
      dns := ConfigDNSMaster[i];
      MemoLogs.Lines.Add('Master '+ dns +'... ');
      if resolveDNSByPython('a.root-servers.net', dns) = '' then
      begin
        DNSMasterSerialized := '';
        MemoLogs.Lines.Add('Erreur: Lancement annul�.');
        MemoLogs.Lines.Add('   Impossible d''atteindre le serveur DNS Master '+dns);
        MemoLogs.Lines.Add('   Veuillez vous connecter � Internet et essayer � nouveau');
        MemoLogs.Lines.Add('   ou indiquer un autre serveur DNS dans la section "DNS Master"');
        if ServerDoStart then TimerRestart.Enabled := True;
        exit;
      end;
      if DNSMasterSerialized <> '' then DNSMasterSerialized := DNSMasterSerialized + ' ';
      DNSMasterSerialized := DNSMasterSerialized + dns;
      MemoLogs.Lines.Delete(MemoLogs.Lines.Count - 1);
      MemoLogs.Lines.Add('Master '+ dns +'... OK');
    end;
  end;





  //ToolButton11.Enabled := False;

  if DNSMasterSerialized = '' then
  begin
    MemoLogs.Lines.Add('Erreur: Lancement annul�');
    MemoLogs.Lines.Add('   Vous n''avez aucun DNS Master dans votre liste.');
    MemoLogs.Lines.Add('   Veuillez d�finir un Master DNS dans votre liste (exemple 209.244.0.3)');
    ToolButton11.Enabled := True;
    if ServerDoStart then TimerRestart.Enabled := True;
    exit;
  end;

  Application.ProcessMessages;
  if not ServerDoStart then
  begin
    ButtonCloseClick(nil);
    onServerDNSStop();
    exit;
  end;


  //MemoLogs.Lines.Delete(MemoLogs.Lines.Count - 1);
  //MemoLogs.Lines.Add('Test DNS Master... DNS is OK :)');
  config_use_host := '1';
  config_use_blackhost := '1';
  config_block_all := '0';
  config_cache_memory := '1';
  config_display_log := 'True';

  if ButtonDisableBlackhost.Down then config_use_blackhost := '0';
  if ButtonDisableHost.Down then config_use_host := '0';
  if ToolButtonBlockAll.Down then config_block_all := '1';
  if CheckBoxNoCacheDNS.Checked then config_cache_memory := '0';
  if CheckBoxPureServer.Checked then config_display_log := 'False';



  PythonDNS.createScript(config_use_host, config_use_blackhost, config_block_all, config_cache_memory, config_display_log);

  if PythonPath = '' then PythonPath := getPythonPath();

  //if not FileExists(DataDirectoryPath + 'relayDNS.pyo') then
  //begin
  if FileExists(DataDirectoryPath + 'relayDNS.pyo') then DeleteFile(DataDirectoryPath + 'relayDNS.pyo');
  script := '"'+PythonPath+'python.exe" -O -m py_compile "'+DataDirectoryPath + 'relayDNS.py"';
  filepath := ExtractFilePath(Application.ExeName)+installDirectoryPath+'compile_relayDNS.bat';
  WriteInFile(filepath, script);
  LaunchAndWait(filepath,'', launchAndWWindow);
  //end;

  if not FileExists(DataDirectoryPath + 'relayDNS.pyo') then
  begin
    MemoLogs.Lines.Add('Erreur: Lancement annul�');
    MemoLogs.Lines.Add('   La compilation du serveur � �chou�. Mauvaise installation de Python 2.7?');
    if ServerDoStart then TimerRestart.Enabled := True;
    exit;
  end;


  if CheckBoxAllowModifyNetCard.Checked then
  begin
    ButtonNetCardIntegrationClick(ButtonNetCardIntegration);
  end;

  Application.ProcessMessages;
  if not ServerDoStart then
  begin
    ButtonCloseClick(nil);
    onServerDNSStop();
    exit;
  end;

  for i := 0 to CheckListBoxDNSRelayIP.Count -1 do
  begin
    if CheckListBoxDNSRelayIP.Checked[i]
    and (CheckListBoxDNSRelayIP.Items.Strings[i] <> '127.0.0.1') then
    begin
      j := Length(listThreads);
      SetLength(listThreads, j+1);
      listThreads[j] := Unit1.ThreadProcess.Create(True);
      listThreads[j].cmd := '"'+PythonPath+'python.exe" "'+DataDirectoryPath + 'relayDNS.pyo" config_dnsip "'+CheckListBoxDNSRelayIP.Items.Strings[i]+'" config_hostfile "'+EditFilehost.Text+'" config_blackhost "'+BlackListCfgFile+'"';
      listThreads[j].output := TStringList.Create;
      listThreads[j].EnMemo := MemoLogs;
      listThreads[j].indexThread := i;
      listThreads[j].Suspended := False;
    end;
  end;


  LaunchAndWait('ipconfig.exe','/flushdns', SW_HIDE);

  if Notebook1.PageIndex = 5 then
  begin
    Panel1.Visible := False;
    Splitter1.Visible := False;
    GroupBox5.Align := alClient;
    ResizePanelConfig();
  end;

  //if not Panel1.Visible then
  Application.ProcessMessages;
  except
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
  end;

end;



procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: Integer;
begin
  i := opacity;
  while i >= 0 do
  begin
    SetFormOpacity(Self.Handle, i);
    Application.ProcessMessages;
    i := i - 5;
  end;
  if isServerStarted then ButtonCloseClick(nil);
  for i := 0 to Form1.ControlCount - 1 do
  begin
    if Form1.Controls[i].ClassName = 'TTimer' then
      TTimer(Form1.Controls[i]).Enabled := False;
  end;
  Application.ProcessMessages;

  if FormDialogIP <> nil then FormDialogIP.Close;

  //CanClose := False;
  //if Length(listThreads) > 0 then onServerDNSStop();
  Systray.EnleveIconeTray();

  //if ServerDoStart or isServerStarted then ButtonCloseClick(Sender);
  //Application.ProcessMessages;
  //Sleep(2000);

  //Application.Terminate;
  //ProcessManager.DestroyProcess(Application.Handle);
end;

procedure TForm1.ButtonCloseClick(Sender: TObject);
var
  i: Integer;
begin
  try
    ImageList4.GetIcon(2, Application.Icon);
    Systray.ModifIconeTray(Caption, Application.Icon.Handle);

    Timer1.Enabled := False;
    // bug?
    //PanelRestart.Visible := False;
    Application.ProcessMessages;
    //Notebook1.PageIndex := 4;

    KillTask('python.exe');
    i := 0;
    while (i < Length(listThreads)) and (listThreads[i] <> nil) do
    begin
      DestroyProcess(listThreads[i].h);
      Application.ProcessMessages;
      Inc(i);
    end;
    Sleep(1000);

    i := 0;
    while (i < Length(listThreads)) and (listThreads[i] <> nil) do
    begin
      listThreads[i].Terminate;
      Inc(i);
    end;   
    Sleep(1000);

    i := 0;
    while (i < Length(listThreads)) and (listThreads[i] <> nil) do
    begin
      Application.ProcessMessages;
      listThreads[i].Free;
      Inc(i);
    end;

    SetLength(listThreads, 0);



                        
    Application.ProcessMessages;
    Sleep(100);

    //if ToolButton11.ImageIndex = 13 then
    //begin
      ToolButton11.ImageIndex := 7;
      ToolButton11.Caption := 'D�marrer';
      ToolButton11.Enabled := True;
      ToolButton11.Hint := 'D�marrer le serveur DNS';
    //end;
  except
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
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
var dns: string;
begin
  dns := '';
  if not InputQuery('Add DNS Master', 'Exemple 209.244.0.3', dns) then exit;
  ConfigDNSMaster.Add(dns);
  ListBoxDNSMaster.Items.Add(dns);
  ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
  if isServerStarted then PanelRestart.Visible := True;
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
    ShowMessage('Veuillez d''abord s�lectionner un �l�ment dans la liste');
    exit;
  end;
  txt := ListBoxDNSMaster.Items.Strings[i];
  MessageBeep(MB_OK);
  if MessageDlg(Pchar('Effacer "' + txt + '"?'),mtConfirmation, mbOKCancel, 0)  = mrOK then
  begin
    ConfigDNSMaster.Delete(i);
    ListBoxDNSMaster.DeleteSelected;
    ListBoxDNSMaster.ItemIndex := 1 - 1;
    ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
    if isServerStarted then PanelRestart.Visible := True;
    ShowMessage('Effac�');
  end;
end;

// Update DNS MASTER
procedure TForm1.ToolButtonUpdateDNSMasterClick(Sender: TObject);
var
  i:integer;
  dns:string;
begin
  i := ListBoxDNSMaster.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord s�lectionner un �l�ment dans la liste');
    exit;
  end;
  dns := ListBoxDNSMaster.Items.Strings[i];
  //txt := InputBox('Update DNS Master', 'Exemple 209.244.0.3', txt);
  if not InputQuery('Update DNS Master', 'Exemple 209.244.0.3', dns) then exit;
  ListBoxDNSMaster.Items.Strings[i] := dns;
  ConfigDNSMaster[i] := dns;
  ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
  if isServerStarted then PanelRestart.Visible := True;
end;

procedure TForm1.ToolButtonDownDNSMasterClick(Sender: TObject);
var i:integer;
begin
  i := ListBoxDNSMaster.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord s�lectionner un �l�ment dans la liste');
    exit;
  end;
  if i >= ListBoxDNSMaster.Items.Count -1 then exit;
  ConfigDNSMaster.Exchange(i, i + 1);
  ListBoxDNSMaster.Items.Move(i, i + 1);
  ListBoxDNSMaster.ItemIndex := i + 1;
  ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
  if isServerStarted then PanelRestart.Visible := True;
end;

procedure TForm1.ToolButtonUpDNSMasterClick(Sender: TObject);
var i:integer;
begin
  i := ListBoxDNSMaster.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord s�lectionner un �l�ment dans la liste');
    exit;
  end;
  if i > ListBoxDNSMaster.Items.Count -1 then exit;
  ConfigDNSMaster.Exchange(i, i - 1);
  ListBoxDNSMaster.Items.Move(i, i - 1);
  ListBoxDNSMaster.ItemIndex := i - 1;
  ListBoxDNSMaster.Items.SaveToFile(MasterDNSFile);
  if isServerStarted then PanelRestart.Visible := True;
end;


procedure TForm1.ToolButtonEditHostClick(Sender: TObject);
var
  FormHost: TFormHost;
  filepath: string;
begin
  filepath := ExtractFilePath(Application.ExeName)+ String(EditFilehost.Text);
  if FileExists(filepath) = False then
    WriteInFile(filepath, '127.0.0.1	localhost');

  FormHost := TFormHost.Create(Self);
  FormHost.Show;
  FormHost.Filename := EditFilehost.Text;
  FormHost.Load();
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
  param, txt: string;
  canClose: Boolean;
  autostarted: Boolean;
begin


  // Masque la fen�tre de la taskbar
  SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);

  TimerAfterFormCreate.Enabled := True;
  PageControl1.OwnerDraw := True;
  ServerDoStart := False;
  ServerFailStartCount := 0;
  GroupBoxUpdateTheme.Visible := False;
  //PanelMessage.Visible := False;


  Form1.Width := Form1.Constraints.MinWidth;
  Form1.Height := Form1.Constraints.MinHeight;

  Form1.Top := Screen.WorkAreaHeight - Form1.Height;
  Form1.Left := Screen.WorkAreaWidth - Form1.Width;

  //GroupBox5.Height := Form1.Height div 2;
  //GroupBox5.Width := Form1.Width div 2;
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
    //KillTask(ExtractFileName(Application.ExeName));
    KillProcess(Self.Handle);
    Application.Terminate;
  end;

  if (ParamCount() >= 1) and (ParamStr(1) = '/inst_background') then
  begin
    SetCurrentDir(ExtractFileDir(Application.ExeName));
    ExecAndBringToFront(Application.ExeName, '/background');
    canClose := True;
    FormCloseQuery(nil, canClose);
    //KillTask(ExtractFileName(Application.ExeName));
    KillProcess(Self.Handle);
    Application.Terminate;
  end;

  if (ParamCount() >= 1) and (ParamStr(1) = '/inst_autostart') then
  begin
    SetCurrentDir(ExtractFileDir(Application.ExeName));
    ExecAndBringToFront(Application.ExeName, '/autostart');
    canClose := True;
    FormCloseQuery(nil, canClose);
    //KillTask(ExtractFileName(Application.ExeName));
    KillProcess(Self.Handle);
    Application.Terminate;
  end;

  if isDevVersion then txt := ' alpha' else txt := '';
  Form1.Caption := PChar('DNS Relay Server '+CurrentApplicationVersion+txt);

  isServerStarted := False;
  Memo1.Clear;
  Memo1.Text := 'Veuillez lire les modalit�s et les conditions suivantes avant l''utilisation de ce logiciel.  L''utilisation de ce logiciel indique l''acceptation des termes et conditions de la licence.'+#13#10#13#10+
                '1. D�ni de garantie'+#13#10#13#10+
                '"DNS Relay Server" est fourni "tel-que", et aucune garantie de quelque sorte n''est exprim�e ou impliqu�e, incluant sans limitation, toute garantie de valeur marchande ou format physique pour un but particulier.'+#13#10#13#10+
                'Dans aucun cas, l''auteur de ce logiciel ne sera jug� responsable de la perte de donn�es, des dommages, du manque � gagner ou de n''importe quel autre genre de perte par l''utilisation correcte ou non de ce logiciel.'+#13#10#13#10+
                'Le logiciel peut-�tre modifi�. Le code source est fourni dans le setup d''installation.'+#13#10#13#10+
                ''+#13#10#13#10+
                '2. Licence'+#13#10#13#10+
                '"DNS Relay Server" est fourni en tant que logiciel open source.'+#13#10#13#10+
                'Dans ce cas, Vous avez le droit d''utiliser, de le modifier et de le distribuer comme vous voulez.'+#13#10#13#10+
                'L''installation et l''utilisation de ce logiciel signifie l''acceptation des termes et conditions de la license.'+#13#10#13#10+
                ''+#13#10#13#10+
                '3. Fonctionnement'+#13#10#13#10+
                '"DNS Relay Server" peut modifier la configuration de vos cartes r�seau afin de pouvoir faciliter son int�gration dans le syst�me et filtrer Internet au niveau des noms de domaines (DNS).'+#13#10#13#10+
                'Au lancement du serveur, l''adresse des serveurs DNS sont modifi�s par l''IP de votre propre machine.'+#13#10#13#10+
                'A la fermeture du serveur, vos cartes r�seau repassent en mode automatique (mode DHCP).'+#13#10#13#10+
                'Si vous �tiez en configuration IP manuelle, vous risquez de changer d''IP.'+#13#10#13#10+
                'Donc si vous lancez ce programme sur un serveur distant, vous risquez de perdre la connexion avec celui-ci.'+#13#10#13#10+
                'Soyez conscient de ce risque.'+#13#10#13#10+
                'Par mesure de s�curit�, un script VBS est plac� au lancement de Windows afin de r�parer la connexion Internet en cas de plantage ou red�marrage du PC.'+#13#10#13#10+
                'Ce script ne se lance pas si vous avez d�j� configur� ce serveur pour qu''il red�marre avec Windows. Ce script ne r�parera pas la connexion qui a �t� cass� par un autre programme.'+#13#10#13#10+
                'Pour la d�tection d''une connexion cass� par cette application, le script va v�rifier au red�marrage du PC si l''addresse IP est indentique � celle du serveur DNS, si oui, alors il restaure la carte r�seau en DHCP. Si non, il ne fait rien.'+#13#10#13#10+
                'Vous �tes en version beta-test, ce qui signifie que ce programme n''a pas �t� encore test� partout. Il peut y avoir encore des bugs non-r�pertori�s.'+#13#10#13#10+
                'Pour fonctionner le serveur DNS a besoin de Python 2.7 et de quelques librairies pour fonctionner. Ces d�pendances seront t�l�charg�s et install�s automatiquement au lancement du serveur.  Une connexion Internet sera n�cessaire.';


  MemoHelpWebAdmin.Lines.Add('Ce script permet de contr�ler cette application depuis un serveur web PHP. '
    +'Cette application doit pouvoir avoir un acc�s en �criture o� sera install� le script. '
    +'Et le script a aussi besoin d''un acc�s en �criture o� est install� cette application. Lors de l''installation, l''application va m�moriser le chemin o� est export� le script.'
    +' Veillez � exporter dans le r�p�rtoire du serveur web si vous voulez profiter des mises � jour automatique du script. '
    +'Effacez le script ou exportez-le dans un r�pertoire temporaire si vous ne voulez pas de mise � jour automatique du script. '
    +'Pour le moment il n''y a aucune s�curit� d''acc�s au script. '
    +'Install� tel quel, n''importe qui qui acc�de au serveur pourra changer ensuite les configurations de cette application. A vous de s�curiser l''acc�s au script (avec un .htaccess ou en placant uniquement sur un intranet local)');

  Panel1.Align := alClient;
  GroupBox1.Align := alClient;
  GroupBox2.Align := alClient;
  GroupBox3.Align := alClient;
  GroupBox4.Align := alClient;
  //GroupBox5.Align := alClient;
  GroupBox6.Align := alClient;
  Notebook1.Align := alClient;
  PageControl1.Align := alClient;
  //ListBoxBlacklist.Align := alClient;
  ScrollBox1.Align := alClient;
  ScrollBox2.Align := alClient;
  ScrollBox3.Align := alClient;
  ScrollBox4.Align := alClient;
  ScrollBox5.Align := alClient;
  ScrollBox6.Align := alClient;
  ScrollBox6.VertScrollBar.Position := 0;

  GroupBox5.Align := alBottom;
  PanelRestart.Align := alBottom;
  PanelMessage.Align := alBottom;

  PageControl1.TabIndex := 0;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
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
  DirCustomHost := DataDirectoryPath + DirCustomHost;

  if EditFilehost.Text = '' then EditFilehost.Text := DataDirectoryPath + 'host.txt';

  PythonPath := getPythonPath();


  if FileExists(MasterDNSFile) then
    ListBoxDNSMaster.Items.LoadFromFile(MasterDNSFile);

  ConfigDNSMaster := TStringList.Create;
  for i := 0 to ListBoxDNSMaster.Items.Count - 1 do
    ConfigDNSMaster.Add(ListBoxDNSMaster.Items.Strings[i]);

  if FileExists(FilehostPathConfig) then
    EditFilehost.Text := ReadFromFile(FilehostPathConfig);

  //if FileExists(SlaveDNSIPConfig) then
  //  CheckListBoxDNSRelayIP.Items.LoadFromFile(SlaveDNSIPConfig);
  //CBoxDNSServerSlaveIP.Text := ReadFromFile(SlaveDNSIPConfig);

  //SpinEditAlertDuration.Value := 10;
  if FileExists(DataDirectoryPath + 'alertDisplayDuration.cfg') then
    SpinEditAlertDuration.Value := StrToInt(ReadFromFile(DataDirectoryPath + 'alertDisplayDuration.cfg'))
  else SpinEditAlertDuration.Value := 10;
  if SpinEditAlertDuration.Value < 3 then SpinEditAlertDuration.Value := 3;


  if FileExists(SlaveDNSPortConfig) then
    SpinPort.Value := StrToInt(ReadFromFile(SlaveDNSPortConfig));

  if FileExists(DataDirectoryPath + 'contrasteTextarea.cfg') then
    SpinEditContraste.Position := StrToInt(ReadFromFile(DataDirectoryPath + 'contrasteTextarea.cfg'));

  if FileExists(TimeCheckUpdateFile) then
    SpinTimeCheckUpdate.Value := StrToInt(ReadFromFile(TimeCheckUpdateFile));

  if FileExists(BlackListCfgFile) then
    ListBoxBlacklist.Items.LoadFromFile(BlackListCfgFile);

  CheckBoxAutostartDNSOnBoot.Checked := FileExists(DataDirectoryPath + 'checkAutostartDNS.cfg');
  CheckBoxUpdate.Checked := FileExists(DataDirectoryPath + 'checkupdate.cfg');
  CheckBoxUpdateIntervall.Checked := FileExists(DataDirectoryPath + 'checkupdateIntervall.cfg');
  CheckBoxUpdateSilent.Checked := FileExists(DataDirectoryPath + 'checkupdateSilent.cfg');
  TimerCheckUpdate.Enabled := Form1.CheckBoxUpdateIntervall.Checked;
  TimerCheckUpdate.Interval := SpinTimeCheckUpdate.Value * 3600000;
  CheckBoxAllowModifyNetCard.Checked := FileExists(DataDirectoryPath + 'checkAllowModifyNetcard.cfg');

  //CheckBoxSwitchTheme.Checked := FileExists(DataDirectoryPath + 'checkSwitchTheme.cfg');
  ComboBoxCurrentTheme.OnSelect := nil;
  if FileExists(DataDirectoryPath + 'ThemeNames.cfg') then
    ComboBoxCurrentTheme.Items.LoadFromFile(DataDirectoryPath + 'ThemeNames.cfg');

  ComboBoxCurrentTheme.ItemIndex := 0;
  if FileExists(DataDirectoryPath + 'ThemeSelected.cfg') then
    ComboBoxCurrentTheme.ItemIndex := StrToInt( ReadFromFile(DataDirectoryPath + 'ThemeSelected.cfg'));
  //ShowMessage(inttostr(StrToInt(ReadFromFile(DataDirectoryPath + 'ThemeSelected.cfg'))));
  //ComboBoxCurrentTheme.OnSelect := ComboBoxCurrentThemeSelect;
  ComboBoxCurrentThemeSelect(ComboBoxCurrentTheme);

  ComboBoxPosLogs.ItemIndex := 1;
  if FileExists(DataDirectoryPath + 'PositionLogs.cfg') then
    ComboBoxPosLogs.ItemIndex := StrToInt( ReadFromFile(DataDirectoryPath + 'PositionLogs.cfg'));
  ComboBoxPosLogsSelect(ComboBoxPosLogs);

  Systray.AjouteIconeTray(Handle,Application.Icon.Handle,Self.Caption);
  ButtonRefreshNetCardClick(nil);
  CheckBoxAlertEventsKnown.Checked := FileExists(DataDirectoryPath + 'checkAlertEventsKnow.cfg');
  CheckBoxAlertEventsUnknown.Checked := FileExists(DataDirectoryPath + 'checkAlertEventsUnknown.cfg');
  CheckBoxAlertEventDisallowed.Checked := FileExists(DataDirectoryPath + 'checkAlertEventDisallowed.cfg');
  inconnus1.Checked := CheckBoxAlertEventsUnknown.Checked;
  connus1.Checked := CheckBoxAlertEventsKnown.Checked;
  bloques1.Checked := CheckBoxAlertEventDisallowed.Checked;


  ButtonDisableBlackhost.Down := FileExists(DataDirectoryPath + 'disableBlackhost.cfg');
  ButtonDisableHost.Down := FileExists(DataDirectoryPath + 'disableHost.cfg');
  DsactiverlefiltragedufichierHost1.Checked := ButtonDisableHost.Down;
  DsactiverlefiltrageBlackword1.Checked := ButtonDisableBlackhost.Down;
  ToolButtonBlockAll.Down := FileExists(DataDirectoryPath + 'disableAll.cfg')
                         or (FileExists(DataDirectoryPath + 'disableHost.cfg')
                         and FileExists(DataDirectoryPath + 'disableBlackhost.cfg'));
  toutbloquer1.Checked := ToolButtonBlockAll.Down;

  AllowAll.Checked := FileExists(DataDirectoryPath + 'disableHost.cfg') and FileExists(DataDirectoryPath + 'disableBlackhost.cfg');
  DisallowAll.Checked := FileExists(DataDirectoryPath + 'disableAll.cfg');
  Toutautoriser1.Checked := AllowAll.Checked;
  //ToolButtonBlockAll.Down := AllowAll.Checked;
  ButtonDisableBlackhost.Down := AllowAll.Checked;
  ButtonDisableHost.Down := AllowAll.Checked;
  DsactiverlefiltragedufichierHost1.Checked := AllowAll.Checked;
  DsactiverlefiltrageBlackword1.Checked := AllowAll.Checked;

  Toutnormale1.Checked := not ButtonDisableBlackhost.Down
                      and not ButtonDisableHost.Down
                      and not AllowAll.Checked
                      and not DisallowAll.Checked
                      and not Toutnormale1.Checked;
  Toutnormal1.Checked := Toutnormale1.Checked;

  CheckBoxNoTestDNSMaster.Checked := FileExists(DataDirectoryPath + 'CheckBoxNoTestDNSMaster.cfg');
  CheckBoxNoCacheDNS.Checked := FileExists(DataDirectoryPath + 'CheckBoxNoCacheDNS.cfg');
  CheckBoxPureServer.Checked := FileExists(DataDirectoryPath + 'CheckBoxPureServer.cfg');

  CheckBoxRemoteAccess.Checked := FileExists(DataDirectoryPath + 'CheckBoxRemoteAccess.cfg');
  TimerRemoteAccess.Enabled := CheckBoxRemoteAccess.Checked;


  CheckBoxRestartOnNetworkInterfaceChange.Checked := FileExists(DataDirectoryPath + 'CheckBoxRestartOnNetworkInterfaceChange.cfg');
  //TimerCheckSystemChanges.Enabled := CheckBoxRestartOnNetworkInterfaceChange.Checked;

  //TActionManageIP.getIPCustomHostFiles(ComboBoxSelectIPBlackhost, '_blackhost.txt');
  //TActionManageIP.getIPCustomHostFiles(ComboBoxSelectIPhostfile, '_hostfile.txt');
  TActionManageIP.load();

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
    ServerDoStart := True;
    ButtonStartClick(nil);
  {
    ServerDoStart := True;
    ImageList4.GetIcon(2, Application.Icon);
    Systray.ModifIconeTray(Caption, Application.Icon.Handle);
    ToolButton11.ImageIndex := 13;
    TimerRestart.Enabled := True;
   }
  end;


  TimerUpdateOnLoad.Enabled := CheckBoxUpdate.Enabled;
  //setTheme(RGB(10,30,40), RGB(220,155,220));

  //ComboBoxSelectIPBlackhost.Items.s
end;

procedure TForm1.setTheme(color, bg:TColor);
begin
  setThemeBg(bg);
  setThemeFont(color);
end;


function secureColor(i:Integer):Integer;
begin
  if i < 0 then i := 0;
  if i > 255 then i := 255;
  result := i;
end;

function changeColor(c:TColor; r,g,b:Integer):TColor;
begin
  result := RGB(
    secureColor(getRValue(ColorToRGB(c)) + r),
    secureColor(getGValue(ColorToRGB(c)) + g),
    secureColor(getBValue(ColorToRGB(c)) + b)
  );
end;

procedure TForm1.setThemeBg(bg:TColor);
var
  bg2:TColor;
begin


  Form1.Color := bg;

  GroupBox2.Color := bg;
  GroupBox3.Color := bg;
  GroupBox4.Color := bg;
  GroupBox5.Color := bg;
  GroupBox6.Color := bg;
  GroupBox13.Color := bg;
  GroupBox14.Color := bg;
  GroupBox15.Color := bg;

  Panel1.Color := bg;
  Panel2.Color := bg;
  Panel3.Color := bg;
  Panel4.Color := bg;
  Panel5.Color := bg;
  Panel6.Color := bg;
  Panel7.Color := bg;
  Panel8.Color := bg;
  Panel9.Color := bg;
  Panel11.Color := bg;
  PanelMessage.Color := bg;

  Splitter1.Color := bg;

  ToolBar1.Color := bg;
  ToolBar2.Color := bg;
  ToolBar3.Color := bg;
  ToolBar4.Color := bg;
  CheckBoxStartWithWindows.Color := bg;
  CheckBoxAutostartDNSOnBoot.Color := bg;
  PanelRestart.Color := bg;
  ShapeColorBackground.Brush.Color := bg;
  Label11.Color := bg;
  LabelMessage.Color := bg;

  bg2 := changeColor(bg, SpinEditContraste.Position, SpinEditContraste.Position, SpinEditContraste.Position);

  ListView1.Color := bg2;
  Memo1.Color := bg2;
  MemoLogs.Color := bg2;
  MemoHelpWebAdmin.Color := bg2;
  ListBoxIpClients.Color := bg2;
  ListBoxDNSMaster.Color := bg2;
  CheckListBoxDNSRelayIP.Color := bg2;
  SpinPort.Color := bg2;
  EditFilehost.Color := bg2;
  SpinTimeCheckUpdate.Color := bg2;
  SpinEditAlertDuration.Color := bg2;
  ComboBoxCurrentTheme.Color := bg2;
  EditThemeName.Color := bg2;
  ListBoxBlacklist.Color := bg2;
  ComboBoxPosLogs.Color := bg2;
  ComboBoxSelectIPBlackhost.Color := bg2;
  ComboBoxSelectIPhostfile.Color := bg2;

  bg2 := changeColor(bg, -SpinEditContraste.Position, -SpinEditContraste.Position, -SpinEditContraste.Position);

  ListView1.Font.Color := bg2;
  Memo1.Font.Color := bg2;
  MemoLogs.Font.Color := bg2;
  MemoHelpWebAdmin.Font.Color := bg2;
  ListBoxIpClients.Font.Color := bg2;
  ListBoxDNSMaster.Font.Color := bg2;
  CheckListBoxDNSRelayIP.Font.Color := bg2;
  SpinPort.Font.Color := bg2;
  EditFilehost.Font.Color := bg2;
  SpinTimeCheckUpdate.Font.Color := bg2;
  SpinEditAlertDuration.Font.Color := bg2;
  ComboBoxCurrentTheme.Font.Color := bg2;
  EditThemeName.Font.Color := bg2;
  ListBoxBlacklist.Font.Color := bg2;
  ComboBoxPosLogs.Font.Color := bg2;
  ComboBoxSelectIPBlackhost.Font.Color := bg2;
  ComboBoxSelectIPhostfile.Font.Color := bg2;
end;
procedure TForm1.setThemeFont(color:TColor);
begin
  LabelUpdateTheme.Font.Color := color;
  ShapeColorText.Brush.Color := color;
  Label1.Font.Color := color;
  Label2.Font.Color := color;
  Label3.Font.Color := color;
  Label4.Font.Color := color;
  Label5.Font.Color := color;
  Label6.Font.Color := color;
  Label7.Font.Color := color;
  Label9.Font.Color := color;
  Label8.Font.Color := color;
  Label10.Font.Color := color;
  Label11.Font.Color := color;
  Label12.Font.Color := color;
  Label13.Font.Color := color;
  Label14.Font.Color := color;
  Label15.Font.Color := color;
  Label16.Font.Color := color;
  Label17.Font.Color := color;
  Label18.Font.Color := color;
  Label26.Font.Color := color;
  Label30.Font.Color := color;
  Label31.Font.Color := color;
  Label32.Font.Color := color;
  Label33.Font.Color := color;
  Label34.Font.Color := color;
  Label35.Font.Color := color;
  Label37.Font.Color := color;
  Label38.Font.Color := color;
  Label39.Font.Color := color;

  LabelMessage.Font.Color := color;
  CheckBoxStartWithWindows.Font.Color := color;
  CheckBoxAutostartDNSOnBoot.Font.Color := color;
  GroupBox2.Font.Color := color;
  Panel1.Font.Color := color;
  Panel3.Font.Color := color;
  PanelMessage.Font.Color := color;
  Form1.Font.Color := color;
  ToolBar4.Font.Color := color;
  GroupBox2.Font.Color := color;
  GroupBox3.Font.Color := color;
  GroupBox4.Font.Color := color;
  GroupBox5.Font.Color := color;
  GroupBox6.Font.Color := color;
  GroupBox7.Font.Color := color;
  CheckBoxStartWithWindows.Font.Color := color;
  CheckBoxAutostartDNSOnBoot.Font.Color := color;
  CheckBoxUpdate.Font.Color := color;
  CheckBoxUpdateIntervall.Font.Color := color;
  CheckBoxUpdateSilent.Font.Color := color;
  CheckBoxAllowModifyNetCard.Font.Color := color;

end;



procedure TForm1.TimerAfterFormCreateLongTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  isApplicationLoading := False;
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
  WriteInFile(SlaveDNSProcesslist, IntToStr(h));
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

  txt := ReadFromFile(SlaveDNSProcesslist);
  if txt = '' then exit;
  h := StrToInt(txt);
  CloseTaskPID('python.exe',h);
  exit;

  sl:=TStringList.Create;
  txt := ReadFromFile(SlaveDNSProcesslist);
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
    WM_LBUTTONUP: ; //PopupMenu1.Popup(Pos.X,Pos.Y); //Bouton gauche l�ve
    WM_RBUTTONDBLCLK:; //Double klik droit
    WM_RBUTTONDOWN:;    //Bouton droit pousse
    WM_RBUTTONUP:PopupMenu1.Popup(Pos.X,Pos.Y); //Bouton droite l�ve: Popup
  end;
end;


procedure TForm1.Masquer1Click(Sender: TObject);
begin                                       
  //Self.Hide;
  //TimerFadeIn.Enabled := False;
  //TimerFadeOut.Enabled := True;
                                         
  Top := Screen.Height;
  Left := Screen.Width;
  //currentFormStyle := Self.FormStyle;
  //Self.FormStyle := fsStayOnTop;
  //Systray.EnleveIconeTray;
  //Systray.AjouteIconeTray(Handle,Application.Icon.Handle,Self.Caption);

end;

procedure TForm1.Afficher1Click(Sender: TObject);
begin
  //TimerFadeOut.Enabled := False;
  //TimerFadeIn.Enabled := True;  
  Self.Show;
  try

  if Top > Screen.WorkAreaHeight - Self.Height then
    Top := Screen.WorkAreaHeight - Self.Height;
  if Left > Screen.WorkAreaWidth - Self.Width then
    Left := Screen.WorkAreaWidth - Self.Width;
  //Self.WindowState := wsNormal;
  Application.Restore;
  Application.BringToFront;
  //Self.FormStyle := currentFormStyle;
  {

  Application.BringToFront;
  //Systray.EnleveIconeTray;
  //Systray.AjouteIconeTray(Handle,Application.Icon.Handle,Self.Caption);
  {
  // Restaure la fen�tre de la taskbar
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
      GetWindowLong(Application.Handle, GWL_EXSTYLE)
      or WS_EX_TOOLWINDOW);
      }
  except
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
  end;
end;

procedure TForm1.Quitter1Click(Sender: TObject);
var CanClose: Boolean;
begin
  if isServerStarted then ButtonCloseClick(nil);
  FormCloseQuery(Form1, CanClose);
  Application.Terminate;
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
  Notebook1.PageIndex := 5;
end;
         

var
  ResizePanelConfig_oldHeight: Integer = 0;
  ResizePanelConfig_oldWidth: Integer = 0;

procedure TForm1.ResizePanelConfig();
begin
  refreshCheckBox(CheckBoxStartWithWindows);

  if Form1.WindowState = wsMaximized then exit;
  {
  if GroupBox5.Visible and ((Splitter1.Align = alLeft) or (Splitter1.Align = alRight)) then
  begin
    if Form1.Width < 450 + GroupBox5.Width then
      Form1.Width := 450 + GroupBox5.Width;
  end else begin
    if Form1.Width < 420 then
      Form1.Width := 420;
  end;

  if Splitter1.Visible then
  begin
    if Form1.Height < 540 then
    begin
      GroupBox5.Height := 100;
      Form1.Height := 540;

    end;
  end else begin
    if Form1.Height < 350 then Form1.Height := 350;
  end;
  if Form1.Top > Screen.WorkAreaHeight - Form1.Height then
    Form1.Top := Screen.WorkAreaHeight - Form1.Height;

  if Form1.Left > Screen.WorkAreaWidth - Form1.Width then
    Form1.Left := Screen.WorkAreaWidth - Form1.Width;
  }
  // Main
  if GroupBox5.Visible or Panel1.Visible then
  begin
    Form1.Constraints.MinHeight := 300;
    Form1.Height := ResizePanelConfig_oldHeight;
    Form1.Width := ResizePanelConfig_oldWidth;
    Afficher1Click(nil);
  end else
  begin
    Form1.Constraints.MinHeight := ToolBar3.Height + 40;
    if Form1.Width <> Form1.Constraints.MinWidth then
    begin
      ResizePanelConfig_oldWidth := Form1.Width;
      ResizePanelConfig_oldHeight := Form1.Height;
    end;
    Form1.Height := Form1.Constraints.MinHeight+2;
    Form1.Width := Form1.Constraints.MinWidth;
  end;
  Application.ProcessMessages;
  //Sleep(1000);
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
  //Notebook1.PageIndex := 1;
end;

procedure TForm1.GotoMainPage(inexPage: Integer);
var
  isIndexChanged: Boolean;
  isVisibleChanged: Boolean;
  oldVisibility: Boolean;
begin
   {
  if Notebook1.PageIndex <> inexPage then
  begin
    Panel1.Visible := False;
    Splitter1.Visible := False;
  end;
    }
  isIndexChanged := Notebook1.PageIndex <> inexPage;
  oldVisibility := Panel1.Visible;

  Panel1.Visible := not Panel1.Visible or isIndexChanged;
  Splitter1.Visible := Panel1.Visible;

  isVisibleChanged :=  Panel1.Visible <> oldVisibility;
  //Splitter1.Visible := (GroupBox5.Visible and Panel1.Visible);

  if not Panel1.Visible then
    GroupBox5.Align := alClient
  else begin
    //Splitter1.Align := alBottom;
    //GroupBox5.Align := alBottom;
    //GroupBox5.Height := 100;
    if isVisibleChanged then ComboBoxPosLogsSelect(ComboBoxPosLogs);
  end;



  ToolButton8.Down := Panel1.Visible and (inexPage = 0);
  ToolButtonBlackwords.Down := Panel1.Visible and (inexPage = 1);
  ToolButton4.Down := Panel1.Visible and (inexPage = 2);
  ToolButton6.Down := Panel1.Visible and (inexPage = 3);
  ToolButton3.Down := Panel1.Visible and (inexPage = 4);




  Notebook1.PageIndex := inexPage;
  //ResizePanelConfig();
  PanelMessage.Visible := False;
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
  GotoMainPage(0);
end;
          
procedure TForm1.ToolButtonBlackwordsClick(Sender: TObject);
begin
  GotoMainPage(1);
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  GotoMainPage(2);
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
  GotoMainPage(3);
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  GotoMainPage(4);
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
  if isApplicationLoading then exit;

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

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
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
    PanelRestart.Visible := True;
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
  if MessageDlg(PChar('Ce bouton est un bouton d''aide. Vous allez voir quelques messages qui vont vous expliquer les boutons qui se trouvent � c�t� de celui que vous venez de cliquer. Voulez-vous continuer?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
    ShowMessage(PChar('Cliquez sur le premier bouton pour effacer les domaines inconnus (boule noire) et ne garder que ceux qui sont connus.'));
    ShowMessage(PChar('Cliquez sur le deuxi�me bouton pour �diter manuellement le fichier host'#13#13
    +'Edition du fichier host'#13#13
    +'Exemple:'#13
    +'127.0.0.1  localhost'#13#13
    +'R�gle: '#13
    +'Un ligne par domaine et ip.'#13
    +'D''abord l''ip ensuite le domaine.'#13
    +'L''ip et le domaine doivent �tre s�par� par une tabulation (touche TAB).'#13#13
    +'Une fois les changements termin�s, red�marrez le serveur (avec le bouton Start) pour appliquer les modifications.'));
    ShowMessage(PChar('Cliquer bouton droit sur une IP de la liste (colone gauche) pour afficher le menu.'));
end;

procedure TForm1.EditFilehostChange(Sender: TObject);
begin
  TimerSaveChange.Enabled := False;
  TimerSaveChange.Enabled := True;
end;

procedure TForm1.TimerSaveChangeTimer(Sender: TObject);
var
  i: Integer;
  txt: String;
begin
  TTimer(Sender).Enabled := False;
  if isApplicationLoading then exit;
  
  WriteInFile(FilehostPathConfig, EditFilehost.Text);
  //CheckListBoxDNSRelayIP.Items.SaveToFile(SlaveDNSIPConfig);
  //WriteInFile(SlaveDNSIPConfig, CBoxDNSServerSlaveIP.Text);
  WriteInFile(SlaveDNSPortConfig, IntToStr(SpinPort.Value));
  WriteInFile(TimeCheckUpdateFile, IntToStr(SpinTimeCheckUpdate.Value));
  WriteInFile(DataDirectoryPath + 'alertDisplayDuration.cfg', IntToStr(SpinEditAlertDuration.Value));

  txt := #13#10;
  for i := 0 to CheckListBoxDNSRelayIP.Count - 1 do
  begin
    if not CheckListBoxDNSRelayIP.Checked[i] then
    begin
      txt := txt + CheckListBoxDNSRelayIP.Items.Strings[i]+#13#10;
    end;
  end;
  WriteInFile(DataDirectoryPath + 'CheckListBoxDNSRelayIP.cfg', txt);

  if isServerStarted then PanelRestart.Visible := True;
  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
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
  SelectedListItem := ListView1.Selected;
  if not Assigned(SelectedListItem) then exit;
  //setDomain( EditFilehost.Text, SelectedListItem.SubItems.Strings[0], '127.0.0.1');
  setDomain(EditFilehost.Text, SelectedListItem.Caption, '127.0.0.1');
  SelectedListItem.SubItems.Strings[0] := '127.0.0.1';
  MemoLogs.Lines.Add('Bloquage de '+SelectedListItem.Caption);
  refreshListView1Click();
  if isServerStarted then
  begin
    PanelRestart.Visible := True;
  end;
end;

procedure TForm1.Autoriser1Click(Sender: TObject);
begin
  SelectedListItem := ListView1.Selected;
  if not Assigned(SelectedListItem) then exit;
  if (SelectedListItem.SubItems.Strings[0] = '') then exit;
  //delDomain(EditFilehost.Text, SelectedListItem.SubItems.Strings[0]);
  delDomain(EditFilehost.Text, SelectedListItem.Caption);     
  MemoLogs.Lines.Add('D�bloquage de '+SelectedListItem.Caption);
  SelectedListItem.Delete;
  refreshListView1Click();
  if isServerStarted then
  begin
    PanelRestart.Visible := True;
  end;
end;

procedure TForm1.Modifier1Click(Sender: TObject);
var
  ip:string;
begin
  SelectedListItem := ListView1.Selected;
  if not Assigned(SelectedListItem) then exit;
  //txt := InputBox('Update IP Domain', 'Exemple: pour bloquer 127.0.0.1', SelectedListItem.SubItems.Strings[0]);
  ip := SelectedListItem.SubItems.Strings[0];
  if not InputQuery('Update IP Domain', 'Exemple: pour bloquer 127.0.0.1', ip) then exit;
  setDomain( EditFilehost.Text, SelectedListItem.Caption, ip);
  SelectedListItem.SubItems.Strings[0] := ip;
  refreshListView1Click();
  if isServerStarted then
  begin
    PanelRestart.Visible := True;
  end;
end;

procedure TForm1.ListView1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  ListItem:TListItem;
  CurPos:TPoint;
begin
  // Si on clique dans la case � cocher, on s�l�ctionne la ligne
  // Donc on r�cup�re la position de la souris sur l'�cran
  GetcursorPos(MousePos);
  // on indique sa position en fonction du ListView
  CurPos:=TListView(Sender).ScreenToClient(MousePos);
  // On r�cup�re la ligne du listView o� se trouve la souris
  ListItem:=TListView(Sender).GetItemAt(CurPos.x,CurPos.y);
  if Assigned(ListItem) then
  begin
    SelectedListItem := ListItem;
    PopupMenuListView.Popup(MousePos.x, MousePos.y);
  end;
end;


procedure TForm1.refreshListView1Click();
var
  i:integer;
  ip, ipdomain:string;
begin
  for i := 0 to ListView1.items.count - 1 do
  begin
            {
    //ip := getDomain(EditFilehost.Text, ListView1.Items.Item[i].SubItems.Strings[0]);


    //ip := onlyChars(ip);
    //ShowMessage('"'+ip+'"');
    if ip = '' then ListView1.Items.Item[i].ImageIndex := 0
    else }
    ip := getDomain(EditFilehost.Text, ListView1.Items.Item[i].Caption);
    ipdomain := ListView1.Items.Item[i].SubItems.Strings[0];
    if Pos('127.0.0.', ipdomain) > 0 then ListView1.Items.Item[i].ImageIndex := 3
    else if ip = '' then ListView1.Items.Item[i].ImageIndex := 0
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
var i, j: Integer;
begin
  Timer1.Enabled := False;
  if listThreads = nil then exit;
  if Length(listThreads) = 0 then exit;
  for j := 0 to Length(listThreads) - 1 do
  begin                                    
    if j >= Length(listThreads) then exit;
    if listThreads[j] = nil then exit;
    if listThreads[j].Terminated then exit;
    if listThreads[j].output.Count = 0 then exit;
    for i := 0 to listThreads[j].output.Count - 1 do
    begin
      OnOutput(listThreads[j].output[i]);
    end;
    listThreads[j].output := TStringList.Create;
  end;
end;



procedure TForm1.ButtonForceStartClick(Sender: TObject);
begin
  KillTask('python.exe');
  ButtonStartClick(nil);
end;

procedure TForm1.ToolButton11Click(Sender: TObject);
begin


  if not TToolButton(Sender).Enabled then exit;
  TToolButton(Sender).Enabled := False;
  if not ServerDoStart then
  begin
    //if MessageDlg('D�marrer le serveur?',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    //begin
      ButtonStartClick(nil);
    //end;
  end
  else begin
    //if MessageDlg('Arr�ter le serveur?',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    //begin
      ServerDoStart := False;
      //ToolButton11.Enabled := False;
      TimerRestart.Enabled := False;

      Application.ProcessMessages;
      ButtonCloseClick(nil);


    //end;
  end;
  PanelRestart.Visible := False;
  Application.ProcessMessages;
  Sleep(1000);
  TToolButton(Sender).Enabled := True;
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

procedure TForm1.ButtonUpdateDevClick(Sender: TObject);
begin
  if MessageDlg(PChar('Attention, cette mise � jour est destin�e � son d�veloppement. Vous allez mettre � jour le serveur dans une version d''essai qui est potentiellement instable. Voulez-vous continuer?'),  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then exit;


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
  ThreadUpdate.DoUpdateDevelopper(False);
  TButton(Sender).Enabled := True;
end;
      
procedure TUpdate.DoUpdate(isSilent: Boolean);
begin
  UpdateUrl(
    'https://github.com/ddeeproton/DNSRelayServer-DelphiPython/raw/master/lastversion.txt',
    'https://github.com/ddeeproton/DNSRelayServer-DelphiPython/raw/master/Setup installation/DNSRelayServerSetup_',
    '',
    isSilent,
    false
  );
end;

procedure TUpdate.DoUpdateDevelopper(isSilent: Boolean);
begin
  UpdateUrl(
    'https://github.com/ddeeproton/DNSRelayServer-DelphiPython/raw/master/DNSRelayServer_Test Version (last build)/NSIS/version_dev.txt',
    'https://github.com/ddeeproton/DNSRelayServer-DelphiPython/raw/master/Setup installation/test versions (bugged)/DNSRelayServerSetup_',
    '_alpha',
    isSilent,
    true
  );
end;

procedure TUpdate.UpdateUrl(urlLastVersion, urlUpdate, suffixe: string; isSilent, isDev: Boolean);
var
  lastversion, lastverFile, url, msg: string;
  canClose: Boolean;
begin
  //url := 'https://raw.gith4ubusercontent.com/ddeeproton/DNSRelayServer-DelphiPython/master/Special version/BlackEdition/lastversion.txt';
  url := urlLastVersion+'?'+DateTimeToStr(Now);
  lastverFile := ExtractFilePath(Application.ExeName)+installDirectoryPath+'lastversion.txt';
  if FileExists(lastverFile) then DeleteFile(lastverFile);
  if FileExists(lastverFile) then
  begin
    if isSilent then
      //Form1.MemoLogs.Lines.Add('Error Update: Probl�me de connexion au serveur de mise � jour.')
    else
      ShowMessage('Error Update: Impossible d''effacer le fichier temporaire suivant:'+#13#13+lastverFile);
    exit;
  end;
  downloadFile(url, lastverFile);

  if not FileExists(lastverFile) then
  begin
    if isSilent then
      //Form1.MemoLogs.Lines.Add('Error Update: Probl�me de connexion au serveur de mise � jour.')
    else
      ShowMessage('Error Update: Probl�me de connexion au serveur de mise � jour.');
    exit;
  end;
  lastversion := ReadFromFile(lastverFile);
  if (Pos(CurrentApplicationVersion, lastversion) = 1) and (isDev = isDevVersion ) then
  begin
    if isSilent then
      //Form1.MemoLogs.Lines.Add('Vous �tes � jour')
    else
      ShowMessage('Vous �tes � jour')
  end
  else begin
    if lastversion = '' then
    begin
      if isSilent then
        //Form1.MemoLogs.Lines.Add('Le t�l�chargement a �chou�.')
      else
        ShowMessage('Le t�l�chargement a �chou�.'+#13+url);

      exit;
    end;
    msg := 'Mise � jour version "'+lastversion+'" disponible :)'+#13+'Mettre � jour?';
    if (isSilent and Form1.CheckBoxUpdateSilent.Checked) or (MessageDlg(PChar(msg),  mtConfirmation, [mbYes, mbNo], 0) = IDYES) then
    begin
      url := urlUpdate+lastversion+suffixe+'.exe';
      lastverFile := ExtractFilePath(Application.ExeName)+installDirectoryPath+'DNSRelayServerSetup_'+lastversion+'.exe';
      downloadFile(url, lastverFile);
      if FileExists(lastverFile) and (FileSize(lastverFile) > 0) then
      begin
        //if (isSilent and Form1.CheckBoxUpdateSilent.Checked) or (MessageDlg(PChar('Le serveur va red�marrer. Continuer?'),  mtConfirmation, [mbYes, mbNo], 0) = IDYES) then
        //begin
          if Form1.CheckBoxUpdateSilent.Checked then
            ExecAndWait(lastverFile, '/S', SW_HIDE)
          else
            ExecAndWait(lastverFile, '', SW_SHOWNORMAL);

          canClose := True;
          Form1.FormCloseQuery(nil, canClose);
          KillTask('python.exe');
          KillTask(ExtractFileName(Application.ExeName));
          Application.Terminate;

        //end;
      end
      else begin
        if isSilent then
          //Form1.MemoLogs.Lines.Add('La mise � jour � �chou�.')
        else
          ShowMessage('La mise � jour � �chou�. '+#13+url);
      end;
    end;
  end;
end;

procedure TForm1.CheckBoxUpdateClick(Sender: TObject);
begin
  if isApplicationLoading then exit;

  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkupdate.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkupdate.cfg');

  setDNSOnBoot(not CheckBoxStartWithWindows.Checked);

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
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
  txt: String;
begin
  txt := ReadFromFile(DataDirectoryPath + 'CheckListBoxDNSRelayIP.cfg');

  CheckListBoxDNSRelayIP.Clear;
  if GetNetworkInterfaces(net) then
  begin
    for i := 0 to High (net) do
    begin
      if net[i].AddrIP <> '127.0.0.1' then
      begin
        CheckListBoxDNSRelayIP.Items.Add(net[i].AddrIP);
        CheckListBoxDNSRelayIP.Checked[CheckListBoxDNSRelayIP.Items.Count -1] := Pos(net[i].AddrIP, txt) = 0;
      end;
    end;
  end;
end;

procedure TForm1.TimerAfterFormCreateTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  ComboBoxPosLogsSelect(ComboBoxPosLogs);
  ComboBoxCurrentTheme.OnSelect := ComboBoxCurrentThemeSelect;
  SpinEditContraste.OnChange := ComboBoxCurrentThemeSelect;
  TimerHideMessage.Enabled := False;
  TimerSaveChange.Enabled := False;
  if startedInBackground then exit;
  Afficher1Click(nil);       
  PanelRestart.Visible := False;
  PanelMessage.Visible := False;

  {
  Application.ShowMainForm := true;
  Form1.BringToFront;
  Application.BringToFront;
  Self.Show;
  BringToFront;
  SetFocus;
  FlashWindow(Application.Handle, true);
  ShowWindow(Application.Handle, SW_SHOW);
  }
end;

procedure TForm1.CheckBoxUpdateIntervallClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkupdateIntervall.cfg', '1')
  else DeleteFile(DataDirectoryPath + 'checkupdateIntervall.cfg');

  TimerCheckUpdate.Interval := SpinTimeCheckUpdate.Value * 60 * 60 * 1000;
  TimerCheckUpdate.Enabled := TCheckBox(Sender).Checked;

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;

procedure TForm1.CheckBoxUpdateSilentClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkupdateSilent.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkupdateSilent.cfg');

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
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
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkAllowModifyNetcard.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAllowModifyNetcard.cfg');

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.CheckBoxAutostartDNSOnBootClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkAutostartDNS.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAutostartDNS.cfg');

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.ButtonNetCardIntegrationClick(Sender: TObject);
var
  i: Integer;
  dnslist: String;
  //net: tNetworkInterfaceList;
begin
  //if Sender <> nil then
  //begin
    //ToolButton8.Down := False;
    //ToolButton3.Down := True;
    //ToolButton6Click(nil);
  //end;
  //setIPToDHCP();


  dnslist := '';
  for i := 0 to CheckListBoxDNSRelayIP.Items.Count - 1 do
  begin
    if CheckListBoxDNSRelayIP.Checked[i]
    and (CheckListBoxDNSRelayIP.Items.Strings[i] <> '127.0.0.1') then
    begin
      if dnslist <> '' then dnslist := dnslist + ' ';
      dnslist := dnslist + CheckListBoxDNSRelayIP.Items.Strings[i];
    end
  end;
  
  //setDNS(CBoxDNSServerSlaveIP.Text);
  MemoLogs.Lines.Add('Set DNS '+dnslist);
  setDNS(dnslist);
  setDNSOnBoot(not CheckBoxStartWithWindows.Checked);
end;

procedure TForm1.ButtonNetCardDesintegrationClick(Sender: TObject);
var
  i: Integer;
  dns: string;
begin
  if Sender <> nil then
  begin
    ToolButton8.Down := False;
    //ToolButton3.Down := True;
    ToolButton6Click(nil);
  end;
  MemoLogs.Lines.Add('Go to DHCP');
  dns := '';
  for i := 0 to ConfigDNSMaster.Count - 1 do
  begin
    if dns <> '' then dns := dns + ' ';
    dns := dns + ConfigDNSMaster[i];
  end;
  setDNS(dns);
  //setDNS('');
  setDNSOnBoot(False);
  //setIPToDHCP();
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
  //On prend les coordonn�es du curseur de souris...
  GetCursorPos(Point);

  //Cette ensemble de proc�dure permet de simuler le click.
  //Un click gauche est constitu� de deux clicks : quand le
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
  //Systray.EnleveIconeTray;
  //Systray.AjouteIconeTray(Handle,Application.Icon.Handle,Self.Caption);
end;

procedure TForm1.CheckBoxSwitchThemeClick(Sender: TObject);
begin
{
  if TCheckbox(Sender).Checked then
    //setTheme(clWhite, clBlack)
    setTheme(RGB(250,250,250), RGB(10,10,10))
  else
    setTheme(clBlack, clWhite);
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkSwitchTheme.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkSwitchTheme.cfg');
    }
end;



procedure TForm1.CheckBoxAlertEventsKnownClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkAlertEventsKnow.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAlertEventsKnow.cfg');
  connus1.Checked := CheckBoxAlertEventsKnown.Checked;

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;

procedure TForm1.CheckBoxAlertEventsUnknownClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkAlertEventsUnknown.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAlertEventsUnknown.cfg');

  inconnus1.Checked := CheckBoxAlertEventsUnknown.Checked;

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;

procedure TForm1.CheckBoxAlertEventDisallowedClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkAlertEventDisallowed.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAlertEventDisallowed.cfg');
  bloques1.Checked := CheckBoxAlertEventDisallowed.Checked;

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
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

procedure TForm1.inconnus1Click(Sender: TObject);
begin
  CheckBoxAlertEventsUnknown.Checked := not CheckBoxAlertEventsUnknown.Checked;
  CheckBoxAlertEventsUnknownClick(CheckBoxAlertEventsUnknown);
end;

procedure TForm1.connus1Click(Sender: TObject);
begin
  CheckBoxAlertEventsKnown.Checked := not CheckBoxAlertEventsKnown.Checked;
  CheckBoxAlertEventsKnownClick(CheckBoxAlertEventsKnown);
end;

procedure TForm1.bloques1Click(Sender: TObject);
begin
  CheckBoxAlertEventDisallowed.Checked := not CheckBoxAlertEventDisallowed.Checked;
  CheckBoxAlertEventDisallowedClick(CheckBoxAlertEventDisallowed);
end;



procedure TForm1.Ajouter2Click(Sender: TObject);
var ip: string;
begin
  ip := '';
  if not InputQuery('Add Blackword', 'Interdit tous les domaines comportant le mot suivant', ip) then exit;
  ListBoxBlacklist.Items.Add(ip);
  ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
  if isServerStarted then PanelRestart.Visible := True;
end;

procedure TForm1.Modifier3Click(Sender: TObject);
var
  i:integer;
  txt:string;
begin
  i := ListBoxBlacklist.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord s�lectionner un �l�ment dans la liste');
    exit;
  end;
  txt := ListBoxBlacklist.Items.Strings[i];
  if not InputQuery('Update Blackword', txt, txt) then exit;
  ListBoxBlacklist.Items.Strings[i] := txt;
  ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
  if isServerStarted then PanelRestart.Visible := True;
end;

procedure TForm1.Supprimer2Click(Sender: TObject);
var
  i:integer;
  txt:string;
begin
  i := ListBoxBlacklist.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord s�lectionner un �l�ment dans la liste');
    exit;
  end;
  txt := ListBoxBlacklist.Items.Strings[i];
  MessageBeep(MB_OK);
  if MessageDlg(Pchar('Effacer "' + txt + '"?'),mtConfirmation, mbOKCancel, 0)  = mrOK then
  begin
    ListBoxBlacklist.DeleteSelected;
    ListBoxBlacklist.ItemIndex := 1 - 1;
    ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
    if isServerStarted then PanelRestart.Visible := True;
    //ShowMessage('Effac�');
  end;
end;

procedure TForm1.ListBoxBlacklistKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then Supprimer2Click(nil);
end;

procedure TForm1.ButtonClosePanelRestartClick(Sender: TObject);
begin
  PanelRestart.Visible := False;
end;

procedure TForm1.ButtonApplyChangesClick(Sender: TObject);
begin
  PanelRestart.Visible := False;
  KillTask('python.exe');
  //ButtonStartClick(nil);
end;

procedure TForm1.PageControl1DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
  Control.Canvas.Brush.Color := Color;
  if Active then
  begin
    Control.Canvas.TextOut (Rect.Left +6, Rect.Top +5, (Control as
TPageControl).Pages[TabIndex].Caption);
  end
  else
    Control.Canvas.TextOut (Rect.Left +2, Rect.Top +4, (Control as
TPageControl).Pages[TabIndex].Caption);
{
  Control.Canvas.Brush.Color := Color;
  if Active then
  begin
    Control.Canvas.TextOut (Rect.Left +6, Rect.Top +5, (Control as
TPageControl).Pages[TabIndex].Caption);
    Control.Canvas.Pen.Color := Color;
    Control.Canvas.MoveTo (Rect.Left +1, Rect.Bottom -2);
    Control.Canvas.LineTo (Rect.Right,   Rect.Bottom -2);
  end
  else
    Control.Canvas.TextOut (Rect.Left +2, Rect.Top +4, (Control as
TPageControl).Pages[TabIndex].Caption);
} 
end;



procedure TForm1.LabelToCheckboxClick(Sender: TObject);
var
  Checkbox: TCheckbox;
begin
  Checkbox := TCheckbox(TLabel(Sender).FocusControl);
  Checkbox.Checked := not Checkbox.Checked;
  Checkbox.OnClick(Checkbox);
  Checkbox.SetFocus;
end;

procedure TForm1.LabelCheckboxMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsUnderline];
end;

procedure TForm1.LabelCheckboxMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
end;



procedure TForm1.ButtonMenuThemeClick(Sender: TObject);
var
  Pos:TPoint;
begin
  GetCursorPos(Pos);
  PopupMenuTheme.Popup(Pos.X,Pos.Y);
end;


procedure TForm1.SpeedButtonClosePanelUpdateThemeClick(Sender: TObject);
begin
  GroupBoxUpdateTheme.Visible := False;
end;

procedure TForm1.ComboBoxCurrentThemeSelect(Sender: TObject);
var
  i:Integer;
  ThemesList, s:TStringList;
begin


  i := ComboBoxCurrentTheme.ItemIndex;
  if i = -1 then exit;

  ThemesList := TStringList.Create;
  if FileExists(DataDirectoryPath + 'ThemeListData.cfg') then
    ThemesList := ReadFileToStringList(DataDirectoryPath + 'ThemeListData.cfg')
  else begin
    // Create first list of themes
    ThemesList.Add('0,0,0,255,255,255');
    ThemesList.Add('0,0,0,210,226,227');
    ThemesList.Add('250,250,250,30,30,30');
    ThemesList.Add('0,255,0,0,0,0');
    ThemesList.Add('0,255,255,0,0,0');
    ThemesList.Add('0,0,0,255,0,255');
    ThemesList.Add('255,255,255,168,0,168');
    ThemesList.Add('255,255,255,0,0,160');
    ThemesList.Add('0,0,0,0,221,221');
    ThemesList.Add('0,0,0,192,192,192');
    ThemesList.Add('0,0,0,238,238,238');
    WriteStringListInFile(DataDirectoryPath + 'ThemeListData.cfg', ThemesList);

    ComboBoxCurrentTheme.Clear;
    ComboBoxCurrentTheme.Items.Add('White');
    ComboBoxCurrentTheme.Items.Add('Cream');
    ComboBoxCurrentTheme.Items.Add('Black');
    ComboBoxCurrentTheme.Items.Add('Matrix');
    ComboBoxCurrentTheme.Items.Add('DarkBlue');
    ComboBoxCurrentTheme.Items.Add('Pink');
    ComboBoxCurrentTheme.Items.Add('DarkPink');
    ComboBoxCurrentTheme.Items.Add('Blue');
    ComboBoxCurrentTheme.Items.Add('BlueSky');
    ComboBoxCurrentTheme.Items.Add('Gray');
    ComboBoxCurrentTheme.Items.Add('Sylver');
    ComboBoxCurrentTheme.Items.SaveToFile(DataDirectoryPath + 'ThemeNames.cfg');
    ComboBoxCurrentTheme.ItemIndex := 0;
    //WriteInFile(DataDirectoryPath + 'ThemeSelected.cfg', IntToStr(i));

  end;

  if (i >= 0) and (i < ThemesList.Count) then
  begin
    s := TStringList.Create;
    SplitStr(ThemesList.Strings[i], ',', s);
    if s.Count >= 6 then
    begin
      setTheme(RGB(StrToInt(s[0]),StrToInt(s[1]),StrToInt(s[2])), RGB(StrToInt(s[3]),StrToInt(s[4]),StrToInt(s[5])));
      //WriteInFile(DataDirectoryPath + 'ThemeSelected.cfg', IntToStr(i));
      if Notebook1.PageIndex = 0 then
      begin
        Notebook1.PageIndex := 4;
        Notebook1.PageIndex := 0;
        ComboBoxCurrentTheme.SetFocus;
      end;
    end;
  end;
  
  if isApplicationLoading then exit;
  WriteInFile(DataDirectoryPath + 'contrasteTextarea.cfg', IntToStr(SpinEditContraste.Position));
  WriteInFile(DataDirectoryPath + 'ThemeSelected.cfg', IntToStr(ComboBoxCurrentTheme.ItemIndex));

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;

end;



procedure TForm1.Ajouter3Click(Sender: TObject);
begin
  LabelUpdateTheme.Caption := PChar('Ajouter un th�me');
  EditThemeName.Text := '';
  GroupBoxUpdateTheme.Hint := 'add';
  GroupBoxUpdateTheme.Visible := True;
end;

procedure TForm1.Modifier4Click(Sender: TObject);
begin
  LabelUpdateTheme.Caption := PChar('Modifier un th�me');
  EditThemeName.Text := ComboBoxCurrentTheme.Text;
  GroupBoxUpdateTheme.Hint := IntToStr(ComboBoxCurrentTheme.ItemIndex);
  GroupBoxUpdateTheme.Visible := True;
end;

procedure TForm1.Supprimer3Click(Sender: TObject);
var
  i: Integer;
  ThemesList:TStringList;
begin
  if MessageDlg(PChar('Effacer le theme ['+ComboBoxCurrentTheme.Text+']?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
  if ComboBoxCurrentTheme.Items.Count <= 1 then
  begin
    ShowMessage('Vous ne pouvez pas effacer le dernier th�me. Veuillez en cr�er un autre avant d''effacer celui-ci.');
    exit;
  end;

  ThemesList := TStringList.Create;
  if FileExists(DataDirectoryPath + 'ThemeListData.cfg') then
    ThemesList := ReadFileToStringList(DataDirectoryPath + 'ThemeListData.cfg');


  if FileExists(DataDirectoryPath + 'ThemeNames.cfg') then
    ComboBoxCurrentTheme.Items.LoadFromFile(DataDirectoryPath + 'ThemeNames.cfg');

  ComboBoxCurrentTheme.ItemIndex := 0;
  if FileExists(DataDirectoryPath + 'ThemeSelected.cfg') then
    ComboBoxCurrentTheme.ItemIndex := StrToInt(ReadFromFile(DataDirectoryPath + 'ThemeSelected.cfg'));

    i := ComboBoxCurrentTheme.ItemIndex;
    if (i >= ThemesList.Count) or (i < 0) then
    begin
      if MessageDlg(PChar('Erreur avec les fichiers template. Restaurer les templates � leur origine?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
      if FileExists(DataDirectoryPath + 'ThemeListData.cfg') then DeleteFile(DataDirectoryPath + 'ThemeListData.cfg');
      if FileExists(DataDirectoryPath + 'ThemeNames.cfg') then DeleteFile(DataDirectoryPath + 'ThemeNames.cfg');
      if FileExists(DataDirectoryPath + 'ThemeSelected.cfg') then DeleteFile(DataDirectoryPath + 'ThemeSelected.cfg');
      ComboBoxCurrentThemeSelect(nil);
    end
    else begin
      ThemesList.Delete(i);
      ComboBoxCurrentTheme.DeleteSelected;
    end;

  WriteStringListInFile(DataDirectoryPath + 'ThemeListData.cfg', ThemesList);
  ComboBoxCurrentTheme.Items.SaveToFile(DataDirectoryPath + 'ThemeNames.cfg');
  ComboBoxCurrentTheme.ItemIndex := 0;
  ComboBoxCurrentThemeSelect(ComboBoxCurrentTheme);
  GroupBoxUpdateTheme.Visible := False;



end;


procedure TForm1.ButtonUpdateThemeClick(Sender: TObject);
var
  i: Integer;
  ThemesList:TStringList;
  txt :String;
  c: TColor;
  fr,fg,fb,br,bg,bb:string;
begin
  ThemesList := TStringList.Create;
  if FileExists(DataDirectoryPath + 'ThemeListData.cfg') then
    ThemesList := ReadFileToStringList(DataDirectoryPath + 'ThemeListData.cfg');


  if FileExists(DataDirectoryPath + 'ThemeNames.cfg') then
    ComboBoxCurrentTheme.Items.LoadFromFile(DataDirectoryPath + 'ThemeNames.cfg');

  ComboBoxCurrentTheme.ItemIndex := 0;
  if FileExists(DataDirectoryPath + 'ThemeSelected.cfg') then
    ComboBoxCurrentTheme.ItemIndex := StrToInt(ReadFromFile(DataDirectoryPath + 'ThemeSelected.cfg'));



  c := ShapeColorText.Brush.Color;

  fr := IntToStr(getRValue(ColorToRGB(c)));
  fg := IntToStr(getGValue(ColorToRGB(c)));
  fb := IntToStr(getBValue(ColorToRGB(c)));

  c := ShapeColorBackground.Brush.Color;

  br := IntToStr(getRValue(ColorToRGB(c)));
  bg := IntToStr(getGValue(ColorToRGB(c)));
  bb := IntToStr(getBValue(ColorToRGB(c)));

  txt := fr+','+fg+','+fb+','+br+','+bg+','+bb;
  i := 0;
  if GroupBoxUpdateTheme.Hint = 'add' then
  begin
    ThemesList.Add(txt);
    ComboBoxCurrentTheme.Items.Add(EditThemeName.Text);
  end else
  begin
    i := StrtoInt(GroupBoxUpdateTheme.Hint);
    if (i >= ThemesList.Count) or (i < 0) then
    begin
      if MessageDlg(PChar('Erreur avec les fichiers template. Restaurer les templates � leur origine?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
      if FileExists(DataDirectoryPath + 'ThemeListData.cfg') then DeleteFile(DataDirectoryPath + 'ThemeListData.cfg');
      if FileExists(DataDirectoryPath + 'ThemeNames.cfg') then DeleteFile(DataDirectoryPath + 'ThemeNames.cfg');
      if FileExists(DataDirectoryPath + 'ThemeSelected.cfg') then DeleteFile(DataDirectoryPath + 'ThemeSelected.cfg');
      ComboBoxCurrentThemeSelect(nil);
    end
    else begin
      ThemesList.Strings[i] := txt;
      ComboBoxCurrentTheme.Items.Strings[i] := EditThemeName.Text;
    end;
  end;
  WriteStringListInFile(DataDirectoryPath + 'ThemeListData.cfg', ThemesList);
  ComboBoxCurrentTheme.Items.SaveToFile(DataDirectoryPath + 'ThemeNames.cfg');
  if GroupBoxUpdateTheme.Hint = 'add' then
    ComboBoxCurrentTheme.ItemIndex := ComboBoxCurrentTheme.Items.Count - 1
  else
    ComboBoxCurrentTheme.ItemIndex := i;
  GroupBoxUpdateTheme.Visible := False;
end;

procedure TForm1.Restaurer1Click(Sender: TObject);
begin
  if MessageDlg(PChar('Restaurer les templates � leur origine?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
  if FileExists(DataDirectoryPath + 'ThemeListData.cfg') then DeleteFile(DataDirectoryPath + 'ThemeListData.cfg');
  if FileExists(DataDirectoryPath + 'ThemeNames.cfg') then DeleteFile(DataDirectoryPath + 'ThemeNames.cfg');
  if FileExists(DataDirectoryPath + 'ThemeSelected.cfg') then DeleteFile(DataDirectoryPath + 'ThemeSelected.cfg');
  ComboBoxCurrentThemeSelect(nil);
  ComboBoxCurrentThemeSelect(nil);
end;



procedure TForm1.ShapeColorTextMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ColorDialog1.Color := ShapeColorText.Brush.Color;
  if not ColorDialog1.Execute then exit;
  setThemeFont(ColorDialog1.Color);
  ShapeColorText.Brush.Color := ColorDialog1.Color;
  Notebook1.PageIndex := 4;
  Notebook1.PageIndex := 0;
end;

procedure TForm1.ShapeColorBackgroundMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ColorDialog1.Color := ShapeColorBackground.Brush.Color;
  if not ColorDialog1.Execute then exit;
  setThemeBg(ColorDialog1.Color);
  ShapeColorBackground.Brush.Color := ColorDialog1.Color;
  Notebook1.PageIndex := 4;
  Notebook1.PageIndex := 0;
end;



procedure TForm1.ToolButtonDisplayOrangeClick(Sender: TObject);
begin
  //if MessageDlg(PChar('Voulez-vous effacer les boules rouges de la liste?'+#13#10+'(efface juste l''affichage)'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
  ListViewEraseFromImageIndex(ListView1, 3);
end;

procedure TForm1.ToolButtonDisplayGreenClick(Sender: TObject);
begin
  //if MessageDlg(PChar('Voulez-vous effacer les boules vertes de la liste?'+#13#10+'(efface juste l''affichage)'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
  ListViewEraseFromImageIndex(ListView1, 1);
end;

procedure TForm1.ToolButtonDisplayGrayClick(Sender: TObject);
begin
  //if MessageDlg(PChar('Voulez-vous effacer les boules grises de la liste?'+#13#10+'(efface juste l''affichage)'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
  ListViewEraseFromImageIndex(ListView1, 0);
end;

procedure TForm1.ButtonClearLogsClick(Sender: TObject);
begin
  //if MessageDlg(PChar('Voulez-vous effacer les logs?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
  MemoLogs.Clear;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if ListView1.Columns.Count < 2 then exit;
  ListView1.Columns.Items[1].Width := 95;
  ListView1.Columns.Items[0].Width := ListView1.Width - ListView1.Columns.Items[1].Width - 25;
end;

procedure TForm1.ComboBoxPosLogsSelect(Sender: TObject);
begin
  WriteInFile(DataDirectoryPath + 'PositionLogs.cfg', IntToStr(ComboBoxPosLogs.ItemIndex));

{
  if Sender = nil then
  begin
    Panel1.Visible := True;
    Splitter1.Visible := True;
  end;
  }
  if ComboBoxPosLogs.ItemIndex = 0 then
  begin
    GroupBox5.Align := alTop;
    Splitter1.Align := alTop;

    GroupBox5.Visible := True;
    Splitter1.Visible := True;
    GroupBox5.Height := ((Form1.height - Panel5.Height) div 2) - Splitter1.Height;
    GroupBox5.Width := Form1.Width;
    Panel1.Height := ((Form1.height - Panel5.Height) div 2) - Splitter1.Height;
    Panel1.Width := Form1.Width;
    Splitter1.Top := ((Form1.height - Panel5.Height) div 2);
    if Splitter1.Visible then
    begin
      Splitter1.Visible := False;
      Splitter1.Visible := True;
    end;
  end;
  if ComboBoxPosLogs.ItemIndex = 1 then
  begin
    GroupBox5.Align := alBottom;
    Splitter1.Align := alBottom;

    GroupBox5.Visible := True;
    Splitter1.Visible := True;
    GroupBox5.Height := ((Form1.height - Panel5.Height) div 2) - Splitter1.Height;
    GroupBox5.Width := Form1.Width;
    Panel1.Height := ((Form1.height - Panel5.Height) div 2) - Splitter1.Height;
    Panel1.Width := Form1.Width;
    Splitter1.Top := ((Form1.height - Panel5.Height) div 2);
    if Splitter1.Visible then
    begin
      Splitter1.Visible := False;
      Splitter1.Visible := True;
    end;
  end;
  if ComboBoxPosLogs.ItemIndex = 2 then
  begin
    Splitter1.Align := alLeft;
    GroupBox5.Align := alLeft;

    GroupBox5.Visible := True;
    Splitter1.Visible := True;
    GroupBox5.Width := (Form1.Width div 2) - Splitter1.Width;
    GroupBox5.Height := Form1.height - Panel5.Height;
    Panel1.Width := GroupBox5.Width;
    Panel1.Height := Form1.Height - Panel5.Height;
    Splitter1.Left := (Form1.Width div 2);
    if Splitter1.Visible then
    begin
      Splitter1.Visible := False;
      Splitter1.Visible := True;
    end;
  end;
  if ComboBoxPosLogs.ItemIndex = 3 then
  begin
    GroupBox5.Align := alRight;
    Splitter1.Align := alRight;

    GroupBox5.Visible := True;
    Splitter1.Visible := True;
    GroupBox5.Width := (Form1.Width div 2) - Splitter1.Width;
    GroupBox5.Height := Form1.height - Panel5.Height;
    Panel1.Width := GroupBox5.Width;
    Panel1.Height := Form1.Height - Panel5.Height;
    Splitter1.Left := (Form1.Width div 2);
    //Splitter1.Left := 0;
    if Splitter1.Visible then
    begin
      Splitter1.Visible := False;
      Splitter1.Visible := True;
    end;
  end;
  if ComboBoxPosLogs.ItemIndex = 4 then
  begin
    GroupBox5.Visible := False;
    Splitter1.Visible := False;
    ResizePanelConfig();
  end;
  Form1.Height := Form1.Height + 1;
  Form1.Height := Form1.Height - 1;
  Application.ProcessMessages;
end;

procedure TForm1.DsactiverlefiltragedufichierHost1Click(Sender: TObject);
begin
  ButtonDisableHost.Down := not ButtonDisableHost.Down;
  ButtonDisableHostClick(ButtonDisableHost);
  Afficher1Click(nil);
  RefreshModeFilter();
end;

procedure TForm1.DsactiverlefiltrageBlackword1Click(Sender: TObject);
begin
  ButtonDisableBlackhost.Down := not ButtonDisableBlackhost.Down;
  ButtonDisableBlackhostClick(ButtonDisableBlackhost);
  Afficher1Click(nil);
  RefreshModeFilter();

end;



procedure TForm1.PageControl1Change(Sender: TObject);
begin
  // bug?
  //ResizePanelConfig();
end;


procedure TForm1.ToolButtonBlockAllClick(Sender: TObject);
var
  Pos:TPoint;
begin
  GetCursorPos(Pos);
  PopupMenuForAllDNSRules.Popup(Pos.X,Pos.Y);
  ToolButtonBlockAll.Down := FileExists(DataDirectoryPath + 'disableAll.cfg')
  or (FileExists(DataDirectoryPath + 'disableHost.cfg')
  and FileExists(DataDirectoryPath + 'disableBlackhost.cfg'));
end;




procedure TForm1.ButtonDisableHostClick(Sender: TObject);
begin
  PanelRestart.Visible := True;
  //TToolButton(Sender).Down := not TToolButton(Sender).Down;

  if FileExists(DataDirectoryPath + 'disableHost.cfg') then
  begin
    MemoLogs.Lines.Add('Activation du fichier Host.');
    DeleteFile(DataDirectoryPath + 'disableHost.cfg');
    TToolButton(Sender).Down := False;
  end
  else begin
    MemoLogs.Lines.Add('D�sactivation du fichier Host.');
    WriteInFile(DataDirectoryPath + 'disableHost.cfg', '1');
    TToolButton(Sender).Down := True;
  end;
  DsactiverlefiltragedufichierHost1.Checked := TToolButton(Sender).Down;
end;



procedure TForm1.ButtonDisableBlackhostClick(Sender: TObject);
begin
  PanelRestart.Visible := True;
  if FileExists(DataDirectoryPath + 'disableBlackhost.cfg') then
  begin
    MemoLogs.Lines.Add('Activation du filtre Blackwords.');
    DeleteFile(DataDirectoryPath + 'disableBlackhost.cfg');
    TToolButton(Sender).Down := False;
  end
  else begin
    MemoLogs.Lines.Add('D�sactivation du filtre Blackwords.');
    WriteInFile(DataDirectoryPath + 'disableBlackhost.cfg', '1');

    TToolButton(Sender).Down := True;
  end;
  DsactiverlefiltrageBlackword1.Checked := TToolButton(Sender).Down;
end;

procedure TForm1.RefreshModeFilter();
begin
  AllowAll.Checked := FileExists(DataDirectoryPath + 'disableHost.cfg') and FileExists(DataDirectoryPath + 'disableBlackhost.cfg');
  DisallowAll.Checked := FileExists(DataDirectoryPath + 'disableAll.cfg');
  ButtonDisableBlackhost.Down := FileExists(DataDirectoryPath + 'disableBlackhost.cfg');
  ButtonDisableHost.Down := FileExists(DataDirectoryPath + 'disableHost.cfg');
  Toutnormale1.Checked := not ButtonDisableBlackhost.Down
                      and not ButtonDisableHost.Down
                      and not AllowAll.Checked
                      and not DisallowAll.Checked
                      and not Toutnormale1.Checked;
  Toutnormal1.Checked := Toutnormale1.Checked;
  if isServerStarted then ButtonApplyChangesClick(nil);
end;


procedure TForm1.AllowAllClick(Sender: TObject);
begin
  if not FileExists(DataDirectoryPath + 'disableHost.cfg') then
    WriteInFile(DataDirectoryPath + 'disableHost.cfg', '1');

  if not FileExists(DataDirectoryPath + 'disableBlackhost.cfg') then
    WriteInFile(DataDirectoryPath + 'disableBlackhost.cfg', '1');

  if FileExists(DataDirectoryPath + 'disableAll.cfg') then
    DeleteFile(DataDirectoryPath + 'disableAll.cfg');

  MemoLogs.Lines.Add('Mode "tout autoriser"');
  RefreshModeFilter();

end;



procedure TForm1.ToutNormal1Click(Sender: TObject);
begin
  if FileExists(DataDirectoryPath + 'disableAll.cfg') then
    DeleteFile(DataDirectoryPath + 'disableAll.cfg');

  if FileExists(DataDirectoryPath + 'disableHost.cfg') then
    DeleteFile(DataDirectoryPath + 'disableHost.cfg');

  if FileExists(DataDirectoryPath + 'disableBlackhost.cfg') then
    DeleteFile(DataDirectoryPath + 'disableBlackhost.cfg');


  MemoLogs.Lines.Add('Mode normal');

  AllowAll.Checked := False;
  toutbloquer1.Checked := False;
  ToolButtonBlockAll.Down := False;
  ButtonDisableBlackhost.Down := False;
  ButtonDisableHost.Down := False;
  DsactiverlefiltragedufichierHost1.Checked := False;
  DsactiverlefiltrageBlackword1.Checked := False;
  Toutautoriser1.Checked := False;

  RefreshModeFilter();
end;


procedure TForm1.DisallowAllClick(Sender: TObject);
begin
  if not FileExists(DataDirectoryPath + 'disableAll.cfg') then
    WriteInFile(DataDirectoryPath + 'disableAll.cfg', '1');

  if FileExists(DataDirectoryPath + 'disableHost.cfg') then
    DeleteFile(DataDirectoryPath + 'disableHost.cfg');

  if FileExists(DataDirectoryPath + 'disableBlackhost.cfg') then
    DeleteFile(DataDirectoryPath + 'disableBlackhost.cfg');


  MemoLogs.Lines.Add('Mode "tout bloquer"');

  AllowAll.Checked := False;
  toutbloquer1.Checked := not AllowAll.Checked;
  ToolButtonBlockAll.Down := True;
  DsactiverlefiltragedufichierHost1.Checked := AllowAll.Checked;
  DsactiverlefiltrageBlackword1.Checked := AllowAll.Checked;
  Toutautoriser1.Checked := AllowAll.Checked;

  RefreshModeFilter();

end;





procedure TForm1.AjouterBlackworkds1Click(Sender: TObject);
var
  domain: string;
begin
  SelectedListItem := ListView1.Selected;
  if not Assigned(SelectedListItem) then exit;
  domain := SelectedListItem.Caption; //SelectedListItem.SubItems.Strings[0];
  //txt := InputBox('Add Blackword', 'Interdit tous les domaines comportant le mot suivant', domain);
  if not InputQuery('Add Blackword', 'Interdit tous les domaines comportant le mot suivant', domain) then exit;
  ListBoxBlacklist.Items.Add(domain);
  ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
  if isServerStarted then PanelRestart.Visible := True;
end;

procedure TForm1.ToolButtonMenuLogsClick(Sender: TObject);
var
  Pos:TPoint;
begin
  GetCursorPos(Pos);
  PopupMenuLogs.Popup(Pos.X,Pos.Y);
end;

procedure TForm1.Afficherenhaut1Click(Sender: TObject);
begin
  ComboBoxPosLogs.ItemIndex := 0;
  ComboBoxPosLogsSelect(nil);
end;

procedure TForm1.Afficherenbas1Click(Sender: TObject);
begin
  ComboBoxPosLogs.ItemIndex := 1;
  ComboBoxPosLogsSelect(nil);
end;

procedure TForm1.Affichergauche1Click(Sender: TObject);
begin
  ComboBoxPosLogs.ItemIndex := 2;
  ComboBoxPosLogsSelect(nil);
end;

procedure TForm1.Afficherdroite1Click(Sender: TObject);
begin
  ComboBoxPosLogs.ItemIndex := 3;
  ComboBoxPosLogsSelect(nil);
end;


procedure TForm1.Masquer2Click(Sender: TObject);
begin
  ComboBoxPosLogs.ItemIndex := 4;
  ComboBoxPosLogsSelect(nil);
end;

procedure TForm1.Activertouteslesalertes1Click(Sender: TObject);
begin
  CheckBoxAlertEventsUnknown.Checked := True;
  CheckBoxAlertEventsKnown.Checked := CheckBoxAlertEventsUnknown.Checked;
  CheckBoxAlertEventDisallowed.Checked := CheckBoxAlertEventsUnknown.Checked;
  CheckBoxAlertEventsUnknownClick(CheckBoxAlertEventsUnknown);
  CheckBoxAlertEventsKnownClick(CheckBoxAlertEventsKnown);
  CheckBoxAlertEventDisallowedClick(CheckBoxAlertEventDisallowed);
end;

procedure TForm1.Dsactivertouteslesalertes1Click(Sender: TObject);
begin
  CheckBoxAlertEventsUnknown.Checked := False;
  CheckBoxAlertEventsKnown.Checked := CheckBoxAlertEventsUnknown.Checked;
  CheckBoxAlertEventDisallowed.Checked := CheckBoxAlertEventsUnknown.Checked;
  CheckBoxAlertEventsUnknownClick(CheckBoxAlertEventsUnknown);
  CheckBoxAlertEventsKnownClick(CheckBoxAlertEventsKnown);
  CheckBoxAlertEventDisallowedClick(CheckBoxAlertEventDisallowed);
end;

//https://download.sysinternals.com/files/TCPView.zip

procedure TForm1.DNS1Click(Sender: TObject);
begin
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 0;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
  Afficher1Click(nil);
end;

procedure TForm1.DNSMatres1Click(Sender: TObject);
begin                     
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 1;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
  Afficher1Click(nil);
end;

procedure TForm1.Misejour1Click(Sender: TObject);
begin                                        
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 2;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
  Afficher1Click(nil);
end;

procedure TForm1.Carterseau1Click(Sender: TObject);
begin                             
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 3;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
  Afficher1Click(nil);
end;

procedure TForm1.Affichage1Click(Sender: TObject);
begin                                   
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 4;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
  Afficher1Click(nil);
end;

procedure TForm1.Alertes2Click(Sender: TObject);
begin                          
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 5;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
  Afficher1Click(nil);
end;

procedure TForm1.Relancerlapplication1Click(Sender: TObject);
var
  i: Integer;
  param: string;
  canclose: Boolean;
begin
  param := '';
  for i:=1 to ParamCount() do
    param := param +' '+ParamStr(i);
  ExecAndBringToFront(Application.ExeName, param);
  canClose := True;
  FormCloseQuery(nil, canClose);
  //KillTask(ExtractFileName(Application.ExeName));
  KillProcess(Self.Handle);
  Application.Terminate;
end;

procedure TForm1.SpinEditAlertDurationChange(Sender: TObject);
begin
  TimerSaveChange.Enabled := False;
  TimerSaveChange.Enabled := True;
  if TSpinEdit(Sender).Value < 3 then TSpinEdit(Sender).Value := 3; 
end;

procedure TForm1.SpeedButtonCloseMessageClick(Sender: TObject);
begin
  PanelMessage.Visible := False;
end;

procedure TForm1.TimerHideMessageTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  PanelMessage.Visible := False;
end;

procedure TForm1.CheckListBoxDNSRelayIPClickCheck(Sender: TObject);
begin
  if isServerStarted then PanelRestart.Visible := True;
  TimerSaveChange.Enabled := True;
end;

procedure TForm1.ListView1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  //MemoLogs.Lines.Add(inttostr(Key));
  // 46 = key Del
  if (Key = 46) and (Shift = []) then
  begin
    if MessageDlg(PChar('Bloquer ['+ListView1.Selected.Caption+']?'),  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    begin
      Bloquerledomaine1Click(Bloquerledomaine1);
    end;
  end;     
  // 46 = key Ins
  if (Key = 45) and (Shift = []) then
  begin
    if MessageDlg(PChar('Autoriser ['+ListView1.Selected.Caption+']?'),  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    begin
      Autoriser1Click(Autoriser1);
    end;
  end;

  // Del + Shift
  if (Key = 46) and (Shift = [ssShift]) then AjouterBlackworkds1Click(AjouterBlackworkds1);
  // Ins + Shift
  if (Key = 45) and (Shift = [ssShift]) then Modifier1Click(Modifier1);

end;

procedure TForm1.CheckBoxNoTestDNSMasterClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'CheckBoxNoTestDNSMaster.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'CheckBoxNoTestDNSMaster.cfg');


  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;

procedure TForm1.CheckBoxNoCacheDNSClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'CheckBoxNoCacheDNS.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'CheckBoxNoCacheDNS.cfg');

  PanelRestart.Visible := True;
  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.CheckBoxPureServerClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'CheckBoxPureServer.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'CheckBoxPureServer.cfg');
    
  PanelRestart.Visible := True;
  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ShowMessage('En cours d''impl�mentation :)');
  if FormNetConfig = nil then
    FormNetConfig := TFormNetConfig.Create(Self);
  FormNetConfig.Show;
end;



procedure TForm1.TimerAlertTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  AlertManager.ShowAllAlert(AlertManager.MainListAlert);
  TTimer(Sender).Enabled := True;
end;



procedure TForm1.TimerFadeInTimer(Sender: TObject);
begin     
  SetFormOpacity(Self.Handle, opacity);
  if opacity < 100 then opacity := opacity + 10 else TTimer(Sender).Enabled := False;
end;

procedure TForm1.TimerFadeOutTimer(Sender: TObject);
begin  
  SetFormOpacity(Self.Handle, opacity);
  if opacity > 0 then
    opacity := opacity - 10
  else
  begin
    Top := Screen.Height;
    TTimer(Sender).Enabled := False;
  end;

end;


// ==== Detect Network Interface Change ===
var
  oldNet: tNetworkInterfaceList;


function FindNetworkInterface(net:tNetworkInterface;netList:tNetworkInterfaceList):Boolean;
var
  i: integer;
begin
  for i := 0 to High(netList) do
  begin
    if (netList[i].AddrIP = net.AddrIP)
    and (netList[i].IsInterfaceUp = net.IsInterfaceUp) then
    begin
      result := true;
      exit;
    end;
  end;
  result := false;
end;

procedure TForm1.CheckSystemChangesTimer(Sender: TObject);
var
  i: Integer;
  net: tNetworkInterfaceList;
begin
  if not GetNetworkInterfaces(net) then exit;
  if (oldNet <> nil) and (net <> nil) then
  begin
    for i := 0 to High(net) do
    begin
      if not FindNetworkInterface(net[i], oldNet) then
      begin
        if isServerStarted then
        begin
          ButtonRefreshNetCardClick(nil);
          ButtonApplyChangesClick(nil);
          oldNet := net;
          exit;
        end;
      end;
    end;
    for i := 0 to High(oldNet) do
    begin
      if not FindNetworkInterface(oldNet[i], net) then
      begin
        if isServerStarted then
        begin
          ButtonRefreshNetCardClick(nil);
          ButtonApplyChangesClick(nil);
          oldNet := net;
          exit;
        end;
      end;
    end;
  end;
  oldNet := net;
end;


// ================ Remote access ======== //

procedure TForm1.TimerRemoteAccessTimer(Sender: TObject);
var
  f: string;
begin
  f := DataDirectoryPath + 'action.server.restart.txt';
  if FileExists(f) then
  begin
    DeleteFile(f);
    FormCreate(nil);
    ButtonApplyChangesClick(nil);
    exit;
  end;
  f := DataDirectoryPath + 'action.server.start.txt';
  if FileExists(f) then
  begin
    DeleteFile(f);    
    FormCreate(nil);
    ButtonStartClick(nil);
    exit;
  end;
  f := DataDirectoryPath + 'action.server.stop.txt';
  if FileExists(f) then
  begin
    DeleteFile(f);
    FormCreate(nil);
    ButtonCloseClick(nil);
    exit;
  end;
  f := DataDirectoryPath + 'action.application.reload.txt';
  if FileExists(f) then
  begin
    DeleteFile(f);
    FormCreate(nil);
    exit;
  end;
end;


procedure TForm1.CheckBoxRemoteAccessClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  TimerRemoteAccess.Enabled := TCheckBox(Sender).Checked;

  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'CheckBoxRemoteAccess.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'CheckBoxRemoteAccess.cfg');

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;

procedure TForm1.ButtonInstallScriptWebAdminClick(Sender: TObject);
var PathScript: string;
begin
  ShowMessage('En cours d''impl�mentation :)');
  exit;
  if FileExists(DataDirectoryPath + 'PathScriptWebAdminPHP.cfg') then
    PathScript := ReadFromFile(DataDirectoryPath + 'PathScriptWebAdminPHP.cfg')
  else
    PathScript := Application.ExeName;

  if DirectoryExists(ExtractFilePath(PathScript)) then
    SaveDialog1.InitialDir := ExtractFilePath(PathScript);

  if SaveDialog1.Execute then
  begin
    PathScript := SaveDialog1.FileName;
    WriteInFile(DataDirectoryPath + 'PathScriptWebAdminPHP.cfg', PathScript);
    // todo
  end;
end;

procedure TForm1.CheckBoxRestartOnNetworkInterfaceChangeClick(
  Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'CheckBoxRestartOnNetworkInterfaceChange.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'CheckBoxRestartOnNetworkInterfaceChange.cfg');
  TimerCheckSystemChanges.Enabled := isServerStarted and TCheckBox(Sender).Checked;

  LabelMessage.Caption := PChar('Sauv�!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;



var oldIndex: Integer = 0;

procedure TForm1.ComboBoxSelectIPSelect(Sender: TObject);
var
  filename, ip: String;
  i: Integer;
  ComboBox: TComboBox;
begin
  ComboBox := TComboBox(Sender);
  if ComboBox.ItemIndex = 0 then
  begin
    filename := BlackListCfgFile;
  end else
  begin
    if ComboBox.ItemIndex = ComboBox.Items.Count - 1 then
    begin

      if FormManageIP = nil then FormManageIP := TFormManageIP.Create(nil);
      FormManageIP.FormCreate(nil);
      FormManageIP.Top := Top;
      FormManageIP.Left := Left;
      FormManageIP.Show;
      Hide;

      if oldIndex > ComboBoxSelectIPBlackhost.Items.Count - 1 then oldIndex := 0;
      ComboBoxSelectIPBlackhost.ItemIndex := oldIndex;
      ComboBoxSelectIPhostfile.ItemIndex := oldIndex;
    end else
    begin
      if ComboBox.ItemIndex = ComboBox.Items.Count - 2 then
      begin
        TActionManageIP.addIP(True);

        if oldIndex > ComboBoxSelectIPBlackhost.Items.Count - 1 then oldIndex := 0;
        ComboBoxSelectIPBlackhost.ItemIndex := oldIndex;
        ComboBoxSelectIPhostfile.ItemIndex := oldIndex;
      end else
      begin

        i := ComboBox.ItemIndex;
        if (i >= 0) and (i < ComboBox.Items.Count) then
        filename := DirCustomHost+'\'+ComboBox.Items.Strings[i]+'_blackhost.txt';

      end;
    end;
  end;
  if FileExists(filename) then ListBoxBlacklist.Items.LoadFromFile(filename);

  ListViewCreate(ListView1);
  ListView1.Clear;
  getDomains(filename, ListView1);

  if oldIndex > ComboBox.Items.Count - 1 then oldIndex := 0;
  i := ComboBox.ItemIndex;
  oldIndex := i;
  ComboBoxSelectIPBlackhost.ItemIndex := i;
  ComboBoxSelectIPhostfile.ItemIndex := i;
end;


class procedure TActionManageIP.getIPCustomHostFiles(var ComboBox: TComboBox; suffix: string);
var
  i: Integer;
  data: TStrings;
begin
  data := TActionManageIP.loadListIP(suffix);
  data.Insert(0, 'Tout le monde');
  data.Add('Nouvelle Adresse IP ...');
  data.Add('G�rer adresses IP ...');
  ComboBox.Items := data;
  ComboBox.ItemIndex := 0;
end;

class function TActionManageIP.loadListIP(suffix: string = '_hostfile.txt'): TStrings;
var
  i: Integer;
  data: TStrings;
begin
  if not DirectoryExists(DirCustomHost) then makeDir(DirCustomHost);
  data := dirList(DirCustomHost, '*'+suffix, false, true, false);
  for i:=0 to data.Count - 1 do
  begin
    data[i] := StringReplace(data[i], suffix, '', [rfReplaceAll, rfIgnoreCase]);
  end;
  result := data;
end;


class procedure TActionManageIP.load();
begin
  with Form1 do
  begin
    if not DirectoryExists(DirCustomHost) then makeDir(DirCustomHost);
    TActionManageIP.getIPCustomHostFiles(ComboBoxSelectIPBlackhost, '_blackhost.txt');
    TActionManageIP.getIPCustomHostFiles(ComboBoxSelectIPhostfile, '_hostfile.txt');
  end;
end;



class procedure TActionManageIP.eraseIP(ip: string);
var
  i: Integer;
  list : array[0..1] of string;
begin
  list[0] := DirCustomHost+'\'+ip+'_blackhost.txt';
  list[1] := DirCustomHost+'\'+ip+'_hostfile.txt';

  for i := 0 to Length(list) -1 do
    if FileExists(list[i]) then
      DeleteFile(PAnsiChar(list[i]));
  
end;

class procedure TActionManageIP.addIP(HideShowForm1: Boolean = False);
var
  i: integer;
  ip: string;
  list : array[0..1] of string;
begin


  if FormDialogIP = nil then FormDialogIP := TFormDialogIP.Create(nil);

  if HideShowForm1 then
  begin
    FormDialogIP.Top := Form1.Top;
    FormDialogIP.Left := Form1.Left;
  end
  else begin
    if FormManageIP <> nil then
    begin       
      FormDialogIP.Top := FormManageIP.Top;
      FormDialogIP.Left := FormManageIP.Left;
    end;
  end;
  
  if HideShowForm1 then Form1.Masquer1Click(nil);
  ip := FormDialogIP.waitForValue();

  if HideShowForm1 then Form1.Afficher1Click(nil);

  if ip = '' then exit;

  list[0] := DirCustomHost+'\'+ip+'_blackhost.txt';
  list[1] := DirCustomHost+'\'+ip+'_hostfile.txt';

  for i := 0 to Length(list) -1 do
    if not FileExists(list[i]) then
      FilesManager.WriteInFile(list[i], '');

  TActionManageIP.load();

  with Form1 do
  begin
    ComboBoxSelectIPBlackhost.ItemIndex := ComboBoxSelectIPBlackhost.Items.IndexOf(ip);
    ComboBoxSelectIPhostfile.ItemIndex := ComboBoxSelectIPhostfile.Items.IndexOf(ip);
  end;
end;


end.

