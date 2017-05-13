unit UnitAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  HostParser, Buttons, ImgList, Menus, FilesManager, WindowsManager;

type
  TFormAlert = class(TForm)
    PanelDisallowed: TPanel;
    PanelAllowed: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    TimerAfterCreate: TTimer;
    ButtonMenuForDisallowed: TSpeedButton;
    ButtonMenuForAllowed: TSpeedButton;
    Image1: TImage;
    Image2: TImage;
    SpeedButtonClosePanelUpdateTheme: TSpeedButton;
    SpeedButton1: TSpeedButton;
    CheckBoxStay: TCheckBox;
    CheckBoxStay2: TCheckBox;
    PopupMenuForAllowed: TPopupMenu;
    Bloquerparfichierhost1: TMenuItem;
    BloquerparfichierBlackwords1: TMenuItem;
    PopupMenuForDisallowed: TPopupMenu;
    AutoriserledomainedufichierHost1: TMenuItem;
    AutoriserledomaineBlackwords1: TMenuItem;
    Desactiverlebloquagedetouslesdomaines1: TMenuItem;
    DisableAlertDisallowed: TMenuItem;
    Dsactiverlesalertespourlesdomainesautoriss1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ButtonDisableBlockHost: TMenuItem;
    ButtonDisableBlockBlackwords: TMenuItem;
    N3: TMenuItem;
    Bloquertout1: TMenuItem;
    Edit1: TEdit;
    TimerFadeIn: TTimer;
    TimerFadeOut: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure PanelAllowedClick(Sender: TObject);
    procedure Bloquerparfichierhost1Click(Sender: TObject);
    procedure ButtonMenuForDisallowedClick(Sender: TObject);
    procedure ButtonMenuForAllowedClick(Sender: TObject);
    procedure BloquerparfichierBlackwords1Click(Sender: TObject);
    procedure AutoriserledomaineBlackwords1Click(Sender: TObject);
    procedure CheckBoxStayClick(Sender: TObject);
    procedure AutoriserledomainedufichierHost1Click(Sender: TObject);
    procedure Desactiverlebloquagedetouslesdomaines1Click(Sender: TObject);
    procedure DisableAlertDisallowedClick(Sender: TObject);
    procedure Dsactiverlesalertespourlesdomainesautoriss1Click(
      Sender: TObject);
    procedure ButtonDisableBlockHostClick(Sender: TObject);
    procedure ButtonDisableBlockBlackwordsClick(Sender: TObject);
    procedure Bloquertout1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure TimerFadeInTimer(Sender: TObject);
    procedure TimerFadeOutTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAlert: TFormAlert;
  opacity: Integer;
implementation

{$R *.dfm}

uses Unit1;

procedure TFormAlert.FormCreate(Sender: TObject);
var
  i: integer;
  domain, txt: string;
begin

  Self.FormStyle := fsStayOnTop;
  //Self.Show;
  //Systray.EnleveIconeTray;
  //Systray.AjouteIconeTray(Handle,Application.Icon.Handle,Self.Caption);
  PanelAllowed.Top := 0;
  PanelDisallowed.Top := 0;
  Self.Height := PanelAllowed.Height;
  Self.Width := Label1.Width
    + ButtonMenuForAllowed.Width
    + SpeedButtonClosePanelUpdateTheme.Width
    + CheckBoxStay.Width
    + 10
    + Label1.Left;
  Self.Left := Screen.WorkAreaWidth - Self.Width - 30;

  PanelAllowed.Visible := True;
  PanelDisallowed.Visible := False;
  //Self.Top := Screen.WorkAreaHeight - Self.Height;
  //Self.SendToBack;

  Desactiverlebloquagedetouslesdomaines1.Visible := Form1.ToolButtonBlockAll.Down;
  if Form1.ToolButtonBlockAll.Down then
  begin
    PanelAllowed.Visible := False;
    PanelDisallowed.Visible := True;
  end;

  AutoriserledomainedufichierHost1.Visible := False;
  AutoriserledomaineBlackwords1.Visible := False;
  ButtonDisableBlockHost.Visible := False;
  ButtonDisableBlockBlackwords.Visible := False;
  domain := Label1.Caption;
  if domain <> '' then
  begin
    txt := ReadFromFile(form1.EditFilehost.Text);
    if Pos('127.0.0.1	'+domain, txt) > 0 then
    begin
      AutoriserledomainedufichierHost1.Visible := True;
      PanelAllowed.Visible := False;
      PanelDisallowed.Visible := True;
      if not Form1.ButtonDisableHost.Down then ButtonDisableBlockHost.Visible := True;
    end;
    with Form1 do
    begin
      for i:= 0 to ListBoxBlacklist.Items.Count - 1 do
      begin
        txt := ListBoxBlacklist.Items.Strings[i];
        if Pos(txt, domain) > 0 then
        begin
          AutoriserledomaineBlackwords1.Visible := True;
          PanelAllowed.Visible := False;
          PanelDisallowed.Visible := True;
          if not Form1.ButtonDisableBlackhost.Down then ButtonDisableBlockBlackwords.Visible := True;
        end;
      end;
    end;

  end;
  Edit1.Width := Label1.Width + 5;
  Edit1.Text := Label1.Caption;

  opacity := 0;
  SetFormOpacity(Self.Handle, opacity);
  TimerFadeIn.Enabled := True;
end;

procedure TFormAlert.PanelAllowedClick(Sender: TObject);
begin
  opacity := 100;
  TimerFadeOut.Enabled := True;
end;


procedure TFormAlert.AutoriserledomainedufichierHost1Click(
  Sender: TObject);
var
  i: integer;
  domain: string;
begin
  domain := Label1.Caption;
  if domain = '' then exit;

  //delDomain(Form1.EditFilehost.Text, domain);
  //if Form1.isServerStarted then Form1.ButtonStartClick(nil);
  //Form1.refreshListView1Click();
  //Self.Visible := False;

  //for i := 0 to form1.ListView1.Items.Count-1 do
  i := 0;
  while i < form1.ListView1.Items.Count do
  begin
    if form1.ListView1.Items[i].Caption =  domain then
    begin
      try
        form1.SelectedListItem := form1.ListView1.Items[i];
        //form1.ListView1.Items[i].Caption := '';
        //form1.ListView1.Items[i].SubItems[0] := '';
        //form1.Autoriser1Click(Form1.Autoriser1);
        form1.ListView1.Items[i].Delete;
        form1.MemoLogs.Lines.Add('Débloquage de '+domain);
        delDomain(form1.EditFilehost.Text, domain);
        Form1.TimerRestart.Enabled := False;
        if Form1.isServerStarted then Form1.TimerRestart.Enabled := True; //Form1.ButtonStartClick(nil);
      except
        On E :   EOSError do
          exit;
      end;
    end
    else begin
        Inc(i);
    end;
  end;

  FormCreate(nil);
  TimerAfterCreate.Enabled := True;
  CheckBoxStay.Checked := False;
  CheckBoxStay2.Checked := False;
end;

procedure TFormAlert.Bloquerparfichierhost1Click(Sender: TObject);
var
  i: integer;
  domain: string;
begin
  domain := Label2.Caption;
  if domain = '' then exit;
  for i := 0 to form1.ListView1.Items.Count-1 do
  begin
    if form1.ListView1.Items[i].Caption =  domain then form1.ListView1.Items[i].SubItems.Strings[0] := '127.0.0.1';
  end;
  setDomain(Form1.EditFilehost.Text, domain, '127.0.0.1');
  Form1.MemoLogs.Lines.Add('Bloquage de '+domain);
  Form1.refreshListView1Click();
  Form1.TimerRestart.Enabled := False;
  if Form1.isServerStarted then Form1.TimerRestart.Enabled := True; //Form1.ButtonStartClick(nil);
  FormCreate(nil);
end;

procedure TFormAlert.BloquerparfichierBlackwords1Click(Sender: TObject);
var domain: string;
begin
  domain := Label2.Caption;
  with Form1 do
  begin
    if not InputQuery('Add Blackword', 'Interdit tous les domaines comportant le mot suivant', domain) then exit;
    ListBoxBlacklist.Items.Add(domain);
    ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
    TimerRestart.Enabled := isServerStarted;
  end;
  FormCreate(nil);
  TimerAfterCreate.Enabled := False;
  CheckBoxStay.Checked := True;
  CheckBoxStay2.Checked := True;
end;

procedure TFormAlert.AutoriserledomaineBlackwords1Click(Sender: TObject);
var
  i :integer;
  txt, domain: string;
  callRestart, isFound: boolean;
begin
  domain := Label2.Caption;
  with Form1 do
  begin
    callRestart := False;
    isFound := False;
    i := 0;
    while i < ListBoxBlacklist.Items.Count do
    begin
      txt := ListBoxBlacklist.Items.Strings[i];
       if Pos(txt, domain) > 0 then
       begin
         isFound := True;
         if MessageDlg(PChar('Effacer l''entrée suivante du Blackword? ['+txt+']'),  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
         begin
            callRestart := True;
            ListBoxBlacklist.ItemIndex := i;
            ListBoxBlacklist.DeleteSelected;
            ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
            Form1.TimerRestart.Enabled := False;
            if Form1.isServerStarted then Form1.TimerRestart.Enabled := True;
         end else
         begin
           Inc(i);
         end;
       end
       else begin
         Inc(i);
       end;
    end;
    if callRestart then TimerRestart.Enabled := True;  //and isServerStarted
    if not isFound then ShowMessage('Pas de bloquage trouvé');
  end;
  FormCreate(nil);
  TimerAfterCreate.Enabled := True;
  CheckBoxStay.Checked := False;
  CheckBoxStay2.Checked := False;
end;


procedure TFormAlert.ButtonMenuForDisallowedClick(Sender: TObject);
var
  Pos:TPoint;
begin
  TimerAfterCreate.Enabled := False;
  CheckBoxStay.Checked := True;
  CheckBoxStay2.Checked := True;
  GetCursorPos(Pos);
  PopupMenuForDisallowed.Popup(Pos.X,Pos.Y);
  FormCreate(nil);
end;

procedure TFormAlert.ButtonMenuForAllowedClick(Sender: TObject);
var
  Pos:TPoint;
begin
  TimerAfterCreate.Enabled := False;
  CheckBoxStay.Checked := True;
  CheckBoxStay2.Checked := True;
  GetCursorPos(Pos);
  PopupMenuForAllowed.Popup(Pos.X,Pos.Y);
  FormCreate(nil);
end;


procedure TFormAlert.CheckBoxStayClick(Sender: TObject);
begin
  TimerAfterCreate.Enabled := not TCheckBox(Sender).Checked;
  CheckBoxStay.Checked := not TimerAfterCreate.Enabled;
  CheckBoxStay2.Checked := not TimerAfterCreate.Enabled;
  FormCreate(nil);
end;


procedure TFormAlert.Desactiverlebloquagedetouslesdomaines1Click(
  Sender: TObject);
begin
  Form1.MemoLogs.Lines.Add('Bloquage de tous les domaines [désactivé].');
  DeleteFile(Form1.DataDirectoryPath + 'disableAll.cfg');
  Form1.ToolButtonBlockAll.Down := False;
  Desactiverlebloquagedetouslesdomaines1.Checked := False;
  Form1.TimerRestart.Enabled := False;
  if Form1.isServerStarted then Form1.TimerRestart.Enabled := True;
  FormCreate(nil);
end;

procedure TFormAlert.DisableAlertDisallowedClick(Sender: TObject);
begin
  Form1.CheckBoxAlertEventDisallowed.Checked := False;
  Form1.CheckBoxAlertEventDisallowedClick(Form1.CheckBoxAlertEventDisallowed);
  FormCreate(nil);
end;

procedure TFormAlert.Dsactiverlesalertespourlesdomainesautoriss1Click(
  Sender: TObject);
begin
  Form1.CheckBoxAlertEventsKnown.Checked := False;
  Form1.CheckBoxAlertEventsKnownClick(Form1.CheckBoxAlertEventsKnown);
  Form1.CheckBoxAlertEventsUnknown.Checked := False;
  Form1.CheckBoxAlertEventsUnknownClick(Form1.CheckBoxAlertEventsUnknown);
  FormCreate(nil);
end;

procedure TFormAlert.ButtonDisableBlockHostClick(Sender: TObject);
begin
  with Form1 do
  begin
    ButtonDisableHost.Down := False;
    MemoLogs.Lines.Add('Activation du du fichier Host.');
    DeleteFile(DataDirectoryPath + 'disableHost.cfg');
    Form1.TimerRestart.Enabled := False;
    if Form1.isServerStarted then Form1.TimerRestart.Enabled := True;
  end;
  FormCreate(nil);
end;

procedure TFormAlert.ButtonDisableBlockBlackwordsClick(Sender: TObject);
begin
  with Form1 do
  begin
    ButtonDisableBlackhost.Down := False;
    MemoLogs.Lines.Add('Activation du filtre Blackwords.');
    DeleteFile(DataDirectoryPath + 'disableBlackhost.cfg');
    Form1.TimerRestart.Enabled := False;
    if Form1.isServerStarted then Form1.TimerRestart.Enabled := True;
  end;
  FormCreate(nil);
end;
          
procedure TFormAlert.Bloquertout1Click(Sender: TObject);
begin
  with Form1 do
  begin
    ToolButtonBlockAll.Down := True;
    ToolButtonBlockAllClick(ToolButtonBlockAll);
    Form1.TimerRestart.Enabled := False;
    if Form1.isServerStarted then Form1.TimerRestart.Enabled := True;
  end;
  FormCreate(nil);
end;

procedure TFormAlert.Label2Click(Sender: TObject);
begin
  Edit1.Visible := True;
  Edit1.SetFocus;
  Edit1.SelectAll;
  CheckBoxStay2.Checked := True;
  TimerAfterCreate.Enabled := False;
end;

procedure TFormAlert.Edit1Enter(Sender: TObject);
begin
  Edit1.SelectAll;
end;



procedure TFormAlert.TimerFadeInTimer(Sender: TObject);
begin
  SetFormOpacity(Self.Handle, opacity);
  //Application.ProcessMessages;
  if opacity < 100 then Inc(opacity) else TTimer(Sender).Enabled := False;
end;

procedure TFormAlert.TimerFadeOutTimer(Sender: TObject);
begin                                               
  SetFormOpacity(Self.Handle, opacity);
  //Application.ProcessMessages;
  if opacity > 0 then
    Dec(opacity)
  else
  begin
    TTimer(Sender).Enabled := False;
    Self.Close;
    Self.Free;
  end;
end;

end.
