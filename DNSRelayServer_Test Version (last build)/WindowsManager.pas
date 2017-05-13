unit WindowsManager;

interface

uses Windows;

function SetFormOpacity(wnd: HWND; transparent:integer): boolean;

implementation


// Opacity
function SetFormOpacity(wnd: HWND; transparent:integer): boolean;
type
  TSetLayeredWindowAttributes = function(Handle: HWND; crKey: DWORD; bAlpha: Byte; dwFlags: DWORD): BOOL; stdcall;
const WS_EX_LAYERED = $00080000;
      LWA_COLORKEY  = $00000001;
      LWA_ALPHA     = $00000002;
var SetLayeredWindowAttributes: TSetLayeredWindowAttributes;
    h: THandle;
    dwStyle: DWORD;
    alpha: byte;
begin
  //if ((PLATFORM = 'Windows NT') and (VERSION[1] = '5')) then
  //begin
    h := LoadLibrary('user32.dll');
    if (h <> 0) then
    begin
      @SetLayeredWindowAttributes := GetProcAddress(h, 'SetLayeredWindowAttributes');
      alpha := (255 * transparent) div 100;
      dwStyle := GetWindowLong(wnd, GWL_EXSTYLE);
      SetWindowLong(wnd, GWL_EXSTYLE, dwStyle or WS_EX_LAYERED);
      if (@SetLayeredWindowAttributes <> nil) then
        SetLayeredWindowAttributes(wnd, RGB(0,0,0), alpha, LWA_ALPHA);
      FreeLibrary(h);
      result := true;
    end else result := false;
  //end else result := false;
end;

end.
