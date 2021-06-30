unit LoginUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ClassesUnit, DMunit;

type
  TLoginForm = class(TForm)
    eLogin: TEdit;
    bbEntrance: TBitBtn;
    lLogin: TLabel;
    ePwd: TEdit;
    lPwd: TLabel;
    iLogin: TImage;
    bbRegister: TBitBtn;
    bbGuest: TBitBtn;
    procedure bbEntranceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbRegisterClick(Sender: TObject);
    procedure bbGuestClick(Sender: TObject);
  private
    FObjectItem: TCustomItem;
  public
    property ObjItem: TCustomItem read FObjectItem write FObjectItem;
  end;

var
  LoginForm: TLoginForm;

implementation

uses CustomerUnit, CustomUnit, {RegisterCustomerUnit} RegisterUnit;


{$R *.dfm}

procedure TLoginForm.bbEntranceClick(Sender: TObject);
begin
  ModalResult := mrNone;
  if ObjItem.ClassNameIs('TUser') then
  begin
    dm.user_id := TUser(ObjItem).CheckLogin(eLogin.Text, ePwd.Text);
    if dm.user_id = 0 then
    begin
      ShowMessage('�������� ����� ��� ������');
      ModalResult := mrNone;
    end else
    begin
      ModalResult := mrOk;
    end
  end else
  if ObjItem.ClassNameIs('TCustomer') then
  begin
    dm.customer_id := TCustomer(ObjItem).CheckLogin(eLogin.Text, ePwd.Text);
    if dm.customer_id = 0 then
    begin
      ShowMessage('�������� ����� ��� ������');
      ModalResult := mrNone;//mrCancel;
    end else
    begin
      ModalResult := mrOk;
    end
  end;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  bbRegister.Caption:='�'#10#13'�'#10#13'�'#10#13'�'#10#13'�'#10#13'�'#10#13'�'#10#13'�'#10#13'�'#10#13'�'#10#13'�';
end;

procedure TLoginForm.bbRegisterClick(Sender: TObject);
var
  ACustomer: TCustomer;
begin
  With TRegisterForm.Create(Self) do
  begin
    ACustomer := TCustomer.Create(dm.MainConnection, 0);
    ObjectItem := ACustomer;
    Show;
  end;
end;

procedure TLoginForm.bbGuestClick(Sender: TObject);
begin
  LoginForm.Tag := 1;
  ModalResult := mrOk;
end;

end.

