inherited ProductForm: TProductForm
  Width = 735
  Height = 431
  Caption = #1055#1088#1086#1076#1091#1082#1090#1099
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnAction: TPanel
    Top = 337
    Width = 719
    inherited bbOk: TBitBtn
      OnClick = bbOkClick
    end
    inherited bbClose: TBitBtn
      Left = 600
    end
    object bbLoadPhoto: TBitBtn
      Left = 264
      Top = 14
      Width = 185
      Height = 27
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1092#1086#1090#1086
      Default = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clHighlight
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnClick = bbLoadPhotoClick
    end
  end
  inherited pnData: TPanel
    Width = 719
    Height = 296
    object iProduct: TImage
      Left = 448
      Top = 72
      Width = 257
      Height = 209
      Stretch = True
    end
    object lRedactor: TLabel
      Left = 176
      Top = 8
      Width = 337
      Height = 33
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1087#1088#1086#1076#1091#1082#1090#1086#1074
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l1: TLabel
      Left = 24
      Top = 48
      Width = 125
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1076#1091#1082#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l2: TLabel
      Left = 24
      Top = 96
      Width = 26
      Height = 13
      Caption = #1062#1077#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l3: TLabel
      Left = 24
      Top = 144
      Width = 63
      Height = 13
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l4: TLabel
      Left = 24
      Top = 192
      Width = 57
      Height = 13
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l5: TLabel
      Left = 24
      Top = 240
      Width = 120
      Height = 13
      Caption = #1050#1086#1083#1083#1080#1095#1077#1090#1089#1074#1086' '#1085#1072' '#1089#1082#1083#1072#1076#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l6: TLabel
      Left = 680
      Top = 48
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
    object eName: TEdit
      Left = 24
      Top = 64
      Width = 297
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object ePrice: TEdit
      Left = 24
      Top = 112
      Width = 297
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object eInf: TEdit
      Left = 24
      Top = 160
      Width = 297
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object eProv: TEdit
      Left = 24
      Top = 208
      Width = 297
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object eCount: TEdit
      Left = 24
      Top = 256
      Width = 297
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  inherited pnFilter: TPanel
    Width = 719
  end
  object dOpen: TOpenDialog
    Filter = 'bmp only|*.bmp'
    Left = 8
    Top = 8
  end
end
