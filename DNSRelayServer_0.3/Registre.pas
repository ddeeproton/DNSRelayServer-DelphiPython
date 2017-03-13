unit Registre;

interface

uses Registry, Windows, Classes;

  function ListKeys(RootKey: HKey; Path:string; DataName:string): TStrings;
  function ListValues(RootKey: HKey; Path:string; DataName:string): TStrings;
  function ReadString(RootKey: HKey; Path:string; DataName:string): string;
  function ReadInteger(RootKey: HKey; Path:string; DataName:string): integer;
  function ReadBoolean(RootKey: HKey; Path:string; DataName:string): boolean;

  procedure WriteString(RootKey: HKey; Path:string; DataName:string; Value:String);
  procedure WriteInteger(RootKey: HKey; Path:string; DataName:string; Value:integer);
  procedure WriteBoolean(RootKey: HKey; Path:string; DataName:string; Value:Boolean);

implementation

// HKEY_CLASSES_ROOT
// HKEY_CURRENT_USER
// HKEY_LOCAL_MACHINE
// HKEY_USERS
// HKEY_CURRENT_CONFIG

function ListKeys(RootKey: HKey; Path:string; DataName:string): TStrings;
var
  KeyNames : TStringList;
  registre : TRegistry;
begin
  KeyNames := TStringList.Create();
  registre := TRegistry.Create();
  registre.RootKey := RootKey;
  registre.OpenKey(Path, False);
  registre.GetKeyNames(KeyNames);
  result := KeyNames;
  registre.Free;
  KeyNames.Free;
end;


function ListValues(RootKey: HKey; Path:string; DataName:string): TStrings;
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
  ValueNames.Free;
end;


function ReadString(RootKey: HKey; Path:string; DataName:string): string;
var Registre : TRegistry;
begin
  Registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  if Registre.openkey(Path,False) and Registre.ValueExists(DataName) then
    result := Registre.ReadString(DataName);
  Registre.Free;
end;


function ReadInteger(RootKey: HKey; Path:string; DataName:string): integer;
var Registre : TRegistry;
begin
  Registre := TRegistry.Create;
  Registre.RootKey := RootKey;
  if Registre.openkey(Path,False) and Registre.ValueExists(DataName) then
    result := Registre.ReadInteger(DataName);
  Registre.Free;
end;


function ReadBoolean(RootKey: HKey; Path:string; DataName:string): boolean;
var Registre : TRegistry;
begin
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

