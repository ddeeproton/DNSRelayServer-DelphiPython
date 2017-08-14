unit StringManager;

interface

uses Classes, StrUtils;

procedure SplitStr(const Source, Delimiter: String; var DelimitedList: TStringList);
function onlyChars(txt: string):string;

implementation

procedure SplitStr(const Source, Delimiter: String; var DelimitedList: TStringList);
var
  s: PChar;
  DelimiterIndex: Integer;
  Item: String;
begin
  s:=PChar(Source);
  repeat
    DelimiterIndex:=Pos(Delimiter, s);
    if DelimiterIndex=0 then Break;
    Item:=Copy(s, 1, DelimiterIndex-1);
    DelimitedList.Add(Item);
    inc(s, DelimiterIndex + Length(Delimiter)-1);
  until DelimiterIndex = 0;
  DelimitedList.Add(s);
end;
  

function onlyChars(txt: string):string;
begin
  txt := AnsiReplaceStr(txt, #9, '');
  txt := AnsiReplaceStr(txt, #10, '');
  txt := AnsiReplaceStr(txt, #13, '');
  result := AnsiReplaceStr(txt, ' ', '');
end;


end.
