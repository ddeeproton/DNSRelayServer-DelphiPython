unit UnitHost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormHost = class(TForm)
    Memo1: TMemo;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Filename: string;
    procedure Load();
  end;

var
  FormHost: TFormHost;

implementation

{$R *.dfm}


procedure writeFile(Fichier, txt : string);
var
  Fp : textfile;
begin
  assignFile(Fp, Fichier);
  reWrite(Fp);
  Writeln(Fp, txt);
  closefile(Fp);
end;

function readFile(Filename: string):String;
var
  Fichier        : textfile;
  texte          : string;
begin
  result:= '';
  assignFile(Fichier, Filename);
  reset(Fichier); // ouvre en lecture
  while not eof(Fichier) do begin
    readln(Fichier, texte);
    result := result + texte + #13 + #10;
  end;
  closefile(Fichier);
end;

procedure TFormHost.Load();
begin
  if not FileExists(Filename) then
    writeFile(Filename, '127.0.0.1	localhost');

  {
  if not FileExists(Filename) then
    if MessageDlg('Le fichier host n''existe pas, le créer?',  mtConfirmation, [mbYes, mbNo], 0) = IDNO then
      Exit
    else
      ecrireDansUnFichier(EditFilehost.Text, '127.0.0.1	localhost');
  }
  
  Memo1.Lines.LoadFromFile(Filename);
  Self.Caption := PChar('Edit "'+Filename+'"');
end;

procedure TFormHost.ButtonCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormHost.ButtonSaveClick(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(Filename);
  Self.Close;
end;

end.
