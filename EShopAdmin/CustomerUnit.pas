unit CustomerUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomUnit, StdCtrls, ExtCtrls, ClassesUnit, Buttons;

type
  TCustomerForm = class(TCustomItemForm)
    lRedactor: TLabel;
    eLogin: TEdit;
    ePwd: TEdit;
    eFio: TEdit;
    eDate: TEdit;
    eEmail: TEdit;
    eCountry: TEdit;
    eCity: TEdit;
    ePhone: TEdit;
    eAdress: TEdit;
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    l8: TLabel;
    l7: TLabel;
    l9: TLabel;
    rgSex: TRadioGroup;
    bbBalance: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
    procedure bbCloseClick(Sender: TObject);
    procedure bbBalanceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses GridUnit, DMunit;

{$R *.dfm}

procedure TCustomerForm.FormCreate(Sender: TObject);
begin
  Height := 492;
  Width := 729;
end;

procedure TCustomerForm.bbOkClick(Sender: TObject);
begin
  TCustomer(ObjectItem).pwd := ePwd.Text;
  TCustomer(ObjectItem).fio := eFio.Text;
  TCustomer(ObjectItem).email := eEmail.Text;
  TCustomer(ObjectItem).date_birth := StrToDate(eDate.Text);
  TCustomer(ObjectItem).sex := Boolean(rgSex.ItemIndex);
  TCustomer(ObjectItem).country := eCountry.Text;
  TCustomer(ObjectItem).city := eCity.Text;
  TCustomer(ObjectItem).adress := eAdress.Text;
  TCustomer(ObjectItem).telephone := ePhone.Text;
  ObjectItem.InsUpdDel;
  ObjList.Refresh;
  parent.SetDataSet;
  Close;
end;

procedure TCustomerForm.bbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCustomerForm.bbBalanceClick(Sender: TObject);
var
  ABalances: TBalances;
  ABalanceItem: TBalance;
begin
  with TGridForm.Create(Self.Owner) do
  begin
    ABalances := TBalances.Create(dm.MainConnection, TCustomer(ObjectItem).id);
    ABalanceItem := TBalance.Create(dm.MainConnection, 0);
    Obj := ABalances;
    ObjItem := ABalanceItem;
    SetDataSet;
    bbAddBalance.Visible := True;
    Show;
  end;
end;

{ var
  ABaskets: TBaskets;
  ABasketItem: TBasket;
begin
  With TBasketForm.Create(Self) do
  begin
    if dm.Tag = 1 then
    begin
      bbAddProduct.Visible := False;
      //bbDelete.Visible := False;
      pnFilter.Visible := False;
      //pnAction.Visible := False;
    end;
    ABaskets := TBaskets.Create(dm.MainConnection, dm.customer_id);
    ABasketItem := TBasket.Create(dm.MainConnection, dm.customer_id);
    Obj := ABaskets;
    ObjItem := ABasketItem;
    SetDataSet;
    Show;
  end;  }

end.
