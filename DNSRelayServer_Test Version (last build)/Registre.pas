unit Registre;

interface

uses Registry, Windows, Classes, SysUtils;

  function ListKeys(RootKey: HKey; Path:string): TStrings;
  function ListValues(RootKey: HKey; Path:string): TStrings;
  
  function ReadStringExists(RootKey: HKey; Path:string; DataName:string): Boolean;
  
  function ReadType(RootKey: HKey; Path:string; DataName:string): string;
  function ReadTypeTReg(RootKey: HKey; Path:string; DataName:string): TRegDataType;

  function ReadBinaryData(RootKey: HKey; Path:string; DataName:string): string;
  function ReadString(RootKey: HKey; Path:string; DataName:string): string;
  function ReadInteger(RootKey: HKey; Path:string; DataName:string): integer;
  function ReadBoolean(RootKey: HKey; Path:string; DataName:string): boolean;

  procedure WriteString(RootKey: HKey; Path:string; DataName:string; Value:String);
  procedure WriteInteger(RootKey: HKey; Path:string; DataName:string; Value:integer);
  procedure WriteBoolean(RootKey: HKey; Path:string; DataName:string; Value:Boolean);

implementation

//uses SysUtils;

// HKEY_CLASSES_ROOT
// HKEY_CURRENT_USER
// HKEY_LOCAL_MACHINE
// HKEY_USERS
// HKEY_CURRENT_CONFIG

function ListKeys(RootKey: HKey; Path:string): TStrings;
var
  KeyNames : TStringList;
  registre : TRegistry;
begin
  KeyNames := TStringList.Create();
  registre := TRegistry.Create();
  registre.RootKey := RootKey;
  registre.OpenKey(Path, False);
  registre.GetKeyNames(KeyNames);
  registre.Free;
  result := KeyNames;
end;


function ListValues(RootKey: HKey; Path:string): TStrings;
var
  ValueNames : TStringList;
  registre : TRegistry;
begin
  ValueNames := TStringList.Create();
  registre := TRegistry.Create();
  registre.RootKey := RootKey;
  registre.OpenKey(Path, False);
  registre.GetValueNames(ValueNames);
  registre.Free;
  result := ValueNames;
end;



function ReadStringExists(RootKey: HKey; Path:string; DataName:string): Boolean;
var Registre : TRegistry;
begin
  Registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  result := Registre.openkey(Path,False) and Registre.ValueExists(DataName);
  Registre.Free;
end;


function ReadString(RootKey: HKey; Path:string; DataName:string): string;
var Registre : TRegistry;
begin
  Registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  if Registre.openkey(Path,False) and Registre.ValueExists(DataName) then
    result := Registre.ReadString(DataName)
  else
    result := 'Error: not found "'+Path+'"';
  Registre.Free;
end;

function ReadBinaryData(RootKey: HKey; Path:string; DataName:string): string;
const 
  KeyName: string = 'System\CurrentControlSet\control\TimeZoneInformation';
  ValName: string = 'DaylightStart';
var
  i:        integer;
  keyGood:  boolean;
  regKey:   TRegistry;
  timeInfo: array of byte;
  tmpStr:   string;
  vSize:    integer;
begin
  result := 'error';
  regKey := TRegistry.Create; 
  try 
    regKey.RootKey := RootKey;
    keyGood        := regKey.OpenKey(Path, false);
    if (keyGood) then 
    begin
      vSize := regKey.GetDataSize(DataName);
      //result := IntToStr( vSize);

      if (vSize > 0) then
      begin
        SetLength(timeInfo, vSize);
        regKey.ReadBinaryData(DataName, timeInfo[0], vSize);
        for i := 0 to vSize - 1 do 
          //tmpStr := tmpStr + Format('%.2X ', [timeInfo[i]]);
          tmpStr := tmpStr +  Format('%x', [timeInfo[i]]);
        Delete(tmpStr, Length(tmpStr), 1);
        result := tmpStr;
      end;
            
    end; 
  finally 
    regKey.Free; 
  end;
end;



function ReadType(RootKey: HKey; Path:string; DataName:string): string;
var Registre : TRegistry;
DType: TRegDataType;
begin
  Registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  registre.OpenKey(Path, False);
  DType := Registre.GetDataType(DataName);
  if DType = rdUnknown then
    result := 'type unkown'
  else if DType = rdExpandString then
    result := 'type ExpandString'
  else if DType = rdString then
    result := 'type String'
  else if DType = rdInteger then
    result := 'type Integer'
  else if DType = rdBinary then
    result := 'type Binary'
  else result := 'type other';
  Registre.Free;
end;

function ReadTypeTReg(RootKey: HKey; Path:string; DataName:string): TRegDataType;
var Registre : TRegistry;
//DType: TRegDataType;
begin
  Registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  registre.OpenKey(Path, False);
  result := Registre.GetDataType(DataName);
  Registre.Free;
end;


function ReadInteger(RootKey: HKey; Path:string; DataName:string): integer;
var Registre : TRegistry;
begin
  result := -1;
  Registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  if Registre.openkey(Path,False) and Registre.ValueExists(DataName) then
    result := Registre.ReadInteger(DataName);
  Registre.Free;
end;


function ReadBoolean(RootKey: HKey; Path:string; DataName:string): boolean;
var Registre : TRegistry;
begin
  result := False;
  Registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  if Registre.openkey(Path,False) and Registre.ValueExists(DataName) then
    result := Registre.ReadBool(DataName);
  Registre.Free;
end;


procedure WriteString(RootKey: HKey; Path:string; DataName:string; Value:String);
var Registre : TRegistry;
begin
  Registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  if Registre.openkey(Path,False) then
    Registre.WriteString(DataName,Value);
  Registre.Free;
end;


procedure WriteInteger(RootKey: HKey; Path:string; DataName:string; Value:integer);
var Registre : TRegistry;
begin
  Registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  if Registre.openkey(Path,False) then
    Registre.WriteInteger(DataName,Value);
  Registre.Free;
end;


procedure WriteBoolean(RootKey: HKey; Path:string; DataName:string; Value:Boolean);
var Registre : TRegistry;
begin
  registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  if Registre.openkey(Path,False) then
    Registre.WriteBool(DataName,Value);
  Registre.Free;
end;


end.

