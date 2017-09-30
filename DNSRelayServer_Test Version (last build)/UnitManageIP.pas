unit UnitManageIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormManageIP = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    ButtonAjouter: TButton;
    ButtonModifier: TButton;
    ButtonSupprimer: TButton;
    ButtonClose: TButton;
    procedure ButtonCloseClick(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  FormManageIP: TFormManageIP;

implementation

{$R *.dfm}

procedure TFormManageIP.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

end.
