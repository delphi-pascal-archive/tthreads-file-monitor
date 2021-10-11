object Form1: TForm1
  Left = 223
  Top = 132
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TThreads - '#1055#1086#1090#1086#1082#1080' - File monitor'
  ClientHeight = 370
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 264
    Top = 344
    Width = 71
    Height = 16
    Caption = #1055#1088#1086#1075#1088#1077#1089#1089'...'
  end
  object Label2: TLabel
    Left = 480
    Top = 312
    Width = 35
    Height = 16
    Caption = #1055#1091#1090#1100':'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 89
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 72
    Width = 465
    Height = 9
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 8
    Top = 120
    Width = 465
    Height = 209
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Button2: TButton
    Left = 208
    Top = 8
    Width = 89
    Height = 25
    Caption = #1050#1074#1072#1076#1088#1072#1090
    TabOrder = 3
    OnClick = Button2Click
  end
  object SpinEdit1: TSpinEdit
    Left = 304
    Top = 8
    Width = 49
    Height = 26
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 2
  end
  object Button3: TButton
    Left = 360
    Top = 8
    Width = 113
    Height = 25
    Caption = 'Add in Memo'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 104
    Top = 8
    Width = 97
    Height = 25
    Caption = 'Stop'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 176
    Top = 40
    Width = 145
    Height = 25
    Caption = 'ProgressBar Start'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 328
    Top = 40
    Width = 145
    Height = 25
    Caption = 'ProgressBar Stop'
    TabOrder = 8
    OnClick = Button6Click
  end
  object ProgressBar2: TProgressBar
    Left = 8
    Top = 88
    Width = 465
    Height = 9
    TabOrder = 9
  end
  object ProgressBar3: TProgressBar
    Left = 8
    Top = 104
    Width = 465
    Height = 9
    TabOrder = 10
  end
  object Button7: TButton
    Left = 8
    Top = 336
    Width = 241
    Height = 25
    Caption = #1054#1078#1080#1076#1072#1085#1080#1077' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1103' '#1080' '#1088#1072#1073#1086#1090#1072
    TabOrder = 11
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 8
    Top = 40
    Width = 161
    Height = 25
    Caption = 'ProgressBar Create'
    TabOrder = 12
    OnClick = Button8Click
  end
  object ListBox1: TListBox
    Left = 480
    Top = 40
    Width = 233
    Height = 257
    ItemHeight = 16
    Sorted = True
    TabOrder = 13
  end
  object Button9: TButton
    Left = 480
    Top = 8
    Width = 233
    Height = 25
    Caption = 'Run File monitor'
    TabOrder = 14
    OnClick = Button9Click
  end
  object Edit1: TEdit
    Left = 528
    Top = 304
    Width = 185
    Height = 24
    TabOrder = 15
  end
end
