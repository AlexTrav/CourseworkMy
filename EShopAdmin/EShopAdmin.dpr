program EShopAdmin;

uses
  Forms,
  DMunit in '..\Common\DMunit.pas' {dm: TDataModule},
  ClassesUnit in '..\Common\ClassesUnit.pas',
  MainUnitAdmin in '..\Common\MainUnitAdmin.pas' {MainForm},
  ParentUnit in '..\Common\ParentUnit.pas' {ParentForm},
  GridUnit in '..\Common\GridUnit.pas' {GridForm},
  CustomUnit in '..\Common\CustomUnit.pas' {CustomItemForm},
  UserUnit in 'UserUnit.pas' {UserForm},
  CustomerUnit in 'CustomerUnit.pas' {CustomerForm},
  ProductUnit in 'ProductUnit.pas' {ProductForm},
  LoginUnit in '..\Common\LoginUnit.pas' {LoginForm},
  ProductListUnit in '..\Common\ProductListUnit.pas' {ProductListForm},
  BalanceItemUnit in 'BalanceItemUnit.pas' {BalanceItemForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  dm.Tag := 0;
  Application.CreateForm(TMainForm, MainForm);
  MainForm.miUsers.Visible := True;
  MainForm.miCustomers.Visible := True;
  Application.Run;
end.
