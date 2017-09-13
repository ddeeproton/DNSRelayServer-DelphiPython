unit UnitDialogIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormDialogIP = class(TForm)
    Edit4: TEdit;
    Memo4: TMemo;
    Memo3: TMemo;
    Memo2: TMemo;
    Memo1: TMemo;
    Label3: TLabel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDialogIP: TFormDialogIP;

implementation

{$R *.dfm}

procedure TFormDialogIP.FormCreate(Sender: TObject);
begin
  Memo1.Text := '';
  Memo2.Text := '';
  Memo3.Text := '';
  Memo4.Text := '';
end;

procedure TFormDialogIP.MemoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  m, m2: TMemo;
begin
  //ShowMessage(IntToStr(Key));
  if Key = 13 then exit; // key = Enter
  if Key = 27 then exit; // key = Escape
  if Key = 37 then exit; // key = left
  if Key = 38 then exit; // key = up
  if Key = 39 then exit; // key = right
  if Key = 40 then exit; // key = down
  m := TMemo(Sender);
  m2 := nil;
  if (Length(m.Text) > 2) then // if key "." pressed
  begin
    if (StrToInt(m.Text) < 1) or (StrToInt(m.Text) > 255) then
    begin
      ShowMessage(m.Text + ' is not a valid entry. Please specify a value between 1 and 255.');
      exit;
    end;
  end;
  if (Length(m.Text) > 2) or ((Length(m.Text) > 0) and (Key = 190)) then // if key "." pressed
  begin
    if m.Name = 'Memo1' then m2 := Memo2;
    if m.Name = 'Memo2' then m2 := Memo3;
    if m.Name = 'Memo3' then m2 := Memo4;
  end;
  if (Length(m.Text) = 0) and (Key = 8) then // if key "Backspace" pressed
  begin
    if m.Name = 'Memo4' then m2 := Memo3;
    if m.Name = 'Memo3' then m2 := Memo2;
    if m.Name = 'Memo2' then m2 := Memo1;
  end;
  if m2 <> nil then
  begin
    m2.SetFocus;
    m2.SelStart := Length(m2.Text);
  end;
end;

procedure TFormDialogIP.MemoKeyPress(Sender: TObject; var Key: Char);
begin
  //ShowMessage(IntToStr(ord(Key)));
  if ord(Key) = 13 then ButtonOKClick(nil); // Key = Enter
  if ord(Key) = 27 then ButtonCancelClick(nil); // Key = Escpape
  if ord(Key) = 8 then exit;   // key = Backspace
  if (Key = '.') or ((ord(Key) < ord('0')) or (ord(Key) > ord('9'))) then Key := #0;
end;

procedure TFormDialogIP.ButtonOKClick(Sender: TObject);
begin
  ShowMessage('En cours d''implémentation :)');
  Close;
end;

procedure TFormDialogIP.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

end.
