inherited BasketForm: TBasketForm
  Caption = #1050#1086#1088#1079#1080#1085#1072
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnAction: TPanel
    object bbPlace: TBitBtn [2]
      Left = 224
      Top = 11
      Width = 193
      Height = 33
      Caption = #1054#1092#1086#1088#1084#1080#1090#1100' '#1079#1072#1082#1072#1079
      Default = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clHighlight
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnClick = bbPlaceClick
    end
    inherited bbAddBalance: TBitBtn
      Left = 1059
      TabOrder = 3
    end
    inherited bbAddProduct: TBitBtn
      Left = 432
    end
  end
  inherited pnPhoto: TPanel
    inherited iPhotoProduct: TImage
      Height = 205
    end
  end
end
