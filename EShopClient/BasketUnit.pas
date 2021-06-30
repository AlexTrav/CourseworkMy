unit BasketUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProductListUnit, DB, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons,
  DMunit, ActnList;

type
  TBasketForm = class(TProductListForm)
    bbPlace: TBitBtn;
    procedure MainGridDblClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbPlaceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ClassesUnit, GridUnit;

procedure TBasketForm.MainGridDblClick(Sender: TObject);
begin
  //
end;

procedure TBasketForm.bbDeleteClick(Sender: TObject);
begin
  inherited;

  //
end;

procedure TBasketForm.bbPlaceClick(Sender: TObject);
var
  ACustomer: TCustomer;
  ABalance: TBalance;
  AOrder: TOrder;
  Abal, Acost, Aorder_id: integer;
begin
  if DataSource.DataSet.RecordCount = 0 then Exit;

  Acost := TBaskets(Obj).GetCosts;
  ACustomer := TCustomer.Create(dm.MainConnection, dm.customer_id);
  try
    Abal := ACustomer.GetBalance;
  finally
    ACustomer.Free;
  end;
  if Abal < Acost then
  begin
    ShowMessage('Не хватает средств');
    Exit;
  end;
  ABalance := TBalance.Create(dm.MainConnection, 0);
  try
    ABalance.customer_id := dm.customer_id;
    ABalance.op_sum := -1*Acost;
    ABalance.operation_id := 2;
    ABalance.InsUpdDel;
  finally
    ABalance.Free;
  end;

  AOrder := TOrder.Create(dm.MainConnection, 0);
  try
    AOrder.customer_id := dm.customer_id;
    if AOrder.InsUpdDel then
    begin
      Aorder_id := AOrder.id;
      TBaskets(Obj).MakeOrders(Aorder_id);
    end;
  finally
    AOrder.Free;
  end;
  TBaskets(Obj).Refresh;
  ShowMessage('Ваш заказ принят, ожидайте курьера'#13#10'Итого: ' + IntToStr(Acost));
end;

end.
