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
    ButtonModifier: TButton;
    ButtonSupprimer: TButton;
    ButtonClose: TButton;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonAjouterClick(Sender: TObject);
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
  Close;
end;

procedure TFormManageIP.ButtonAjouterClick(Sender: TObject);
var ip: string;
begin
  if FormDialogIP = nil then FormDialogIP := TFormDialogIP.Create(nil);
  FormDialogIP.isDone := False;
  FormDialogIP.ip := '';
  FormDialogIP.Show;
  Application.ProcessMessages;
  while not FormDialogIP.isDone do
  begin
    Sleep(100);
    Application.ProcessMessages;
  end;
  ip := FormDialogIP.ip;
  if ip = '' then exit;

  with Form1 do
  begin
    if not DirectoryExists(DirCustomHost) then makeDir(DirCustomHost);

    FilesManager.WriteInFile(DirCustomHost+'\'+ip+'_blackhost.txt', '');
    PythonDNS.getIPCustomHostFiles(ComboBoxSelectIPBlackhost, '_blackhost.txt');
    ComboBoxSelectIPBlackhost.ItemIndex := ComboBoxSelectIPBlackhost.Items.IndexOf(ip);

    FilesManager.WriteInFile(DirCustomHost+'\'+ip+'_hostfile.txt', '');
    PythonDNS.getIPCustomHostFiles(ComboBoxSelectIPhostfile, '_hostfile.txt');
    ComboBoxSelectIPhostfile.ItemIndex := ComboBoxSelectIPhostfile.Items.IndexOf(ip);

    //if oldIndexHost > ComboBoxSelectIPhostfile.Items.Count - 1 then oldIndexHost := 0;
    //ComboBoxSelectIPhostfile.ItemIndex := oldIndexHost;
  end;
end;

end.
