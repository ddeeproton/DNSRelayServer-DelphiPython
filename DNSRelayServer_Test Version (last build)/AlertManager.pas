unit AlertManager;

interface

uses
  UnitAlert;

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
function EraseAlert(ListAlert: PAlert): PAlert;

implementation


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
    //temp^.data.domain;
    temp := temp^.next;
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
