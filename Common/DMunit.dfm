object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 533
  Top = 227
  Height = 285
  Width = 487
  object MainConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=..\exe\db\EShop.mdb' +
      ';Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 48
    Top = 16
  end
  object ReportOrderQuery: TADOQuery
    Connection = MainConnection
    CursorType = ctStatic
    AfterScroll = ReportOrderQueryAfterScroll
    Parameters = <
      item
        Name = 'customer_id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'select id, order_date'
      'from Orders'
      'where customer_id = :customer_id'
      '  and is_deleted = 0'
      'order by order_date desc')
    Left = 136
    Top = 16
    object ReportOrderQueryid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object ReportOrderQueryorder_date: TDateTimeField
      FieldName = 'order_date'
    end
  end
  object ReportOrderItemQuery: TADOQuery
    Connection = MainConnection
    Parameters = <
      item
        Name = 'order_id'
        Attributes = [paNullable]
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select p.[name], p.price, oi.[count]'
      'from OrdersItems oi'
      '  inner join Products p on p.id = oi.product_id'
      'where oi.order_id = :order_id'
      '  and oi.is_deleted = 0'
      '')
    Left = 136
    Top = 72
  end
  object frxReport: TfrxReport
    Version = '4.1.38'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44315.914621944400000000
    ReportOptions.LastChange = 44323.034414351850000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 48
    Top = 72
    Datasets = <
      item
        DataSet = OrderDBds
        DataSetName = 'OrderDBds'
      end
      item
        DataSet = OrderItemDBds
        DataSetName = 'OrderfrxDBDataset'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 97.677180000000010000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 10.000000000000000000
          Top = 4.464437990000001000
          Width = 190.983457500000000000
          Height = 63.535562010000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = '@Arial Unicode MS'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1115#1057#8218#1057#8225#1057#8216#1057#8218' '#1056#1109#1057#8218' ')
          ParentFont = False
        end
        object SysMemo1: TfrxSysMemoView
          Left = 104.702875500000000000
          Top = 4.102350000000001000
          Width = 288.785374500000000000
          Height = 63.535562010000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = '@Arial Unicode MS'
          Font.Style = []
          Memo.UTF8 = (
            '[DATE]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 32.677180000000000000
        Top = 249.448980000000000000
        Width = 718.110700000000000000
        DataSet = OrderDBds
        DataSetName = 'OrderDBds'
        RowCount = 0
        object OrderDBdsorder_date: TfrxMemoView
          Left = 75.000000000000000000
          Top = 5.952689999999990000
          Width = 158.740260000000000000
          Height = 23.897650000000000000
          DataField = 'order_date'
          DataSet = OrderDBds
          DataSetName = 'OrderDBds'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = '@Arial Unicode MS'
          Font.Style = []
          Memo.UTF8 = (
            '[OrderDBds."order_date"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 4.000000000000000000
          Top = 4.362089999999995000
          Width = 94.488250000000000000
          Height = 21.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = '@Arial Unicode MS'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8212#1056#176#1056#1108#1056#176#1056#183' '#1056#1109#1057#8218)
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        Height = 43.495980000000000000
        Top = 306.141930000000000000
        Width = 718.110700000000000000
        DataSet = OrderItemDBds
        DataSetName = 'OrderfrxDBDataset'
        RowCount = 0
        object OrderfrxDBDatasetname: TfrxMemoView
          Left = 4.000000000000000000
          Top = 1.598329999999976000
          Width = 238.110390000000000000
          Height = 27.897650000000000000
          DataField = 'name'
          DataSet = OrderItemDBds
          DataSetName = 'OrderfrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = '@Arial Unicode MS'
          Font.Style = []
          Memo.UTF8 = (
            '[OrderfrxDBDataset."name"]')
          ParentFont = False
        end
        object OrderfrxDBDatasetprice: TfrxMemoView
          Left = 250.000000000000000000
          Top = 1.598329999999976000
          Width = 107.370130000000000000
          Height = 38.897650000000000000
          DataField = 'price'
          DataSet = OrderItemDBds
          DataSetName = 'OrderfrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = '@Arial Unicode MS'
          Font.Style = []
          Memo.UTF8 = (
            '[OrderfrxDBDataset."price"]')
          ParentFont = False
        end
        object OrderfrxDBDatasetcount: TfrxMemoView
          Left = 416.000000000000000000
          Top = 1.598329999999976000
          Width = 111.370130000000000000
          Height = 41.897650000000000000
          DataField = 'count'
          DataSet = OrderItemDBds
          DataSetName = 'OrderfrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = '@Arial Unicode MS'
          Font.Style = []
          Memo.UTF8 = (
            '[OrderfrxDBDataset."count"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        Height = 49.677180000000000000
        Top = 177.637910000000000000
        Width = 718.110700000000000000
        object Memo3: TfrxMemoView
          Left = 4.000000000000000000
          Top = 13.362090000000000000
          Width = 137.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = '@Arial Unicode MS'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#183#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#1111#1057#1026#1056#1109#1056#1169#1057#1107#1056#1108#1057#8218#1056#176)
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 250.000000000000000000
          Top = 10.362090000000000000
          Width = 125.488250000000000000
          Height = 23.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = '@Arial Unicode MS'
          Font.Style = []
          Memo.UTF8 = (
            #1056#166#1056#181#1056#1029#1056#176' '#1056#1111#1057#1026#1056#1109#1056#1169#1057#1107#1056#1108#1057#8218#1056#176)
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 416.000000000000000000
          Top = 10.362090000000000000
          Width = 122.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = '@Arial Unicode MS'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1113#1056#1109#1056#187#1056#187#1056#1105#1057#8225#1056#181#1057#8218#1057#1027#1056#1030#1056#1109)
          ParentFont = False
        end
      end
    end
  end
  object OrderDBds: TfrxDBDataset
    UserName = 'OrderDBds'
    CloseDataSource = False
    DataSet = ReportOrderQuery
    Left = 280
    Top = 16
  end
  object OrderItemDBds: TfrxDBDataset
    UserName = 'OrderfrxDBDataset'
    CloseDataSource = False
    DataSet = ReportOrderItemQuery
    Left = 280
    Top = 72
  end
end
