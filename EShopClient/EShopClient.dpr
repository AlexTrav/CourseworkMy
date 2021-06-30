program EShopClient;

uses
  Forms,
  DMunit in '..\Common\DMunit.pas' {dm: TDataModule},
  MainUnitAdmin in '..\Common\MainUnitAdmin.pas' {MainForm},
  ClassesUnit in '..\Common\ClassesUnit.pas',
  LoginUnit in '..\Common\LoginUnit.pas' {LoginForm},
  RegisterUnit in 'RegisterUnit.pas' {RegisterForm},
  AboutTheProgramUnit in '..\Common\AboutTheProgramUnit.pas' {AboutTheProgramForm},
  ProductListUnit in '..\Common\ProductListUnit.pas' {ProductListForm},
  BasketUnit in 'BasketUnit.pas' {BasketForm},
  ParentUnit in '..\Common\ParentUnit.pas' {ParentForm},
  GridUnit in '..\Common\GridUnit.pas' {GridForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  dm.Tag := 1;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
