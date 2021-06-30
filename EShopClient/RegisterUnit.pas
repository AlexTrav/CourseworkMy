unit RegisterUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ParentUnit, CustomUnit, ClassesUnit,
  DMunit, jpeg;

type
  TRegisterForm = class(TForm)
    pnAction: TPanel;
    bbOk: TBitBtn;
    bbClose: TBitBtn;
    pnData: TPanel;
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    l8: TLabel;
    l7: TLabel;
    l9: TLabel;
    eLogin: TEdit;
    ePwd: TEdit;
    eFio: TEdit;
    eDate: TEdit;
    eEmail: TEdit;
    eCountry: TEdit;
    eCity: TEdit;
    ePhone: TEdit;
    eAdress: TEdit;
    rgSex: TRadioGroup;
    iRegister: TImage;
    procedure FormCreate(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
    procedure bbCloseClick(Sender: TObject);
  private
    FObjectItem: TCustomItem;
  public
    property ObjectItem: TCustomItem read FObjectItem write FObjectItem;
  end;

implementation

{$R *.dfm}

procedure TRegisterForm.FormCreate(Sender: TObject);
begin
  Height := 471;
  Width := 747;
  FObjectItem := TCustomer.Create(dm.MainConnection, 0);
end;

procedure TRegisterForm.bbOkClick(Sender: TObject);
begin
  TCustomer(ObjectItem).login := eLogin.Text;
  TCustomer(ObjectItem).pwd := ePwd.Text;
  TCustomer(ObjectItem).fio := eFio.Text;
  TCustomer(ObjectItem).email := eEmail.Text;
  TCustomer(ObjectItem).date_birth := StrToDate(eDate.Text);
  TCustomer(ObjectItem).sex := Boolean(rgSex.ItemIndex);
  TCustomer(ObjectItem).country := eCountry.Text;
  TCustomer(ObjectItem).city := eCity.Text;
  TCustomer(ObjectItem).adress := eAdress.Text;
  TCustomer(ObjectItem).telephone := ePhone.Text;
  if not TCustomer(ObjectItem).CheckUniqLogin then
    ShowMessage('���� ����� ��� �����')
  else
  ObjectItem.InsUpdDel;
  Close;
end;

procedure TRegisterForm.bbCloseClick(Sender: TObject);
begin
  Close;
end;

end.
