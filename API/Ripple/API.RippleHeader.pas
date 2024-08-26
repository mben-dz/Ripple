unit API.RippleHeader;

interface

uses
  Winapi.Windows;

// Functions
const
  RippleDll = 'WaterDll.dll';

function WaterInit(bitmap:HDC):Integer; stdcall; external RippleDll;
function WaterMouseAction(hdc:HDC; sx,sy,mx,my,half,deep:Integer):Integer; stdcall; external RippleDll;
function WaterTimer(hdc:HDC; sx,sy:Integer):Integer; stdcall; external RippleDll;

implementation

end.
