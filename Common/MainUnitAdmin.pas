unit MainUnitAdmin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ClassesUnit, StdCtrls, DMunit, DB, ADODB, Grids, DBGrids, Menus,
  ExtCtrls, jpeg;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    miView: TMenuItem;
    miHelp: TMenuItem;
    miFile: TMenuItem;
    miClose: TMenuItem;
    miUsers: TMenuItem;
    miCustomers: TMenuItem;
    miCascade: TMenuItem;
    miHorizont: TMenuItem;
    miVertical: TMenuItem;
    miPrevious: TMenuItem;
    miNext: TMenuItem;
    miProducts: TMenuItem;
    iMain: TImage;
    miAboutTheProgram: TMenuItem;
    miRegisterUser: TMenuItem;
    miBasket: TMenuItem;
    miMybalance: TMenuItem;
    miReport: TMenuItem;
    procedure miCascadeClick(Sender: TObject);
    procedure miHorizontClick(Sender: TObject);
    procedure miVerticalClick(Sender: TObject);
    procedure miPreviousClick(Sender: TObject);
    procedure miNextClick(Sender: TObject);
    procedure miUsersClick(Sender: TObject);
    procedure miCustomersClick(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure miProductsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miAboutTheProgramClick(Sender: TObject);
    procedure miRegisterUserClick(Sender: TObject);
    procedure miBasketClick(Sender: TObject);
    procedure miMybalanceClick(Sender: TObject);
    procedure miReportClick(Sender: TObject);
  private
    { Private declarations }
  public
    MyUser: TUser;
    MyUsers: TUsers;
    MyCustomer: TCustomer;
    MyCustomers: TCustomers;
    MyProduct: TProduct;
    MyProducts: TProducts;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses GridUnit, LoginUnit, AboutTheProgramUnit, UserUnit, ProductListUnit, BasketUnit,
  ParentUnit, BalanceItemUnit;

procedure TMainForm.miCascadeClick(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.miHorizontClick(Sender: TObject);
begin
  Tilemode := tbHorizontal;
  Tile;
end;

procedure TMainForm.miVerticalClick(Sender: TObject);
begin
  Tilemode := tbVertical;
  Tile;
end;

procedure TMainForm.miPreviousClick(Sender: TObject);
begin
  Previous;
end;

procedure TMainForm.miNextClick(Sender: TObject);
begin
  Next;
end;

procedure TMainForm.miUsersClick(Sender: TObject);
var
  GridForm: TGridForm;
  AUsers: TUsers;
  AUserItem: TUser;
begin
  GridForm := TGridForm.Create(Self);
  GridForm.Caption := 'Сотрудники';
  AUsers := TUsers.Create(dm.MainConnection);
  AUserItem := TUser.Create(dm.MainConnection, 0);
  GridForm.Obj := AUsers;
  GridForm.ObjItem := AUserItem;
  GridForm.SetDataSet;
end;

procedure TMainForm.miCustomersClick(Sender: TObject);
var
  GridForm: TGridForm;
  ACustomers: TCustomers;
  ACustomerItem: TCustomer;
begin
  GridForm := TGridForm.Create(Self);
  GridForm.Caption := 'Покупатели';
  ACustomers := TCustomers.Create(dm.MainConnection);
  ACustomerItem := TCustomer.Create(dm.MainConnection, 0);
  GridForm.Obj := ACustomers;
  GridForm.ObjItem := ACustomerItem;
  GridForm.SetDataSet;
end;

procedure TMainForm.miCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.miProductsClick(Sender: TObject);
var
  AProducts: TProducts;
  AProductItem: TProduct;
begin
  With TProductListForm.Create(Self) do
  begin
    if dm.Tag = 1 then
    begin
      bbDelete.visible := False;
      pnFilter.visible := False;
      pnAction.visible := False;
    end;
    Caption := 'Список продуктов';
    AProducts := TProducts.Create(dm.MainConnection);
    AProductItem := TProduct.Create(dm.MainConnection, 0);
    Obj := AProducts;
    ObjItem := AProductItem;
    SetDataSet;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  LoginForm := TLoginForm.Create(Self);
  if dm.Tag = 0 then
  begin
    LoginForm.ObjItem := TUser.Create(dm.MainConnection, 0);
    LoginForm.bbRegister.Enabled := False;
    miRegisterUser.Visible := True;
    miBasket.Enabled := False;
    LoginForm.bbGuest.Enabled := False;
    miMybalance.Enabled := False;
    miReport.Enabled := False;
  end
  else
    LoginForm.ObjItem := TCustomer.Create(dm.MainConnection, 0);

  if LoginForm.ShowModal <> mrOk then Application.Terminate

  else if LoginForm.tag = 1 then
  begin
    miMybalance.Enabled := false;
    miBasket.Enabled := false;
    miReport.Enabled := false;
  end;
end;

procedure TMainForm.miAboutTheProgramClick(Sender: TObject);
begin
  with TAboutTheProgramForm.create(Self) do
  begin
    Show;
  end;
end;

procedure TMainForm.miRegisterUserClick(Sender: TObject);
var
  AUser: TUser;
begin
  with TUserForm.Create(Self) do
  begin
    AUser := TUser.Create(dm.MainConnection, 0);
    lRedactor.Caption := 'Регистрация';
    Caption := 'Сотрудники';
    ObjectItem := AUser;
    Show;
  end;
end;

procedure TMainForm.miBasketClick(Sender: TObject);
var
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
    ABasketItem := TBasket.Create(dm.MainConnection, 0);
    Obj := ABaskets;
    ObjItem := ABasketItem;
    SetDataSet;
    Show;
  end;
end;

procedure TMainForm.miMybalanceClick(Sender: TObject);
var
  ACustomer: TCustomer;
begin
  ACustomer := TCustomer.Create(dm.MainConnection, dm.customer_id);
  ShowMessage(IntToStr(ACustomer.GetBalance));
end;

procedure TMainForm.miReportClick(Sender: TObject);
begin
  if dm.customer_id > 0 then
  begin
    dm.ReportOrderQuery.Close;
    dm.ReportOrderQuery.Parameters.ParamByName('customer_id').Value := dm.customer_id;
    dm.ReportOrderQuery.Open;
    dm.frxReport.ShowReport;

    dm.ReportOrderItemQuery.Close;
    dm.ReportOrderQuery.Close;
  end;
end;

end.
