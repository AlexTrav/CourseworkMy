inherited ProductListForm: TProductListForm
  Left = 247
  Top = 188
  Width = 1563
  Height = 516
  Caption = 'ProductListForm'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnAction: TPanel
    Top = 422
    Width = 1547
    inherited bbDelete: TBitBtn
      Left = 16
    end
    inherited bbAddBalance: TBitBtn
      TabOrder = 2
    end
    object bbAddProduct: TBitBtn
      Left = 232
      Top = 11
      Width = 185
      Height = 33
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Default = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clHighlight
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = bbAddProductClick
    end
  end
  inherited pnData: TPanel
    Width = 1280
    Height = 381
    inherited MainGrid: TDBGrid
      Width = 1278
      Height = 379
    end
  end
  inherited pnFilter: TPanel
    Width = 1547
  end
  object pnPhoto: TPanel [3]
    Left = 1280
    Top = 41
    Width = 267
    Height = 381
    Align = alRight
    TabOrder = 3
    object iPhotoProduct: TImage
      Left = 13
      Top = 28
      Width = 241
      Height = 213
      Stretch = True
    end
    object l6: TLabel
      Left = 17
      Top = 8
      Width = 26
      Height = 13
      Caption = #1060#1086#1090#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 280
      Width = 50
      Height = 19
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 16
      Top = 304
      Width = 241
      Height = 27
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object Button1: TButton
      Left = 16
      Top = 336
      Width = 137
      Height = 25
      Caption = #1053#1072#1081#1090#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
  end
end
