unit API.RippleEffects;

interface

uses
  Winapi.Windows
, Vcl.Forms
, Vcl.Graphics
, Vcl.ExtCtrls
;

type
  TWaterEffect = class
  private
    fForm: TForm;
    fSx, fSy: Integer;
    fTimer: TTimer;
    IsBitmapLoaded: Boolean;
    fBitmap: TBitmap;
    procedure OnRippleTimer(Sender: TObject);
  public
    constructor Create(const aForm: TForm; const aBitmapResName: string; aSx, aSy: Integer);
    destructor Destroy; override;
    procedure InitBitmap;
    function MouseAction(aMouseX, aMouseY, aHalf, aDeep: Integer): Integer; inline;
  end;

implementation

uses
  System.Classes
, System.SysUtils
, System.Threading
, API.RippleHeader;

{ TWaterEffect }

procedure TWaterEffect.InitBitmap;
var
  LTask: ITask;

begin
  if (fBitmap.Handle <> 0)and not IsBitmapLoaded then begin

    LTask := TTask.Run(procedure begin
      TThread.Synchronize(nil, procedure begin
        WaterInit(fBitmap.Handle);
        IsBitmapLoaded := True;
        fTimer.Enabled := True;
      end);

    end);

  end;
end;

function TWaterEffect.MouseAction(aMouseX, aMouseY, aHalf, aDeep: Integer): Integer;
var
  LHandle: HDC;
begin
  if not IsBitmapLoaded then
    Exit(-1);

  LHandle := GetDC(fForm.Handle);
  try
    Result := WaterMouseAction(LHandle, fSx, fSy, aMouseX, aMouseY, aHalf, aDeep);
  finally
    ReleaseDC(fForm.Handle, LHandle);
  end;
end;

procedure TWaterEffect.OnRippleTimer(Sender: TObject);
var
  LHandle: HDC;
begin
  if not IsBitmapLoaded then
    Exit;

  LHandle := GetDC(fForm.Handle);
  try
    WaterTimer(LHandle, fSx, fSy);
  finally
    ReleaseDC(fForm.Handle, LHandle);
  end;
end;

constructor TWaterEffect.Create(const aForm: TForm; const aBitmapResName: string; aSx, aSy: Integer);
begin inherited Create;

  fForm := aForm;
  fSx := aSx;
  fSy := aSy;
  IsBitmapLoaded := False;

  fTimer := TTimer.Create(fForm);
  with fTimer do
  begin
    Interval := 10;
    OnTimer := OnRippleTimer;
    Enabled := False;
  end;

  fBitmap := TBitmap.Create;
    fBitmap.LoadFromResourceName(HInstance, aBitmapResName);
end;

destructor TWaterEffect.Destroy;
begin
  fTimer.Enabled := False;
  fTimer.Free;
  fBitmap.Free;

  inherited;
end;

end.
