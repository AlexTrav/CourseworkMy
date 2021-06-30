inherited CustomItemForm: TCustomItemForm
  Left = 866
  Top = 201
  Width = 553
  Height = 413
  Caption = 'CustomItemForm'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnAction: TPanel
    Top = 319
    Width = 537
    Caption = ''
    object bbOk: TBitBtn
      Left = 8
      Top = 14
      Width = 89
      Height = 27
      Caption = #1054#1082
      Default = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clHighlight
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
    end
    object bbClose: TBitBtn
      Left = 424
      Top = 14
      Width = 105
      Height = 27
      Caption = #1054#1090#1084#1077#1085#1072
      Default = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clHighlight
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = bbCloseClick
    end
  end
  inherited pnData: TPanel
    Width = 537
    Height = 278
    Caption = ''
  end
  inherited pnFilter: TPanel
    Width = 537
    Visible = False
  end
end
