inherited BalanceItemForm: TBalanceItemForm
  Width = 571
  Height = 266
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1073#1072#1083#1072#1085#1089#1072
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnAction: TPanel
    Top = 172
    Width = 555
    inherited bbOk: TBitBtn
      OnClick = bbOkClick
    end
  end
  inherited pnData: TPanel
    Width = 555
    Height = 131
    object lRedactor: TLabel
      Left = 116
      Top = 16
      Width = 308
      Height = 33
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1073#1072#1083#1072#1085#1089#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l1: TLabel
      Left = 24
      Top = 64
      Width = 82
      Height = 13
      Caption = #1057#1091#1084#1084#1072' '#1086#1087#1077#1088#1072#1094#1080#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object eOp_sum: TEdit
      Left = 24
      Top = 80
      Width = 97
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  inherited pnFilter: TPanel
    Width = 555
  end
end
