unit UnitAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  HostParser;

type
  TFormAlert = class(TForm)
    PanelDisallowed: TPanel;
    PanelAllowed: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ButtonDisallow: TButton;   
    ButtonAllowDomain: TButton;
    TimerAfterCreate: TTimer;
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
  for i := 0 to form1.ListView1.Items.Count-1 do
  begin
    if form1.ListView1.Items[i].Caption =  domain then form1.ListView1.Items[i].Delete;
  end;
  Form1.refreshListView1Click();
  delDomain(Form1.EditFilehost.Text, domain);
  if Form1.isServerStarted then Form1.ButtonStartClick(nil);
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
  if Form1.isServerStarted then Form1.ButtonStartClick(nil);
end;

procedure TFormAlert.FormCreate(Sender: TObject);
begin
  Self.Height := PanelAllowed.Height;
  Self.Width := Label1.Width + ButtonAllowDomain.Width + 100;
  Self.Left := Screen.WorkAreaWidth - Self.Width;
  Self.Top := Screen.WorkAreaHeight - Self.Height;
  Self.SendToBack;
end;

procedure TFormAlert.PanelAllowedClick(Sender: TObject);
begin
  Self.Close;
end;

end.
