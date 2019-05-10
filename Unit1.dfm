object Form1: TForm1
  Left = 600
  Top = 353
  Caption = 'Form1'
  ClientHeight = 419
  ClientWidth = 892
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 137
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 193
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label2'
  end
  object Image1: TImage
    Left = 56
    Top = 39
    Width = 320
    Height = 288
    Stretch = True
  end
  object Button2: TButton
    Left = 56
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 0
    OnClick = Button2Click
  end
  object DXDraw1: TDXDraw
    Left = 512
    Top = 39
    Width = 320
    Height = 288
    AutoInitialize = True
    AutoSize = True
    Color = clBlack
    Display.FixedBitCount = False
    Display.FixedRatio = True
    Display.FixedSize = True
    Options = [doAllowReboot, doWaitVBlank, doCenter, do3D, doDirectX7Mode, doHardware, doSelectDriver]
    SurfaceHeight = 288
    SurfaceWidth = 320
    TabOrder = 1
    Traces = <>
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 240
    Top = 8
  end
end
