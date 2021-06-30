unit UserUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomUnit, StdCtrls, ExtCtrls, Buttons, ClassesUnit;

type
  TUserForm = class(TCustomItemForm)
    lRedactor: TLabel;
    l1: TLabel;
    eLogin: TEdit;
    l2: TLabel;
    ePwd: TEdit;
    l3: TLabel;
    eFio: TEdit;
    l4: TLabel;
    eDate: TEdit;
    l5: TLabel;
    eEmail: TEdit;
    rgSex: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
    procedure bbCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TUserForm.FormCreate(Sender: TObject);
begin
  Height := 452;
  Width := 611;
end;

procedure TUserForm.bbOkClick(Sender: TObject);
begin
  TUser(ObjectItem).login := eLogin.Text;
  TUser(ObjectItem).pwd := ePwd.Text;
  TUser(ObjectItem).fio := eFio.Text;
  TUser(ObjectItem).email := eEmail.Text;
  TUser(ObjectItem).date_birth := StrToDate(eDate.Text);
  TUser(ObjectItem).sex := Boolean(rgSex.ItemIndex);
  if not TUser(ObjectItem).CheckUniqLogin then
    ShowMessage('Этот логин уже занят')
  else
    ObjectItem.InsUpdDel;
  if Assigned(ObjList) then
  begin
    ObjList.Refresh;
    parent.SetDataSet;
  end;
  Close;
end;

procedure TUserForm.bbCloseClick(Sender: TObject);
begin
  Close;
end;

end.
