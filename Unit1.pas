unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DXDraws;
type
  PScreenArr = ^TScreenArry;
  TScreenArry = array[0..23039] of Integer;
  PGBBmpScren = ^TBitmap;
const
    GBColor : array[0..3] of Integer = (clBlue,clYellow,clRed,clBlack);
type
  TForm1 = class(TForm)
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    Image1: TImage;
    DXDraw1: TDXDraw;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    _fps,_fpsTotal: Integer;
    _bmp: TBitmap;
    _pbmp: PBitmap;
  public
    { Public declarations }
    //screen:array[0..23039] of Integer;
    procedure drawScreen(pscreen: PScreenArr);
    procedure drawScreenBMP(pbmp: PGBBmpScren);
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
  getPath := 'C:/Users/WJL/Desktop/EmuDoc/Tetris.gb';
  getStream := TFileStream.Create(getPath, fmOpenRead or fmShareExclusive);
  getStream.Position := 0;
  rom := TGBRom.Create;
  rom.readRom(getStream);
  gpu := TGBGpu.Create;
  pgpu := @gpu;
  _gbrom := @rom;
  _mbc := TGBMbc.Create(_gbrom);
  _pmbc := @_mbc;
  mem := TGBMemory.Create(_pmbc,pgpu);
  pmem := @mem;
  cpu := TGBCpu.Create(pmem,pgpu);
  Application.ProcessMessages;
  cpu.skipBios;
  cpu.main;
//  ShowMessage('done');
//  while not cpu.Paused do
//  begin
//    Application.ProcessMessages;
//    cpu.step(1);
//  end;

end;

procedure TForm1.drawScreen(pscreen: PScreenArr);
var
  I,line: Integer;
  posX,posY: Integer;
//  bmp: TBitmap;
//  stream: TStream;
begin
////  Inc(_fps);
  Inc(_fpsTotal);
  if not Timer1.Enabled then
  begin
    Timer1.Enabled := True;

  end;

  Label1.Caption := IntToStr(_fpsTotal);

//  with _bmp.canvas do
//  for posY := 0 to 143 do
//  begin
//    for posX := 0 to 159 do
//    begin
//      Pixels[posX,posY] := GBColor[pscreen^[160*posY+posX]];
//    end;
//  end;
//  DXDraw1.Surface.LoadFromGraphic(_bmp);
//	DXDraw1.Surface.Canvas.Release;
//	DXDraw1.Flip;

  DXDraw1.Surface.Fill($F2F5A9); {填充为红色, 注意这个颜色格式是和 HTML 的颜色顺序一样的}
  with DXDraw1.Surface.Canvas do
  begin
    Pen.Style:= psClear;
    for posY := 0 to 143 do
    begin
      for posX := 0 to 159 do
      begin
        case pscreen^[160*posY+posX] of
          0:begin
            DXDraw1.Surface.Canvas.Pixels[posX,posY] :=$F2F5A9;
          end;
          1:begin
            DXDraw1.Surface.Canvas.Pixels[posX,posY] :=clYellow;
          end;
          2:begin
            DXDraw1.Surface.Canvas.Pixels[posX,posY] :=clRed;
          end;
          3:begin
            DXDraw1.Surface.Canvas.Pixels[posX,posY] :=clBlack;
          end;
        end;
      end;
    end;
  end;
  DXDraw1.Surface.Canvas.Release; {释放 Canvas 对象}
  DXDraw1.Flip;
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
//DXDraw1.Surface.StretchDraw();

//  DXDraw1.Surface.LoadFromGraphic(pbmp^);
//	DXDraw1.Surface.Canvas.Release;
//	DXDraw1.Flip;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//    FillChar( screen, SizeOf( screen ), 0 );
    _fps := 0;
    _fpsTotal := 0;
    _bmp := TBitmap.Create;
    _bmp.Width := 160;
    _bmp.Height :=144;
    _pbmp := @_bmp;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Inc(_fps);
  Label2.Caption := IntToStr(_fpsTotal div _fps);
end;

end.
