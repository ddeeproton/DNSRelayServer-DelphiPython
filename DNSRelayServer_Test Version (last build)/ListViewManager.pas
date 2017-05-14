unit ListViewManager;

interface

uses ComCtrls, SysUtils, Forms, Windows;

procedure ListViewCreate(ListView: TListView);
procedure RafraichirProxies(ListView: TListView);
procedure ChargerProxies(ListView: TListView);
procedure AjouterUneColone(NewColumn: TListColumn; Titre:string; Largeur:integer);
procedure SauvegarderProxies(ListView: TListView);
procedure EditerLigne(ListView: TListView; ListItem: TListItem; Ligne:integer; ImageNum:integer = -1; Colone1: string = ''; Colone2: string = ''; isChecked: Boolean = false);
procedure ListViewClick(Sender: TObject);
procedure ListView1DblClick(Sender: TObject);
procedure EditerLigne2(ListView: TListView; Ligne:integer; ImageNum:integer = -1;
  Colone1: string = ''; Colone2: string = ''; isChecked: Boolean = false);
procedure ListViewEraseFromImageIndex(ListView:TListView;indexImage:integer);

implementation



procedure ListViewCreate(ListView: TListView);
begin
  // On créer la première colone dans ListView1
  AjouterUneColone(ListView.Columns.Add,
                   'Domain',
                   250); //ListView.Width div 2 + 30
  // On créer la seconde colone dans ListView1
  AjouterUneColone(ListView.Columns.Add,
                   'IP',
                   ListView.Width - 200);   //ListView.Width div 2 - 50

  // On charge la liste des proxy dans ListView1
  ChargerProxies(ListView);
  // On coche la case du proxy actuel
  RafraichirProxies(ListView);
end;


// Met une croix au proxy actuel et enlève la croix aux autres
procedure RafraichirProxies(ListView: TListView);
var
  CurrProxy : String;
  ProxyActive: boolean;
   i: integer;
begin
  // Si une sauvegarde des proxy existe
  if FileExists('') then
  begin
    // Récupère si le proxy est actif dans Internet Explorer
    ProxyActive := false;
    // On recupere l'adresse du proxy
    CurrProxy := '127.0.0.1';
    // Pour chaques adresses de la liste des proxy
    for i := 0 to ListView.items.count - 1 do
    begin
      // On coche la case du proxy actuel (si actif) et decoche les autres
      ListView.Items.Item[i].Checked := (ListView.Items.Item[i].Caption = CurrProxy) and ProxyActive;
    end;
  end;
  Application.ProcessMessages;
end;




// Charge les proxies dans le listView
procedure ChargerProxies(ListView: TListView);
var
  Fichier        : textfile;
  texte          : string;
begin
  if not FileExists('a.txt') then exit;
  ListView.Items.Clear;
  assignFile(Fichier, 'a.txt');
  reset(Fichier); // ouvre en lecture
  while not eof(Fichier) do
  begin
    readln(Fichier, texte);
    // On ajoute le proxy en fin de liste
    EditerLigne(ListView,
                ListView.Items.Add,       // Item (ou ligne) du listView
                ListView.Items.Count,     // Numéro de ligne
                0,                   // Numéro de l'image
                texte,                     // Adresse du proxy
                '');     // Texte du status

  end;
  closefile(Fichier);
end;


// Sauvegarde les proxies du listView
procedure SauvegarderProxies(ListView: TListView);
var
  i: Integer;
  Fp : textfile;
begin
  assignFile(Fp, 'a.txt');
  reWrite(Fp);
  for i := 0 to ListView.items.count - 1 do
  begin
    Writeln(Fp, ListView.Items.Item[i].Caption);
  end;
  closefile(Fp);
end;


// Ajoute une colone dans le listView
procedure AjouterUneColone(NewColumn: TListColumn; Titre:string; Largeur:integer);
begin
  // Titre de la colone
  NewColumn.Caption := Titre;
  // Largeur de la colone
  NewColumn.Width   := Largeur;
end;


// Edite (ou ajoute) une ligne dans le listView
procedure EditerLigne(ListView: TListView; ListItem: TListItem; Ligne:integer; ImageNum:integer = -1;
  Colone1: string = ''; Colone2: string = ''; isChecked: Boolean = false);
begin
  // Met dans le listView l'adresse IP si on en indique une
  if Colone1 <> '' then
    Listitem.Caption    := Colone1;
  // Met dans le listView le status si on l'indique
  if Colone2 <> '' then
  begin
    // Si la ligne vient à l'instant d'être créer
    // (donc que la deuxième colone n'a pas encore une valeure)
    if ListView.Items.Item[Ligne].SubItems.Count = 0 then
    begin
      // On ajoute le status dans la deuxième colone
      ListView.Items.Item[Ligne].SubItems.Add(Colone2);
    end
    else // Si la ligne a déjà été crée
      // On édite le status de la deuxième colone
      ListView.Items.Item[Ligne].SubItems.Strings[0] := Colone2;
  end;
  // Si on a indiqué un numéro d'image
  if ImageNum > -1 then
    // On change d'image
    ListItem.ImageIndex := ImageNum;
end;


// Edite (ou ajoute) une ligne dans le listView
procedure EditerLigne2(ListView: TListView; Ligne:integer; ImageNum:integer = -1;
  Colone1: string = ''; Colone2: string = ''; isChecked: Boolean = false);
var ListItem: TListItem;
begin
  if (ListView.Items.Count < Ligne) then exit;
  if (ListView.Items.Count = Ligne) then
    ListItem := ListView.Items.Add
  else
    if Ligne = -1 then
      ListItem := ListView.Items.Insert(0)
    else
      ListItem := ListView.Items.Item[Ligne];
  // Met dans le listView l'adresse IP si on en indique une
  if Colone1 <> '' then
    ListItem.Caption    := Colone1;
  // Met dans le listView le status si on l'indique
  if Colone2 <> '' then
  begin
    // Si la ligne vient à l'instant d'être créer
    // (donc que la deuxième colone n'a pas encore une valeure)
    if ListItem.SubItems.Count = 0 then
    begin
      // On ajoute le status dans la deuxième colone
      ListItem.SubItems.Add(Colone2);
    end
    else // Si la ligne a déjà été crée
      // On édite le status de la deuxième colone
      ListItem.SubItems.Strings[0] := Colone2;
  end;
  // Si on a indiqué un numéro d'image
  if ImageNum > -1 then
    // On change d'image
    ListItem.ImageIndex := ImageNum;
  ListItem.Checked := isChecked;
end;


// Coche la ligne selectionnee si on double clique dessus
procedure ListView1DblClick(Sender: TObject);
var i: integer;
Begin
  exit;
  // Si aucune ligne selectionnee, on sort de la procedure
  if TListView(Sender).SelCount = 0 then exit;
  // Recupere la ligne selectionnee
  i := TListView(Sender).Selected.Index;
  //txt := TListView(Sender).Items.Item[i].Caption;
end;


// Quand on coche ou decoche une case dans la liste des proxy
// On active ou désactive le proxy dans la base de registre
procedure ListViewClick(Sender: TObject);
var
  ListItem:TListItem;
  CurPos:TPoint;
begin
  // Si on clique dans la case à cocher, on séléctionne la ligne
  // Donc on récupère la position de la souris sur l'écran
  GetcursorPos(CurPos);
  // on indique sa position en fonction du ListView
  CurPos:=TListView(Sender).ScreenToClient(CurPos);
  // On récupère la ligne du listView où se trouve la souris
  ListItem:=TListView(Sender).GetItemAt(CurPos.x,CurPos.y);
  // Si on récupère bien une ligne et pas un espace blanc
  if Assigned(ListItem) then
  begin
    // Si on se trouve bien dans la case à cocher
    if (CurPos.x >= 5) and (CurPos.x <= 20) then
      if ListItem.Checked then
      begin
        //ListItem.Caption
      end
      else begin

      end;
    end;
  // On rafraîchit la liste des proxy
  RafraichirProxies(TListView(Sender));
end;

procedure ListViewEraseFromImageIndex(ListView:TListView;indexImage:integer);
var
  i: integer;
begin
  i := 0;
  while i < ListView.items.count do
    if ListView.Items.Item[i].ImageIndex = indexImage then
      ListView.Items.Item[i].Delete
    else
      Inc(i);
end;

end.
