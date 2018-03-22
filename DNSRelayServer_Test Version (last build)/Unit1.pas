unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, ComCtrls, ToolWin, Menus,
  UnitHost, Systray, Registry, md5,  ListViewManager, HostParser, XPMan,
  Spin, Buttons, NetworkManager, DNSManager, UnitNetConfig, DNSServer,
  UrlMon, FilesManager, Registre, UnitInstallation, StrUtils, ProcessManager,
  CheckLst, StringManager, UnitRestartAlert, WindowsManager,
  UnitDialogIP, UnitManageIP, RulesManager, UnitNetstat2, UnitTaskManager, Commctrl, ShellApi, Winsock,
  Sockets;   

var
  CurrentApplicationVersion: string = '0.4.385.1';
  isDevVersion: Boolean = True;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Quitter1: TMenuItem;
    Masquer1: TMenuItem;
    Afficher1: TMenuItem;
    ImageList2: TImageList;
    SaveDialog1: TSaveDialog;
    ImageList3: TImageList;
    TimerSaveChangeAndRestart: TTimer;
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
    N5: TMenuItem;
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
    ColorDialog1: TColorDialog;
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
    N7: TMenuItem;
    toutbloquer1: TMenuItem;
    Panel7: TPanel;
    ToolBar5: TToolBar;
    ToolButton23: TToolButton;
    PopupMenuForAllDNSRules: TPopupMenu;
    AllowAll: TMenuItem;
    DisallowAll: TMenuItem;
    Toutautoriser1: TMenuItem;
    AjouterBlackworkds1: TMenuItem;
    ToolButtonMenuLogs: TToolButton;
    PopupMenuLogs: TPopupMenu;
    Afficherenhaut1: TMenuItem;
    Afficherenbas1: TMenuItem;
    Affichergauche1: TMenuItem;
    Afficherdroite1: TMenuItem;
    Toutnormal1: TMenuItem;
    Toutnormale1: TMenuItem;
    Config1: TMenuItem;
    N8: TMenuItem;
    DNS1: TMenuItem;
    DNSMatres1: TMenuItem;
    Misejour1: TMenuItem;
    Carterseau1: TMenuItem;
    Affichage1: TMenuItem;
    TimerHideMessage: TTimer;
    PanelMessage: TPanel;
    SpeedButtonCloseMessage: TSpeedButton;
    LabelMessage: TLabel;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    ScrollBox3: TScrollBox;
    ScrollBox8: TScrollBox;
    Masquer2: TMenuItem;
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
    Clients1: TMenuItem;
    Blacklist1: TMenuItem;
    Hostfile1: TMenuItem;
    TimerFadeIn: TTimer;
    TimerFadeOut: TTimer;
    TimerAfterFormCreateLong: TTimer;
    TimerRemoteAccess: TTimer;
    TabSheet7: TTabSheet;
    ScrollBox6: TScrollBox;
    TimerCheckSystemChanges: TTimer;
    ComboBoxSelectIPBlackhost: TComboBox;
    Label36: TLabel;
    Label41: TLabel;
    ComboBoxSelectIPhostfile: TComboBox;
    TabSheet8: TTabSheet;
    ScrollBox7: TScrollBox;
    GroupBox16: TGroupBox;
    Label46: TLabel;
    CheckBoxExecOnDisconnected: TCheckBox;
    EditExecOnDisconnected: TEdit;
    Label43: TLabel;
    TimerExecOnDisconnected: TTimer;
    ButtonTester: TButton;
    CheckBoxBindAllIP: TCheckBox;
    Label44: TLabel;
    GroupBox17: TGroupBox;
    Panel12: TPanel;
    GroupBox15: TGroupBox;
    Panel10: TPanel;
    Panel11: TPanel;
    Label42: TLabel;
    CheckBoxRestartOnNetworkInterfaceChange: TCheckBox;
    GroupBox7: TGroupBox;
    Label7: TLabel;
    Panel4: TPanel;
    ButtonNetCardIntegration: TButton;
    ButtonNetCardDesintegration: TButton;
    Button3: TButton;
    Panel2: TPanel;
    Label9: TLabel;
    Label13: TLabel;
    CheckBoxAllowModifyNetCard: TCheckBox;
    TabSheet9: TTabSheet;
    GroupBox20: TGroupBox;
    ButtonUpdate: TButton;
    Label12: TLabel;
    CheckBoxUpdateSilent: TCheckBox;
    Label11: TLabel;
    CheckBoxUpdateIntervall: TCheckBox;
    SpinTimeCheckUpdate: TSpinEdit;
    Label10: TLabel;
    CheckBoxUpdate: TCheckBox;
    Label34: TLabel;
    GroupBox21: TGroupBox;
    ButtonUpdateDev: TButton;
    Label35: TLabel;
    GroupBox22: TGroupBox;
    GroupBox14: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    CheckBoxRemoteAccess: TCheckBox;
    GroupBox13: TGroupBox;
    Label39: TLabel;
    ButtonInstallScriptWebAdmin: TButton;
    MemoHelpWebAdmin: TMemo;
    GroupBoxAffichage: TGroupBox;
    GroupBoxUpdateTheme: TGroupBox;
    Shape2: TShape;
    Label29: TLabel;
    Label27: TLabel;
    ShapeColorText: TShape;
    Label28: TLabel;
    Shape1: TShape;
    ShapeColorBackground: TShape;
    EditThemeName: TEdit;
    Button2: TButton;
    ButtonUpdateTheme: TButton;
    GroupBox19: TGroupBox;
    Label30: TLabel;
    Label26: TLabel;
    ComboBoxCurrentTheme: TComboBox;
    ButtonMenuTheme: TButton;
    SpinEditContraste: TTrackBar;
    GroupBox23: TGroupBox;
    Label15: TLabel;
    ComboBoxPosLogs: TComboBox;
    LabelUpdateTheme: TLabel;
    SpeedButtonClosePanelUpdateTheme: TSpeedButton;
    Label20: TLabel;
    SpinEditTTLCache: TSpinEdit;
    TimerClearCache: TTimer;
    TimerSaveChange: TTimer;
    TimerBootNoXP: TTimer;
    SpeedButton1: TSpeedButton;
    Label40: TLabel;
    CheckBoxShowDebug: TCheckBox;
    Relancerlapplication1: TMenuItem;
    MainMenu1: TMainMenu;
    Clients2: TMenuItem;
    Blacklist2: TMenuItem;
    webfilter1: TMenuItem;
    Logs1: TMenuItem;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Config2: TMenuItem;
    Shape3: TShape;
    Netstat1: TMenuItem;
    GroupBox8: TGroupBox;
    Label47: TLabel;
    Memo1: TMemo;
    GroupBox6: TGroupBox;
    Label25: TLabel;
    ListViewNetstat: TListView;
    Panel8: TPanel;
    ToolBar3: TToolBar;
    ToolButtonRefreshNetstat: TToolButton;
    ImageListNestat: TImageList;
    PopupMenuListViewNetstat: TPopupMenu;
    Fermerlaconnexion1: TMenuItem;
    Fermerleprocessus1: TMenuItem;
    ToolButtonNetstatMenu: TToolButton;
    PopupMenuRefreshNetstat: TPopupMenu;
    Rafraichirtoutesles1seconde1: TMenuItem;
    Rafraichirtoutesles2secondes1: TMenuItem;
    Rafraichirtoutesles5secondes1: TMenuItem;
    Pause1: TMenuItem;
    TimerRefreshNetstat: TTimer;
    Netstat2: TMenuItem;
    Ajouterunnouveaudomaine1: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    PageControlLogs: TPageControl;
    TabSheet10: TTabSheet;
    MemoLogs: TMemo;
    TabSheet11: TTabSheet;
    ListViewLogs: TListView;
    TabSheet12: TTabSheet;
    ListViewLogsNetstat: TListView;
    PopupMenuListViewLogsDNS: TPopupMenu;
    MenuItemLogsDNSAdd: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItemLogsDNSAllow: TMenuItem;
    MenuItemLogsDNSModify: TMenuItem;
    MenuItemLogsDNSBan: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItemLogsDNSBanBlackhost: TMenuItem;
    TimerLogsNetstat: TTimer;
    N12: TMenuItem;
    LogDNSAutoScroll: TMenuItem;
    PopupMenuListViewLogsNetstat: TPopupMenu;
    LogNetstatAutoScroll: TMenuItem;
    EraseLogsListViewDNS: TMenuItem;
    EraseLogsListViewNetstat: TMenuItem;
    ScrollBox4: TScrollBox;
    GroupBox18: TGroupBox;
    Label45: TLabel;
    Label17: TLabel;
    EditDonation: TEdit;
    ButtonCopyEditDonation: TButton;
    GroupBox9: TGroupBox;
    Label16: TLabel;
    EditSourceURL: TEdit;
    ButtonCopyEditSourceURL: TButton;
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
    procedure TimerSaveChangeAndRestartTimer(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure Bloquerledomaine1Click(Sender: TObject);
    procedure Autoriser1Click(Sender: TObject);
    procedure ListView1ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ListViewNetstatContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);

    procedure Modifier1Click(Sender: TObject);
    procedure refreshListView1Click();
    procedure onServerDNSStart();
    procedure onServerDNSStop();
    procedure Timer1Timer(Sender: TObject);
    procedure OnOutput(txt:String);
    procedure ToolButton8Click(Sender: TObject);
    procedure ButtonForceStartClick(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ButtonUpdateClick(Sender: TObject);
    procedure CheckBoxUpdateClick(Sender: TObject);
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
    procedure CheckBoxExecOnDisconnectedClick(Sender: TObject);
    procedure TimerExecOnDisconnectedTimer(Sender: TObject);
    procedure ButtonTesterClick(Sender: TObject);
    procedure CheckBoxBindAllIPClick(Sender: TObject);
    procedure ButtonCopyEditSourceURLClick(Sender: TObject);
    procedure TimerClearCacheTimer(Sender: TObject);
    procedure TimerSaveChangeTimer(Sender: TObject);
    procedure SpinEditTTLCacheChange(Sender: TObject);
    function isXP(): Boolean;
    procedure forOldVersions();
    procedure Alertes1Click(Sender: TObject);
    procedure Config1Click(Sender: TObject);
    procedure TimerBootNoXPTimer(Sender: TObject);
    procedure ButtonShowLogsClick(Sender: TObject);
    procedure debug(log: String);
    procedure CheckBoxShowDebugClick(Sender: TObject);
    procedure setButtonStartText(state: Integer);
    procedure FormShow(Sender: TObject);
    procedure Netstat1Click(Sender: TObject);
    procedure ToolButtonRefreshNetstatClick(Sender: TObject);
    procedure Fermerlaconnexion1Click(Sender: TObject);
    procedure Fermerleprocessus1Click(Sender: TObject);
    procedure ToolButtonNetstatMenuClick(Sender: TObject);
    procedure TimerRefreshNetstatTimer(Sender: TObject);
    procedure Rafraichirtoutesles1seconde1Click(Sender: TObject);
    procedure Rafraichirtoutesles2secondes1Click(Sender: TObject);
    procedure Rafraichirtoutesles5secondes1Click(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure CheckBoxShowHTTPRequestInLogsClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Ajouterunnouveaudomaine1Click(Sender: TObject);
    procedure LogsAdd(log:String);
    procedure ListViewLogsContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure MenuItemLogsDNSAddClick(Sender: TObject);
    procedure MenuItemLogsDNSAllowClick(Sender: TObject);
    procedure MenuItemLogsDNSModifyClick(Sender: TObject);
    procedure MenuItemLogsDNSBanClick(Sender: TObject);
    procedure MenuItemLogsDNSBanBlackhostClick(Sender: TObject);
    procedure TimerLogsNetstatTimer(Sender: TObject);
    procedure LogDNSAutoScrollClick(Sender: TObject);
    procedure ListViewLogsNetstatContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure LogNetstatAutoScrollClick(Sender: TObject);
    procedure EraseLogsListViewDNSClick(Sender: TObject);
    procedure EraseLogsListViewNetstatClick(Sender: TObject);
    function GetDomainFromIP(ip: String): String;
    procedure ButtonCopyEditDonationClick(Sender: TObject);
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
  BlackListCfgFile: string = 'blackhost.txt';
  SlaveDNSIPConfig: string = 'SlaveDNSIP.cfg';
  SlaveDNSPortConfig: string = 'SlaveDNSPort.cfg';
  TimeCheckUpdateFile: string = 'TimeCheckUpdate.cfg';
  DirCustomHost : string = 'customhost';

  FormAlertLastShow: string = '';

  DNSMasterSerialized: string = '';
  LastPositionFormAlertTop: integer = 0;
  CountFormAlert: integer = 0;
  startedInBackground: Boolean = False;

  lastLogOutput: string = '';
  isApplicationLoading: Boolean = True;
  isFormVisible : Boolean = False;
  opacity: Integer = 0;
  autostarted: Boolean = False;
  isFormHideOnStart: Boolean = False;

  Connections: TConnectionArray = nil;
  oldConnections: TConnectionArray = nil;
  ConnectionsNetstat: TConnectionArray = nil;
  SelectedConnection : TConnection;
implementation

uses TypInfo;

{$R *.dfm}

procedure TForm1.debug(log: String);
begin
  if CheckBoxShowDebug.Checked then
    MemoLogs.Lines.Add('Debug: '+log);
end;

procedure TForm1.FormShow(Sender: TObject);
var
  i: Integer;
begin
  if isFormHideOnStart then exit;
  isFormHideOnStart := True;
  for i:=0 to ParamCount() do
  begin
    if ParamStr(i) = '/background' then
    begin
      Masquer1Click(nil);
      startedInBackground := True;
      autostarted := True;
      ButtonStartClick(nil);
      TimerStartInBackground.Enabled := True;
      exit;

    end;
  end;
  Masquer1Click(nil);
  Afficher1Click(nil);
end;


procedure TForm1.OnOutput(txt:String);
var
  i, imgIndex: integer;
  isNew, isRepeated: Boolean;
  sl: TStringList;
  // 04.03.17; 09:33:09; 127.0.0.1; 185.22.116.72; tf1.fr.
  date, time, ipserver, ipclient, ipdomain, domain, ip, logs, tab, status:string;
  //hostdata, blackhost : String;
  //FormAlert: TFormAlert;
  //data: TRecordAlert;
  p: TPoint;
begin
  imgIndex := 0;
  txt := StringReplace(txt, #13, '', [rfReplaceAll, rfIgnoreCase]);
  txt := StringReplace(txt, #10, '', [rfReplaceAll, rfIgnoreCase]);
  if txt = '' then exit;

  isRepeated := lastLogOutput = txt;
  lastLogOutput := txt;

  sl:=TStringList.Create;
  SplitStr(txt,';',sl);
  //form1.LogsAdd(sl.Text);
  if sl.Count >= 6 then
  begin
    date := onlyChars(sl.Strings[0]);
    time := onlyChars(sl.Strings[1]);
    ipserver := onlyChars(sl.Strings[2]);
    ipclient := onlyChars(sl.Strings[3]);
    ipdomain := onlyChars(sl.Strings[4]);
    domain := onlyChars(sl.Strings[5]);
    domain := Rules.DomainWithoutDotAtEnd(domain);
    //SetLength(domain, Length(domain));

    if form1.ListBoxIpClients.Items.IndexOf(ipclient) = -1 then
    begin
      form1.ListBoxIpClients.Items.Add(ipclient);
    end;

  
    isNew := true;
    for i := 0 to form1.ListView1.Items.Count-1 do
    begin
      //if form1.ListView1.Items[i].SubItems[0] =  domain then isNew := false;
      if Rules.DomainWithoutDotAtEnd(form1.ListView1.Items[i].Caption) = domain then
        isNew := false;
    end;

    ip := ipdomain;
    ip := onlyChars(ip);


    if isNew then
    begin
      EditerLigne2(form1.ListView1, -1, imgIndex, domain, ipdomain, imgIndex = 3);
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

      //if form1.MemoLogs.Visible then
      form1.LogsAdd(logs);


      ListViewLogs.Items.Add().Caption := domain;
      i := ListViewLogs.Items.Count - 1;

      // ==== Image
      ListViewLogs.Items[i].ImageIndex := 0;

      if Rules.IsBlacklistDomain(domain)
      or Rules.IsBlackHostDomain(domain)
      or (Pos('127.0.0.', ipdomain) > 0) then
      begin
        ListViewLogs.Items[i].ImageIndex := 3;
      end;
      if Rules.IsDefinedHostDomain(domain) then
      begin
        ListViewLogs.Items[i].ImageIndex := 1;
      end;
        // ====

      ListViewLogs.Items[i].SubItems.Add(ipdomain);
      ListViewLogs.Items[i].SubItems.Add(status);
      ListViewLogs.Items[i].SubItems.Add(ipclient);
      ListViewLogs.Items[i].SubItems.Add(ipserver);
      ListViewLogs.Items[i].SubItems.Add(date);
      ListViewLogs.Items[i].SubItems.Add(time);

      if LogDNSAutoScroll.Checked then
      begin
        p := ListViewLogs.Items[i].Position;
        ListViewLogs.Scroll(p.X, p.Y);
      end;

      if isXP then
      begin
        if ListViewLogs.Items.Count > 50 then
          ListViewLogs.Items[0].Delete;
      end else begin
        if ListViewLogs.Items.Count > 200 then
          ListViewLogs.Items[0].Delete;
      end;


      {
      if ((status = 'OK') and
          (CheckBoxAlertEventsKnown.Checked
           or CheckBoxAlertEventsUnknown.Checked))
      or ((status <> 'OK') and CheckBoxAlertEventDisallowed.Checked) then // bloqué
      begin
        //data.ip := ip;
        //data.domain := domain;
        //data.typeAlert := imgIndex;

        //AlertManager.createNewAlert(FormAlert, data);

        // Don't do FormAlert.Show; because you loose the focus.
        // Use this code instead
        //ShowWindow(FormAlert.Handle, SW_SHOWNOACTIVATE);
        //FormAlert.Visible := true;

      end;
      }

      {
      if (imgIndex = 0) and CheckBoxAlertEventsKnown.Checked then // inconnu
      begin
        AlertManager.createNewAlert(FormAlert, data);
        if FormAlert <> nil then
        begin
          //FormAlert.PanelAllowed.Visible := True;
          //FormAlert.PanelDisallowed.Visible := False;
          FormAlert.FormCreate(nil);
          // Don't do FormAlert.Show; because you loose the focus.
          // Use this code instead
          ShowWindow(FormAlert.Handle, SW_SHOWNOACTIVATE);
          FormAlert.Visible := true;
          FormAlert.Repaint;
        end;
      end;
      if (imgIndex = 1) and CheckBoxAlertEventsUnknown.Checked then // connu
      begin
        AlertManager.createNewAlert(FormAlert, data);
        if FormAlert <> nil then
        begin
          //FormAlert.PanelAllowed.Visible := True;
          //FormAlert.PanelDisallowed.Visible := False;
          FormAlert.FormCreate(nil);
          // Don't do FormAlert.Show; because you loose the focus.
          // Use this code instead
          ShowWindow(FormAlert.Handle, SW_SHOWNOACTIVATE);
          FormAlert.Visible := true;
          FormAlert.Repaint;
        end;
      end;
      if (imgIndex = 3) and CheckBoxAlertEventDisallowed.Checked then // bloqué
      begin
        AlertManager.createNewAlert(FormAlert, data);
        if FormAlert <> nil then
        begin
          //FormAlert.PanelAllowed.Visible := False;
          //FormAlert.PanelDisallowed.Visible := True;
          FormAlert.FormCreate(nil);
          // Don't do FormAlert.Show; because you loose the focus.
          // Use this code instead
          ShowWindow(FormAlert.Handle, SW_SHOWNOACTIVATE);
          FormAlert.Visible := true;
          FormAlert.Repaint;
        end;
      end;
      }

      if ipdomain = '127.0.0.4' then //status := 'BLOCKED by DNS Master fail';
      begin
        if CheckBoxExecOnDisconnected.Checked and not TimerExecOnDisconnected.Enabled then
        begin
          if EditExecOnDisconnected.Text <> '' then
          begin
            Form1.MemoLogs.Lines.Add('Event "Disconnected"');
            ProcessManager.ExecAndContinue(EditExecOnDisconnected.Text, '', SW_SHOWNORMAL);
            TimerExecOnDisconnected.Enabled := True;
          end;
        end;
      end;

    end;
  end
  else begin
    if Pos('Error: Port  53  already used', txt) > 0 then
    begin
      //if MessageDlg(PChar('Le port 53 est déjà utilisé. Désirez-vous forcer la fermerture des processus python et essayer à nouveau?'#13#13'(si ce message persiste, soit le port 53 est utilisé par un autre processus, soit vous avez indiqué une mauvaise adresse IP.'),  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
      //begin
        Form1.MemoLogs.Lines.Add('Error: Port '+IntToStr(SpinPort.Value)+'  already used');
        KillTask('python.exe');
        Form1.ButtonRefreshNetCardClick(nil);
        ServerDoStart := True;
        Form1.ButtonStartClick(nil);
      //end;
    end
    else begin
        logs := StringReplace(txt, ';', '', [rfReplaceAll, rfIgnoreCase]);
        form1.LogsAdd(logs);
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

    repeat

      BytesRead := 0;
      PeekNamedPipe(PaLeer, nil, 0, nil, tb, nil);
      if tb^=0 then
        break;
      ReadFile(PaLeer,Buffer[0],CUANTOBUFFER,BytesRead,nil);
      Buffer[BytesRead]:= #0;
      OemToAnsi(Buffer,Buffer);

      txt := StringReplace(String(Buffer), ';EOL;', '', [rfReplaceAll, rfIgnoreCase]);

      sl:=TStringList.Create;
      SplitStr(String(Buffer),';EOL;',sl);
      for i:=0 to sl.Count-1 do
      begin
        txt := String(sl.Strings[i]);
        txt := StringReplace(txt, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
        output.Add(txt);
      end;
      form1.Timer1.Enabled := True;

    until (BytesRead < CUANTOBUFFER);
  end;

begin
  with Seguridades do
  begin
    nlength              := SizeOf(TSecurityAttributes);
    binherithandle       := true;
    lpsecuritydescriptor := nil;
  end;

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
        //form1.onServerDNSStart();
        h := ProcessInfo.hProcess;
    	  form1.onProcessCreated(ProcessInfo.dwProcessId);
        new(tb);
        repeat
          CuandoSale := WaitForSingleObject( ProcessInfo.hProcess,100);
          readFromPipe;
          Application.ProcessMessages;
        until (CuandoSale <> WAIT_TIMEOUT);
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
  RunDosInMemo(cmd, EnMemo);
end;

procedure ThreadProcess.Execute2(cmd:String; EnMemo:TMemo);
begin
  RunDosInMemo(cmd, EnMemo);
end;

procedure TForm1.onServerDNSStart();
//var bmp: TBitmap;
begin
  Application.ProcessMessages;
  try
    ImageList4.GetIcon(3, Application.Icon);
    Systray.ModifIconeTray(Caption, Application.Icon.Handle);
    setButtonStartText(1);
    isServerStarted := True;
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
//var  bmp: TBitmap; 
begin
  try
    if ServerDoStart then
    begin
      ImageList4.GetIcon(2, Application.Icon);
      Systray.ModifIconeTray(Caption, Application.Icon.Handle);
      setButtonStartText(2);
      inc(ServerFailStartCount);
      TimerRestart.Enabled := True;
      exit;
    end
    else begin
      ImageList4.GetIcon(1, Application.Icon);
      Systray.ModifIconeTray(Caption, Application.Icon.Handle);
      setButtonStartText(0);
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
  Systray.EnleveIconeTray();
end;

procedure TForm1.ButtonCloseClick(Sender: TObject);
//var  bmp: TBitmap; 
begin
  try
    setButtonStartText(2);
    MemoLogs.Lines.Add('Close server');
    KillTask('python.exe');
    ImageList4.GetIcon(2, Application.Icon);
    Systray.ModifIconeTray(Caption, Application.Icon.Handle);
    Timer1.Enabled := False;
    Application.ProcessMessages;
    SetLength(listThreads, 0);                 
    Application.ProcessMessages;
    setButtonStartText(0);
  except
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
  end;
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
    ShowMessage('Veuillez d''abord sélectionner un élément dans la liste');
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
    ShowMessage('Effacé');
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
    ShowMessage('Veuillez d''abord sélectionner un élément dans la liste');
    exit;
  end;
  dns := ListBoxDNSMaster.Items.Strings[i];
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
    ShowMessage('Veuillez d''abord sélectionner un élément dans la liste');
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
    ShowMessage('Veuillez d''abord sélectionner un élément dans la liste');
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

begin


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
  forOldVersions();


  // hide from task bar and task list
  SetWindowLong(Handle, GWL_EXSTYLE,
                GetWindowLong(Handle, GWL_EXSTYLE) or
                WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
  ShowWindow(Application.Handle, SW_HIDE);

  //SetWindowTheme(PageControl1.Handle, '', '');

  TimerAfterFormCreate.Enabled := True;
  ServerDoStart := False;
  ServerFailStartCount := 0;
  GroupBoxUpdateTheme.Visible := False;
  GroupBoxAffichage.Height := GroupBox19.Top + GroupBox19.Height + GroupBox23.Top;

  Form1.Width := Form1.Constraints.MinWidth * 2;
  Form1.Height := Form1.Constraints.MinHeight * 2;

  if Form1.Width > Screen.WorkAreaWidth then Form1.Width := Screen.WorkAreaWidth;
  if Form1.Height > Screen.WorkAreaHeight then Form1.Height := Screen.WorkAreaHeight;

  Form1.Top := Screen.WorkAreaHeight - Form1.Height;
  Form1.Left := Screen.WorkAreaWidth - Form1.Width;

  if (ParamCount() >= 1) and (ParamStr(1) = '/taskschd') then
  begin
    Masquer1Click(nil);
    StopDNS1Click(nil);
    TimerBootNoXP.Enabled := True;
    exit;
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
    exit;
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


  MemoHelpWebAdmin.Lines.Add('Ce script permet de contrôler cette application depuis un serveur web PHP. '
    +'Cette application doit pouvoir avoir un accès en écriture où sera installé le script. '
    +'Et le script a aussi besoin d''un accès en écriture où est installé cette application. Lors de l''installation, l''application va mémoriser le chemin où est exporté le script.'
    +' Veillez à exporter dans le répértoire du serveur web si vous voulez profiter des mises à jour automatique du script. '
    +'Effacez le script ou exportez-le dans un répertoire temporaire si vous ne voulez pas de mise à jour automatique du script. '
    +'Pour le moment il n''y a aucune sécurité d''accès au script. '
    +'Installé tel quel, n''importe qui qui accède au serveur pourra changer ensuite les configurations de cette application. A vous de sécuriser l''accès au script (avec un .htaccess ou en placant uniquement sur un intranet local)');

  Panel1.Align := alClient;
  GroupBox1.Align := alClient;
  GroupBox2.Align := alClient;
  GroupBox3.Align := alClient;
  GroupBox4.Align := alClient;
  GroupBox6.Align := alClient;
  GroupBox8.Align := alClient;
  Notebook1.Align := alClient;
  PageControl1.Align := alClient;
  ScrollBox1.Align := alClient;
  ScrollBox2.Align := alClient;
  ScrollBox3.Align := alClient;
  ScrollBox8.Align := alClient;
  GroupBoxAffichage.Align := alTop;
  //ScrollBox5.Align := alClient;
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

  if FileExists(DataDirectoryPath + 'EditExecOnDisconnected.cfg') then
    EditExecOnDisconnected.Text := ReadFromFile(DataDirectoryPath + 'EditExecOnDisconnected.cfg');

  {
  if FileExists(DataDirectoryPath + 'alertDisplayDuration.cfg') then
    SpinEditAlertDuration.Value := StrToInt(ReadFromFile(DataDirectoryPath + 'alertDisplayDuration.cfg'))
  else SpinEditAlertDuration.Value := 10;
  if SpinEditAlertDuration.Value < 3 then SpinEditAlertDuration.Value := 3;
  }
  
  if FileExists(SlaveDNSPortConfig) then
    SpinPort.Value := StrToInt(ReadFromFile(SlaveDNSPortConfig));

  SpinEditContraste.Position := 205;
  if FileExists(DataDirectoryPath + 'contrasteTextarea.cfg') then
    SpinEditContraste.Position := StrToInt(ReadFromFile(DataDirectoryPath + 'contrasteTextarea.cfg'));

  if FileExists(TimeCheckUpdateFile) then
    SpinTimeCheckUpdate.Value := StrToInt(ReadFromFile(TimeCheckUpdateFile));

  if FileExists(BlackListCfgFile) then
    ListBoxBlacklist.Items.LoadFromFile(BlackListCfgFile);

  SpinEditTTLCache.Value := 1;
  if FileExists(DataDirectoryPath + 'SpinEditTTLCache.cfg') then
     SpinEditTTLCache.Value := StrToInt(ReadFromFile(DataDirectoryPath + 'SpinEditTTLCache.cfg'));
  TimerClearCache.Interval := SpinEditTTLCache.Value * 1000 * 60 * 60;
  TimerClearCache.Enabled := SpinEditTTLCache.Value > 0;

  CheckBoxAutostartDNSOnBoot.Checked := FileExists(DataDirectoryPath + 'checkAutostartDNS.cfg');
  CheckBoxUpdate.Checked := FileExists(DataDirectoryPath + 'checkupdate.cfg');
  CheckBoxUpdateIntervall.Checked := FileExists(DataDirectoryPath + 'checkupdateIntervall.cfg');
  CheckBoxUpdateSilent.Checked := FileExists(DataDirectoryPath + 'checkupdateSilent.cfg');
  TimerCheckUpdate.Enabled := Form1.CheckBoxUpdateIntervall.Checked;
  TimerCheckUpdate.Interval := SpinTimeCheckUpdate.Value * 3600000;
  CheckBoxAllowModifyNetCard.Checked := FileExists(DataDirectoryPath + 'checkAllowModifyNetcard.cfg');
  CheckBoxShowDebug.Checked := FileExists(DataDirectoryPath + 'CheckBoxShowDebug.cfg');

  {
  connus1.Checked := FileExists(DataDirectoryPath + 'checkAlertEventsKnow.cfg');
  CheckBoxAlertEventsKnown.Checked := FileExists(DataDirectoryPath + 'checkAlertEventsKnow.cfg');

  inconnus1.Checked := FileExists(DataDirectoryPath + 'checkAlertEventsUnknown.cfg');
  CheckBoxAlertEventsUnknown.Checked := FileExists(DataDirectoryPath + 'checkAlertEventsUnknown.cfg');

  bloques1.Checked := FileExists(DataDirectoryPath + 'checkAlertEventDisallowed.cfg');
  CheckBoxAlertEventDisallowed.Checked := FileExists(DataDirectoryPath + 'checkAlertEventDisallowed.cfg');
  }
  
  LogDNSAutoScroll.Checked := FileExists(DataDirectoryPath + 'LogDNSAutoScroll.cfg');
  LogNetstatAutoScroll.Checked := FileExists(DataDirectoryPath + 'LogNetstatAutoScroll.cfg');

  ComboBoxCurrentTheme.OnSelect := nil;
  if FileExists(DataDirectoryPath + 'ThemeNames.cfg') then
    ComboBoxCurrentTheme.Items.LoadFromFile(DataDirectoryPath + 'ThemeNames.cfg');

  ComboBoxCurrentTheme.ItemIndex := 0;
  if FileExists(DataDirectoryPath + 'ThemeSelected.cfg') then
    ComboBoxCurrentTheme.ItemIndex := StrToInt( ReadFromFile(DataDirectoryPath + 'ThemeSelected.cfg'));
  ComboBoxCurrentThemeSelect(ComboBoxCurrentTheme);

  ComboBoxPosLogs.ItemIndex := 1;
  if FileExists(DataDirectoryPath + 'PositionLogs.cfg') then
    ComboBoxPosLogs.ItemIndex := StrToInt( ReadFromFile(DataDirectoryPath + 'PositionLogs.cfg'));
  ComboBoxPosLogsSelect(ComboBoxPosLogs);

  Systray.AjouteIconeTray(Handle,Application.Icon.Handle,Self.Caption);
  CheckBoxBindAllIP.Checked := FileExists(DataDirectoryPath + 'CheckBoxBindAllIP.cfg');
  CheckBoxBindAllIPClick(nil);
  ButtonRefreshNetCardClick(nil);

  RefreshModeFilter;

  CheckBoxNoTestDNSMaster.Checked := FileExists(DataDirectoryPath + 'CheckBoxNoTestDNSMaster.cfg');
  CheckBoxNoCacheDNS.Checked := FileExists(DataDirectoryPath + 'CheckBoxNoCacheDNS.cfg');
  CheckBoxPureServer.Checked := FileExists(DataDirectoryPath + 'CheckBoxPureServer.cfg');

  CheckBoxRemoteAccess.Checked := FileExists(DataDirectoryPath + 'CheckBoxRemoteAccess.cfg');
  TimerRemoteAccess.Enabled := CheckBoxRemoteAccess.Checked;

  CheckBoxRestartOnNetworkInterfaceChange.Checked := FileExists(DataDirectoryPath + 'CheckBoxRestartOnNetworkInterfaceChange.cfg');

  CheckBoxExecOnDisconnected.Checked := FileExists(DataDirectoryPath + 'CheckBoxExecOnDisconnected.cfg');
  
  refreshCheckBox(CheckBoxStartWithWindows);

  TActionManageIP.load();

  ListViewCreate(ListView1);
  ListView1.Clear;
  getDomains(EditFilehost.Text, ListView1);

  TimerUpdateOnLoad.Enabled := CheckBoxUpdate.Enabled;

  if Not FileExists(DataDirectoryPath + 'TimerRefreshNetstat.cfg') then
    WriteInFile(DataDirectoryPath + 'TimerRefreshNetstat.cfg', '5000');
  TimerRefreshNetstat.Interval := StrToInt(ReadFromFile(DataDirectoryPath + 'TimerRefreshNetstat.cfg'));
  TimerRefreshNetstat.Enabled := TimerRefreshNetstat.Interval > 0;
   

  // ListViewNetstat
  AjouterUneColone(ListViewNetstat.Columns.Add, 'Process', 100);
  AjouterUneColone(ListViewNetstat.Columns.Add, 'PID', 50);
  AjouterUneColone(ListViewNetstat.Columns.Add, 'Protocol', 50);
  AjouterUneColone(ListViewNetstat.Columns.Add, 'Local Address', 100);
  AjouterUneColone(ListViewNetstat.Columns.Add, 'Local Port', 50);
  AjouterUneColone(ListViewNetstat.Columns.Add, 'Remote Address', 100);
  AjouterUneColone(ListViewNetstat.Columns.Add, 'Remote Port', 50);
  AjouterUneColone(ListViewNetstat.Columns.Add, 'State', 100);
  ToolButtonRefreshNetstatClick(nil);

  ListViewNetstat.DoubleBuffered := True;

  // ==========================

  AjouterUneColone(ListViewLogs.Columns.Add, 'Domaine', 130);
  AjouterUneColone(ListViewLogs.Columns.Add, 'IP Domaine', 95);
  AjouterUneColone(ListViewLogs.Columns.Add, 'Status', 130);
  AjouterUneColone(ListViewLogs.Columns.Add, 'IP Client', 95);
  AjouterUneColone(ListViewLogs.Columns.Add, 'IP Serveur', 95);
  AjouterUneColone(ListViewLogs.Columns.Add, 'Date', 55);
  AjouterUneColone(ListViewLogs.Columns.Add, 'Heure', 55);
  ListViewLogs.DoubleBuffered := True;
  
  // ==========================

  AjouterUneColone(ListViewLogsNetstat.Columns.Add, 'Process', 100);
  AjouterUneColone(ListViewLogsNetstat.Columns.Add, 'PID', 50);
  AjouterUneColone(ListViewLogsNetstat.Columns.Add, 'Protocol', 50);
  AjouterUneColone(ListViewLogsNetstat.Columns.Add, 'Local Address', 100);
  AjouterUneColone(ListViewLogsNetstat.Columns.Add, 'Local Port', 50);
  AjouterUneColone(ListViewLogsNetstat.Columns.Add, 'Remote Address', 100);
  AjouterUneColone(ListViewLogsNetstat.Columns.Add, 'Remote Port', 50);
  AjouterUneColone(ListViewLogsNetstat.Columns.Add, 'Domaine', 100);

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
  GroupBox16.Color := bg;

  Panel1.Color := bg;
  Panel2.Color := bg;
  Panel3.Color := bg;
  Panel4.Color := bg;
  Panel5.Color := bg;
  Panel6.Color := bg;
  Panel7.Color := bg;
  Panel8.Color := bg;
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

  EditFilehost.Color := bg2;
  EditThemeName.Color := bg2;
  EditExecOnDisconnected.Color := bg2;
  ListView1.Color := bg2;
  ListViewNetstat.Color := bg2;
  ListViewLogs.Color := bg2;
  ListViewLogsNetstat.Color := bg2;
  Memo1.Color := bg2;
  MemoLogs.Color := bg2;
  MemoHelpWebAdmin.Color := bg2;
  ListBoxIpClients.Color := bg2;
  ListBoxDNSMaster.Color := bg2;
  CheckListBoxDNSRelayIP.Color := bg2;
  SpinPort.Color := bg2;
  SpinTimeCheckUpdate.Color := bg2;
  //SpinEditAlertDuration.Color := bg2;
  ComboBoxCurrentTheme.Color := bg2;
  ListBoxBlacklist.Color := bg2;
  ComboBoxPosLogs.Color := bg2;
  ComboBoxSelectIPBlackhost.Color := bg2;
  ComboBoxSelectIPhostfile.Color := bg2;
  EditSourceURL.Color := bg2;
  EditDonation.Color := bg2;
  SpinEditTTLCache.Color := bg2;

  bg2 := changeColor(bg, -SpinEditContraste.Position, -SpinEditContraste.Position, -SpinEditContraste.Position);


  EditFilehost.Font.Color := bg2;
  EditThemeName.Font.Color := bg2;
  EditExecOnDisconnected.Font.Color := bg2;
  ListView1.Font.Color := bg2;
  ListViewNetstat.Font.Color := bg2;
  ListViewLogs.Font.Color := bg2;
  ListViewLogsNetstat.Font.Color := bg2;
  Memo1.Font.Color := bg2;
  MemoLogs.Font.Color := bg2;
  MemoHelpWebAdmin.Font.Color := bg2;
  ListBoxIpClients.Font.Color := bg2;
  ListBoxDNSMaster.Font.Color := bg2;
  CheckListBoxDNSRelayIP.Font.Color := bg2;
  SpinPort.Font.Color := bg2;
  SpinTimeCheckUpdate.Font.Color := bg2;
  //SpinEditAlertDuration.Font.Color := bg2;
  ComboBoxCurrentTheme.Font.Color := bg2;
  ListBoxBlacklist.Font.Color := bg2;
  ComboBoxPosLogs.Font.Color := bg2;
  ComboBoxSelectIPBlackhost.Font.Color := bg2;
  ComboBoxSelectIPhostfile.Font.Color := bg2;
  EditSourceURL.Font.Color := bg2;
  EditDonation.Font.Color := bg2;
  SpinEditTTLCache.Font.Color := bg2;
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
  //Label17.Font.Color := color;
  //Label18.Font.Color := color;
  Label20.Font.Color := color;
  Label26.Font.Color := color;
  Label30.Font.Color := color;
  //Label31.Font.Color := color;
  Label32.Font.Color := color;
  Label33.Font.Color := color;
  Label34.Font.Color := color;
  Label35.Font.Color := color;
  Label37.Font.Color := color;
  Label38.Font.Color := color;
  Label39.Font.Color := color;
  Label42.Font.Color := color;
  Label43.Font.Color := color;
  Label44.Font.Color := color;
  Label45.Font.Color := color;
  Label46.Font.Color := color;
  Label47.Font.Color := color;

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
  debug('TimerAfterFormCreateLongTimer');
  TTimer(Sender).Enabled := False;
  isApplicationLoading := False;

  if not ServerDoStart
  and CheckBoxAutostartDNSOnBoot.Checked
  and not autostarted then
  begin
    ServerDoStart := True;
    ButtonStartClick(nil);
    exit;
  end;

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
  LineCount := TMemo(Sender).Perform(EM_GETLINECOUNT, 0, 0) - 1;
  SendMessage(TMemo(Sender).Handle, EM_LINESCROLL, 0, LineCount);
end;


procedure TForm1.onProcessCreated(h: Cardinal);
begin
  WriteInFile(SlaveDNSProcesslist, IntToStr(h));
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
  GetCursorPos(Pos);
  case X of
    WM_LBUTTONDBLCLK: Afficher1Click(nil); 
    WM_LBUTTONDOWN:  Afficher1Click(nil); 
    WM_LBUTTONUP: ; //PopupMenu1.Popup(Pos.X,Pos.Y);
    WM_RBUTTONDBLCLK:; 
    WM_RBUTTONDOWN:;   
    WM_RBUTTONUP:PopupMenu1.Popup(Pos.X,Pos.Y);
  end;
end;


procedure TForm1.Masquer1Click(Sender: TObject);
begin
  isFormVisible := False;
  //  To hide the form, Don't use Hide; (because buggy on refresh),
  // use this code instead:
  Top := -Form1.Height;
  Left := -Form1.Width;
  // hide from task bar and task list
  SetWindowLong(Handle, GWL_EXSTYLE,
                GetWindowLong(Handle, GWL_EXSTYLE) or
                WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.Afficher1Click(Sender: TObject);
begin
  isFormVisible := True;
  Self.Show;
  try
    Top := Screen.WorkAreaHeight - Self.Height;
    Left := Screen.WorkAreaWidth - Self.Width;
    Application.Restore;
    Application.BringToFront;
    BringToFront;
    // show from task bar:
    SetWindowLong(
      Handle,
      GWL_EXSTYLE,
      GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_TOOLWINDOW and WS_EX_APPWINDOW
    );
    ShowWindow(Application.Handle, SW_SHOW);
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
var h, w: Integer;
begin
  refreshCheckBox(CheckBoxStartWithWindows);
  if Form1.WindowState = wsMaximized then exit;
  if GroupBox5.Visible or Panel1.Visible then
  begin
    Form1.Constraints.MinHeight := 300;
    h := ResizePanelConfig_oldHeight;
    w := ResizePanelConfig_oldWidth;
  end else
  begin
    Form1.Constraints.MinHeight := Panel5.Height + 40;
    if Form1.Width <> Form1.Constraints.MinWidth then
    begin
      ResizePanelConfig_oldWidth := Form1.Width;
      ResizePanelConfig_oldHeight := Form1.Height;
    end;
    h := Form1.Constraints.MinHeight+2;
    w := Form1.Constraints.MinWidth;
  end;
  if h > Form1.Height then Form1.Height := h;
  if w > Form1.Width then Form1.Width := w;
  Application.ProcessMessages;
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

procedure TForm1.GotoMainPage(inexPage: Integer);
//var
  //isIndexChanged: Boolean;
  //isVisibleChanged: Boolean;
  //oldVisibility: Boolean;
begin
  Notebook1.PageIndex := inexPage;
  Panel1.Visible := True;
  Splitter1.Visible := True;
  Notebook1.Visible := True;
  GroupBox5.Visible := True;  
  GroupBox5.Align := alClient;
  ComboBoxPosLogsSelect(ComboBoxPosLogs);
  if not isFormVisible then
    Afficher1Click(nil);
  Application.Restore;
  Application.BringToFront;
  BringToFront;
end;


function TForm1.isXP:Boolean;
begin
  result := SysUtils.Win32MajorVersion < 6;
end;

procedure TForm1.refreshCheckBox(Checkbox:TCheckBox);
var
  Reg: TRegistry;
begin
  if isXP() then
  begin
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
    begin
      Checkbox.Checked := Reg.ValueExists(ExtractFileName(Application.ExeName)+'_'+md5string(Application.ExeName));
      Reg.CloseKey;
    end;
    Reg.Free;
  end else begin
    Checkbox.Checked := Pos('DNSRelayServer', ExecAndRead('schtasks')) > 0;
  end;
end;



procedure TForm1.CheckBoxStartWithWindowsClick(Sender: TObject);
var
  Reg: TRegistry;
begin
  if isApplicationLoading then exit;

  if isXP() then
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
  end else begin
    if TCheckBox(Sender).Checked then
      ExecAndContinue('SCHTASKS','/create /TN "DNSRelayServer" /TR "'''+Application.ExeName+''' /taskschd"  /SC ONLOGON /RL HIGHEST /IT', SW_HIDE)
    else
      ExecAndContinue('SCHTASKS','/delete /TN "DNSRelayServer" /F', SW_HIDE);
  end;
  LabelMessage.Caption := PChar('Sauvé!');
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
    TimerSaveChangeAndRestart.Enabled := True;
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
  if isApplicationLoading then exit;
  TimerSaveChangeAndRestart.Enabled := False;
  TimerSaveChangeAndRestart.Enabled := True;
end;

procedure TForm1.SpinEditTTLCacheChange(Sender: TObject);
begin
  if isApplicationLoading then exit;
  TimerSaveChange.Enabled := False;
  TimerSaveChange.Enabled := True;
end;

procedure TForm1.TimerSaveChangeAndRestartTimer(Sender: TObject);
begin                    
  debug('TimerSaveChangeAndRestartTimer');
  TimerSaveChangeTimer(Sender);
  if isServerStarted then PanelRestart.Visible := True;
end;

procedure TForm1.TimerSaveChangeTimer(Sender: TObject);
var
  i: Integer;
  txt: String;
begin                     
  debug('TimerSaveChangeTimer');
  TTimer(Sender).Enabled := False;
  if isApplicationLoading then exit;
  WriteInFile(FilehostPathConfig, EditFilehost.Text);
  WriteInFile(SlaveDNSPortConfig, IntToStr(SpinPort.Value));
  WriteInFile(TimeCheckUpdateFile, IntToStr(SpinTimeCheckUpdate.Value));
  //WriteInFile(DataDirectoryPath + 'alertDisplayDuration.cfg', IntToStr(SpinEditAlertDuration.Value));
  WriteInFile(DataDirectoryPath + 'EditExecOnDisconnected.cfg', EditExecOnDisconnected.Text);
  WriteInFile(DataDirectoryPath + 'SpinEditTTLCache.cfg', IntToStr(SpinEditTTLCache.Value));
  TimerClearCache.Interval := SpinEditTTLCache.Value * 1000 * 60 * 60;
  TimerClearCache.Enabled := SpinEditTTLCache.Value > 0;

  txt := #13#10;
  for i := 0 to CheckListBoxDNSRelayIP.Count - 1 do
  begin
    if not CheckListBoxDNSRelayIP.Checked[i] then
    begin
      txt := txt + CheckListBoxDNSRelayIP.Items.Strings[i]+#13#10;
    end;
  end;
  WriteInFile(DataDirectoryPath + 'CheckListBoxDNSRelayIP.cfg', txt);

  LabelMessage.Caption := PChar('Sauvé!');
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


procedure TForm1.Autoriser1Click(Sender: TObject);
begin
  SelectedListItem := ListView1.Selected;
  if not Assigned(SelectedListItem) then exit;
  if (SelectedListItem.SubItems.Strings[0] = '') then exit;
  //delDomain(EditFilehost.Text, SelectedListItem.SubItems.Strings[0]);
  delDomain(EditFilehost.Text, SelectedListItem.Caption);
  MemoLogs.Lines.Add('Débloquage de '+SelectedListItem.Caption);
  SelectedListItem.Delete;
  refreshListView1Click();
  if isServerStarted then ActionDNS.clearCache;
end;

procedure TForm1.Modifier1Click(Sender: TObject);
var
  ip:string;
begin
  SelectedListItem := ListView1.Selected;
  if not Assigned(SelectedListItem) then exit;
  ip := SelectedListItem.SubItems.Strings[0];
  //txt := InputBox('Update IP Domain', 'Exemple: pour bloquer 127.0.0.1', SelectedListItem.SubItems.Strings[0]); // This method can't cancel input
  if not InputQuery('Update IP Domain', 'Exemple: pour bloquer 127.0.0.1', ip) then exit;
  setDomain( EditFilehost.Text, SelectedListItem.Caption, ip);
  SelectedListItem.SubItems.Strings[0] := ip;
  refreshListView1Click();
  if isServerStarted then ActionDNS.clearCache;
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
  if isServerStarted then ActionDNS.clearCache;
end;

procedure TForm1.ListView1ContextPopup(Sender: TObject; MousePos: TPoint;var Handled: Boolean);
var
  ListItem:TListItem;
  CurPos:TPoint;
begin
  GetcursorPos(MousePos);
  CurPos:=ListView1.ScreenToClient(MousePos);

  ListItem:=ListView1.GetItemAt(CurPos.x,CurPos.y);
  if Assigned(ListItem) then
  begin
    SelectedListItem := ListItem;
    PopupMenuListView.Popup(MousePos.x, MousePos.y);
  end;
end;


procedure TForm1.ListViewNetstatContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  ListItem:TListItem;
  CurPos:TPoint;
begin
  GetcursorPos(MousePos);
  CurPos:=TListView(Sender).ScreenToClient(MousePos);
  ListItem:=TListView(Sender).GetItemAt(CurPos.x,CurPos.y);

  if Assigned(ListItem) then
  begin
    SelectedListItem := ListItem;
    SelectedConnection := ConnectionsNetstat[SelectedListItem.Index];


    PopupMenuListViewNetstat.Popup(MousePos.x, MousePos.y);
  end;
end;


procedure TForm1.refreshListView1Click();
var
  i:integer;
  ip, ipdomain:string;
begin
  for i := 0 to ListView1.items.count - 1 do
  begin
    ip := getDomain(EditFilehost.Text, ListView1.Items.Item[i].Caption);
    ipdomain := ListView1.Items.Item[i].SubItems.Strings[0];
    if Pos('127.0.0.', ipdomain) > 0 then ListView1.Items.Item[i].ImageIndex := 3
    else if ip = '' then ListView1.Items.Item[i].ImageIndex := 0
    else ListView1.Items.Item[i].ImageIndex := 1;
    ListView1.Items.Item[i].Checked := ListView1.Items.Item[i].ImageIndex > 0;
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var i, j: Integer;
begin                        
  debug('Timer1Timer');
  Timer1.Enabled := False;
  if listThreads = nil then exit;
  if Length(listThreads) = 0 then exit; 
  try
    for j := 0 to Length(listThreads) - 1 do
    begin
      if j > Length(listThreads) -1 then exit;
      if listThreads[j] = nil then exit;
      if listThreads[j].Terminated then exit;
      if listThreads[j].output.Count = 0 then exit;
      for i := 0 to listThreads[j].output.Count - 1 do
      begin
        OnOutput(listThreads[j].output[i]);
      end;
      if listThreads[j] = nil then exit;
      listThreads[j].output := TStringList.Create;
    end;
  except
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
    On E : ERangeError do exit;
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
    ButtonStartClick(nil);
  end
  else begin
    //if MessageDlg('Arrêter le serveur?',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    //begin
      ServerDoStart := False;
      TimerRestart.Enabled := False;
      Application.ProcessMessages;
      ButtonCloseClick(nil);
    //end;
  end;
  PanelRestart.Visible := False;
  Application.ProcessMessages;
  TToolButton(Sender).Enabled := True;
end;



procedure TForm1.ButtonStartClick(Sender: TObject);
var
  i, j, count: Integer;
  filepath, dns, script, config_cache_memory, config_display_log, bat, cmd: string;
  //bmp: TBitmap;
begin
  debug('Start DNS (1)');
  try
    setButtonStartText(2);
    ImageList4.GetIcon(2, Application.Icon);
    Systray.ModifIconeTray(Caption, Application.Icon.Handle);

    // Close others instances
    Form1.Hint := Form1.Caption;
    Form1.Caption := 'DRS Loading...';
    Application.ProcessMessages;
    CloseProcess(Form1.Hint);
    Form1.Caption := Form1.Hint;
    Application.ProcessMessages;

    ButtonCloseClick(nil);
    ServerDoStart := True;
    ButtonRefreshNetCardClick(nil);
    Application.ProcessMessages;


    debug('Start DNS (2)');

    if FormInstall = nil then
    begin
      FormInstall := TFormInstall.Create(Self);
    end;
    FormInstall.CheckInstallation;

    if not FormInstall.isPythonInstalled
    or not FormInstall.isMSVisualInstalled
    or not FormInstall.isDNSInstalled
    or not FormInstall.isSetuptoolInstalled
    then begin
      FormInstall.Show;
      FormInstall.ButtonInstallClick(nil);
      FormInstall.TimerWatchThread.Enabled := True;
      setButtonStartText(0);
      exit;
    end else
    begin
      FormInstall.Close;
    end;

    Application.ProcessMessages;
    
    debug('Start DNS (3)');

    filepath := String(EditFilehost.Text);
    if FileExists(filepath) = False then
      WriteInFile(filepath, '127.0.0.1	localhost');




    if not FileExists(BlackListCfgFile) then
      WriteInFile(BlackListCfgFile, 'doubleclick'#13#10+
                                    'godaddy'#13#10+
                                    'googleads');

    if not FileExists(filepath) then
    begin
      MemoLogs.Lines.Add('Erreur: Lancement annulé.');
      MemoLogs.Lines.Add('   Le chemin du fichier host est introuvable.');
      MemoLogs.Lines.Add('   Veuillez définir le chemin du fichier host en cliquant sur le bouton "Config"');
      setButtonStartText(0);
      if ServerDoStart then TimerRestart.Enabled := True;
      exit;
    end;


    debug('Start DNS (4)');

    count := 0;
    for i := 0 to CheckListBoxDNSRelayIP.Count -1 do
    begin
      if CheckListBoxDNSRelayIP.Checked[i] then inc(count);
    end;
    if count = 0 then
    begin
      MemoLogs.Lines.Add('Erreur: Lancement annulé');
      MemoLogs.Lines.Add('   Veuillez cocher une IP dans le panneau de config du serveur (ou attendre le redémarrage).');

      setButtonStartText(0);
      ToolButton8Click(SpeedButton1);
      exit;
    end;

    debug('Start DNS (5)');

    DNSMasterSerialized := '';
    for i := 0 to ConfigDNSMaster.Count -1 do
    begin
      if DNSMasterSerialized <> '' then DNSMasterSerialized := DNSMasterSerialized + ' ';
      DNSMasterSerialized := DNSMasterSerialized + ConfigDNSMaster[i];
    end;

    debug('Start DNS (6)');

    if not FileExists(DataDirectoryPath + 'CheckBoxNoTestDNSMaster.cfg') then
    begin
      DNSMasterSerialized := '';
      MemoLogs.Lines.Add('Test DNS Master...');
      DNSMasterSerialized := '';
      for i := 0 to ConfigDNSMaster.Count -1 do
      begin
        dns := ConfigDNSMaster[i];
        MemoLogs.Lines.Add('Master '+ dns +'... ');
        if ActionDNS.resolveDNSByPython('a.root-servers.net', dns) = '' then
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
    end;

    debug('Start DNS (7)');

    if DNSMasterSerialized = '' then
    begin
      MemoLogs.Lines.Add('Erreur: Lancement annulé');
      MemoLogs.Lines.Add('   Vous n''avez aucun DNS Master dans votre liste.');
      MemoLogs.Lines.Add('   Veuillez définir un Master DNS dans votre liste (exemple 209.244.0.3)');
      ButtonRefreshNetCardClick(nil);
      setButtonStartText(0);
      if ServerDoStart then TimerRestart.Enabled := True;
      exit;
    end;


    debug('Start DNS (8)');

    config_cache_memory := '1';
    config_display_log := 'True';

    if CheckBoxNoCacheDNS.Checked then config_cache_memory := '0';
    if CheckBoxPureServer.Checked then config_display_log := 'False';

    ServerDNS.createScript(config_cache_memory, config_display_log);

    if PythonPath = '' then PythonPath := getPythonPath();

    if FileExists(DataDirectoryPath + 'relayDNS.pyo') then DeleteFile(DataDirectoryPath + 'relayDNS.pyo');
    script := '"'+PythonPath+'python.exe" -O -m py_compile "'+DataDirectoryPath + 'relayDNS.py"';
    filepath := ExtractFilePath(Application.ExeName)+installDirectoryPath+'compile_relayDNS.bat';
    WriteInFile(filepath, script);
    LaunchAndWait(filepath,'', launchAndWWindow);


    debug('Start DNS (9)');

    if not FileExists(DataDirectoryPath + 'relayDNS.pyo') then
    begin
      MemoLogs.Lines.Add('Erreur: Lancement annulé');
      MemoLogs.Lines.Add('   La compilation du serveur à échoué. Mauvaise installation de Python 2.7?');
      if ServerDoStart then TimerRestart.Enabled := True;
      exit;
    end;
               
    debug('Start DNS (10)');

    if CheckBoxAllowModifyNetCard.Checked then
    begin
      ButtonNetCardIntegrationClick(ButtonNetCardIntegration);
    end;

    debug('Start DNS (11)');

    Application.ProcessMessages;



    for i := 0 to CheckListBoxDNSRelayIP.Count -1 do
    begin
      if CheckListBoxDNSRelayIP.Checked[i]
      and (CheckListBoxDNSRelayIP.Items.Strings[i] <> '127.0.0.1') then
      begin
        bat := DataDirectoryPath+'relayDNS'+IntToStr(i)+'.bat';
        cmd := '"'+PythonPath+'python.exe" "'+DataDirectoryPath + 'relayDNS.pyo" config_dnsip "'+CheckListBoxDNSRelayIP.Items.Strings[i]+'" config_hostfile "'+EditFilehost.Text+'" config_blackhost "'+BlackListCfgFile+'"';
        WriteInFile(bat, '@start "titre" /B /WAIT /REALTIME '+cmd+#13#10'@exit');
        if CheckBoxShowDebug.Checked then LogsAdd(cmd);
        j := Length(listThreads);
        SetLength(listThreads, j+1);
        listThreads[j] := Unit1.ThreadProcess.Create(True);
        listThreads[j].cmd := bat;
        listThreads[j].output := TStringList.Create;
        listThreads[j].EnMemo := MemoLogs;
        listThreads[j].indexThread := i;
        listThreads[j].Suspended := False;
      end;
    end;

    LaunchAndWait('ipconfig.exe','/flushdns', SW_HIDE);

    Application.ProcessMessages;
    Sleep(1000);
    onServerDNSStart();
  except
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
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


procedure TForm1.ButtonUpdateDevClick(Sender: TObject);
begin
  if MessageDlg(PChar('Attention, cette mise à jour est destinée à son développement. Vous allez mettre à jour le serveur dans une version d''essai qui est potentiellement instable. Voulez-vous continuer?'),  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then exit;
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
  url := urlLastVersion+'?'+DateTimeToStr(Now);
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
  lastversion := ReadFromFile(lastverFile);
  if (Pos(CurrentApplicationVersion, lastversion) = 1) and (isDev = isDevVersion ) then
  begin
    if isSilent then
    begin
      //Form1.MemoLogs.Lines.Add('Vous êtes à jour')
      exit;
    end else begin

      if MessageDlg(PChar('Vous êtes à jour :)'#13#10#13#10'Forcer malgré tout la réinstallation?'),  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then
      begin
        exit;
      end;
    end;
  end;

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
    url := urlUpdate+lastversion+suffixe+'.exe';
    lastverFile := ExtractFilePath(Application.ExeName)+installDirectoryPath+'DNSRelayServerSetup_'+lastversion+'.exe';
    downloadFile(url, lastverFile);
    if FileExists(lastverFile) and (FileSize(lastverFile) > 0) then
    begin

      if Form1.CheckBoxUpdateSilent.Checked then
        ExecAndWait(lastverFile, '/S', SW_HIDE)
      else
        ExecAndWait(lastverFile, '', SW_SHOWNORMAL);

      canClose := True;
      Form1.FormCloseQuery(nil, canClose);
      KillTask('python.exe');
      KillTask(ExtractFileName(Application.ExeName));
      Application.Terminate;

    end
    else begin
      if isSilent then
        //Form1.MemoLogs.Lines.Add('La mise à jour à échoué.')
      else
        ShowMessage('La mise à jour à échoué. '+#13+url);
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

  //ActionDNS.setDNSOnBoot(not CheckBoxStartWithWindows.Checked);

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.TimerUpdateOnLoadTimer(Sender: TObject);
begin                          
  debug('TimerUpdateOnLoadTimer');
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
  if CheckBoxBindAllIP.Checked then exit;
  
  txt := ReadFromFile(DataDirectoryPath + 'CheckListBoxDNSRelayIP.cfg');

  CheckListBoxDNSRelayIP.Clear;
  if GetNetworkInterfaces(net) then
  begin
    for i := 0 to High(net) - 1 do
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
var i: Integer;
begin              
  debug('TimerAfterFormCreateTimer');
  TTimer(Sender).Enabled := False;


  ComboBoxPosLogsSelect(ComboBoxPosLogs);
  ComboBoxCurrentTheme.OnSelect := ComboBoxCurrentThemeSelect;
  TimerHideMessage.Enabled := False;
  TimerSaveChangeAndRestart.Enabled := False;
  if startedInBackground then exit;

  PanelRestart.Visible := False;
  PanelMessage.Visible := False;

  if (ParamCount() >= 1) and (ParamStr(1) = '/uninst') then
  begin
    ButtonNetCardDesintegrationClick(nil);
    Application.Terminate;
    exit;
  end;


  startedInBackground := False;
  autostarted := False;
  for i:=0 to ParamCount() do
  begin
    {
    if ParamStr(i) = '/background' then
    begin
      Masquer1Click(nil);
      startedInBackground := True;
      autostarted := True;
      ButtonStartClick(nil);
      TimerStartInBackground.Enabled := True;
      exit;

    end;
    }
    if ParamStr(i) = '/autostart' then
    begin
      ServerDoStart := True;
      ButtonStartClick(nil);
      autostarted := True;
      exit;
    end;
  end;

end;

procedure TForm1.CheckBoxUpdateIntervallClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkupdateIntervall.cfg', '1')
  else DeleteFile(DataDirectoryPath + 'checkupdateIntervall.cfg');

  TimerCheckUpdate.Interval := SpinTimeCheckUpdate.Value * 60 * 60 * 1000;
  TimerCheckUpdate.Enabled := TCheckBox(Sender).Checked;

  LabelMessage.Caption := PChar('Sauvé!');
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

  LabelMessage.Caption := PChar('Sauvé!');
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

  LabelMessage.Caption := PChar('Sauvé!');
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

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.ButtonNetCardIntegrationClick(Sender: TObject);
var
  i, j: Integer;
  dnslist: String;
  net: tNetworkInterfaceList;
begin
  dnslist := '';
  if GetNetworkInterfaces(net) then
  begin
    for i := 0 to High(net) - 1 do
    begin
      if net[i].AddrIP <> '127.0.0.1' then
      begin
        if CheckBoxBindAllIP.Checked then
        begin

          if dnslist <> '' then dnslist := dnslist + ' ';
          dnslist := dnslist + net[i].AddrIP;

        end else begin

          j := CheckListBoxDNSRelayIP.Items.IndexOf(net[i].AddrIP);
          if j > -1 then
          begin
            if CheckListBoxDNSRelayIP.Checked[j] then
            begin
              if dnslist <> '' then dnslist := dnslist + ' ';
              dnslist := dnslist + net[i].AddrIP;
            end;
          end;
        end;

      end;
    end;
  end;

  MemoLogs.Lines.Add('Set DNS '+dnslist);
  ActionDNS.setDNS(dnslist);
  //ActionDNS.setDNSOnBoot(not CheckBoxStartWithWindows.Checked);
end;

procedure TForm1.ButtonNetCardDesintegrationClick(Sender: TObject);
begin
  ActionDNS.setDNS('');
  //ActionDNS.setDNSOnBoot(False);
  //ActionDNS.setIPToDHCP();
  MemoLogs.Lines.Add('Go to DHCP');
end;

procedure TForm1.TimerCheckUpdateTimer(Sender: TObject);
begin
  debug('TimerCheckUpdateTimer');
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
  GetCursorPos(Point);
  Mouse_Event(MOUSEEVENTF_LEFTDOWN, Point.X, Point.Y, 0, 0);
  Mouse_Event(MOUSEEVENTF_LEFTUP, Point.X, Point.Y, 0, 0);
  Application.ProcessMessages;
end;


procedure TForm1.Mettrejour1Click(Sender: TObject);
begin
  ButtonUpdateClick(ButtonUpdate);
end;


procedure TForm1.TimerStartInBackgroundTimer(Sender: TObject);
var
  i :Integer;
  isParamBackground: Boolean;
begin
  debug('TimerStartInBackgroundTimer');
  TTimer(Sender).Enabled := False;

  isParamBackground := False;
  for i:=0 to ParamCount() do
  begin
    if ParamStr(i) = '/background' then
    begin
      isParamBackground := True;
    end;
  end;

  if CheckBoxStartWithWindows.Checked
  or isParamBackground then
    Masquer1Click(nil);
end;


procedure TForm1.toujoursenavant1Click(Sender: TObject);
begin
  toujoursenavant1.Checked := not toujoursenavant1.Checked;
  if toujoursenavant1.Checked then Form1.FormStyle := fsStayOnTop
  else Form1.FormStyle := fsNormal;
end;

procedure TForm1.CheckBoxAlertEventsKnownClick(Sender: TObject);
begin
  {
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkAlertEventsKnow.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAlertEventsKnow.cfg');
  connus1.Checked := CheckBoxAlertEventsKnown.Checked;

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
  }
end;

procedure TForm1.CheckBoxAlertEventsUnknownClick(Sender: TObject);
begin
  {
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkAlertEventsUnknown.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAlertEventsUnknown.cfg');

  inconnus1.Checked := CheckBoxAlertEventsUnknown.Checked;

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
  }
end;

procedure TForm1.CheckBoxAlertEventDisallowedClick(Sender: TObject);
begin
{
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'checkAlertEventDisallowed.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'checkAlertEventDisallowed.cfg');
  bloques1.Checked := CheckBoxAlertEventDisallowed.Checked;

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
}
end;


procedure TForm1.TimerRestartTimer(Sender: TObject);
begin                           
  debug('TimerRestartTimer');
  TTimer(Sender).Enabled := False;
  ButtonStartClick(nil);
end;


procedure TForm1.TimerResetAlertPositionTimer(Sender: TObject);
begin                           
  debug('TimerResetAlertPositionTimer');
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
{
  CheckBoxAlertEventsUnknown.Checked := not CheckBoxAlertEventsUnknown.Checked;
  CheckBoxAlertEventsUnknownClick(CheckBoxAlertEventsUnknown);
}
end;


procedure TForm1.connus1Click(Sender: TObject);
begin
{
  CheckBoxAlertEventsKnown.Checked := not CheckBoxAlertEventsKnown.Checked;
  CheckBoxAlertEventsKnownClick(CheckBoxAlertEventsKnown);
}
end;


procedure TForm1.bloques1Click(Sender: TObject);
begin
{
  CheckBoxAlertEventDisallowed.Checked := not CheckBoxAlertEventDisallowed.Checked;
  CheckBoxAlertEventDisallowedClick(CheckBoxAlertEventDisallowed);
}
end;


procedure TForm1.Ajouter2Click(Sender: TObject);
var ip: string;
begin
  ip := '';
  if not InputQuery('Add Blackword', 'Interdit tous les domaines comportant le mot suivant', ip) then exit;
  ListBoxBlacklist.Items.Add(ip);
  ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
  if isServerStarted then ActionDNS.clearCache;
end;


procedure TForm1.Modifier3Click(Sender: TObject);
var
  i:integer;
  txt:string;
begin
  i := ListBoxBlacklist.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord sélectionner un élément dans la liste');
    exit;
  end;
  txt := ListBoxBlacklist.Items.Strings[i];
  if not InputQuery('Update Blackword', txt, txt) then exit;
  ListBoxBlacklist.Items.Strings[i] := txt;
  ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
  if isServerStarted then ActionDNS.clearCache;
end;


procedure TForm1.Supprimer2Click(Sender: TObject);
var
  i:integer;
  txt:string;
begin
  i := ListBoxBlacklist.ItemIndex;
  if i < 0 then
  begin
    ShowMessage('Veuillez d''abord sélectionner un élément dans la liste');
    exit;
  end;
  txt := ListBoxBlacklist.Items.Strings[i];
  MessageBeep(MB_OK);
  if MessageDlg(Pchar('Effacer "' + txt + '"?'),mtConfirmation, mbOKCancel, 0)  = mrOK then
  begin
    ListBoxBlacklist.DeleteSelected;
    ListBoxBlacklist.ItemIndex := 1 - 1;
    ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
    //if isServerStarted then PanelRestart.Visible := True;
    if isServerStarted then ActionDNS.clearCache;
    //ShowMessage('Effacé');
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
  GroupBoxAffichage.Height := GroupBox19.Top + GroupBox19.Height + GroupBox23.Top;
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
  end;

  if (i >= 0) and (i < ThemesList.Count) then
  begin
    s := TStringList.Create;
    SplitStr(ThemesList.Strings[i], ',', s);
    if s.Count >= 6 then
    begin
      setTheme(RGB(StrToInt(s[0]),StrToInt(s[1]),StrToInt(s[2])), RGB(StrToInt(s[3]),StrToInt(s[4]),StrToInt(s[5])));
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

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;

end;


procedure TForm1.Ajouter3Click(Sender: TObject);
begin
  LabelUpdateTheme.Caption := PChar('Ajouter un thème');
  EditThemeName.Text := '';
  GroupBoxUpdateTheme.Hint := 'add';
  GroupBoxUpdateTheme.Visible := True;
  GroupBoxAffichage.Height := GroupBoxUpdateTheme.Top + GroupBoxUpdateTheme.Height + GroupBox23.Top;
  ScrollBox8.VertScrollBar.Position := GroupBoxUpdateTheme.Top - 50;
end;


procedure TForm1.Modifier4Click(Sender: TObject);
begin
  LabelUpdateTheme.Caption := PChar('Modifier un thème');
  EditThemeName.Text := ComboBoxCurrentTheme.Text;
  GroupBoxUpdateTheme.Hint := IntToStr(ComboBoxCurrentTheme.ItemIndex);
  GroupBoxUpdateTheme.Visible := True;                                  
  GroupBoxAffichage.Height := GroupBoxUpdateTheme.Top + GroupBoxUpdateTheme.Height + GroupBox23.Top;
  ScrollBox8.VertScrollBar.Position := GroupBoxUpdateTheme.Top - 50;
end;


procedure TForm1.Supprimer3Click(Sender: TObject);
var
  i: Integer;
  ThemesList:TStringList;
begin
  if MessageDlg(PChar('Effacer le theme ['+ComboBoxCurrentTheme.Text+']?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
  if ComboBoxCurrentTheme.Items.Count <= 1 then
  begin
    ShowMessage('Vous ne pouvez pas effacer le dernier thème. Veuillez en créer un autre avant d''effacer celui-ci.');
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
      if MessageDlg(PChar('Erreur avec les fichiers template. Restaurer les templates à leur origine?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
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
  GroupBoxAffichage.Height := GroupBox19.Top + GroupBox19.Height + GroupBox23.Top;
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
      if MessageDlg(PChar('Erreur avec les fichiers template. Restaurer les templates à leur origine?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
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
  GroupBoxAffichage.Height := GroupBox19.Top + GroupBox19.Height + GroupBox23.Top;
end;


procedure TForm1.Restaurer1Click(Sender: TObject);
begin
  if MessageDlg(PChar('Restaurer les templates à leur origine?'),  mtConfirmation, [mbYes, mbNo], 0) = IDNO then exit;
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
  ListViewLogsNetstat.Clear;
  ListViewLogs.Clear;
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
  if ComboBoxPosLogs.ItemIndex = 0 then
  begin
    GroupBox5.Align := alTop;
    Splitter1.Align := alTop;

    GroupBox5.Visible := True;
    Splitter1.Visible := True;
    GroupBox5.Height := ((Form1.height - Panel5.Height) div 2) - Splitter1.Height;
    GroupBox5.Width := Form1.Width - 10;
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
    GroupBox5.Width := Form1.Width - 10;
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
  RefreshModeFilter();
end;


procedure TForm1.DsactiverlefiltrageBlackword1Click(Sender: TObject);
begin
  ButtonDisableBlackhost.Down := not ButtonDisableBlackhost.Down;
  ButtonDisableBlackhostClick(ButtonDisableBlackhost);
  RefreshModeFilter();
end;


procedure TForm1.ToolButtonBlockAllClick(Sender: TObject);
var
  Pos:TPoint;
begin
  GetCursorPos(Pos);
  PopupMenuForAllDNSRules.Popup(Pos.X,Pos.Y);
end;


procedure TForm1.ButtonDisableHostClick(Sender: TObject);
begin
  PanelRestart.Visible := True;
  if FileExists(DataDirectoryPath + 'disableHost.cfg') then
  begin
    MemoLogs.Lines.Add('Activation du fichier Host.');
    DeleteFile(DataDirectoryPath + 'disableHost.cfg');
    TToolButton(Sender).Down := False;
  end
  else begin
    MemoLogs.Lines.Add('Désactivation du fichier Host.');
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
    MemoLogs.Lines.Add('Désactivation du filtre Blackwords.');
    WriteInFile(DataDirectoryPath + 'disableBlackhost.cfg', '1');

    TToolButton(Sender).Down := True;
  end;
  DsactiverlefiltrageBlackword1.Checked := TToolButton(Sender).Down;
end;

procedure TForm1.RefreshModeFilter();
begin
  AllowAll.Checked := FileExists(DataDirectoryPath + 'disableHost.cfg') and FileExists(DataDirectoryPath + 'disableBlackhost.cfg');
  Toutautoriser1.Checked := AllowAll.Checked;
  DisallowAll.Checked := FileExists(DataDirectoryPath + 'disableAll.cfg');

  ButtonDisableBlackhost.Down := FileExists(DataDirectoryPath + 'disableBlackhost.cfg');
  ButtonDisableHost.Down := FileExists(DataDirectoryPath + 'disableHost.cfg');
  Toutnormale1.Checked := not AllowAll.Checked and not DisallowAll.Checked;
  Toutnormal1.Checked := Toutnormale1.Checked;
  toutbloquer1.Checked := DisallowAll.Checked;
  if isServerStarted then ActionDNS.clearCache; //ButtonApplyChangesClick(nil);
end;


procedure TForm1.AllowAllClick(Sender: TObject);
begin
{
  if FileExists(DataDirectoryPath + 'disableHost.cfg')
  and FileExists(DataDirectoryPath + 'disableBlackhost.cfg')
  and not FileExists(DataDirectoryPath + 'disableAll.cfg') then
  begin
    ToutNormal1Click(nil);
    exit;
  end;
}
  if not FileExists(DataDirectoryPath + 'disableHost.cfg') then
    WriteInFile(DataDirectoryPath + 'disableHost.cfg', '1');

  if not FileExists(DataDirectoryPath + 'disableBlackhost.cfg') then
    WriteInFile(DataDirectoryPath + 'disableBlackhost.cfg', '1');

  if FileExists(DataDirectoryPath + 'disableAll.cfg') then
    DeleteFile(DataDirectoryPath + 'disableAll.cfg');

  MemoLogs.Lines.Add('Mode "tout autoriser"');
  RefreshModeFilter();
  if isServerStarted then ActionDNS.clearCache;
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

  DsactiverlefiltragedufichierHost1.Checked := False;
  DsactiverlefiltrageBlackword1.Checked := False;
  Toutautoriser1.Checked := False;

  RefreshModeFilter();
  if isServerStarted then ActionDNS.clearCache;
end;


procedure TForm1.DisallowAllClick(Sender: TObject);
begin
  if FileExists(DataDirectoryPath + 'disableAll.cfg') then
  begin
    ToutNormal1Click(nil);
    exit;
  end else begin
    WriteInFile(DataDirectoryPath + 'disableAll.cfg', '1');
  end;
  if FileExists(DataDirectoryPath + 'disableHost.cfg') then
    DeleteFile(DataDirectoryPath + 'disableHost.cfg');
  if FileExists(DataDirectoryPath + 'disableBlackhost.cfg') then
    DeleteFile(DataDirectoryPath + 'disableBlackhost.cfg');

  MemoLogs.Lines.Add('Mode "tout bloquer"');

  AllowAll.Checked := not FileExists(DataDirectoryPath + 'disableAll.cfg');
  toutbloquer1.Checked := not AllowAll.Checked;
  DsactiverlefiltragedufichierHost1.Checked := AllowAll.Checked;
  DsactiverlefiltrageBlackword1.Checked := AllowAll.Checked;
  Toutautoriser1.Checked := AllowAll.Checked;

  RefreshModeFilter();
  if isServerStarted then ActionDNS.clearCache;
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
  GotoMainPage(Notebook1.PageIndex);
end;


procedure TForm1.Affichergauche1Click(Sender: TObject);
begin
  ComboBoxPosLogs.ItemIndex := 2;
  ComboBoxPosLogsSelect(nil);     
  GotoMainPage(Notebook1.PageIndex);
end;


procedure TForm1.Afficherdroite1Click(Sender: TObject);
begin
  ComboBoxPosLogs.ItemIndex := 3;
  ComboBoxPosLogsSelect(nil);       
  GotoMainPage(Notebook1.PageIndex);
end;


procedure TForm1.Masquer2Click(Sender: TObject);
begin
  ComboBoxPosLogs.ItemIndex := 4;
  ComboBoxPosLogsSelect(nil);       
  GotoMainPage(Notebook1.PageIndex);
end;


procedure TForm1.Activertouteslesalertes1Click(Sender: TObject);
begin
{
  CheckBoxAlertEventsUnknown.Checked := True;
  CheckBoxAlertEventsKnown.Checked := CheckBoxAlertEventsUnknown.Checked;
  CheckBoxAlertEventDisallowed.Checked := CheckBoxAlertEventsUnknown.Checked;
  CheckBoxAlertEventsUnknownClick(CheckBoxAlertEventsUnknown);
  CheckBoxAlertEventsKnownClick(CheckBoxAlertEventsKnown);
  CheckBoxAlertEventDisallowedClick(CheckBoxAlertEventDisallowed);
}
end;


procedure TForm1.Dsactivertouteslesalertes1Click(Sender: TObject);
begin
{
  CheckBoxAlertEventsUnknown.Checked := False;
  CheckBoxAlertEventsKnown.Checked := CheckBoxAlertEventsUnknown.Checked;
  CheckBoxAlertEventDisallowed.Checked := CheckBoxAlertEventsUnknown.Checked;
  CheckBoxAlertEventsUnknownClick(CheckBoxAlertEventsUnknown);
  CheckBoxAlertEventsKnownClick(CheckBoxAlertEventsKnown);
  CheckBoxAlertEventDisallowedClick(CheckBoxAlertEventDisallowed);
}
end;


procedure TForm1.DNS1Click(Sender: TObject);
begin
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 0;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
end;


procedure TForm1.DNSMatres1Click(Sender: TObject);
begin                     
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 1;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
end;


procedure TForm1.Carterseau1Click(Sender: TObject);
begin
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 2;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
end;


procedure TForm1.Affichage1Click(Sender: TObject);
begin
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 3;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
  Afficher1Click(nil);
end;


procedure TForm1.Alertes2Click(Sender: TObject);
begin
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 4;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
  Afficher1Click(nil);
end;


procedure TForm1.Misejour1Click(Sender: TObject);
begin
  Panel1.Visible := False;
  Splitter1.Visible := False;
  ToolButton8Click(nil);
  PageControl1.TabIndex := 7;
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
  KillProcess(Self.Handle);
  Application.Terminate;
end;


procedure TForm1.SpinEditAlertDurationChange(Sender: TObject);
begin
  if TSpinEdit(Sender).Value < 3 then TSpinEdit(Sender).Value := 3;
  TimerSaveChange.Enabled := False;
  TimerSaveChange.Enabled := True; 
end;


procedure TForm1.SpeedButtonCloseMessageClick(Sender: TObject);
begin
  PanelMessage.Visible := False;
end;


procedure TForm1.TimerHideMessageTimer(Sender: TObject);
begin                            
  debug('TimerHideMessageTimer');
  TTimer(Sender).Enabled := False;
  PanelMessage.Visible := False;
end;


procedure TForm1.CheckListBoxDNSRelayIPClickCheck(Sender: TObject);
begin
  if isServerStarted then PanelRestart.Visible := True;
  TimerSaveChangeAndRestart.Enabled := True;
end;


procedure TForm1.ListView1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 46) and (Shift = []) then
  begin
    if MessageDlg(PChar('Bloquer ['+ListView1.Selected.Caption+']?'),  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    begin
      Bloquerledomaine1Click(Bloquerledomaine1);
    end;
  end;    
  // 45 = Ins 
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
  if isApplicationLoading then Exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'CheckBoxNoTestDNSMaster.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'CheckBoxNoTestDNSMaster.cfg');
  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.CheckBoxNoCacheDNSClick(Sender: TObject);
begin
  if isApplicationLoading then Exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'CheckBoxNoCacheDNS.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'CheckBoxNoCacheDNS.cfg');

  PanelRestart.Visible := True;
  LabelMessage.Caption := PChar('Sauvé!');
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
  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
  ShowMessage('En cours d''implémentation :)');
  if FormNetConfig = nil then
    FormNetConfig := TFormNetConfig.Create(Self);
  FormNetConfig.Show;
end;


procedure TForm1.TimerAlertTimer(Sender: TObject);
begin
{
  debug('TimerAlertTimer');
  TTimer(Sender).Enabled := False;
  AlertManager.ShowAllAlert(AlertManager.MainListAlert);
  TTimer(Sender).Enabled := True;
}
end;


procedure TForm1.TimerFadeInTimer(Sender: TObject);
begin                              
  debug('TimerFadeInTimer');
  SetFormOpacity(Self.Handle, opacity);
  if opacity < 100 then opacity := opacity + 10 else TTimer(Sender).Enabled := False;
end;


procedure TForm1.TimerFadeOutTimer(Sender: TObject);
begin                          
  debug('TimerFadeOutTimer');
  SetFormOpacity(Self.Handle, opacity);
  if opacity > 10 then
    opacity := opacity - 10
  else
  begin
    Top := -Form1.Height;
    Left := -Form1.Width;
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
  for i := 0 to High(netList)-1 do
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
  debug('CheckSystemChangesTimer');
  if not GetNetworkInterfaces(net) then exit;
  if (oldNet <> nil) and (net <> nil) then
  begin
    for i := 0 to High(net) - 1 do
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
    for i := 0 to High(oldNet) - 1 do
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
  debug('TimerRemoteAccessTimer');
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

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;

procedure TForm1.ButtonInstallScriptWebAdminClick(Sender: TObject);
var PathScript: string;
begin
  ShowMessage('En cours d''implémentation :)');
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

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;



var oldIndex: Integer = 0;

procedure TForm1.ComboBoxSelectIPSelect(Sender: TObject);
var
  filename: String;
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
      Masquer1Click(nil);

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
  data: TStrings;
begin
  data := TActionManageIP.loadListIP(suffix);
  data.Insert(0, 'Tout le monde');
  data.Add('Nouvelle Adresse IP ...');
  data.Add('Gérer adresses IP ...');
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


procedure TForm1.CheckBoxExecOnDisconnectedClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + TCheckBox(Sender).Name + '.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + TCheckBox(Sender).Name + '.cfg');

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.TimerExecOnDisconnectedTimer(Sender: TObject);
begin                      
  debug('TimerExecOnDisconnectedTimer');
  TTimer(Sender).Enabled := False;
end;


procedure TForm1.ButtonTesterClick(Sender: TObject);
begin
  ProcessManager.ExecAndContinue(EditExecOnDisconnected.Text, '', SW_SHOWNORMAL);
end;


procedure TForm1.CheckBoxBindAllIPClick(Sender: TObject);
var isCheck: Boolean;
begin
  isCheck := CheckBoxBindAllIP.Checked;
  if isCheck then
  begin
    CheckListBoxDNSRelayIP.Clear;
    CheckListBoxDNSRelayIP.Items.Add('0.0.0.0');
    CheckListBoxDNSRelayIP.Checked[0] := True;
    WriteInFile(DataDirectoryPath + 'CheckBoxBindAllIP.cfg', '1');
  end else begin
    ButtonRefreshNetCardClick(Nil);
    DeleteFile(DataDirectoryPath + 'CheckBoxBindAllIP.cfg');
  end;
  CheckListBoxDNSRelayIP.Enabled := not isCheck;

  if isApplicationLoading then exit;
  if isServerStarted then PanelRestart.Visible := True;
  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.ButtonCopyEditSourceURLClick(Sender: TObject);
begin
  EditSourceURL.SelectAll;
  EditSourceURL.CopyToClipboard;
  LabelMessage.Caption := PChar('Copié!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.TimerClearCacheTimer(Sender: TObject);
begin          
  debug('TimerClearCacheTimer');
  ActionDNS.clearCache;
end;


procedure TForm1.forOldVersions();
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
  begin
    if Reg.ValueExists(ExtractFileName(Application.ExeName)+'_'+md5string(Application.ExeName)) then
    begin

      ExecAndContinue('SCHTASKS','/create /TN "DNSRelayServer" /TR "'''+Application.ExeName+''' /taskschd"  /SC ONLOGON /RL HIGHEST /IT', SW_HIDE);
      MemoLogs.Lines.Add('Update new system boot');
      Sleep(2000);
      Reg.DeleteValue(ExtractFileName(Application.ExeName)+'_'+md5string(Application.ExeName));

    end;
    Reg.CloseKey;
  end;
  Reg.Free;
end;



procedure TForm1.Alertes1Click(Sender: TObject);
begin
  ToolButton8Click(nil);
  PageControl1.TabIndex := 4;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
  Afficher1Click(nil);
end;


procedure TForm1.Config1Click(Sender: TObject);
begin
  ToolButton8Click(nil);
  PageControl1.TabIndex := 0;
  PageControl1.ActivePageIndex := PageControl1.TabIndex;
  Afficher1Click(nil);
end;


procedure TForm1.TimerBootNoXPTimer(Sender: TObject);
var canClose: Boolean;
begin          
  debug('TimerBootNoXPTimer');
  Masquer1Click(nil);
  if Pos('dwm.exe', listProcesses()) = 0 then exit;
  TTimer(Sender).Enabled := False;
  SetCurrentDir(ExtractFileDir(Application.ExeName));
  ExecAndContinue(Application.ExeName, '/background', SW_SHOW);
  StopDNS1Click(nil);
  canClose := True;
  FormCloseQuery(nil, canClose);
  //KillTask(ExtractFileName(Application.ExeName));
  KillProcess(Self.Handle);
  Application.Terminate;
end;


procedure TForm1.ButtonShowLogsClick(Sender: TObject);
begin
  GroupBox5.Align := alClient;
  GroupBox5.Visible := True;
  Splitter1.Visible := False;
end;


procedure TForm1.CheckBoxShowDebugClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'CheckBoxShowDebug.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'CheckBoxShowDebug.cfg');

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;


procedure TForm1.setButtonStartText(state: Integer);
begin
  //
  if state = 0 then
  begin
    SpeedButton1.Caption := 'Arrêté';
    SpeedButton1.Enabled := True;
    SpeedButton1.Hint := 'Démarrer le serveur DNS';
    SpeedButton1.Enabled := True;
    Shape3.brush.Color := clRed;
    Shape3.Enabled := True;
  end;
  if state = 1 then
  begin
    SpeedButton1.Caption := 'Démarré';
    SpeedButton1.Enabled := True;
    SpeedButton1.Hint := 'Arrêter le serveur DNS';
    SpeedButton1.Enabled := True;
    Shape3.brush.Color := clLime;
    Shape3.Enabled := True;
  end;
  if state = 2 then
  begin
    SpeedButton1.Caption := '';
    SpeedButton1.Enabled := True;
    SpeedButton1.Hint := '';
    SpeedButton1.Enabled := False;
    Shape3.brush.Color := clGray;
    Shape3.Enabled := False;
  end;
  Application.ProcessMessages;
end;


procedure TForm1.Netstat1Click(Sender: TObject);
begin
  GotoMainPage(4);
  if not TimerRefreshNetstat.Enabled then
    ToolButtonRefreshNetstatClick(nil);
end;

//=====================
const
  SHIL_LARGE     = $00;  //The image size is normally 32x32 pixels. However, if the Use large icons option is selected from the Effects section of the Appearance tab in Display Properties, the image is 48x48 pixels.
  SHIL_SMALL     = $01;  //These images are the Shell standard small icon size of 16x16, but the size can be customized by the user.
  SHIL_EXTRALARGE= $02;  //These images are the Shell standard extra-large icon size. This is typically 48x48, but the size can be customized by the user.
  SHIL_SYSSMALL  = $03;  //These images are the size specified by GetSystemMetrics called with SM_CXSMICON and GetSystemMetrics called with SM_CYSMICON.
  SHIL_JUMBO     = $04;  //Windows Vista and later. The image is normally 256x256 pixels.
  IID_IImageList: TGUID= '{46EB5926-582E-4017-9FDF-E8998DAA0950}';


function GetImageListSH(SHIL_FLAG:Cardinal): HIMAGELIST;
type
  _SHGetImageList = function (iImageList: integer; const riid: TGUID; var ppv: Pointer): hResult; stdcall;
var
  Handle        : THandle;
  SHGetImageList: _SHGetImageList;
begin
  Result:= 0;
  Handle:= LoadLibrary('Shell32.dll');
  if Handle<> S_OK then
  try
    SHGetImageList:= GetProcAddress(Handle, PChar(727));
    if Assigned(SHGetImageList) and (Win32Platform = VER_PLATFORM_WIN32_NT) then
      SHGetImageList(SHIL_FLAG, IID_IImageList, Pointer(Result));
  finally
    FreeLibrary(Handle);
  end;
end;

procedure GetIconFromFile( aFile: string; var aIcon: TIcon;SHIL_FLAG: Cardinal );
var
  aImgList: HIMAGELIST;
  SFI: TSHFileInfo;
  aIndex: integer;
begin // Get the index of the imagelist
  SHGetFileInfo( PChar( aFile ), FILE_ATTRIBUTE_NORMAL, SFI, SizeOf( TSHFileInfo ),
    SHGFI_ICON or SHGFI_LARGEICON or SHGFI_SHELLICONSIZE or SHGFI_SYSICONINDEX or SHGFI_TYPENAME or SHGFI_DISPLAYNAME );
  if not Assigned( aIcon ) then
    aIcon := TIcon.Create;
  // get the imagelist
  aImgList := GetImageListSH( SHIL_FLAG );
  // get index
  //aIndex := Pred( ImageList_GetImageCount( aImgList ) );
  aIndex := SFI.iIcon;
  // extract the icon handle
  aIcon.Handle := ImageList_GetIcon( aImgList, aIndex, ILD_NORMAL );
end;

procedure TForm1.ToolButtonRefreshNetstatClick(Sender: TObject);
var
  i: Integer;
  lastSelectedIndex: Integer;
  //Connections: TConnectionArray;
  //Protocol: String;
  pos: TPoint;

  //hicon :TIcon;
  //Bitmap: TBitmap;

  sProtocol: String;
  //sLocalAddr, sRemoteAdd: String;
  //sLocalPort, sRemotePort: Integer;
begin
  //FreeAndNil(Connections);
  ConnectionsNetstat := nil;
  UnitNetstat2.GetConnections(ConnectionsNetstat);

  if not isFormVisible or (Notebook1.PageIndex <> 4) then exit;

  lastSelectedIndex := -1;
  try
    if ListViewNetstat.Selected <> nil then
    begin
      if ListViewNetstat.Selected.Index > -1 then
      begin
        lastSelectedIndex := ListViewNetstat.Selected.Index;
      end;
    end;
  except
    On E : EOSError do RaiseLastOSError;
    On E : EAccessViolation do RaiseLastOSError;
  end;

  if isXP then
  begin
    pos := ListViewNetstat.ViewOrigin;
  end else begin
    pos.Y := ListViewNetstat.ViewOrigin.Y;
    pos.X := ListViewNetstat.Left;
    //pos := ListViewNetstat.ViewOrigin;
  end;

  ListViewNetstat.Clear;
  {
  for i:=0 to Length(Connections) - 1 do
  begin
    ListViewNetstat.Items.Add();
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(IntToStr(Connections[i].ProcessID));
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(Connections[i].Protocol);
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(Connections[i].LocalAddress);
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(IntToStr(Connections[i].LocalRawPort));
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(Connections[i].RemoteAddress);
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(IntToStr(Connections[i].RemoteRawPort));
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(TcpConnectionStates[Connections[i].ConnectionState]);
    // Set caption after all (at the end) to prevent some issues
    // Mettre cette ligne à la fin pour éviter un bug à l'affichage
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].Caption := TaskManager.GetExeNameFromPID(Connections[i].ProcessID);

    Bitmap := TBitmap.Create;
    hicon:= TIcon.Create;
    try
      if FileExists(TaskManager.GetPathFromPID(Connections[i].ProcessID)) then
      begin
      LogsAdd(inttostr(Connections[i].ProcessID));
      LogsAdd(TaskManager.GetPathFromPID(Connections[i].ProcessID));
      LogsAdd(TaskManager.GetExeNameFromPID(Connections[i].ProcessID));

      GetIconFromFile(TaskManager.GetPathFromPID(Connections[i].ProcessID),  hicon, SHIL_SMALL);
      Bitmap.Width := 16;
      Bitmap.Height := 16;
      Bitmap.Canvas.Draw(0, 0, hicon);

      //LogsAdd(inttostr( ImageListNestat.Add(Bitmap, nil) )); //
      ImageListNestat.Insert(0, Bitmap, nil); //.Add(Bitmap, nil);
      ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].ImageIndex := 0; //ImageListNestat.Add(Bitmap, nil); //ImageListNestat.Count - 1;
      end else begin
        ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].ImageIndex :=  -1;
      end;
    finally
      hicon.Free;
      Bitmap.Free;
    end;

  end;
  }




  for i:=0 to Length(ConnectionsNetstat) - 1 do
  begin
    if ConnectionsNetstat[i].Protocol = PROTOCOL_TCP then
      sProtocol := 'TCP'
    else
      sProtocol := 'UDP';

    ListViewNetstat.Items.Add();
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(IntToStr(ConnectionsNetstat[i].ProcessID));
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(sProtocol);
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(IpAddressToString(ConnectionsNetstat[i].LocalAddress));
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(IntToStr(ntohs(ConnectionsNetstat[i].LocalRawPort)));
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(IpAddressToString(ConnectionsNetstat[i].RemoteAddress));
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(IntToStr(ntohs(ConnectionsNetstat[i].RemoteRawPort)));
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].SubItems.Add(TcpConnectionStates[ConnectionsNetstat[i].ConnectionState]);
    // Set caption after all (at the end) to prevent some issues
    // Mettre cette ligne à la fin pour éviter un bug à l'affichage
    ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].Caption := TaskManager.GetExeNameFromPID(ConnectionsNetstat[i].ProcessID);
    //ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].ImageIndex := i;

    {
    Bitmap := TBitmap.Create;
    hicon:= TIcon.Create;
    //try
      if FileExists(TaskManager.GetPathFromPID(Connections[i].ProcessID)) then
      begin

      //LogsAdd(inttostr(Connections[i].ProcessID));
      //LogsAdd(TaskManager.GetPathFromPID(Connections[i].ProcessID));
      //LogsAdd(TaskManager.GetExeNameFromPID(Connections[i].ProcessID));

      GetIconFromFile(TaskManager.GetPathFromPID(Connections[i].ProcessID),  hicon, SHIL_SMALL);
      Bitmap.Width := 16;
      Bitmap.Height := 16;
      Bitmap.Canvas.Draw(0, 0, hicon);

      ImageListNestat.Add(Bitmap, nil);
      //LogsAdd(inttostr( ImageListNestat.Add(Bitmap, nil) )); //
      //
      //ImageListNestat.Insert(i, Bitmap, nil); //.Add(Bitmap, nil);
      ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].ImageIndex := ImageListNestat.Count - 1;
      end else begin
      ListViewNetstat.Items.Item[ListViewNetstat.Items.Count-1].ImageIndex := -1; //ImageListNestat.Add(Bitmap, nil); //ImageListNestat.Count - 1;
      end;
    //finally
      hicon.Free;
      Bitmap.Free;
    //end;
   }
  end;

  if isXP then
  begin
    ListViewNetstat.Scroll(pos.X, pos.Y);
  end else begin
    ListViewNetstat.Scroll(pos.X  - 2, pos.Y);
    try
      if lastSelectedIndex > -1 then
        ListViewNetstat.Selected := ListViewNetstat.Items[lastSelectedIndex];
    except
      On E : EOSError do exit;
      On E : EAccessViolation do exit;
    end;
  end;
  //UnitNetstat.CloseConnection(Connections[0]);
end;

procedure TForm1.Fermerlaconnexion1Click(Sender: TObject);
//var i: Integer;
begin

  if UnitNetstat2.CloseConnection(SelectedConnection) = False then
    ShowMessage('Erreur');
  ToolButtonRefreshNetstatClick(nil);

  {
  SelectedListItem := ListViewNetstat.Selected;
  if not Assigned(SelectedListItem) then exit;
  i := SelectedListItem.Index;
  //ShowMessage(inttostr(i));
  if i in [0..Length(Connections) - 1] then
  //if (i >= 0) and (i <= Length(Connections) - 1) then
  begin
    //ShowMessage(IpAddressToString(Connections[i].RemoteAddress));
    if UnitNetstat2.CloseConnection(Connections[i]) = False then
      ShowMessage('Erreur');
    ToolButtonRefreshNetstatClick(nil);
    //
  end;
  }
end;

procedure TForm1.Fermerleprocessus1Click(Sender: TObject);
//var  i: Integer;
begin
  TaskManager.CloseProcessPID(SelectedConnection.ProcessID);
  Sleep(500);
  ToolButtonRefreshNetstatClick(nil);

  {
  SelectedListItem := ListViewNetstat.Selected;
  if not Assigned(SelectedListItem) then exit;
  i := SelectedListItem.Index;
  //ShowMessage(inttostr(i));
  if i in [0..Length(Connections) - 1] then
  begin
    TaskManager.CloseProcessPID(Connections[i].ProcessID);
    //if UnitNetstat2.CloseConnection(Connections[i]) = False then
    //  ShowMessage('Erreur');
    Sleep(500);
    ToolButtonRefreshNetstatClick(nil);
    //
  end;
  }
end;

procedure TForm1.ToolButtonNetstatMenuClick(Sender: TObject);
var
  Pos:TPoint;
begin
  GetCursorPos(Pos);
  PopupMenuRefreshNetstat.Popup(Pos.X,Pos.Y);
end;

procedure TForm1.TimerRefreshNetstatTimer(Sender: TObject);
begin
  ToolButtonRefreshNetstatClick(nil);
end;

procedure TForm1.Rafraichirtoutesles1seconde1Click(Sender: TObject);
begin
  TimerRefreshNetstat.Interval := 1000;
  TimerRefreshNetstat.Enabled := True;
  WriteInFile(DataDirectoryPath + 'TimerRefreshNetstat.cfg', IntToStr(TimerRefreshNetstat.Interval));
end;

procedure TForm1.Rafraichirtoutesles2secondes1Click(Sender: TObject);
begin
  TimerRefreshNetstat.Interval := 2000;
  TimerRefreshNetstat.Enabled := True;
  WriteInFile(DataDirectoryPath + 'TimerRefreshNetstat.cfg', IntToStr(TimerRefreshNetstat.Interval));
end;

procedure TForm1.Rafraichirtoutesles5secondes1Click(Sender: TObject);
begin
  TimerRefreshNetstat.Interval := 5000;
  TimerRefreshNetstat.Enabled := True;     
  WriteInFile(DataDirectoryPath + 'TimerRefreshNetstat.cfg', IntToStr(TimerRefreshNetstat.Interval));
end;

procedure TForm1.Pause1Click(Sender: TObject);
begin
  TimerRefreshNetstat.Enabled := False;
  TimerRefreshNetstat.Interval := 0;
  WriteInFile(DataDirectoryPath + 'TimerRefreshNetstat.cfg', IntToStr(TimerRefreshNetstat.Interval));
end;

procedure TForm1.CheckBoxShowHTTPRequestInLogsClick(Sender: TObject);
begin
  if isApplicationLoading then exit;
  if TCheckBox(Sender).Checked then
    WriteInFile(DataDirectoryPath + 'CheckBoxShowHTTPRequestInLogs.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'CheckBoxShowHTTPRequestInLogs.cfg');

  LabelMessage.Caption := PChar('Sauvé!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;



procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  i: Integer;
  scrollBox: TScrollBox;
begin
  //if isXP then exit;
  
  scrollBox := nil;
  if Notebook1.PageIndex > 0 then exit;
  if PageControl1.TabIndex = 0 then scrollBox := ScrollBox1;
  if PageControl1.TabIndex = 6 then scrollBox := ScrollBox2;
  if PageControl1.TabIndex = 2 then scrollBox := ScrollBox3;
  if PageControl1.TabIndex = 7 then scrollBox := ScrollBox4;
  //if PageControl1.TabIndex = 4 then scrollBox := ScrollBox5;
  if PageControl1.TabIndex = 4 then scrollBox := ScrollBox6;
  if PageControl1.TabIndex = 5 then scrollBox := ScrollBox7;
  if PageControl1.TabIndex = 3 then scrollBox := ScrollBox8;
  if scrollBox = nil then exit;
  Handled := PtInRect(scrollBox.ClientRect, scrollBox.ScreenToClient(MousePos));
  if Handled then
  begin
    for i := 1 to Mouse.WheelScrollLines do
    try
      if WheelDelta > 0 then
        scrollBox.Perform(WM_VSCROLL, SB_LINEUP, 0)
      else
        scrollBox.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
    finally
      scrollBox.Perform(WM_VSCROLL, SB_ENDSCROLL, 0);
    end;
  end;
end;



procedure TForm1.Ajouterunnouveaudomaine1Click(Sender: TObject);
var
  i: Integer;
  ip, domain:string;
  isNew: Boolean;
  item: TListItem;
begin
  if not InputQuery('Nom de domaine', 'Exemple: www.exemple.com', domain) then exit;
  if not InputQuery('IP du domaine', 'Exemple: pour bloquer 127.0.0.1', ip) then exit;
  isNew := True;
  for i := 0 to ListView1.Items.Count - 1 do
  begin
    if UpperCase(ListView1.Items[i].Caption) = UpperCase(domain) then
    begin
      if MessageDlg(PChar('Le domaine existe déjà. Le modifier? ("non" pour annuler)'),  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then
        exit;
      isNew := False;
      SelectedListItem := ListView1.Items[i];
      if SelectedListItem.SubItems.Count = 0 then
        SelectedListItem.SubItems.Add(ip)
      else
        SelectedListItem.SubItems.Strings[0] := ip;
    end;
  end;
  if isNew then
  begin
    item := ListView1.Items.Add();
    item.Caption := domain;
    item.SubItems.Add(ip);
    SelectedListItem := item;
  end;
  setDomain(EditFilehost.Text, domain, ip);
  refreshListView1Click();
  if isServerStarted then ActionDNS.clearCache;
end;

procedure TForm1.LogsAdd(log:String);
begin
  //ListViewLogs
  MemoLogs.Lines.Add(log);
end;

procedure TForm1.ListViewLogsContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  ListItem:TListItem;
  CurPos:TPoint;
begin
  GetcursorPos(MousePos);        
  PopupMenuListViewLogsDNS.Popup(MousePos.x, MousePos.y);
  CurPos:=TListView(Sender).ScreenToClient(MousePos);
  ListItem:=TListView(Sender).GetItemAt(CurPos.x,CurPos.y);
  if Assigned(ListItem) then
  begin
    SelectedListItem := ListItem;
  end;
end;

procedure TForm1.MenuItemLogsDNSAddClick(Sender: TObject);
var
  i: Integer;
  ip, domain:string;
  isNew: Boolean;
  item: TListItem;
begin
  if not InputQuery('Nom de domaine', 'Exemple: www.exemple.com', domain) then exit;
  if not InputQuery('IP du domaine', 'Exemple: pour bloquer 127.0.0.1', ip) then exit;
  isNew := True;
  for i := 0 to ListView1.Items.Count - 1 do
  begin
    if UpperCase(ListView1.Items[i].Caption) = UpperCase(domain) then
    begin
      if MessageDlg(PChar('Le domaine existe déjà. Le modifier? ("non" pour annuler)'),  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then
        exit;
      isNew := False;
      SelectedListItem := ListView1.Items[i];
      if SelectedListItem.SubItems.Count = 0 then
        SelectedListItem.SubItems.Add(ip)
      else
        SelectedListItem.SubItems.Strings[0] := ip;
    end;
  end;
  if isNew then
  begin
    item := ListView1.Items.Add();
    item.Caption := domain;
    item.SubItems.Add(ip);
    SelectedListItem := item;
  end;
  setDomain(EditFilehost.Text, domain, ip);
  refreshListView1Click();
  if isServerStarted then ActionDNS.clearCache;
end;

procedure TForm1.MenuItemLogsDNSAllowClick(Sender: TObject);
begin
  SelectedListItem := ListViewLogs.Selected;
  if not Assigned(SelectedListItem) then exit;
  if (SelectedListItem.SubItems.Strings[0] = '') then exit;
  SelectedListItem.ImageIndex := 0;
  //delDomain(EditFilehost.Text, SelectedListItem.SubItems.Strings[0]);
  delDomain(EditFilehost.Text, SelectedListItem.Caption);
  LogsAdd('Débloquage de '+SelectedListItem.Caption);
  //SelectedListItem.Delete;
  ListView1.OnChange := nil;
  ListView1.Clear;
  getDomains(EditFilehost.Text, ListView1);
  ListView1.OnChange := ListView1Change;

  refreshListView1Click();
  if isServerStarted then ActionDNS.clearCache;
end;

procedure TForm1.MenuItemLogsDNSModifyClick(Sender: TObject);
var
  ip:string;
begin
  SelectedListItem := ListViewLogs.Selected;
  if not Assigned(SelectedListItem) then exit;
  ip := SelectedListItem.SubItems.Strings[0];
  //txt := InputBox('Update IP Domain', 'Exemple: pour bloquer 127.0.0.1', SelectedListItem.SubItems.Strings[0]); // This method can't cancel input
  if not InputQuery('Update IP Domain', 'Exemple: pour bloquer 127.0.0.1', ip) then exit;
  if Pos('127.0.0.', ip) > 0 then
    SelectedListItem.ImageIndex := 3
  else                               
    SelectedListItem.ImageIndex := 1;  
  setDomain( EditFilehost.Text, SelectedListItem.Caption, ip);
  //SelectedListItem.SubItems.Strings[0] := ip;
  ListView1.OnChange := nil;
  ListView1.Clear;
  getDomains(EditFilehost.Text, ListView1);
  ListView1.OnChange := ListView1Change;

  refreshListView1Click();
  if isServerStarted then ActionDNS.clearCache;
end;

procedure TForm1.MenuItemLogsDNSBanClick(Sender: TObject);
begin
  SelectedListItem := ListViewLogs.Selected;
  if not Assigned(SelectedListItem) then exit;
  //setDomain( EditFilehost.Text, SelectedListItem.SubItems.Strings[0], '127.0.0.1');
  setDomain(EditFilehost.Text, SelectedListItem.Caption, '127.0.0.1');
  SelectedListItem.SubItems.Strings[0] := '127.0.0.1';
  SelectedListItem.ImageIndex := 3;
  LogsAdd('Bloquage de '+SelectedListItem.Caption);
  ListView1.OnChange := nil;
  ListView1.Clear;
  getDomains(EditFilehost.Text, ListView1);
  ListView1.OnChange := ListView1Change;

  refreshListView1Click();
  if isServerStarted then ActionDNS.clearCache;
end;

procedure TForm1.MenuItemLogsDNSBanBlackhostClick(Sender: TObject);
var
  domain: string;
begin
  SelectedListItem := ListViewLogs.Selected;
  if not Assigned(SelectedListItem) then exit;
  domain := SelectedListItem.Caption; //SelectedListItem.SubItems.Strings[0];
  //txt := InputBox('Add Blackword', 'Interdit tous les domaines comportant le mot suivant', domain);
  if not InputQuery('Add Blackword', 'Interdit tous les domaines comportant le mot suivant', domain) then exit;
  ListBoxBlacklist.Items.Add(domain);
  ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
  if isServerStarted then PanelRestart.Visible := True;
end;

function TForm1.GetDomainFromIP(ip: String): String;
var i: Integer;
begin
  result := 'Direct IP or "Logs DNS" removed';
  for i := 0 to ListViewLogs.Items.Count -1 do
  begin
    if ListViewLogs.Items[i].SubItems.Strings[0] = ip then
    begin
      result := ListViewLogs.Items[i].Caption;
      Exit;
    end;
  end;
end;

procedure TForm1.TimerLogsNetstatTimer(Sender: TObject);
var
  i, index: Integer;
  sProtocol: String;
  p: TPoint;
begin
  TTimer(Sender).Enabled := False;

  //if Connections <> nil then FreeMem(Connections);
  SetLength(Connections, 0);
  Connections := nil;
  UnitNetstat2.GetConnections(Connections);

  if (Connections <> nil) and (oldConnections <> nil) then
  begin

    for i:=0 to Length(Connections) - 1 do
    begin
      if (Connections[i].ConnectionState = 5) then
      begin
        if not UnitNetstat2.FindConnection(Connections[i], oldConnections) then
        begin
          if Connections[i].Protocol = PROTOCOL_TCP then
            sProtocol := 'TCP'
          else
            sProtocol := 'UDP';

          ListViewLogsNetstat.Items.Add();
          index := ListViewLogsNetstat.Items.Count-1;
          ListViewLogsNetstat.Items.Item[index].SubItems.Add(IntToStr(Connections[i].ProcessID));
          ListViewLogsNetstat.Items.Item[index].SubItems.Add(sProtocol);
          ListViewLogsNetstat.Items.Item[index].SubItems.Add(IpAddressToString(Connections[i].LocalAddress));
          ListViewLogsNetstat.Items.Item[index].SubItems.Add(IntToStr(ntohs(Connections[i].LocalRawPort)));
          ListViewLogsNetstat.Items.Item[index].SubItems.Add(IpAddressToString(Connections[i].RemoteAddress));
          ListViewLogsNetstat.Items.Item[index].SubItems.Add(IntToStr(ntohs(Connections[i].RemoteRawPort)));
          //ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].SubItems.Add(TcpConnectionStates[Connections[i].ConnectionState]);

          ListViewLogsNetstat.Items.Item[index].SubItems.Add(GetDomainFromIP(IpAddressToString(Connections[i].RemoteAddress)));

          // Set caption after all (at the end) to prevent some issues
          // Mettre cette ligne à la fin pour éviter un bug à l'affichage
          ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].Caption := TaskManager.GetExeNameFromPID(Connections[i].ProcessID);
          Application.ProcessMessages;
          Sleep(100);
          Application.ProcessMessages;
          if LogNetstatAutoScroll.Checked then
          begin
            p := ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].Position;
            ListViewLogsNetstat.Scroll(p.X, p.Y);

          end;
        end;
      end;
    end;
    {
    for i:=0 to Length(oldConnections) - 1 do
    begin
      if not UnitNetstat2.FindConnection(oldConnections[i], Connections) then
      begin
        if oldConnections[i].Protocol = PROTOCOL_TCP then
          sProtocol := 'TCP'
        else
          sProtocol := 'UDP';

        ListViewLogsNetstat.Items.Add();
        ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].SubItems.Add(IntToStr(oldConnections[i].ProcessID));
        ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].SubItems.Add(sProtocol);
        ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].SubItems.Add(IpAddressToString(oldConnections[i].LocalAddress));
        ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].SubItems.Add(IntToStr(ntohs(oldConnections[i].LocalRawPort)));
        ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].SubItems.Add(IpAddressToString(oldConnections[i].RemoteAddress));
        ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].SubItems.Add(IntToStr(ntohs(oldConnections[i].RemoteRawPort)));
        ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].SubItems.Add(TcpConnectionStates[oldConnections[i].ConnectionState]);
        // Set caption after all (at the end) to prevent some issues
        // Mettre cette ligne à la fin pour éviter un bug à l'affichage
        ListViewLogsNetstat.Items.Item[ListViewLogsNetstat.Items.Count-1].Caption := TaskManager.GetExeNameFromPID(oldConnections[i].ProcessID);
        //Application.ProcessMessages;
        //Sleep(300);
      end;
    end;
    }
    if isXP then
    begin
      if ListViewLogsNetstat.Items.Count > 50 then
        ListViewLogsNetstat.Items[0].Delete;
    end else begin
      if ListViewLogsNetstat.Items.Count > 200 then
        ListViewLogsNetstat.Items[0].Delete;
    end;

  end;
  //if oldConnections <> nil then FreeMem(oldConnections);
  //FreeAndNil(oldConnections);
  SetLength(oldConnections, 0);
  oldConnections := nil;
  oldConnections := Connections;
  SetLength(Connections, 0);
  //if Connections <> nil then FreeMem(Connections);
  Connections := nil;
  TTimer(Sender).Enabled := True;
end;

procedure TForm1.LogDNSAutoScrollClick(Sender: TObject);
begin
  LogDNSAutoScroll.Checked := not LogDNSAutoScroll.Checked;

  if LogDNSAutoScroll.Checked then
    WriteInFile(DataDirectoryPath + 'LogDNSAutoScroll.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'LogDNSAutoScroll.cfg');

end;

procedure TForm1.ListViewLogsNetstatContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  ListItem:TListItem;
  CurPos:TPoint;
begin
  GetcursorPos(MousePos);
  PopupMenuListViewLogsNetstat.Popup(MousePos.x, MousePos.y);
  CurPos:=TListView(Sender).ScreenToClient(MousePos);
  ListItem:=TListView(Sender).GetItemAt(CurPos.x,CurPos.y);
  if Assigned(ListItem) then
  begin
    SelectedListItem := ListItem;
  end;
end;

procedure TForm1.LogNetstatAutoScrollClick(Sender: TObject);
begin
  LogNetstatAutoScroll.Checked := not LogNetstatAutoScroll.Checked;

  if LogNetstatAutoScroll.Checked then
    WriteInFile(DataDirectoryPath + 'LogNetstatAutoScroll.cfg', '1')
  else
    DeleteFile(DataDirectoryPath + 'LogNetstatAutoScroll.cfg');
end;

procedure TForm1.EraseLogsListViewDNSClick(Sender: TObject);
begin
  ListViewLogs.Clear;
end;

procedure TForm1.EraseLogsListViewNetstatClick(Sender: TObject);
begin
  ListViewLogsNetstat.Clear;
end;
     

procedure TForm1.ButtonCopyEditDonationClick(Sender: TObject);
begin
  EditSourceURL.SelectAll;
  EditSourceURL.CopyToClipboard;
  LabelMessage.Caption := PChar('Copié!');
  PanelMessage.Visible := True;
  TimerHideMessage.Enabled := True;
end;

end.

