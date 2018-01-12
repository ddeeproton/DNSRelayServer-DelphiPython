unit UnitDialogIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FilesManager;

type
  TFormDialogIP = class(TForm)
    Edit4: TEdit;
    Memo4: TMemo;
    Memo3: TMemo;
    Memo2: TMemo;
    Memo1: TMemo;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    function isValidIP(): Boolean;
    function getIP(): String;
    function waitForValue(): string;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }  
    TargetHost: String;
    TargetComboBox: TComboBox;
    isDone: Boolean;
    ip: String;
  end;

var
  FormDialogIP: TFormDialogIP;

implementation

{$R *.dfm}

uses Unit1;

procedure TFormDialogIP.FormCreate(Sender: TObject);
begin
  isDone := False;
  ip := '';
  Memo1.Text := '';
  Memo2.Text := '';
  Memo3.Text := '';
  Memo4.Text := '';
end;


function TFormDialogIP.waitForValue(): string;
begin
  isDone := False;
  ip := '';
  Show;    
  Memo1.SetFocus;
  Application.ProcessMessages;
  while not isDone do
  begin
    Sleep(10);
    Application.ProcessMessages;
  end;
  result := ip;
end;

procedure TFormDialogIP.MemoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  m, m2: TMemo;
begin
  m := TMemo(Sender);
  m2 := nil;

  //ShowMessage(IntToStr(Key));
  if Key = 13 then exit; // key = Enter
  if Key = 27 then exit; // key = Escape
  //if Key = 37 then exit; // key = left
  if Key = 38 then exit; // key = up
  //if Key = 39 then exit; // key = right
  if Key = 40 then exit; // key = down


  Label1.Visible := (m.Text <> '') and ((StrToInt(m.Text) < 1) or (StrToInt(m.Text) > 255));
  if (Length(m.Text) > 2) then
  begin
    if (StrToInt(m.Text) < 1) or (StrToInt(m.Text) > 255) then
    begin
      //ShowMessage(m.Text + ' is not a valid entry. Please specify a value between 1 and 255.');
      exit;
    end;
  end;

  if ((Length(m.Text) > 2) and not (Key = 37)) // Key = Left
  or ((Length(m.Text) > 0) and (Key = 190)) // if key "." pressed
  or ((Key = 39) and (m.SelStart > 0)) then // if key = right pressed
  begin
    if m.Name = 'Memo1' then m2 := Memo2;
    if m.Name = 'Memo2' then m2 := Memo3;
    if m.Name = 'Memo3' then m2 := Memo4;
  end;
  if ((Length(m.Text) = 0) and (Key = 8)) // if key "Backspace" pressed
  or ((Key = 37) and (m.SelStart = 0)) then  // if key = left pressed
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
  ButtonOK.Enabled := isValidIP();
end;

procedure TFormDialogIP.MemoKeyPress(Sender: TObject; var Key: Char);
begin
  //ShowMessage(IntToStr(ord(Key)));
  if ord(Key) = 13 then ButtonOKClick(nil); // Key = Enter
  if ord(Key) = 27 then ButtonCancelClick(nil); // Key = Escpape
  if ord(Key) = 8 then exit;   // key = Backspace
  if ord(Key) = 37 then exit;   // key = Left
  if (Key = '.') or ((ord(Key) < ord('0')) or (ord(Key) > ord('9'))) then Key := #0;
end;

function TFormDialogIP.isValidIP(): Boolean;
var
  i, value: Integer;
  MList: array[1..4] of TMemo;
begin
  result := True;
  MList[1] := Memo1;
  MList[2] := Memo2;
  MList[3] := Memo3;
  MList[4] := Memo4;
  for i := 1 to Length(MList) do
  begin
    value := 0;
    TryStrToInt(MList[i].Text, value);
    if (value < 1) or (value > 255) then
    begin
      result := False;
      exit;
    end;
  end;
end;

function TFormDialogIP.getIP(): String;
var
  i: Integer;
  MList: array[1..4] of TMemo;
begin
  result := '';
  MList[1] := Memo1;
  MList[2] := Memo2;
  MList[3] := Memo3;
  MList[4] := Memo4;
  for i := 1 to Length(MList) do
  begin
    if result <> '' then result := result + '.';
    result := result + MList[i].Text;
  end;
end;




procedure TFormDialogIP.ButtonOKClick(Sender: TObject);
begin
  if not isValidIP() then
  begin
    ShowMessage('IP is not valid. Please specify a value between 1 and 255.');
    exit;
  end;
  ip := getIP();
  {
  with Form1 do
  begin
    if not DirectoryExists(DirCustomHost) then makeDir(DirCustomHost);
    FilesManager.WriteInFile(DirCustomHost+'\'+ip+'_'+FormDialogIP.TargetHost+'.txt', '');
    PythonDNS.getIPCustomHostFiles(TargetComboBox, '_'+FormDialogIP.TargetHost+'.txt');
    TargetComboBox.ItemIndex := TargetComboBox.Items.IndexOf(ip);
  end;
  }
  isDone := True;
  Close;

end;

procedure TFormDialogIP.ButtonCancelClick(Sender: TObject);
begin
  isDone := True;
  Close;
end;

procedure TFormDialogIP.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  isDone := True;
end;

end.
