unit UnitNetConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormNetConfig = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label9: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    RadioButtonDHCP_IP: TRadioButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Edit2: TEdit;
    Memo5: TMemo;
    Memo6: TMemo;
    Memo7: TMemo;
    Memo8: TMemo;
    Edit3: TEdit;
    Memo9: TMemo;
    Memo10: TMemo;
    Memo11: TMemo;
    Memo12: TMemo;
    RadioButtonCUSTOM_IP: TRadioButton;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    Memo13: TMemo;
    Memo14: TMemo;
    Memo15: TMemo;
    Memo16: TMemo;
    Edit5: TEdit;
    Memo17: TMemo;
    Memo18: TMemo;
    Memo19: TMemo;
    Memo20: TMemo;
    Label10: TLabel;
    RadioButtonDHCP_DNS: TRadioButton;
    RadioButtonCUSTOM_DNS: TRadioButton;
    procedure LabelClick(Sender: TObject);
    procedure RadioButtonDHCP_IPClick(Sender: TObject);
    procedure RadioButtonCUSTOM_IPClick(Sender: TObject);
    procedure RadioButtonDHCP_DNSClick(Sender: TObject);
    procedure RadioButtonCUSTOM_DNSClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormNetConfig: TFormNetConfig;

implementation

{$R *.dfm}

procedure TFormNetConfig.LabelClick(Sender: TObject);
var
  RadioButton: TRadioButton;
begin
  RadioButton := TRadioButton(TLabel(Sender).FocusControl);
  RadioButton.Checked := not RadioButton.Checked;
  RadioButton.OnClick(RadioButton);
  RadioButton.SetFocus;
end;

procedure TFormNetConfig.RadioButtonDHCP_IPClick(Sender: TObject);
begin
//
end;

procedure TFormNetConfig.RadioButtonCUSTOM_IPClick(Sender: TObject);
begin
//
end;

procedure TFormNetConfig.RadioButtonDHCP_DNSClick(Sender: TObject);
begin
//
end;

procedure TFormNetConfig.RadioButtonCUSTOM_DNSClick(Sender: TObject);
begin
//
end;

procedure TFormNetConfig.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormNetConfig.Button1Click(Sender: TObject);
begin
  Close;
end;

end.





