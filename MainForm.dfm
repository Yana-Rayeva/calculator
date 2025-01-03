object MainFm: TMainFm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Calculator'
  ClientHeight = 399
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
  object CalcLineLabel: TLabel
    Left = 25
    Top = 64
    Width = 260
    Height = 41
    Alignment = taRightJustify
    AutoSize = False
    Caption = ' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnOne: TButton
    Left = 25
    Top = 266
    Width = 50
    Height = 50
    Caption = '1'
    TabOrder = 0
    OnClick = btnOnClick
  end
  object btnTwo: TButton
    Left = 95
    Top = 266
    Width = 50
    Height = 50
    Caption = '2'
    TabOrder = 1
    OnClick = btnOnClick
  end
  object btnThree: TButton
    Left = 165
    Top = 266
    Width = 50
    Height = 50
    Caption = '3'
    TabOrder = 2
    OnClick = btnOnClick
  end
  object btnFour: TButton
    Left = 25
    Top = 206
    Width = 50
    Height = 50
    Caption = '4'
    TabOrder = 3
    OnClick = btnOnClick
  end
  object btnFive: TButton
    Left = 95
    Top = 206
    Width = 50
    Height = 50
    Caption = '5'
    TabOrder = 4
    OnClick = btnOnClick
  end
  object btnSix: TButton
    Left = 165
    Top = 206
    Width = 50
    Height = 50
    Caption = '6'
    TabOrder = 5
    OnClick = btnOnClick
  end
  object btnSeven: TButton
    Left = 25
    Top = 146
    Width = 50
    Height = 50
    Caption = '7'
    TabOrder = 6
    OnClick = btnOnClick
  end
  object btnEight: TButton
    Left = 95
    Top = 146
    Width = 50
    Height = 50
    Caption = '8'
    TabOrder = 7
    OnClick = btnOnClick
  end
  object btnNine: TButton
    Left = 165
    Top = 146
    Width = 50
    Height = 50
    Caption = '9'
    TabOrder = 8
    OnClick = btnOnClick
  end
  object btnZero: TButton
    Left = 95
    Top = 326
    Width = 50
    Height = 50
    Caption = '0'
    TabOrder = 9
    OnClick = btnOnClick
  end
  object btnDeleteSymbol: TButton
    Left = 235
    Top = 146
    Width = 50
    Height = 30
    Caption = #8592' '
    TabOrder = 10
    OnClick = btnDeleteSymbolClick
  end
  object btnPlus: TButton
    Left = 235
    Top = 221
    Width = 50
    Height = 35
    Caption = '+'
    TabOrder = 11
    OnClick = btnOnClick
  end
  object btnMinus: TButton
    Left = 235
    Top = 181
    Width = 50
    Height = 35
    Caption = '-'
    TabOrder = 12
    OnClick = btnOnClick
  end
  object btnMultiply: TButton
    Left = 235
    Top = 261
    Width = 50
    Height = 35
    Caption = '*'
    TabOrder = 13
    OnClick = btnOnClick
  end
  object btnDivide: TButton
    Left = 235
    Top = 301
    Width = 50
    Height = 35
    Caption = '/'
    TabOrder = 14
    OnClick = btnOnClick
  end
  object btnEquals: TButton
    Left = 235
    Top = 341
    Width = 50
    Height = 35
    Caption = '='
    TabOrder = 15
    OnClick = btnOnClick
  end
  object btnOpenBracket: TButton
    Left = 25
    Top = 326
    Width = 50
    Height = 50
    Caption = '('
    TabOrder = 16
    OnClick = btnOnClick
  end
  object btnCloseBracket: TButton
    Left = 165
    Top = 326
    Width = 50
    Height = 50
    Caption = ')'
    TabOrder = 17
    OnClick = btnOnClick
  end
  object btnFirstCalc: TButton
    Left = 25
    Top = 16
    Width = 75
    Height = 25
    Caption = 'First'
    TabOrder = 18
    OnClick = btnFirstCalcClick
  end
  object btnSecondCalc: TButton
    Left = 121
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Second'
    TabOrder = 19
    OnClick = btnSecondCalcClick
  end
  object btnThirdCalc: TButton
    Left = 210
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Third'
    TabOrder = 20
    OnClick = btnThirdCalcClick
  end
  object btnDeleteText: TButton
    Left = 25
    Top = 115
    Width = 260
    Height = 25
    BiDiMode = bdRightToLeft
    Caption = 'C'
    ParentBiDiMode = False
    TabOrder = 21
    OnClick = btnDeleteTextClick
  end
end
