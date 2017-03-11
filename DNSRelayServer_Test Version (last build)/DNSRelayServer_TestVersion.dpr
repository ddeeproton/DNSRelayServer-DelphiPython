program DNSRelayServer_TestVersion;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UnitHost in 'UnitHost.pas' {FormHost},
  FilesManager in 'FilesManager.pas',
  Registre in 'Registre.pas',
  UnitInstallation in 'UnitInstallation.pas' {FormInstall},
  ListViewManager in 'ListViewManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DNS Relay Server';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormHost, FormHost);
  Application.CreateForm(TFormInstall, FormInstall);
  Application.Run;
end.
