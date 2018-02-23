unit RulesManager;

interface

uses
  HostParser, DNSManager, SysUtils, Dialogs, Windows, FilesManager;

type
  Rules = class
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure BlackListDomain(domain: string);
    class procedure BlackHostDomain(domain: string);
    class procedure RemoveBlacklistDomain(domain: string);
    class procedure RemoveBlackHostDomain(domain: string);
    class function IsBlacklistDomain(domain: string): Boolean;
    class function IsBlackHostDomain(domain: string): Boolean;
  end;

implementation

uses Unit1;

// ====================== Hostfile

class function Rules.IsBlackHostDomain(domain: string): Boolean;
var
  hostdata: String;
begin
  // Check if rule in host file
  hostdata := ReadFromFile(form1.EditFilehost.Text);
  result := Pos('127.0.0.1	'+domain, hostdata) > 0;
end;

class procedure Rules.BlackHostDomain(domain: string);
var
  i: integer;
begin
  if domain = '' then exit;
  for i := 0 to form1.ListView1.Items.Count-1 do
  begin
    if form1.ListView1.Items[i].Caption =  domain then form1.ListView1.Items[i].SubItems.Strings[0] := '127.0.0.1';
  end;
  setDomain(Form1.EditFilehost.Text, domain, '127.0.0.1');
  Form1.MemoLogs.Lines.Add('Bloquage de '+domain);
  Form1.refreshListView1Click();
  ActionDNS.clearCache;
end;



class procedure Rules.RemoveBlackHostDomain(domain: string);
var
  i: integer;
begin
  if domain = '' then exit;

  //delDomain(Form1.EditFilehost.Text, domain);
  //if Form1.isServerStarted then Form1.ButtonStartClick(nil);
  //Form1.refreshListView1Click();
  //Self.Visible := False;

  //for i := 0 to form1.ListView1.Items.Count-1 do
  i := 0;
  while i < form1.ListView1.Items.Count do
  begin
    if form1.ListView1.Items[i].Caption =  domain then
    begin
      try
        form1.SelectedListItem := form1.ListView1.Items[i];
        //form1.ListView1.Items[i].Caption := '';
        //form1.ListView1.Items[i].SubItems[0] := '';
        //form1.Autoriser1Click(Form1.Autoriser1);
        form1.ListView1.Items[i].Delete;
        form1.MemoLogs.Lines.Add('Débloquage de '+domain);
        delDomain(form1.EditFilehost.Text, domain);
        ActionDNS.clearCache;
      except
        On E :   EOSError do
          exit;
      end;
    end
    else begin
        Inc(i);
    end;
  end;

end;


// ====================== Blackhost

class function Rules.IsBlacklistDomain(domain: string): Boolean;
var
  hostdata: String;
  i: Integer;
begin
  result := False;
  for i := 0 to Form1.ListBoxBlacklist.Items.Count - 1 do
  begin
    if Pos(Form1.ListBoxBlacklist.Items.Strings[i], domain) > 0 then
    begin
      result := True;
      exit;
    end;
  end;
  {
  exit;
  // Check if rule in host file
  hostdata := ReadFromFile(Unit1.BlackListCfgFile);
  result := Pos(domain+#1310, hostdata) > 0;
  if Form1.CheckBoxShowDebug.Checked then
    Form1.MemoLogs.Lines.Add(IntToStr(Pos(domain+#1310, hostdata)));
  }
end;


class procedure Rules.BlackListDomain(domain: string);
begin
  with Form1 do
  begin
    if not InputQuery('Add Blackword', 'Interdit tous les domaines comportant le mot suivant', domain) then exit;
    ListBoxBlacklist.Items.Add(domain);
    ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);    
    ActionDNS.clearCache;
  end;
end;


class procedure Rules.RemoveBlacklistDomain(domain: string);
var
  i :integer;
  txt: string;
  callRestart, isFound: boolean;
begin
  with Form1 do
  begin
    callRestart := False;
    isFound := False;
    i := 0;
    while i < ListBoxBlacklist.Items.Count do
    begin
      txt := ListBoxBlacklist.Items.Strings[i];
       if Pos(txt, domain) > 0 then
       begin
         isFound := True;
         if MessageDlg(PChar('Effacer l''entrée suivante du Blackword? ['+txt+']'),  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
         begin
            callRestart := True;
            ListBoxBlacklist.ItemIndex := i;
            ListBoxBlacklist.DeleteSelected;
            ListBoxBlacklist.Items.SaveToFile(BlackListCfgFile);
            ActionDNS.clearCache;
         end else
         begin
           Inc(i);
         end;
       end
       else begin
         Inc(i);
       end;
    end;
    if callRestart then TimerRestart.Enabled := True;  //and isServerStarted
    if not isFound then ShowMessage('Pas de bloquage trouvé');
  end;

end;



end.
