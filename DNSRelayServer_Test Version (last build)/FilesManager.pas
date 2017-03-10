unit FilesManager;

interface

  function lireFichier(Filename: string):String;
  procedure ecrireDansUnFichier(Fichier: string; txt: string);
  function makeDir(path:string):Boolean; 

implementation


function LireFichier(Filename: string):String;
var
  Fichier        : textfile;
  texte          : string;
begin
  result:= '';
  assignFile(Fichier, Filename);
  reset(Fichier); // ouvre en lecture
  while not eof(Fichier) do begin
    readln(Fichier, texte);
    if texte <> '' then
      result := result + texte;
  end;
  closefile(Fichier);
end;

procedure ecrireDansUnFichier(Fichier: string; txt: string);
var
  Fp : textfile;
begin
  assignFile(Fp, Fichier);
  reWrite(Fp); // ouvre en lecture
  Write(Fp, txt);
  closefile(Fp);
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
