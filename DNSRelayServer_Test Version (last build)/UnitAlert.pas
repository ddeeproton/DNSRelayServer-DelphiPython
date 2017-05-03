unit UnitAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,  
  HostParser, Buttons;

type
  TFormAlert = class(TForm)
    PanelDisallowed: TPanel;
    PanelAllowed: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    TimerAfterCreate: TTimer;
    ButtonAllowDomain: TSpeedButton;
    ButtonDisallow: TSpeedButton;
    procedure ButtonAllowDomainClick(Sender: TObject);
    procedure ButtonDisallowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PanelAllowedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAlert: TFormAlert;

implementation

{$R *.dfm}

uses Unit1;

procedure TFormAlert.ButtonAllowDomainClick(Sender: TObject);
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

  for i := 0 to form1.ListView1.Items.Count-1 do
  begin
    if form1.ListView1.Items[i].Caption =  domain then begin
      try

      form1.SelectedListItem := form1.ListView1.Items[i];
      form1.ListView1.Items[i].Caption := '';
      //form1.ListView1.Items[i].SubItems[0] := '';
      //form1.Autoriser1Click(Form1.Autoriser1);
      delDomain(form1.EditFilehost.Text, domain);
      Form1.TimerRestart.Enabled := False;
      if Form1.isServerStarted then Form1.TimerRestart.Enabled := True; //Form1.ButtonStartClick(nil);
            except
        On E :   EOSError do
          exit;
      end;
    end;
  end;

  //Self.Close;
  //FormAlert.Visible := False;
  PanelAllowed.Visible := True;
  PanelDisallowed.Visible := False;
  ButtonAllowDomain.Visible := False;
  ButtonDisallow.Visible := False;

end;


procedure TFormAlert.ButtonDisallowClick(Sender: TObject);
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
  Form1.refreshListView1Click();
  Form1.TimerRestart.Enabled := False;
  if Form1.isServerStarted then Form1.TimerRestart.Enabled := True; //Form1.ButtonStartClick(nil);
  //Self.Close;
  PanelAllowed.Visible := False;
  PanelDisallowed.Visible := True;
  ButtonAllowDomain.Visible := False;
  ButtonDisallow.Visible := False;
end;

procedure TFormAlert.FormCreate(Sender: TObject);
begin
  PanelAllowed.Top := 0;
  PanelDisallowed.Top := 0;
  Self.Height := PanelAllowed.Height;
  Self.Width := Label1.Width + ButtonAllowDomain.Width + 20;
  Self.Left := Screen.WorkAreaWidth - Self.Width;
  //Self.Top := Screen.WorkAreaHeight - Self.Height;
  //Self.SendToBack;
end;

procedure TFormAlert.PanelAllowedClick(Sender: TObject);
begin
  Self.Close;
end;

end.
