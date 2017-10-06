unit FilesManager;

interface

uses SysUtils, Classes;

  function ReadFromFile(Filename: string):String;
  procedure WriteInFile(Filename, txt: string);

  function ReadFileToStringList(Filename: string):TStringList;
  procedure WriteStringListInFile(Filename: string; content :TStringList);

  function makeDir(path:string):Boolean; 
  function FileSize(fileName : wideString) : Int64;
  function dirList(dirname : wideString; Filtre : string = '*.*'; onlyDir: Boolean = False; onlyFiles: Boolean = False; isFullPath: Boolean = True ) : TStrings;

  //procedure deleteFile(fname: string);
implementation

{
procedure deleteFile(fname: string);
begin
  DeleteFile(PAnsiChar(fname));
end;
}

function dirList(dirname : wideString; Filtre : string = '*.*'; onlyDir: Boolean = False; onlyFiles: Boolean = False; isFullPath: Boolean = True ) : TStrings;
var filename: String;
    dirHandle: Integer;
    searchResult: TSearchRec;
    attributs: Integer;
begin
  result := TStringList.Create;
  attributs := faDirectory + faHidden + faSysFile+ faVolumeID + faArchive ;
  dirHandle := FindFirst(dirname+'\'+filtre, attributs, searchResult);
  while dirHandle = 0 do
  begin
    if isFullPath then
      filename := dirname+'\'+searchResult.Name
    else
      filename := searchResult.Name;
    if ((searchResult.Attr and faDirectory) <= 0) then // if is file
      if not onlyDir then
        result.Add(filename)
    else // if is dir
      if not onlyFiles then
        result.Add(filename);
    dirHandle := FindNext(searchResult);
  end;
  FindClose(searchResult);
end;

function FileSize(fileName : wideString) : Int64;
var
  sr : TSearchRec;
begin
  if FindFirst(fileName, faAnyFile, sr ) = 0 then
     result := Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow)
  else
     result := -1;
  FindClose(sr) ;
end;

function ReadFromFile(Filename: string):String;
var
  Fichier        : textfile;
  texte          : string;
begin
  result:= '';
  if not FileExists(Filename) then exit;
  try
    //reset(Fp);
    {$I-}
    assignFile(Fichier, Filename);
    reset(Fichier); // ouvre en lecture
    while not eof(Fichier) do begin
      readln(Fichier, texte);
      if texte <> '' then
        result := result + texte;
    end;
    closefile(Fichier);
    {$I+}
  except
  // If there was an error the reason can be found here
  on E: EInOutError do
    //writeln('File handling error occurred. Details: ', E.ClassName, '/', E.Message);
    exit;
  end;
end;



procedure WriteInFile(Filename, txt: string);
var
  Fp : textfile;
begin
  if not DirectoryExists(ExtractFileDir(Filename)) then exit;
  assignFile(Fp, Filename);
  try
    {$I-}
    reWrite(Fp);
    Write(Fp, txt);
    closefile(Fp);
    {$I+}
  except
  on E: EInOutError do
    //writeln('File handling error occurred. Details: ', E.ClassName, '/', E.Message);
    exit;
  end;
end;

function ReadFileToStringList(Filename: string):TStringList;
begin
  result:=TStringList.Create;
  if FileExists(Filename) then result.LoadFromFile(Filename);
end;

procedure WriteStringListInFile(Filename: string; content :TStringList);
begin
  if not DirectoryExists(ExtractFileDir(Filename)) then exit;
  content.SaveToFile(FileName);
end;


function makeDir(path:string):Boolean; // return true if created
var
  error : Integer;
begin
  {$IOChecks off}
  MkDir(path);
  error := IOResult;
  result := error = 0;
  {$IOChecks on}
end;

end.
