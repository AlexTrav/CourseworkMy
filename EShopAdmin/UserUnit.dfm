inherited UserForm: TUserForm
  Width = 619
  Height = 501
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnAction: TPanel
    Top = 407
    Width = 603
    inherited bbOk: TBitBtn
      OnClick = bbOkClick
    end
    inherited bbClose: TBitBtn
      Left = 480
    end
  end
  inherited pnData: TPanel
    Width = 603
    Height = 366
    object lRedactor: TLabel
      Left = 120
      Top = 0
      Width = 364
      Height = 33
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l1: TLabel
      Left = 24
      Top = 56
      Width = 30
      Height = 13
      Caption = #1051#1086#1075#1080#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l2: TLabel
      Left = 24
      Top = 104
      Width = 37
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l3: TLabel
      Left = 24
      Top = 152
      Width = 23
      Height = 13
      Caption = #1060#1048#1054
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l4: TLabel
      Left = 24
      Top = 200
      Width = 80
      Height = 13
      Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object l5: TLabel
      Left = 24
      Top = 248
      Width = 100
      Height = 13
      Caption = #1069#1083#1077#1082#1090#1088#1086#1085#1085#1072#1103' '#1087#1086#1095#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object eLogin: TEdit
      Left = 24
      Top = 72
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
    object ePwd: TEdit
      Left = 24
      Top = 120
      Width = 297
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
    end
    object eFio: TEdit
      Left = 24
      Top = 168
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
    object eDate: TEdit
      Left = 24
      Top = 216
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
    object eEmail: TEdit
      Left = 24
      Top = 264
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
    object rgSex: TRadioGroup
      Left = 26
      Top = 304
      Width = 297
      Height = 41
      Caption = #1055#1086#1083
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        #1046#1077#1085#1089#1082#1080#1081
        #1052#1091#1078#1089#1082#1086#1081)
      TabOrder = 5
    end
  end
  inherited pnFilter: TPanel
    Width = 603
  end
end
