unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,GBJoypad;
type
  PScreenArr = ^TScreenArry;
  TScreenArry = array[0..23039] of Integer;
  PGBBmpScren = ^TBitmap;
type
  TRGB32 = packed record
    B, G, R, A: Byte;
  end;
  TRGB32Array = packed array[0..MaxInt div SizeOf(TRGB32)-1] of TRGB32;
  PRGB32Array = ^TRGB32Array;
const
    GBColor : array[0..3] of Integer = (clBlue,clYellow,clRed,clBlack);
type
  TForm1 = class(TForm)
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    Image1: TImage;
    Label3: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    _fps,_fpsTotal: Integer;
    _bmp: TBitmap;
    _pbmp: PBitmap;
  public
    { Public declarations }
    //screen:array[0..23039] of Integer;
    _gbJoyPad: TGBJoypad;
    procedure drawScreen(pscreen: PScreenArr);
    procedure drawScreenBMP(pbmp: PGBBmpScren);
    procedure GBKeyDownMsg(var msg: TWMKeyDown); message WM_KEYDOWN;
  end;

var
  Form1: TForm1;

implementation
uses GBRom,GBMemory,GBCpu,GBTimer,GBGpu,GBMbc;
{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var
  getStream,setStream: TFileStream; {声明一个文件流}
  getPath,s: string;
  I,tmp: Integer;
  rom: TGBRom;
  mem: TGBMemory;
  cpu: TGBCpu;
  gpu: TGBGpu;
  pgpu: PGBGpu;
  pmem: PGBMemory;
  _gbrom: PGBRom;
  _mbc: TGBMbc;
  _Pmbc:PGBMbc;
begin
//  getPath := 'C:\Users\WJL\Desktop\EmuDoc\java-gameboy-emu-master\TestROMs\Super Mario Land (World).gb';
//  getPath := 'D:\Emulator\GB\Shanghai (USA).gb';
  getPath := 'D:\Emulator\GB\Tetris.gb';
//  getPath := 'D:\Emulator\GB\Super Mario Land (World).gb';
  getStream := TFileStream.Create(getPath, fmOpenRead or fmShareExclusive);
  getStream.Position := 0;
  rom := TGBRom.Create;
  rom.readRom(getStream);
  getStream.Free;
  gpu := TGBGpu.Create;
  pgpu := @gpu;
  _gbrom := @rom;
  _mbc := TGBMbc.Create(_gbrom);
  _pmbc := @_mbc;
  mem := TGBMemory.Create(_pmbc,pgpu);
  pmem := @mem;
  cpu := TGBCpu.Create(pmem,pgpu);
//  Application.ProcessMessages;
  cpu.skipBios;
//  cpu.main;
//  ShowMessage('done');
  while not cpu.Paused do
  begin
    //Application.ProcessMessages;
    cpu.step(1);
  end;

end;

procedure TForm1.drawScreen(pscreen: PScreenArr);
var
  x,y  : Integer;
  Line : PRGB32Array;
begin
  Inc(_fpsTotal);
  if not Timer1.Enabled then
  begin
    Timer1.Enabled := True;
  end;
  Label1.Caption := IntToStr(_fpsTotal);
  with _bmp do
  begin
    PixelFormat := pf32bit;
//    Width := 160;
//    Height := 144;
    for y := 0 to 144 - 1 do
    begin
      Line := Scanline[y];
      for x := 0 to 160 - 1 do
      begin
        case pscreen^[160*y+x] of
          0:begin//255，255，255
            Line[x].B := 208;
            Line[x].G := 248;
            Line[x].R := 224;
            Line[x].A := 0;
          end;
          1:begin//192，192，192
            Line[x].B := 112;
            Line[x].G := 192;
            Line[x].R := 136;
            Line[x].A := 0;
          end;
          2:begin//96，96，96
            Line[x].B := 86;
            Line[x].G := 104;
            Line[x].R := 52;
            Line[x].A := 0;
          end;
          3:begin//40,40,40
            Line[x].B := 32;
            Line[x].G := 24;
            Line[x].R := 8;
            Line[x].A := 0;
          end;
        end;
      end;
    end;
  end;
//  Image1.Invalidate;
  Image1.Picture.Bitmap := _bmp;
  Application.ProcessMessages;
end;

procedure TForm1.drawScreenBMP(pbmp: PGBBmpScren);
begin
  Inc(_fpsTotal);
  if not Timer1.Enabled then
  begin
    Timer1.Enabled := True;

  end;
  Label1.Caption := IntToStr(_fpsTotal);
  Image1.Picture.Bitmap := pbmp^;
  Application.ProcessMessages;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//    FillChar( screen, SizeOf( screen ), 0 );
    _fps := 0;
    _fpsTotal := 0;
    _bmp := TBitmap.Create;
    _bmp.PixelFormat := pf32bit;
    _bmp.Width := 160;
    _bmp.Height :=144;
  Image1.Picture.Bitmap := _bmp;
    _pbmp := @_bmp;
  Form1.KeyPreview := True;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  Form1.Caption := 'Down:' + IntToStr(Key);
  _gbJoyPad.Instance.GBKeyDown(Key);
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  Form1.Caption := 'Press:' + Key;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  Form1.Caption := 'Up:' + IntToStr(Key);
  _gbJoyPad.Instance.GBKeyUp(Key);
end;

procedure TForm1.GBKeyDownMsg(var msg: TWMKeyDown);
var
  buf: array[0..31] of Char;
  str: string;
begin
  {获取}
  GetKeyNameText(msg.KeyData, buf, Length(buf));
  {画出来}
  str := buf;
  Caption := str;
//  rect := ClientRect;
//  Canvas.FillRect(rect);
//  Canvas.TextRect(rect, str, [tfSingleLine, tfCenter, tfVerticalCenter]);
  inherited;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Inc(_fps);
  Label2.Caption := IntToStr(_fpsTotal div _fps);
end;

end.
