unit AlertManager;

interface

uses
  Forms, UnitAlert;

const
  TAILLE_MAX_PILE = 300;
type
  TRecordAlert = record
    index: Integer;
    domain: String;
    typeAlert: Integer;
    FormAlert: TFormAlert;
  end;
  // List of TRecordAlert
  PAlert = ^TAlert;
  TAlert = record
    data: TRecordAlert;
    next: PAlert;
  end;
var
  MainListAlert: PAlert;

procedure AddAlert(out ListAlert: PAlert; data: TRecordAlert);
procedure ShowAllAlert(ListAlert: PAlert);
procedure EraseAlertIndex(out ListAlert: PAlert; i: Integer);
function EraseAlert(ListAlert: PAlert): PAlert;
procedure doAlert(data: TRecordAlert);
procedure createNewAlert(out FormAlert: TFormAlert; data: TRecordAlert);

implementation


uses
  Unit1, SysUtils;



procedure AddAlert(out ListAlert: PAlert; data: TRecordAlert);
var
  newAlert: PAlert;
  i: Integer;
begin
  if ListAlert = nil then i := 0 else i := ListAlert.data.index + 1;
  data.index := i;
  new(newAlert);
  newAlert^.data := data;
  newAlert^.next := ListAlert;
  ListAlert := newAlert;
end;

procedure ShowAllAlert(ListAlert: PAlert);
var
  temp: PAlert;
begin
  temp := ListAlert;
  while temp <> nil do
  begin
    doAlert(temp.data);
    //temp := EraseAlert(temp);
    Application.ProcessMessages;
    //Sleep(2000);
    //temp^.data.domain;
    temp := temp^.next;
  end;
end;


procedure createNewAlert(out FormAlert: TFormAlert; data: TRecordAlert);
begin
  with Form1 do begin
  if CountFormAlert > 20 then exit;
  inc(CountFormAlert);
  FormAlert := TFormAlert.Create(Form1);
  //FormAlert.Hint := IntToStr(data.index);
  FormAlert.Hint := IntToStr(data.typeAlert);

  if SpinEditAlertDuration.Value < 3 then SpinEditAlertDuration.Value := 3;
  FormAlert.TimerAfterCreate.Interval := SpinEditAlertDuration.Value * 1000;
  FormAlert.Label1.Caption := data.domain;
  FormAlert.Label2.Caption := data.domain;
  FormAlertLastShow := data.domain;
  FormAlert.Color := Form1.Color;
  FormAlert.Label1.Font.Color := Form1.Font.Color;
  FormAlert.Label2.Font.Color := Form1.Font.Color;

  TimerResetAlertPosition.Enabled := False;
  TimerResetAlertPosition.Interval := FormAlert.TimerAfterCreate.Interval + 1000;
  TimerResetAlertPosition.Enabled := True;
  FormAlert.ButtonMenuForDisallowed.Font.Color := Form1.Font.Color;
  FormAlert.ButtonMenuForAllowed.Font.Color := Form1.Font.Color;
  FormAlert.PanelAllowed.Color := Form1.Color;
  FormAlert.PanelDisallowed.Color := Form1.Color;
  LastPositionFormAlertTop := LastPositionFormAlertTop - FormAlert.Height;
  if LastPositionFormAlertTop <= Screen.WorkAreaHeight div 3 then
    LastPositionFormAlertTop := Screen.WorkAreaHeight - ( FormAlert.Height * 2);
  FormAlert.Top := LastPositionFormAlertTop;
  FormAlert.FormCreate(nil);
  end;
end;


procedure doAlert(data: TRecordAlert);
var
  temp: PAlert;
begin

      if (data.index = 0) and Form1.CheckBoxAlertEventsKnown.Checked then // inconnu
      begin
        createNewAlert(FormAlert, data);
        FormAlert.PanelAllowed.Visible := True;
        FormAlert.PanelDisallowed.Visible := False;
        FormAlert.Show;
      end;
      if (data.index = 1) and Form1.CheckBoxAlertEventsUnknown.Checked then // connu
      begin
        createNewAlert(FormAlert, data);
        FormAlert.PanelAllowed.Visible := True;
        FormAlert.PanelDisallowed.Visible := False;
        FormAlert.Show;
      end;
      if (data.index = 3) and Form1.CheckBoxAlertEventDisallowed.Checked then // bloqué
      begin
        createNewAlert(FormAlert, data);
        FormAlert.PanelAllowed.Visible := False;
        FormAlert.PanelDisallowed.Visible := True;
        FormAlert.Show;
      end;
end;
        
function EraseAlert(ListAlert: PAlert): PAlert;
begin
  if ListAlert <> nil then
  begin
    Result := ListAlert^.next;
    Dispose(ListAlert);
  end
  else
    Result := nil;
end;

procedure EraseAlertIndex(out ListAlert: PAlert; i: Integer);
var
  temp: PAlert;
begin
  temp := ListAlert;
  while ListAlert <> nil do
  begin
    if ListAlert^.data.index = i then ListAlert := EraseAlert(ListAlert);
    ListAlert := ListAlert^.next;
  end;
end;



end.
