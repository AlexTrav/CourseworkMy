unit GridUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentUnit, Grids, DBGrids, ExtCtrls, DB, ClassesUnit, StdCtrls,
  DMunit, Buttons, ActnList;

type
  TGridForm = class(TParentForm)
    MainGrid: TDBGrid;
    DataSource: TDataSource;
    bbDelete: TBitBtn;
    bbAddBalance: TBitBtn;
    ActionList: TActionList;
    actRefresh: TAction;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MainGridCellClick(Column: TColumn);
    procedure MainGridDblClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbAddBalanceClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
  private
    FObject: TCustom;
    FObjectItem: TCustomItem;
  public
    procedure SetDataSet;
    property Obj: TCustom read FObject write FObject;
    property ObjItem: TCustomItem read FObjectItem write FObjectItem;
  end;

implementation

{$R *.dfm}

uses UserUnit, CustomerUnit, ProductUnit, CustomUnit, ProductListUnit, BalanceItemUnit,
  StrUtils;

procedure TGridForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FObject) then FObject.Free;
  if Assigned(FObjectItem) then FObjectItem.Free;

  inherited;
end;

procedure TGridForm.SetDataSet;
var
  i, fc: integer;
  fn: string;
  f: TField;
begin
  DataSource.DataSet := FObject.DataSet;
  fc := DataSource.DataSet.FieldCount;
  for i := 0 to fc-1 do
  begin
    f := DataSource.DataSet.Fields[i];
    fn := f.FieldName;
    if (LowerCase(RightStr(fn, 2)) = 'id') or (fn = 'is_deleted')
      or (fn = 'pwd') or (fn = 'photo') then
      f.Visible := false;
  end;
end;

procedure TGridForm.MainGridCellClick(Column: TColumn);
var
  cl: string;
begin
  cl := FObjectItem.ClassName;
  if cl = 'TUser' then
  begin
    TUser(FObjectItem).id := 0;
    TUser(FObjectItem).login := DataSource.DataSet.Fields[1].AsString;
    TUser(FObjectItem).id := DataSource.DataSet.Fields[0].AsInteger;
    TUser(FObjectItem).pwd := DataSource.DataSet.Fields[2].AsString;
    TUser(FObjectItem).is_deleted := DataSource.DataSet.Fields[3].AsBoolean;
    TUser(FObjectItem).fio := DataSource.DataSet.Fields[4].AsString;
    TUser(FObjectItem).email := DataSource.DataSet.Fields[5].AsString;
    TUser(FObjectItem).sex := DataSource.DataSet.Fields[6].AsBoolean;
    TUser(FObjectItem).date_birth := DataSource.DataSet.Fields[7].AsDateTime;
  end else
  if cl = 'TCustomer' then
  begin
    TCustomer(FObjectItem).id := 0;
    TCustomer(FObjectItem).login := DataSource.DataSet.Fields[1].AsString;
    TCustomer(FObjectItem).id := DataSource.DataSet.Fields[0].AsInteger;
    TCustomer(FObjectItem).pwd := DataSource.DataSet.Fields[2].AsString;
    TCustomer(FObjectItem).is_deleted := DataSource.DataSet.Fields[3].AsBoolean;
    TCustomer(FObjectItem).fio := DataSource.DataSet.Fields[4].AsString;
    TCustomer(FObjectItem).email := DataSource.DataSet.Fields[5].AsString;
    TCustomer(FObjectItem).sex := DataSource.DataSet.Fields[6].AsBoolean;
    TCustomer(FObjectItem).date_birth := DataSource.DataSet.Fields[7].AsDateTime;
    TCustomer(FObjectItem).country := DataSource.DataSet.Fields[8].AsString;
    TCustomer(FObjectItem).city := DataSource.DataSet.Fields[9].AsString;
    TCustomer(FObjectItem).adress := DataSource.DataSet.Fields[10].AsString;
    TCustomer(FObjectItem).telephone := DataSource.DataSet.Fields[11].AsString;
  end else
  if cl = 'TProduct' then
  begin
    TProduct(FObjectItem).id := DataSource.DataSet.Fields[0].AsInteger;
    TProduct(FObjectItem).name := DataSource.DataSet.Fields[1].AsString;
    TProduct(FObjectItem).price := DataSource.DataSet.Fields[2].AsInteger;
    TProduct(FObjectItem).photo := DataSource.DataSet.Fields[3].AsString;
    TProduct(FObjectItem).information := DataSource.DataSet.Fields[4].AsString;
    TProduct(FObjectItem).provider := DataSource.DataSet.Fields[5].AsString;
    TProduct(FObjectItem).is_deleted := DataSource.DataSet.Fields[6].AsBoolean;
    TProduct(FObjectItem).count := DataSource.DataSet.Fields[7].AsInteger;
  end else
  if cl = 'TBasket' then
  begin
    TBasket(FObjectItem).id := DataSource.DataSet.Fields[0].AsInteger;
    TBasket(FObjectItem).customer_id := DataSource.DataSet.Fields[1].AsInteger;
    TBasket(FObjectItem).product_id := DataSource.DataSet.Fields[2].AsInteger;
    TBasket(FObjectItem).order_date := DataSource.DataSet.Fields[3].AsDateTime;
    TBasket(FObjectItem).is_deleted := DataSource.DataSet.Fields[4].AsBoolean;
  end else
  if cl = 'TBalance' then
  begin
    TBalance(FObjectItem).id := DataSource.DataSet.Fields[0].AsInteger;
    TBalance(FObjectItem).customer_id := DataSource.DataSet.Fields[1].AsInteger;
    TBalance(FObjectItem).op_sum := DataSource.DataSet.Fields[2].AsInteger;
    TBalance(FObjectItem).operation_id := DataSource.DataSet.Fields[3].AsInteger;
    TBalance(FObjectItem).is_deleted := DataSource.DataSet.Fields[4].AsBoolean;
    TBalance(FObjectItem).op_date := DataSource.DataSet.Fields[5].AsDateTime;
  end else Exit;
end;

procedure TGridForm.MainGridDblClick(Sender: TObject);
var
  cl: string;
begin
  if dm.Tag = 0 then
  begin
    cl := FObjectItem.ClassName;
    if cl = 'TUser' then
    begin
      with TUserForm.Create(Self) do
      begin
        ObjectItem := TUser(FObjectItem);
        eLogin.Text := TUser(ObjectItem).login;
        ePwd.Text := TUser(ObjectItem).pwd;
        eFio.Text := TUser(ObjectItem).fio;
        eEmail.Text := TUser(ObjectItem).email;
        eDate.Text := DateToStr(TUser(ObjectItem).date_birth);
        rgSex.ItemIndex := Integer(TUser(ObjectItem).sex);
        eLogin.Enabled := False;
        ObjList := Obj;
        parent := self;
        Show;
      end;
    end else
    if cl = 'TCustomer' then
    begin
      with TCustomerForm.Create(Self) do
      begin
        ObjectItem := TCustomer(FObjectItem);
        eLogin.Text := TCustomer(ObjectItem).login;
        ePwd.Text := TCustomer(ObjectItem).pwd;
        eFio.Text := TCustomer(ObjectItem).fio;
        eEmail.Text := TCustomer(ObjectItem).email;
        eDate.Text := DateToStr(TCustomer(ObjectItem).date_birth);
        rgSex.ItemIndex := Integer(TCustomer(ObjectItem).sex);
        eCountry.Text := TCustomer(ObjectItem).country;
        eCity.Text := TCustomer(ObjectItem).city;
        eAdress.Text := TCustomer(ObjectItem).adress;
        ePhone.Text := TCustomer(ObjectItem).telephone;
        ObjList := Obj;
        parent := self;
        Show;
      end;
    end else
    if cl = 'TProduct' then
    begin
    end else
    if cl = 'TBasket' then
    begin
    end else
    if cl = 'TBalance' then
    begin
    end else

    {begin
      with TBasket.Create(dm.MainConnection, 0) do
      try
        customer_id := dm.customer_id;
        product_id := TProduct(ObjItem).id;
        InsUpdDel;
      finally
        Free;
      end
    end else}
    if 0 = 1 then
    begin

    end
    else Exit;
  end;
end;

procedure TGridForm.bbDeleteClick(Sender: TObject);
begin
  ObjItem.is_deleted := True;
  ObjItem.InsUpdDel;
  Obj.Refresh;
  SetDataSet;
end;

procedure TGridForm.bbAddBalanceClick(Sender: TObject);
var
  ABalanceItem: TBalance;
begin
  with TBalanceItemForm.Create(Self) do
  begin
    ABalanceItem := TBalance.Create(dm.MainConnection, 0);
    ABalanceItem.customer_id := TBalances(Obj).customer_id;
    ObjList := TCustomers(Obj);
    ObjectItem := ABalanceItem;
    Show;
  end;
end;

procedure TGridForm.actRefreshExecute(Sender: TObject);
begin
  if Assigned(MainGrid.DataSource.DataSet) then
  begin
    Obj.Refresh;
    if Assigned(MainGrid.OnCellClick) then
      MainGrid.OnCellClick(nil);
    SetDataSet;
  end;
end;

end.
