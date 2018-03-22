unit UnitConfig;

interface

uses xmldom, XMLIntf, msxmldom, XMLDoc, StrUtils, SysUtils, Forms, StdCtrls,
    Classes, FilesManager, NetworkManager, inifiles;

type
  Config = class
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure Save;
    class function Load: Boolean;
  end;


  XMLAction = class
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure SetString(var xml: TXMLDocument; valuename, value: String);
    class function  GetString(var xml: TXMLDocument; valuename, default: String):String;
    class procedure SetStringList(var xml: TXMLDocument; varname: String; List: TStringList);
    class procedure GetStringList(var xml: TXMLDocument; varname: String; defaultValues: TStringList; var List: TStringList);
    class procedure SetListBox(var xml: TXMLDocument; varname: String; ListBox: TListBox);
    class procedure GetListBox(var xml: TXMLDocument; varname: String; defaultValues: TStringList; var ListBox: TListBox);
    class procedure SetComboBox(var xml: TXMLDocument; varname: String; ListBox: TComboBox);
    class procedure GetComboBox(var xml: TXMLDocument; varname: String; defaultValues: TStringList; var ListBox: TComboBox);
    class procedure SetBoolean(var xml: TXMLDocument; valuename: String; value: Boolean);
    class function  GetBoolean(var xml: TXMLDocument; valuename: String; default: Boolean):Boolean;
    class function  GetInteger(var xml: TXMLDocument; valuename: String; default: Integer):Integer;
    class procedure SetInteger(var xml: TXMLDocument; valuename: String; value: Integer);
  end;

  IniAction = class
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure SetStringList(var Setup: TIniFile; varname: String; List: TStringList);
    class procedure GetStringList(var Setup: TIniFile; varname: String; defaultValues: TStringList; var List: TStringList);
    class procedure SetListBox(var Setup: TIniFile; varname: String; ListBox: TListBox);
    class procedure GetListBox(var Setup: TIniFile; varname: String; defaultValues: TStringList; var ListBox: TListBox);
    class procedure SetComboBox(var Setup: TIniFile; varname: String; ListBox: TComboBox);
    class procedure GetComboBox(var Setup: TIniFile; varname: String; defaultValues: TStringList; var ListBox: TComboBox);

  end;



  ConfigDeprecated = class
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure Load;
    class function Exists: Boolean;
    class procedure EraseConfiguration;
  end;



implementation

uses Unit1;

function ApplicationShortName:String;
begin
  result := AnsiReplaceStr(ExtractFileName(Application.ExeName), '.exe', '');
end;

function DataDirectoryPath:String;
begin
  result := ExtractFilePath(Application.ExeName)+ApplicationShortName+'\';
end;



class function XMLAction.GetString(var xml: TXMLDocument; valuename, default: String):String;
begin
  if xml.ChildNodes[valuename].IsTextElement then
    result := xml.ChildNodes[valuename].Text
  else
    result := default;
end;


class function  XMLAction.GetBoolean(var xml: TXMLDocument; valuename: String; default: Boolean):Boolean;
begin
  if xml.ChildNodes[valuename].IsTextElement then
    result := UpperCase(xml.ChildNodes[valuename].Text) = 'TRUE'
  else
    result := default;
end;

class function  XMLAction.GetInteger(var xml: TXMLDocument; valuename: String; default: Integer):Integer;
begin
  if xml.ChildNodes[valuename].IsTextElement then
    if not TryStrToInt(xml.ChildNodes[valuename].Text, result) then
      result := default;
end;

class procedure XMLAction.GetListBox(var xml: TXMLDocument; varname: String; defaultValues: TStringList; var ListBox: TListBox);
var
  i: Integer;
begin
  ListBox.Items.Clear;
  if xml.ChildNodes[varname].ChildNodes.Count = 0 then
  begin
    for i := 0 to defaultValues.Count - 1 do
    begin
      ListBox.Items.Add(defaultValues.Strings[i]);
    end;
  end else begin
    for i := 0 to xml.ChildNodes[varname].ChildNodes.Count - 1 do
    begin
      ListBox.Items.Add(xml.ChildNodes[varname].ChildNodes.Get(i).Text);
    end;
  end;
end;

class procedure XMLAction.GetComboBox(var xml: TXMLDocument; varname: String; defaultValues: TStringList; var ListBox: TComboBox);
var
  i: Integer;
begin
  ListBox.Items.Clear;
  if xml.ChildNodes[varname].ChildNodes.Count = 0 then
  begin
    for i := 0 to defaultValues.Count - 1 do
    begin
      ListBox.Items.Add(defaultValues.Strings[i]);
    end;
  end else begin
    for i := 0 to xml.ChildNodes[varname].ChildNodes.Count - 1 do
    begin
      ListBox.Items.Add(xml.ChildNodes[varname].ChildNodes.Get(i).Text);
    end;
  end;
end;


class procedure XMLAction.GetStringList(var xml: TXMLDocument; varname: String; defaultValues: TStringList; var List: TStringList);
var
  i: Integer;
begin
  List := TStringList.Create;
  if xml.ChildNodes[varname].ChildNodes.Count = 0 then
  begin
    for i := 0 to defaultValues.Count - 1 do
    begin
      List.Add(defaultValues.Strings[i]);
    end;
  end else begin
    for i := 0 to xml.ChildNodes[varname].ChildNodes.Count - 1 do
    begin
      List.Add(xml.ChildNodes[varname].ChildNodes.Get(i).Text);
    end;
  end;
end;


class procedure XMLAction.SetString(var xml: TXMLDocument; valuename, value: String);
begin
  xml.AddChild(valuename).Text := value;
end;


class procedure XMLAction.SetBoolean(var xml: TXMLDocument; valuename: String; value: Boolean);
begin
  if value then
    xml.AddChild(valuename).Text := 'True'
  else
    xml.AddChild(valuename).Text := 'False';
end;


class procedure XMLAction.SetListBox(var xml: TXMLDocument; varname: String; ListBox: TListBox);
var
  i: Integer;
begin
  xml.AddChild(varname);
  for i := 0 to ListBox.Items.Count -1 do
  begin
    xml.ChildNodes[varname].AddChild(varname+IntToStr(i)).Text := ListBox.Items.Strings[i];
  end;
end;

class procedure XMLAction.SetComboBox(var xml: TXMLDocument; varname: String; ListBox: TComboBox);
var
  i: Integer;
begin
  if ListBox = nil then Exit;
  xml.AddChild(varname);
  for i := 0 to ListBox.Items.Count -1 do
  begin
    xml.ChildNodes[varname].AddChild(varname+IntToStr(i)).Text := ListBox.Items.Strings[i];
  end;
end;


class procedure XMLAction.SetStringList(var xml: TXMLDocument; varname: String; List: TStringList);

  procedure StringToStream(Stream: TStream;const S: String);
  begin
    Stream.Write(Pointer(S)^, length(S));
  end;

var
  i: Integer;
begin
  if List = nil then Exit;
  xml.AddChild(varname);
  for i := 0 to List.Count -1 do
  begin
    xml.ChildNodes[varname].AddChild(IntToStr(i)).Text := List.Strings[i];
  end;
end;

class procedure XMLAction.SetInteger(var xml: TXMLDocument; valuename: String; value: Integer);
begin
  xml.AddChild(valuename).Text := IntToStr(value);
end;



class function ConfigDeprecated.Exists: Boolean;
var
  MasterDNSFile: String;
begin
  MasterDNSFile := 'MasterDNSFile.cfg';
  MasterDNSFile := DataDirectoryPath + MasterDNSFile;
  result := FileExists(MasterDNSFile);
end;




class procedure ConfigDeprecated.Load;
var
  i: Integer;
  MasterDNSFile: String;
  //SlaveDNSProcesslist: String;
  //FilehostPathConfig: String;
  SlaveDNSIPConfig: String;
  SlaveDNSPortConfig: String;
  TimeCheckUpdateFile: String;
  net: tNetworkInterfaceList;
  txt: String;
begin
  if not DirectoryExists(DataDirectoryPath) then Exit;
  with Form1 do
  begin

    MasterDNSFile := 'MasterDNSFile.cfg';
    //SlaveDNSProcesslist := 'SlaveDNSProcesslist.cfg';
    //FilehostPathConfig := 'FileHostPath.cfg';
    SlaveDNSIPConfig := 'SlaveDNSIP.cfg';
    SlaveDNSPortConfig := 'SlaveDNSPort.cfg';
    TimeCheckUpdateFile := 'TimeCheckUpdate.cfg';

    //FilehostPathConfig := DataDirectoryPath + FilehostPathConfig ;
    SlaveDNSIPConfig := DataDirectoryPath + SlaveDNSIPConfig;
    SlaveDNSPortConfig := DataDirectoryPath + SlaveDNSPortConfig;
    MasterDNSFile := DataDirectoryPath + MasterDNSFile;
    //SlaveDNSProcesslist := DataDirectoryPath + SlaveDNSProcesslist;
    TimeCheckUpdateFile :=  DataDirectoryPath + TimeCheckUpdateFile;
    BlackListCfgFile := DataDirectoryPath + BlackListCfgFile;

    if FileExists(MasterDNSFile) then
      ListBoxDNSMaster.Items.LoadFromFile(MasterDNSFile);

    ConfigDNSMaster := TStringList.Create;
    for i := 0 to ListBoxDNSMaster.Items.Count - 1 do
      ConfigDNSMaster.Add(ListBoxDNSMaster.Items.Strings[i]);

    if EditFilehost.Text = '' then
      EditFilehost.Text := DataDirectoryPath + 'host.txt';

    if FileExists(DataDirectoryPath + 'EditExecOnDisconnected.cfg') then
      EditExecOnDisconnected.Text := ReadFromFile(DataDirectoryPath + 'EditExecOnDisconnected.cfg');

    if FileExists(SlaveDNSPortConfig) then
      SpinPort.Value := StrToInt(ReadFromFile(SlaveDNSPortConfig));

    SpinEditContraste.OnChange := nil;
    SpinEditContraste.Position := 205;
    if FileExists(DataDirectoryPath + 'contrasteTextarea.cfg') then
      SpinEditContraste.Position := StrToInt(ReadFromFile(DataDirectoryPath + 'contrasteTextarea.cfg'));
    SpinEditContraste.OnChange := ComboBoxCurrentThemeSelect;
    //ComboBoxCurrentThemeSelect(SpinEditContraste);


    if FileExists(TimeCheckUpdateFile) then
      SpinTimeCheckUpdate.Value := StrToInt(ReadFromFile(TimeCheckUpdateFile));

    SpinEditTTLCache.Value := 1;
    if FileExists(DataDirectoryPath + 'SpinEditTTLCache.cfg') then
      SpinEditTTLCache.Value := StrToInt(ReadFromFile(DataDirectoryPath + 'SpinEditTTLCache.cfg'));
    TimerClearCache.Interval := SpinEditTTLCache.Value * 1000 * 60 * 60;
    TimerClearCache.Enabled := SpinEditTTLCache.Value > 0;

    CheckBoxAutostartDNSOnBoot.Checked := FileExists(DataDirectoryPath + 'checkAutostartDNS.cfg');
    CheckBoxUpdate.Checked := FileExists(DataDirectoryPath + 'checkupdate.cfg');
    CheckBoxUpdateIntervall.Checked := FileExists(DataDirectoryPath + 'checkupdateIntervall.cfg');
    CheckBoxUpdateSilent.Checked := FileExists(DataDirectoryPath + 'checkupdateSilent.cfg');
    TimerCheckUpdate.Enabled := CheckBoxUpdateIntervall.Checked;
    CheckBoxAllowModifyNetCard.Checked := FileExists(DataDirectoryPath + 'checkAllowModifyNetcard.cfg');
    CheckBoxShowDebug.Checked := FileExists(DataDirectoryPath + 'CheckBoxShowDebug.cfg');
    LogDNSAutoScroll.Checked := FileExists(DataDirectoryPath + 'LogDNSAutoScroll.cfg');
    LogNetstatAutoScroll.Checked := FileExists(DataDirectoryPath + 'LogNetstatAutoScroll.cfg');

    // ===B

    ComboBoxCurrentTheme.OnSelect := nil;
    if FileExists(DataDirectoryPath + 'ThemeNames.cfg') then
      ComboBoxCurrentTheme.Items.LoadFromFile(DataDirectoryPath + 'ThemeNames.cfg');

    ComboBoxCurrentTheme.ItemIndex := 0;
    if FileExists(DataDirectoryPath + 'ThemeSelected.cfg') then
      ComboBoxCurrentTheme.ItemIndex := StrToInt( ReadFromFile(DataDirectoryPath + 'ThemeSelected.cfg'));
    //ComboBoxCurrentThemeSelect(ComboBoxCurrentTheme);

    ComboBoxPosLogs.ItemIndex := 1;
    if FileExists(DataDirectoryPath + 'PositionLogs.cfg') then
      ComboBoxPosLogs.ItemIndex := StrToInt( ReadFromFile(DataDirectoryPath + 'PositionLogs.cfg'));
    //ComboBoxPosLogsSelect(ComboBoxPosLogs);

    ThemesList := TStringList.Create;
    if FileExists(DataDirectoryPath + 'ThemeListData.cfg') then
      ThemesList := ReadFileToStringList(DataDirectoryPath + 'ThemeListData.cfg')
    else begin
      // Create first list of themes
      ThemesList.Add('0,0,0,255,255,255');
      ThemesList.Add('0,0,0,210,226,227');
      ThemesList.Add('250,250,250,30,30,30');
      ThemesList.Add('0,255,0,0,0,0');
      ThemesList.Add('0,255,255,0,0,0');
      ThemesList.Add('0,0,0,255,0,255');
      ThemesList.Add('255,255,255,168,0,168');
      ThemesList.Add('255,255,255,0,0,160');
      ThemesList.Add('0,0,0,0,221,221');
      ThemesList.Add('0,0,0,192,192,192');
      ThemesList.Add('0,0,0,238,238,238');
      WriteStringListInFile(DataDirectoryPath + 'ThemeListData.cfg', ThemesList);

      ComboBoxCurrentTheme.Clear;
      ComboBoxCurrentTheme.Items.Add('White');
      ComboBoxCurrentTheme.Items.Add('Cream');
      ComboBoxCurrentTheme.Items.Add('Black');
      ComboBoxCurrentTheme.Items.Add('Matrix');
      ComboBoxCurrentTheme.Items.Add('DarkBlue');
      ComboBoxCurrentTheme.Items.Add('Pink');
      ComboBoxCurrentTheme.Items.Add('DarkPink');
      ComboBoxCurrentTheme.Items.Add('Blue');
      ComboBoxCurrentTheme.Items.Add('BlueSky');
      ComboBoxCurrentTheme.Items.Add('Gray');
      ComboBoxCurrentTheme.Items.Add('Sylver');
      ComboBoxCurrentTheme.Items.SaveToFile(DataDirectoryPath + 'ThemeNames.cfg');
      ComboBoxCurrentTheme.ItemIndex := 0;

      CheckBoxBindAllIP.Checked := FileExists(DataDirectoryPath + 'CheckBoxBindAllIP.cfg');
      //CheckBoxBindAllIPClick(nil);
      //ButtonRefreshNetCardClick(nil);

      RefreshModeFilter;

      CheckBoxNoTestDNSMaster.Checked := FileExists(DataDirectoryPath + 'CheckBoxNoTestDNSMaster.cfg');
      CheckBoxNoCacheDNS.Checked := FileExists(DataDirectoryPath + 'CheckBoxNoCacheDNS.cfg');
      CheckBoxPureServer.Checked := FileExists(DataDirectoryPath + 'CheckBoxPureServer.cfg');
      CheckBoxRemoteAccess.Checked := FileExists(DataDirectoryPath + 'CheckBoxRemoteAccess.cfg');

      TimerRemoteAccess.Enabled := CheckBoxRemoteAccess.Checked;

      CheckBoxRestartOnNetworkInterfaceChange.Checked := FileExists(DataDirectoryPath + 'CheckBoxRestartOnNetworkInterfaceChange.cfg');
      CheckBoxExecOnDisconnected.Checked := FileExists(DataDirectoryPath + 'CheckBoxExecOnDisconnected.cfg');

      refreshCheckBox(CheckBoxStartWithWindows);
      TActionManageIP.load();

      TimerUpdateOnLoad.Enabled := CheckBoxUpdate.Checked;


      //if Not FileExists(DataDirectoryPath + 'TimerRefreshNetstat.cfg') then
      //  WriteInFile(DataDirectoryPath + 'TimerRefreshNetstat.cfg', '5000');

      //TimerRefreshNetstat.Interval := StrToInt(ReadFromFile(DataDirectoryPath + 'TimerRefreshNetstat.cfg'));
      TimerRefreshNetstat.Enabled := TimerRefreshNetstat.Interval > 0;




      if not CheckBoxBindAllIP.Checked then
      begin
        txt := ReadFromFile(DataDirectoryPath + 'CheckListBoxDNSRelayIP.cfg');
        CheckListBoxDNSRelayIP.Clear;
        if GetNetworkInterfaces(net) then
        begin
          for i := 0 to High(net) - 1 do
          begin
            if net[i].AddrIP <> '127.0.0.1' then
            begin
              CheckListBoxDNSRelayIP.Items.Add(net[i].AddrIP);
              CheckListBoxDNSRelayIP.Checked[CheckListBoxDNSRelayIP.Items.Count -1] := Pos(net[i].AddrIP, txt) = 0;
            end;
          end;
        end;
      end;

      
    end;
  end;
end;



class procedure ConfigDeprecated.EraseConfiguration;
var
  MasterDNSFile: String;
  SlaveDNSProcesslist: String;
  FilehostPathConfig: String;
  BlackListCfgFile: String;
  SlaveDNSIPConfig: String;
  SlaveDNSPortConfig: String;
  TimeCheckUpdateFile: String;
begin
  MasterDNSFile := 'MasterDNSFile.cfg';
  SlaveDNSProcesslist := 'SlaveDNSProcesslist.cfg';
  FilehostPathConfig := 'FileHostPath.cfg';
  BlackListCfgFile := 'blackhost.txt';
  SlaveDNSIPConfig := 'SlaveDNSIP.cfg';
  SlaveDNSPortConfig := 'SlaveDNSPort.cfg';
  TimeCheckUpdateFile := 'TimeCheckUpdate.cfg';

  FilehostPathConfig := DataDirectoryPath + FilehostPathConfig ;
  SlaveDNSIPConfig := DataDirectoryPath + SlaveDNSIPConfig;
  SlaveDNSPortConfig := DataDirectoryPath + SlaveDNSPortConfig;
  MasterDNSFile := DataDirectoryPath + MasterDNSFile;
  SlaveDNSProcesslist := DataDirectoryPath + SlaveDNSProcesslist;
  TimeCheckUpdateFile :=  DataDirectoryPath + TimeCheckUpdateFile;
  BlackListCfgFile := DataDirectoryPath + BlackListCfgFile;

  deleteFile(DataDirectoryPath + 'alertDisplayDuration.cfg');
  deleteFile(MasterDNSFile);
  deleteFile(DataDirectoryPath + 'EditExecOnDisconnected.cfg');
  deleteFile(SlaveDNSPortConfig);
  deleteFile(FilehostPathConfig);
  deleteFile(SlaveDNSProcesslist);
  deleteFile(DataDirectoryPath + 'SpinEditTTLCache.cfg');
  deleteFile(DataDirectoryPath + 'checkAutostartDNS.cfg');
  deleteFile(DataDirectoryPath + 'checkupdate.cfg');
  deleteFile(DataDirectoryPath + 'checkupdateIntervall.cfg');
  deleteFile(DataDirectoryPath + 'checkupdateSilent.cfg');
  deleteFile(DataDirectoryPath + 'checkAllowModifyNetcard.cfg');
  deleteFile(DataDirectoryPath + 'CheckBoxShowDebug.cfg');
  deleteFile(DataDirectoryPath + 'LogDNSAutoScroll.cfg');
  deleteFile(DataDirectoryPath + 'LogNetstatAutoScroll.cfg');
  deleteFile(DataDirectoryPath + 'ThemeNames.cfg');
  deleteFile(DataDirectoryPath + 'ThemeSelected.cfg');
  deleteFile(DataDirectoryPath + 'PositionLogs.cfg');
  deleteFile(DataDirectoryPath + 'CheckBoxBindAllIP.cfg');
  deleteFile(DataDirectoryPath + 'CheckBoxNoTestDNSMaster.cfg');
  deleteFile(DataDirectoryPath + 'CheckBoxNoCacheDNS.cfg');
  deleteFile(DataDirectoryPath + 'CheckBoxPureServer.cfg');
  deleteFile(DataDirectoryPath + 'CheckBoxRemoteAccess.cfg');
  deleteFile(DataDirectoryPath + 'CheckBoxRestartOnNetworkInterfaceChange.cfg');
  deleteFile(DataDirectoryPath + 'CheckBoxExecOnDisconnected.cfg');
  deleteFile(DataDirectoryPath + 'TimerRefreshNetstat.cfg');
  deleteFile(DataDirectoryPath + 'CheckListBoxDNSRelayIP.cfg');



end;


class procedure IniAction.SetStringList(var Setup: TIniFile; varname: String; List: TStringList);
var
  i: Integer;
begin
  Setup.WriteInteger(varname, 'count', List.Count);
  for i := 0 to List.Count - 1 do
  begin
    Setup.WriteString(varname, varname+IntToStr(i), List.Strings[i]);
  end;
end;

class procedure IniAction.GetStringList(var Setup: TIniFile; varname: String; defaultValues: TStringList; var List: TStringList);
var
  i, count: Integer;
begin
  List := TStringList.Create;
  if not Setup.SectionExists(varname) then exit;
  if not Setup.ValueExists(varname, 'count') then exit;
  count := Setup.ReadInteger(varname, 'count', 0);
  if count > 0 then
  begin

    for i := 0 to count - 1 do
    begin
      List.Add(Setup.ReadString(varname, varname+IntToStr(i), ''));
    end;

  end else begin

    for i := 0 to defaultValues.Count - 1 do
    begin
      List.Add(defaultValues.Strings[i]);
    end;

  end;
end;

class procedure IniAction.SetListBox(var Setup: TIniFile; varname: String; ListBox: TListBox);
var
  i: Integer;
begin
  Setup.WriteInteger(varname, 'count', ListBox.Items.Count);
  for i := 0 to ListBox.Items.Count - 1 do
  begin
    Setup.WriteString(varname, varname+IntToStr(i), ListBox.Items.Strings[i]);
  end;
end;

class procedure IniAction.GetListBox(var Setup: TIniFile; varname: String; defaultValues: TStringList; var ListBox: TListBox);
var
  i, count: Integer;
begin
  ListBox.Items.Clear;
  if not Setup.SectionExists(varname) then exit;
  if not Setup.ValueExists(varname, 'count') then exit;
  count := Setup.ReadInteger(varname, 'count', 0);
  if count > 0 then
  begin

    for i := 0 to count - 1 do
    begin
      ListBox.Items.Add(Setup.ReadString(varname, varname+IntToStr(i), ''));
    end;

  end else begin

    for i := 0 to defaultValues.Count - 1 do
    begin
      ListBox.Items.Add(defaultValues.Strings[i]);
    end;

  end;
end;

class procedure IniAction.SetComboBox(var Setup: TIniFile; varname: String; ListBox: TComboBox);
var
  i: Integer;
begin
  Setup.WriteInteger(varname, 'count', ListBox.Items.Count);
  for i := 0 to ListBox.Items.Count - 1 do
  begin
    Setup.WriteString(varname, varname+IntToStr(i), ListBox.Items.Strings[i]);
  end;
end;

class procedure IniAction.GetComboBox(var Setup: TIniFile; varname: String; defaultValues: TStringList; var ListBox: TComboBox);
var
  i, count: Integer;
begin
  ListBox.Items.Clear;
  if not Setup.SectionExists(varname) then exit;
  if not Setup.ValueExists(varname, 'count') then exit;
  count := Setup.ReadInteger(varname, 'count', 0);
  if count > 0 then
  begin

    for i := 0 to count - 1 do
    begin
      ListBox.Items.Add(Setup.ReadString(varname, varname+IntToStr(i), ''));
    end;

  end else begin

    for i := 0 to defaultValues.Count - 1 do
    begin
      ListBox.Items.Add(defaultValues.Strings[i]);
    end;

  end;
end;



class procedure Config.Save;
var Setup: TIniFile;
begin
  if not DirectoryExists(DataDirectoryPath) then makeDir(DataDirectoryPath);
  Setup := TIniFile.Create(DataDirectoryPath+ApplicationShortName+'.ini');
  with Form1 do
  begin
    IniAction.SetListBox(Setup, 'ListBoxDNSMaster', ListBoxDNSMaster);
    IniAction.SetStringList(Setup, 'ListBoxDNSMaster', ConfigDNSMaster);
    Setup.WriteString('GUI', 'EditFilehost', EditFilehost.Text);
    Setup.WriteString('GUI', 'EditExecOnDisconnected', EditExecOnDisconnected.Text);
    Setup.WriteInteger('GUI', 'SpinPort', SpinPort.Value);
    Setup.WriteInteger('GUI', 'SpinEditContraste', SpinEditContraste.Position);
    Setup.WriteInteger('GUI', 'SpinTimeCheckUpdate', SpinTimeCheckUpdate.Value);
    Setup.WriteInteger('GUI', 'SpinEditTTLCache', SpinEditTTLCache.Value);
    Setup.WriteBool('GUI', 'CheckBoxAutostartDNSOnBoot', CheckBoxAutostartDNSOnBoot.Checked);
    Setup.WriteBool('GUI', 'CheckBoxUpdate', CheckBoxUpdate.Checked);
    Setup.WriteBool('GUI', 'CheckBoxUpdateIntervall', CheckBoxUpdateIntervall.Checked);
    Setup.WriteBool('GUI', 'CheckBoxUpdateSilent', CheckBoxUpdateSilent.Checked);
    Setup.WriteBool('GUI', 'CheckBoxAllowModifyNetCard', CheckBoxAllowModifyNetCard.Checked);
    Setup.WriteBool('GUI', 'CheckBoxShowDebug', CheckBoxShowDebug.Checked);
    Setup.WriteBool('GUI', 'LogDNSAutoScroll', LogDNSAutoScroll.Checked);
    Setup.WriteBool('GUI', 'LogNetstatAutoScroll', LogNetstatAutoScroll.Checked);
    IniAction.SetComboBox(Setup, 'ComboBoxCurrentTheme', ComboBoxCurrentTheme); 
    Setup.WriteInteger('GUI', 'ComboBoxCurrentThemeCurrentIndex', ComboBoxCurrentTheme.ItemIndex);
    Setup.WriteInteger('GUI', 'ComboBoxPosLogs', ComboBoxPosLogs.ItemIndex);
    IniAction.SetStringList(Setup, 'ThemesList', ThemesList);
    Setup.WriteBool('GUI', 'CheckBoxBindAllIP', CheckBoxBindAllIP.Checked);
    Setup.WriteBool('GUI', 'CheckBoxNoTestDNSMaster', CheckBoxNoTestDNSMaster.Checked);
    Setup.WriteBool('GUI', 'CheckBoxNoCacheDNS', CheckBoxNoCacheDNS.Checked);
    Setup.WriteBool('GUI', 'CheckBoxPureServer', CheckBoxPureServer.Checked);
    Setup.WriteBool('GUI', 'CheckBoxRemoteAccess', CheckBoxRemoteAccess.Checked);
    Setup.WriteBool('GUI', 'CheckBoxRestartOnNetworkInterfaceChange', CheckBoxRestartOnNetworkInterfaceChange.Checked);
    Setup.WriteBool('GUI', 'CheckBoxExecOnDisconnected', CheckBoxExecOnDisconnected.Checked);
    Setup.WriteInteger('GUI', 'TimerRefreshNetstat', TimerRefreshNetstat.Interval);
  end;
  Setup.Free;
end;


class function Config.Load: Boolean;
var
  Setup: TIniFile;
  defaultValues: TStringList;
begin
  result := False;
  if not DirectoryExists(DataDirectoryPath) then makeDir(DataDirectoryPath);
  Setup := TIniFile.Create(DataDirectoryPath+ApplicationShortName+'.ini');
  if not FileExists(DataDirectoryPath+ApplicationShortName+'.ini') then Exit;
  with Form1 do
  begin
    defaultValues := TStringList.Create;
    defaultValues.Add('209.244.0.3');
    defaultValues.Add('209.244.0.4');
    IniAction.GetListBox(Setup, 'ListBoxDNSMaster', defaultValues, ListBoxDNSMaster);
    IniAction.GetStringList(Setup, 'ListBoxDNSMaster', defaultValues, ConfigDNSMaster);
    defaultValues.Free;

    EditFilehost.Text := Setup.ReadString('GUI', 'EditFilehost', DataDirectoryPath + 'host.txt');
    EditExecOnDisconnected.Text := Setup.ReadString('GUI', 'EditExecOnDisconnected', '');
    SpinPort.Value := Setup.ReadInteger('GUI', 'SpinPort', 53);
    SpinEditContraste.OnChange := nil;
    SpinEditContraste.Position := Setup.ReadInteger('GUI', 'SpinEditContraste', 205);
    SpinEditContraste.OnChange := ComboBoxCurrentThemeSelect;

    SpinTimeCheckUpdate.Value := Setup.ReadInteger('GUI', 'SpinTimeCheckUpdate', 24);

    SpinEditTTLCache.Value := Setup.ReadInteger('GUI', 'SpinEditTTLCache', 1);
    TimerClearCache.Interval := SpinEditTTLCache.Value * 1000 * 60 * 60;
    TimerClearCache.Enabled := SpinEditTTLCache.Value > 0;

    CheckBoxAutostartDNSOnBoot.Checked := Setup.ReadBool('GUI', 'CheckBoxAutostartDNSOnBoot', False);
    CheckBoxUpdate.Checked := Setup.ReadBool('GUI', 'CheckBoxUpdate', False);
    CheckBoxUpdateIntervall.Checked := Setup.ReadBool('GUI', 'CheckBoxUpdateIntervall', False);
    CheckBoxUpdateSilent.Checked := Setup.ReadBool('GUI', 'CheckBoxUpdateSilent', False);
    TimerCheckUpdate.Enabled := CheckBoxUpdateIntervall.Checked;
    TimerCheckUpdate.Interval := SpinTimeCheckUpdate.Value * 3600000;
    CheckBoxAllowModifyNetCard.Checked := Setup.ReadBool('GUI', 'CheckBoxAllowModifyNetCard', False);
    CheckBoxShowDebug.Checked := Setup.ReadBool('GUI', 'CheckBoxShowDebug', False);
    LogDNSAutoScroll.Checked := Setup.ReadBool('GUI', 'LogDNSAutoScroll', False);
    LogNetstatAutoScroll.Checked := Setup.ReadBool('GUI', 'LogNetstatAutoScroll', False);

    defaultValues := TStringList.Create;
    defaultValues.Add('White');
    defaultValues.Add('Cream');
    defaultValues.Add('Black');
    defaultValues.Add('Matrix');
    defaultValues.Add('DarkBlue');
    defaultValues.Add('Pink');
    defaultValues.Add('DarkPink');
    defaultValues.Add('Blue');
    defaultValues.Add('BlueSky');
    defaultValues.Add('Gray');
    defaultValues.Add('Sylver');

    IniAction.GetComboBox(Setup, 'ComboBoxCurrentTheme', defaultValues, ComboBoxCurrentTheme);
    defaultValues.Free;
    ComboBoxCurrentTheme.ItemIndex := Setup.ReadInteger('GUI', 'ComboBoxCurrentThemeCurrentIndex', 0);

    ComboBoxPosLogs.ItemIndex := Setup.ReadInteger('GUI', 'ComboBoxPosLogs', 1);

    defaultValues := TStringList.Create;
    defaultValues.Add('0,0,0,255,255,255');
    defaultValues.Add('0,0,0,210,226,227');
    defaultValues.Add('250,250,250,30,30,30');
    defaultValues.Add('0,255,0,0,0,0');
    defaultValues.Add('0,255,255,0,0,0');
    defaultValues.Add('0,0,0,255,0,255');
    defaultValues.Add('255,255,255,168,0,168');
    defaultValues.Add('255,255,255,0,0,160');
    defaultValues.Add('0,0,0,0,221,221');
    defaultValues.Add('0,0,0,192,192,192');
    defaultValues.Add('0,0,0,238,238,238');
    IniAction.GetStringList(Setup, 'ThemesList', defaultValues, ThemesList);
    defaultValues.Free;

    ComboBoxCurrentThemeSelect(ComboBoxCurrentTheme);

    CheckBoxBindAllIP.Checked := Setup.ReadBool('GUI', 'CheckBoxBindAllIP', False);
    CheckBoxBindAllIPClick(nil);
    ButtonRefreshNetCardClick(nil);
    RefreshModeFilter;

    CheckBoxNoTestDNSMaster.Checked := Setup.ReadBool('GUI', 'CheckBoxNoTestDNSMaster', False);
    CheckBoxNoCacheDNS.Checked := Setup.ReadBool('GUI', 'CheckBoxNoCacheDNS', False);
    CheckBoxPureServer.Checked := Setup.ReadBool('GUI', 'CheckBoxPureServer', False);
    CheckBoxRemoteAccess.Checked := Setup.ReadBool('GUI', 'CheckBoxRemoteAccess', False);

    TimerRemoteAccess.Enabled := CheckBoxRemoteAccess.Checked;


    CheckBoxRestartOnNetworkInterfaceChange.Checked := Setup.ReadBool('GUI', 'CheckBoxRestartOnNetworkInterfaceChange', False);
    CheckBoxExecOnDisconnected.Checked := Setup.ReadBool('GUI', 'CheckBoxExecOnDisconnected', False);

    refreshCheckBox(CheckBoxStartWithWindows);
    TActionManageIP.load();
    TimerUpdateOnLoad.Enabled := CheckBoxUpdate.Checked;

    TimerRefreshNetstat.Interval := Setup.ReadInteger('GUI', 'TimerRefreshNetstat', 5000);
    TimerRefreshNetstat.Enabled := TimerRefreshNetstat.Interval > 0;



    IniAction.GetStringList(Setup, 'CheckListBoxDNSRelayIP', nil, RejectedIPLocalServer);
  end;
  Setup.Free;
  result := True;
end;

{
class procedure Config.Save;
var
  i: Integer;
  xml: TXMLDocument;
  t: TNodeType;
begin

  if not DirectoryExists(DataDirectoryPath) then makeDir(DataDirectoryPath);

  xml := TXMLDocument.Create(nil);
  xml.Active:=True;
  xml.Options := [doNodeAutoCreate,doNodeAutoIndent,doAttrNull,doAutoPrefix,doNamespaceDecl];
  with Form1 do
  begin
  t := ntText
    xml.CreateElement('data', ntText, )
    XMLAction.SetListBox(xml, 'ListBoxDNSMaster', ListBoxDNSMaster);
    XMLAction.SetStringList(xml, 'ListBoxDNSMaster', ConfigDNSMaster);
    XMLAction.SetString(xml, 'EditFilehost', EditFilehost.Text);
    XMLAction.SetString(xml, 'EditExecOnDisconnected', EditExecOnDisconnected.Text);

    XMLAction.SetInteger(xml, 'SpinPort', SpinPort.Value);
    XMLAction.SetInteger(xml, 'SpinEditContraste', SpinEditContraste.Position);
    XMLAction.SetInteger(xml, 'SpinTimeCheckUpdate', SpinTimeCheckUpdate.Value);
    XMLAction.SetInteger(xml, 'SpinEditTTLCache', SpinEditTTLCache.Value);
    XMLAction.SetBoolean(xml, 'CheckBoxAutostartDNSOnBoot', CheckBoxAutostartDNSOnBoot.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxUpdate', CheckBoxUpdate.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxUpdateIntervall', CheckBoxUpdateIntervall.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxUpdateSilent', CheckBoxUpdateSilent.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxAllowModifyNetCard', CheckBoxAllowModifyNetCard.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxShowDebug', CheckBoxShowDebug.Checked);
    XMLAction.SetBoolean(xml, 'LogDNSAutoScroll', LogDNSAutoScroll.Checked);
    XMLAction.SetBoolean(xml, 'LogNetstatAutoScroll', LogNetstatAutoScroll.Checked);
    XMLAction.SetComboBox(xml, 'ComboBoxCurrentTheme', ComboBoxCurrentTheme);
    XMLAction.SetInteger(xml, 'ComboBoxCurrentThemeCurrentIndex', ComboBoxCurrentTheme.ItemIndex);
    XMLAction.SetInteger(xml, 'ComboBoxPosLogs', ComboBoxPosLogs.ItemIndex);
    XMLAction.SetStringList(xml, 'ThemesList', ThemesList);
    XMLAction.SetBoolean(xml, 'CheckBoxBindAllIP', CheckBoxBindAllIP.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxNoTestDNSMaster', CheckBoxNoTestDNSMaster.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxNoCacheDNS', CheckBoxNoCacheDNS.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxPureServer', CheckBoxPureServer.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxRemoteAccess', CheckBoxRemoteAccess.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxRestartOnNetworkInterfaceChange', CheckBoxRestartOnNetworkInterfaceChange.Checked);
    XMLAction.SetBoolean(xml, 'CheckBoxExecOnDisconnected', CheckBoxExecOnDisconnected.Checked);
    XMLAction.SetInteger(xml, 'TimerRefreshNetstat', TimerRefreshNetstat.Interval);



    if RejectedIPLocalServer = nil then
      RejectedIPLocalServer := TStringList.Create;
    for i := 0 to CheckListBoxDNSRelayIP.Count - 1 do
    begin
      if not CheckListBoxDNSRelayIP.Checked[i] then
      begin
        RejectedIPLocalServer.Add(CheckListBoxDNSRelayIP.Items.Strings[i]);
      end;
    end;
    XMLAction.SetStringList(xml, 'CheckListBoxDNSRelayIP', RejectedIPLocalServer);

  end;
  xml.SaveToFile(DataDirectoryPath+ApplicationShortName+'.xml');
  xml.Free;
end;


class function Config.Load: Boolean;
var
  xml: TXMLDocument;
  defaultValues: TStringList;
begin
  result := False;
  if not DirectoryExists(DataDirectoryPath) then
    makeDir(DataDirectoryPath);

  if not FileExists(DataDirectoryPath+ApplicationShortName+'.xml') then
  begin
    Exit;
  end;

  xml := TXMLDocument.Create(nil);
  xml.LoadFromFile(DataDirectoryPath+ApplicationShortName+'.xml');
  with Form1 do
  begin
    //ListBoxDNSMaster
    defaultValues := TStringList.Create;
    defaultValues.Add('209.244.0.3');
    defaultValues.Add('209.244.0.4');
    XMLAction.GetListBox(xml, 'ListBoxDNSMaster', defaultValues, ListBoxDNSMaster);
    XMLAction.GetStringList(xml, 'ListBoxDNSMaster', defaultValues, ConfigDNSMaster);
    defaultValues.Free;

    EditFilehost.Text := XMLAction.GetString(xml, 'EditFilehost', DataDirectoryPath + 'host.txt');
    EditExecOnDisconnected.Text := XMLAction.GetString(xml, 'EditExecOnDisconnected', '');
    SpinPort.Value := XMLAction.GetInteger(xml, 'SpinPort', 53);
    SpinEditContraste.Position := XMLAction.GetInteger(xml, 'SpinEditContraste', 205);
    SpinTimeCheckUpdate.Value := XMLAction.GetInteger(xml, 'SpinTimeCheckUpdate', 24);

    SpinEditTTLCache.Value := XMLAction.GetInteger(xml, 'SpinEditTTLCache', 1);
    TimerClearCache.Interval := SpinEditTTLCache.Value * 1000 * 60 * 60;
    TimerClearCache.Enabled := SpinEditTTLCache.Value > 0;

    CheckBoxAutostartDNSOnBoot.Checked := XMLAction.GetBoolean(xml, 'CheckBoxAutostartDNSOnBoot', False);
    CheckBoxUpdate.Checked := XMLAction.GetBoolean(xml, 'CheckBoxUpdate', False);
    CheckBoxUpdateIntervall.Checked := XMLAction.GetBoolean(xml, 'CheckBoxUpdateIntervall', False);
    CheckBoxUpdateSilent.Checked := XMLAction.GetBoolean(xml, 'CheckBoxUpdateSilent', False);
    TimerCheckUpdate.Enabled := CheckBoxUpdateIntervall.Checked;
    TimerCheckUpdate.Interval := SpinTimeCheckUpdate.Value * 3600000;
    CheckBoxAllowModifyNetCard.Checked := XMLAction.GetBoolean(xml, 'CheckBoxAllowModifyNetCard', False);
    CheckBoxShowDebug.Checked := XMLAction.GetBoolean(xml, 'CheckBoxShowDebug', False);
    LogDNSAutoScroll.Checked := XMLAction.GetBoolean(xml, 'LogDNSAutoScroll', False);
    LogNetstatAutoScroll.Checked := XMLAction.GetBoolean(xml, 'LogNetstatAutoScroll', False);

    defaultValues := TStringList.Create;
    defaultValues.Add('White');
    defaultValues.Add('Cream');
    defaultValues.Add('Black');
    defaultValues.Add('Matrix');
    defaultValues.Add('DarkBlue');
    defaultValues.Add('Pink');
    defaultValues.Add('DarkPink');
    defaultValues.Add('Blue');
    defaultValues.Add('BlueSky');
    defaultValues.Add('Gray');
    defaultValues.Add('Sylver');
    XMLAction.GetComboBox(xml, 'ComboBoxCurrentTheme', defaultValues, ComboBoxCurrentTheme);
    defaultValues.Free;
    ComboBoxCurrentTheme.ItemIndex := XMLAction.GetInteger(xml, 'ComboBoxCurrentThemeCurrentIndex', 0);

    ComboBoxPosLogs.ItemIndex := XMLAction.GetInteger(xml, 'ComboBoxPosLogs', 1);

    defaultValues := TStringList.Create;
    defaultValues.Add('0,0,0,255,255,255');
    defaultValues.Add('0,0,0,210,226,227');
    defaultValues.Add('250,250,250,30,30,30');
    defaultValues.Add('0,255,0,0,0,0');
    defaultValues.Add('0,255,255,0,0,0');
    defaultValues.Add('0,0,0,255,0,255');
    defaultValues.Add('255,255,255,168,0,168');
    defaultValues.Add('255,255,255,0,0,160');
    defaultValues.Add('0,0,0,0,221,221');
    defaultValues.Add('0,0,0,192,192,192');
    defaultValues.Add('0,0,0,238,238,238');
    XMLAction.GetStringList(xml, 'ThemesList', defaultValues, ThemesList);
    defaultValues.Free;

    ComboBoxCurrentThemeSelect(ComboBoxCurrentTheme);

    CheckBoxBindAllIP.Checked := XMLAction.GetBoolean(xml, 'CheckBoxBindAllIP', False);
    CheckBoxBindAllIPClick(nil);
    ButtonRefreshNetCardClick(nil);
    RefreshModeFilter;

    CheckBoxNoTestDNSMaster.Checked := XMLAction.GetBoolean(xml, 'CheckBoxNoTestDNSMaster', False);
    CheckBoxNoCacheDNS.Checked := XMLAction.GetBoolean(xml, 'CheckBoxNoCacheDNS', False);
    CheckBoxPureServer.Checked := XMLAction.GetBoolean(xml, 'CheckBoxPureServer', False);
    CheckBoxRemoteAccess.Checked := XMLAction.GetBoolean(xml, 'CheckBoxRemoteAccess', False);

    TimerRemoteAccess.Enabled := CheckBoxRemoteAccess.Checked;


    CheckBoxRestartOnNetworkInterfaceChange.Checked := XMLAction.GetBoolean(xml, 'CheckBoxRestartOnNetworkInterfaceChange', False);
    CheckBoxExecOnDisconnected.Checked := XMLAction.GetBoolean(xml, 'CheckBoxExecOnDisconnected', False);

    refreshCheckBox(CheckBoxStartWithWindows);
    TActionManageIP.load();
    TimerUpdateOnLoad.Enabled := CheckBoxUpdate.Checked;

    TimerRefreshNetstat.Interval := XMLAction.GetInteger(xml, 'TimerRefreshNetstat', 5000);
    TimerRefreshNetstat.Enabled := TimerRefreshNetstat.Interval > 0;



    XMLAction.GetStringList(xml, 'CheckListBoxDNSRelayIP', nil, RejectedIPLocalServer);


  end;
  xml.Free;
  result := True;
end;

}

end.
