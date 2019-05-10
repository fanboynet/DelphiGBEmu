program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  GBCartridge in 'GBCartridge.pas',
  GBCpu in 'GBCpu.pas',
  GBGpu in 'GBGpu.pas',
  GBInterruptManager in 'GBInterruptManager.pas',
  GBMbc in 'GBMbc.pas',
  GBMemory in 'GBMemory.pas',
  GBRom in 'GBRom.pas',
  GBTimer in 'GBTimer.pas',
  GBJoypad in 'GBJoypad.pas',
  GBTypes in 'GBTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
