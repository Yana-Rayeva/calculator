object MainFm: TMainFm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'MainFm'
  ClientHeight = 340
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Label1: TLabel
    Left = 25
    Top = 8
    Width = 260
    Height = 50
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Hello world '
    OnClick = Label1Click
  end
  object Button1: TButton
    Left = 25
    Top = 210
    Width = 50
    Height = 50
    Caption = '1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 95
    Top = 210
    Width = 50
    Height = 50
    Caption = '2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 165
    Top = 210
    Width = 50
    Height = 50
    Caption = '3'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 25
    Top = 150
    Width = 50
    Height = 50
    Caption = '4'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 95
    Top = 150
    Width = 50
    Height = 50
    Caption = '5'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 165
    Top = 150
    Width = 50
    Height = 50
    Caption = '6'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 25
    Top = 90
    Width = 50
    Height = 50
    Caption = '7'
    TabOrder = 6
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 95
    Top = 90
    Width = 50
    Height = 50
    Caption = '8'
    TabOrder = 7
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 165
    Top = 90
    Width = 50
    Height = 50
    Caption = '9'
    TabOrder = 8
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 95
    Top = 270
    Width = 50
    Height = 50
    Caption = '0'
    TabOrder = 9
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 235
    Top = 90
    Width = 50
    Height = 30
    Caption = #8592' '
    TabOrder = 10
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 235
    Top = 165
    Width = 50
    Height = 35
    Caption = '+'
    TabOrder = 11
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 235
    Top = 125
    Width = 50
    Height = 35
    Caption = '-'
    TabOrder = 12
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 235
    Top = 205
    Width = 50
    Height = 35
    Caption = '*'
    TabOrder = 13
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 235
    Top = 245
    Width = 50
    Height = 35
    Caption = #247
    TabOrder = 14
    OnClick = Button15Click
  end
  object Button16: TButton
    Left = 235
    Top = 285
    Width = 50
    Height = 35
    Caption = '='
    TabOrder = 15
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 25
    Top = 270
    Width = 50
    Height = 50
    Caption = '('
    TabOrder = 16
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 165
    Top = 270
    Width = 50
    Height = 50
    Caption = ')'
    TabOrder = 17
    OnClick = Button18Click
  end
  object Button19: TButton
    Left = 112
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Button19'
    TabOrder = 18
    OnClick = Button19Click
  end
end
