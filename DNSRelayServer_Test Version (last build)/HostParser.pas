unit HostParser;

interface

uses SysUtils, StrUtils, Classes, ComCtrls, StringManager;

procedure setDomain(hostfile, domain, ip: string);
procedure getDomains(hostfile: string; ListView:TListView);
function getDomain(hostfile, domain: string):string;
procedure delDomain(hostfile, domain: string);

implementation

procedure delDomain(hostfile, domain: string);
var
  fp : textfile;
  texte, result : string;
begin        
  domain := onlyChars(domain);
  if FileExists(hostfile) then
  begin
    assignFile(fp, hostfile);
    reset(fp);
    while not eof(fp) do
    begin
      readln(fp, texte);
      if Pos(domain, texte) = 0 then
        result := result + texte +#13#10;
    end;
    closefile(fp);
  end;
  assignFile(fp, hostfile);
  reWrite(fp);
  Write(Fp, result);
  closefile(fp);
end;


procedure setDomain(hostfile, domain, ip: string);
var
  i: Integer;
  fp : textfile;
  texte, result : string;
  isInHost : Boolean;
begin
  domain := onlyChars(domain);
  ip := onlyChars(ip);

  isInHost := false;
  if FileExists(hostfile) then
  begin
    assignFile(fp, hostfile);
    reset(fp);
    while not eof(fp) do
    begin
      readln(fp, texte);
      if Pos(domain, texte) > 0 then
      begin
        i := Pos(#9, texte); // #9 code ascii pour touche TAB (tabulation)
        if i > 0 then
        begin
          isInHost := true;
          result := result + ip + #9 + System.Copy(texte, i+1, Length(texte)-i+1) +#13#10;
        end
        else
          result := result + texte +#13#10;
      end else
        result := result + texte +#13#10;
    end;
    closefile(fp);
  end;

  if not isInHost then
    result := result + ip + #9 + domain +#13#10;
  assignFile(fp, hostfile);
  reWrite(fp);
  Write(Fp, result);
  closefile(fp);
end;



function getDomain(hostfile, domain: string): string;
var
  fp        : textfile;
  texte          : string;
  i: Integer;
begin
  domain := onlyChars(domain);

  if not FileExists(hostfile) then exit;
  assignFile(fp, hostfile);
  reset(fp);
  while not eof(fp) do
  begin
    readln(fp, texte);
    if Pos(domain, texte) > 0 then
    begin
      i := Pos(#9, texte); // #9 code ascii pour touche TAB (tabulation)
      if i > 0 then
      begin
        result := System.Copy(texte, 1, i-1);
        closefile(fp);
        exit;
      end;

    end;

  end;
  closefile(fp);
  result := '';
end;



procedure getDomains(hostfile: string; ListView:TListView);
var
  fp: textfile;
  texte, domain, ip: string;
  i: Integer;
  ListItem: TListItem;
begin
  if not FileExists(hostfile) then exit;
  assignFile(fp, hostfile);
  reset(fp);
  while not eof(fp) do
  begin
    readln(fp, texte);
    i := Pos(#9, texte); // #9 code ascii pour touche TAB (tabulation)
    if i > 0 then
    begin
      domain := System.Copy(texte, i+1, Length(texte) - i+1);
      ip := System.Copy(texte, 1, i-1);
      if (ip <> '') and (domain <> '') then
      begin
        ListItem := ListView.Items.Add;
        ListItem.Caption := domain;
        ListItem.SubItems.Add(ip);
        if ip = '127.0.0.1' then
          ListItem.ImageIndex := 3
        else
          ListItem.ImageIndex := 1;
        
      end;
    end;
  end;
  closefile(fp);
  //result := '';
end;

end.
