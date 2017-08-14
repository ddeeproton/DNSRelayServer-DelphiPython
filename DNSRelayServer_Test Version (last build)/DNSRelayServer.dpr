program DNSRelayServer;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UnitHost in 'UnitHost.pas' {FormHost},
  FilesManager in 'FilesManager.pas',
  Registre in 'Registre.pas',
  UnitInstallation in 'UnitInstallation.pas' {FormInstall},
  ListViewManager in 'ListViewManager.pas',
  HostParser in 'HostParser.pas',
  NetworkManager in 'NetworkManager.pas',
  ProcessManager in 'ProcessManager.pas',
  PythonDNS in 'PythonDNS.pas',
  DNSManager in 'DNSManager.pas',
  UnitAlert in 'UnitAlert.pas' {FormAlert},
  WindowsManager in 'WindowsManager.pas',
  UnitNetConfig in 'UnitNetConfig.pas' {FormNetConfig},
  StringManager in 'StringManager.pas',
  UnitRestartAlert in 'UnitRestartAlert.pas' {FormRestart};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DNS Relay Server';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormHost, FormHost);
  Application.CreateForm(TFormInstall, FormInstall);
  Application.CreateForm(TFormAlert, FormAlert);
  Application.CreateForm(TFormNetConfig, FormNetConfig);
  Application.CreateForm(TFormRestart, FormRestart);
  Application.Run;
end.
