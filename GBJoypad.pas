unit GBJoypad;

interface
uses System.SysUtils;
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
    class var FInstance: TGBJoypad;
    class function GetInstance: TGBJoypad; static;
  protected
     Constructor Create(); overload;
  public
    class procedure ReleaseInstance;
    class property Instance: TGBJoypad read GetInstance;
end;
implementation

{ TGBJoypad }

constructor TGBJoypad.Create;
begin

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

end.
