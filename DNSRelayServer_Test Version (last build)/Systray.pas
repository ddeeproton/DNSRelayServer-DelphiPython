unit Systray;

interface

uses
  Forms,  Messages,  ShellAPI,  Windows;
  
procedure EnleveIconeTray();
procedure ModifIconeTray(Texte:String;Icone:HICON);
procedure AjouteIconeTray(handle:HWND;Icone:HICON;Texte:string);

var
  IconeT:TNotifyIconData;

implementation

procedure AjouteIconeTray(handle:HWND;Icone:HICON;Texte:string);
var a:integer;
begin
  IconeT.cbSize := SizeOf(IconeT); //Taille de l'ic�ne en octet
  IconeT.wnd := handle;      //Handle de l'application
  IconeT.uID := 1;             //Identificateur de l'ic�ne
  IconeT.uFlags := NIF_ICON or NIF_TIP or NIF_MESSAGE;
  IconeT.uCallbackMessage := WM_MOUSEMOVE;     //Renvoyer les messages concernant l'action de la souris
  IconeT.hIcon := Icone;   //Mettre en ic�ne l'image qui est dans le contr�le "Image1"
  //Texte de la bulle d'aide
  if Length(Texte) > 64 then SetLength(Texte,64);
  IconeT.szTip:='';
  for a:=0 to Length(Texte)-1 do IconeT.szTip[a] := Texte[a+1];
  //Appel de la fonction pour mettre l'ic�ne dans le syst�me tray
  Shell_NotifyIcon(NIM_ADD,@IconeT);
end;

procedure EnleveIconeTray();
begin
  IconeT.uID := 1;
  Shell_NotifyIcon(NIM_DELETE,@IconeT);
end;

procedure ModifIconeTray(Texte:String;Icone:HICON);
var a:integer;
begin
  IconeT.uID:=1;
  //Texte de la bulle d'aide
  if Length(Texte) > 64 then SetLength(Texte,64);
  IconeT.szTip:='';
  for a:=0 to Length(Texte)-1 do IconeT.szTip[a] := Texte[a+1];
  IconeT.hIcon := Icone; //Icone
  Shell_NotifyIcon(NIM_MODIFY, @IconeT);  //modifie
End;

end.

