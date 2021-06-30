unit DMunit;

interface

uses
  SysUtils, Classes, DB, ADODB, frxClass, frxDBSet;

type
  Tdm = class(TDataModule)
    MainConnection: TADOConnection;
    ReportOrderQuery: TADOQuery;
    ReportOrderItemQuery: TADOQuery;
    frxReport: TfrxReport;
    OrderDBds: TfrxDBDataset;
    OrderItemDBds: TfrxDBDataset;
    ReportOrderQueryid: TAutoIncField;
    ReportOrderQueryorder_date: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure ReportOrderQueryAfterScroll(DataSet: TDataSet);
  private
    Fuser_id: integer;
    Fcustomer_id: integer;
  public
    property user_id: integer read Fuser_id write Fuser_id;
    property customer_id: integer read Fcustomer_id write Fcustomer_id;
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  MainConnection.Close;
  MainConnection.ConnectionString :=
     'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=db\EShop.mdb;Persist Security Info=False';
  MainConnection.Connected := true;
end;

procedure Tdm.ReportOrderQueryAfterScroll(DataSet: TDataSet);
begin
  ReportOrderItemQuery.Close;
  ReportOrderItemQuery.Parameters.ParamByName('order_id').Value:= ReportOrderQueryid.AsInteger;
  ReportOrderItemQuery.Open;
end;

end.
