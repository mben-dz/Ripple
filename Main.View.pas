unit Main.View;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  API.RippleEffects;

type
  TMainView = class(TForm)
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fRipple: TWaterEffect;
    { Private declarations }
  public
    { Public declarations }
  end;


var
  MainView: TMainView;

implementation

uses
  System.Threading
, API.RippleHeader;


{$R *.dfm}

procedure TMainView.FormCreate(Sender: TObject);
begin
  fRipple := TWaterEffect.Create(Self, 'CRISTO', 0, 0);
  fRipple.InitBitmap;
end;

procedure TMainView.FormDestroy(Sender: TObject);
begin
  fRipple.Free;
end;

procedure TMainView.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  fRipple.MouseAction(X, Y, 30, 5000);
end;

procedure TMainView.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  fRipple.MouseAction(X, Y, 10, 100);
end;

end.
