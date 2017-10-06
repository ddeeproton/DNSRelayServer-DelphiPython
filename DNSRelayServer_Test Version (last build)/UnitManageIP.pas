unit UnitManageIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UnitDialogIP, FilesManager, PythonDNSUnit;

type
  TFormManageIP = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    ButtonAjouter: TButton;
    ButtonSupprimer: TButton;
    ButtonClose: TButton;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonAjouterClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSupprimerClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormManageIP: TFormManageIP;

implementation

{$R *.dfm}

uses Unit1;

procedure TFormManageIP.ButtonCloseClick(Sender: TObject);
begin
  Form1.Masquer1Click(nil);
  Close;
end;

procedure TFormManageIP.ButtonAjouterClick(Sender: TObject);
begin
  Hide;
  TActionManageIP.addIP(False);
  ListBox1.Items := TActionManageIP.loadListIP();
  Show;
end;

procedure TFormManageIP.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Form1.Afficher1Click(nil);
end;

procedure TFormManageIP.FormCreate(Sender: TObject);
begin
  ListBox1.Items := TActionManageIP.loadListIP();
end;

procedure TFormManageIP.ButtonSupprimerClick(Sender: TObject);
var
  i: Integer;
  ip: String;
begin

  i := ListBox1.ItemIndex;
  if i = -1 then exit;
  ip := ListBox1.Items.Strings[i];
  if MessageDlg(PChar('Effacer '+ip+'?'),  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then exit;

  TActionManageIP.eraseIP(ip);
end;

end.
