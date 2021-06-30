inherited GridForm: TGridForm
  Width = 1280
  Height = 509
  Caption = 'GridForm'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnAction: TPanel
    Top = 415
    Width = 1264
    Caption = ''
    object Label1: TLabel
      Left = 864
      Top = 24
      Width = 147
      Height = 13
      Caption = #1044#1083#1103' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1085#1072#1078#1084#1080#1090#1077' F5'
    end
    object bbDelete: TBitBtn
      Left = 24
      Top = 11
      Width = 185
      Height = 33
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Default = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clHighlight
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnClick = bbDeleteClick
    end
    object bbAddBalance: TBitBtn
      Left = 1038
      Top = 10
      Width = 217
      Height = 33
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1073#1072#1083#1072#1085#1089
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
      Visible = False
      OnClick = bbAddBalanceClick
    end
  end
  inherited pnData: TPanel
    Width = 1264
    Height = 374
    object MainGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 1262
      Height = 372
      Align = alClient
      DataSource = DataSource
      FixedColor = clMenu
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = MainGridCellClick
      OnDblClick = MainGridDblClick
    end
  end
  inherited pnFilter: TPanel
    Width = 1264
  end
  object DataSource: TDataSource
    Left = 1229
    Top = 5
  end
  object ActionList: TActionList
    Left = 248
    Top = 425
    object actRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
  end
end
