unit GBJoypad;

interface
uses System.SysUtils,GBInterruptManager;
//type GBKeys = (A=90,B=88,START=10,SELECT=16,UP=38,DOWN=40,LEFT=37,RIGHT=39);
//type GBKey_Index = (UP,DOWN,LEFT,RIGHT,A,B,SELECT,START);

type TGBJoypad = class
  private
    aPressed: Boolean;
    bPressed: Boolean;
    startPressed: Boolean;
    selectPressed: Boolean;
    upPressed: Boolean;
    downPressed: Boolean;
    leftPressed: Boolean;
    rightPressed: Boolean;
    isDpadMode: Boolean;
    GBKeys: array[0..7] of Integer;
    class var FInstance: TGBJoypad;
    class function GetInstance: TGBJoypad; static;
  protected
     Constructor Create(); overload;
  public
    _GBInterrupt: TGBInterruptManager;
    function getGBKeyPressed():Integer;
    procedure setGBJoypadMode(value: Integer);
    procedure GBKeyDown(Key: Integer);//按下
    procedure GBKeyUp(Key:Integer);//放开
    class procedure ReleaseInstance;
    class property Instance: TGBJoypad read GetInstance;
end;
implementation

{ TGBJoypad }

constructor TGBJoypad.Create;
begin
    aPressed := False;
    bPressed := False;
    startPressed := False;
    selectPressed := False;
    upPressed := False;
    downPressed := False;
    leftPressed := False;
    rightPressed := False;

    // UP=87,DOWN=83,LEFT=65,RIGHT=68
    GBKeys[0] := 87;
    GBKeys[1] := 83;
    GBKeys[2] := 65;
    GBKeys[3] := 68;
    // A=74,B=75,SELECT=90,START=88
    GBKeys[4] := 74;
    GBKeys[5] := 75;
    GBKeys[6] := 90;
    GBKeys[7] := 88;
end;

procedure TGBJoypad.GBKeyDown(Key: Integer);
begin
  case Key of
    // UP=87,DOWN=83,LEFT=65,RIGHT=68
    74:begin
      if not isDpadMode then
        _GBInterrupt.Instance.raiseInterruptByIdx(0);//JoyPad_Input
      aPressed := True;
    end;
    75:begin
      if not isDpadMode then
        _GBInterrupt.Instance.raiseInterruptByIdx(0);//JoyPad_Input
      bPressed := True;
    end;
    88:begin
      if not isDpadMode then
        _GBInterrupt.Instance.raiseInterruptByIdx(0);//JoyPad_Input
      startPressed := True;
    end;
    90:begin
      if not isDpadMode then
        _GBInterrupt.Instance.raiseInterruptByIdx(0);//JoyPad_Input
      selectPressed := True;
    end;
    // UP=87,DOWN=83,LEFT=65,RIGHT=68
    87:begin
      if isDpadMode then
        _GBInterrupt.Instance.raiseInterruptByIdx(0);//JoyPad_Input
      upPressed := True;
    end;
    83:begin
      if isDpadMode then
        _GBInterrupt.Instance.raiseInterruptByIdx(0);//JoyPad_Input
      downPressed := True;
    end;
    65:begin
      if isDpadMode then
        _GBInterrupt.Instance.raiseInterruptByIdx(0);//JoyPad_Input
      leftPressed := True;
    end;
    68:begin
      if isDpadMode then
        _GBInterrupt.Instance.raiseInterruptByIdx(0);//JoyPad_Input
      rightPressed := True;
    end;
  else
    // 其他所有键都不处理
  end;
end;

procedure TGBJoypad.GBKeyUp(Key: Integer);
begin
  case Key of
    // UP=87,DOWN=83,LEFT=65,RIGHT=68
    74:begin
      aPressed := False;
    end;
    75:begin
      bPressed := False;
    end;
    88:begin
      startPressed := False;
    end;
    90:begin
      selectPressed := False;
    end;
    // UP=87,DOWN=83,LEFT=65,RIGHT=68
    87:begin
      upPressed := False;
    end;
    83:begin
      downPressed := False;
    end;
    65:begin
      leftPressed := False;
    end;
    68:begin
      rightPressed := False;
    end;
  else
    // 其他所有键都不处理
  end;
end;

function TGBJoypad.getGBKeyPressed: Integer;
var
  retval: Integer;
begin
  retval := $CF;
  if (isDpadMode) then//按的是十字键
  begin
    retval := retval or $20;
    if downPressed then// Bit 3 - P13 Input Down  (0=Pressed)
      retval := retval and $F7
    else
      retval := retval and $FF;
    if upPressed then// Bit 2 - P12 Input Up    (0=Pressed)
      retval := retval and $FB
    else
      retval := retval and $FF;

    if leftPressed then// Bit 1 - P11 Input Left  (0=Pressed)
      retval := retval and $FD
    else
      retval := retval and $FF;
    if rightPressed then// Bit 0 - P10 Input Right (0=Pressed)
      retval := retval and $FE
    else
      retval := retval and $FF;
  end
  else begin//按的是按钮键
    retval := retval or $20;
    if startPressed then//  Bit 3 - P13 Input Start    (0=Pressed)
      retval := retval and $F7
    else
      retval := retval and $FF;
    if selectPressed then//Bit 2 - P12 Input Select   (0=Pressed)
      retval := retval and $FB
    else
      retval := retval and $FF;

    if bPressed then//Bit 1 - P11 Input Button B (0=Pressed)
      retval := retval and $FD
    else
      retval := retval and $FF;
    if aPressed then// Bit 0 - P10 Input Button A (0=Pressed)
      retval := retval and $FE
    else
      retval := retval and $FF;
  end;
  Result := retval;
end;

class function TGBJoypad.GetInstance: TGBJoypad;
begin
  if FInstance = nil then FInstance := TGBJoypad.Create;
  Result := FInstance;
end;

class procedure TGBJoypad.ReleaseInstance;
begin
  FreeAndNil (FInstance );
end;

procedure TGBJoypad.setGBJoypadMode(value: Integer);
begin
  value := value and $30;
  if value = $20 then
    isDpadMode := True
  else if value = $10 then
    isDpadMode := False;
end;

end.
