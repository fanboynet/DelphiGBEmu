object Form1: TForm1
  Left = 600
  Top = 353
  Caption = #20142#20142#30340'GameBoy'#27169#25311#22120
  ClientHeight = 392
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 89
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 145
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label2'
  end
  object Image1: TImage
    Left = 8
    Top = 39
    Width = 320
    Height = 288
    Stretch = True
  end
  object Label3: TLabel
    Left = 8
    Top = 344
    Width = 314
    Height = 39
    Caption = 
      '           Up=[W]'#13#10'Left=[A]           Right=[D]                 ' +
      '                         A=[J]   B=[K]'#13#10'           Down=[S]     ' +
      '            Select=[Z]    Start=[X]'
  end
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Load GB Rom'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 192
    Top = 8
  end
end
