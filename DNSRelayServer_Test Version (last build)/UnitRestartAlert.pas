unit UnitRestartAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WindowsManager, ExtCtrls, Buttons;

type
  TFormRestart = class(TForm)
    ButtonRestart: TButton;
    TimerFadeIn: TTimer;
    TimerFadeOut: TTimer;
    Panel1: TPanel;
    SpeedButtonClose: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonRestartClick(Sender: TObject);
    procedure TimerFadeInTimer(Sender: TObject);
    procedure TimerFadeOutTimer(Sender: TObject);
    procedure SpeedButtonCloseClick(Sender: TObject);
    procedure SpeedButtonCloseDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TRestart = class(TThread)
  private
  protected
    procedure Execute; override;
  public
  end;

var
  FormRestart: TFormRestart;
  opacity: Integer;
  ThreadRestart: TRestart;
implementation

{$R *.dfm}

uses Unit1;



procedure TFormRestart.FormCreate(Sender: TObject);
begin
  try                     
    // Masque la fenêtre de la taskbar
    SetWindowLong(Self.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);

    ButtonRestart.Align := alClient;
    Self.Left := Screen.WorkAreaWidth - Self.Width;
    Self.Top := Screen.WorkAreaHeight - Self.Height;
    opacity := 0;
    SetFormOpacity(Self.Handle, opacity);
    TimerFadeIn.Enabled := True;
    if Sender = nil then Form1.PanelRestart.Visible := True;
  except
    On E : EOSError do exit;  
    On E : EAccessViolation do exit;
  end;
end;

procedure TFormRestart.ButtonRestartClick(Sender: TObject);
begin
  TimerFadeOut.Enabled := True;
  ThreadRestart := TRestart.Create(False);
end;

procedure TRestart.Execute();
begin
  Form1.ButtonApplyChangesClick(nil);
  ThreadRestart.Terminate;
end;

procedure TFormRestart.TimerFadeInTimer(Sender: TObject);
begin
  try
    SetFormOpacity(Self.Handle, opacity);
    if opacity < 100 then Inc(opacity) else TTimer(Sender).Enabled := False;
  except
    On E : EOSError do exit;
    On E : EAccessViolation do exit;
  end;
end;

procedure TFormRestart.TimerFadeOutTimer(Sender: TObject);
begin
  try
    SetFormOpacity(Self.Handle, opacity);
    if opacity > 0 then
      Dec(opacity)
    else
    begin
      TTimer(Sender).Enabled := False;
      Self.Close;
      Self.Free;
    end;
  except
    On E : EOSError do exit;   
    On E : EAccessViolation do exit;
  end;
end;

procedure TFormRestart.SpeedButtonCloseClick(Sender: TObject);
begin
  TimerFadeOut.Enabled := True;
end;

procedure TFormRestart.SpeedButtonCloseDblClick(Sender: TObject);
begin
  Close;
end;

end.
