unit BalanceItemUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomUnit, StdCtrls, Buttons, ExtCtrls, ClassesUnit;

type
  TBalanceItemForm = class(TCustomItemForm)
    lRedactor: TLabel;
    l1: TLabel;
    eOp_sum: TEdit;
    procedure bbOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.dfm}

procedure TBalanceItemForm.bbOkClick(Sender: TObject);
begin
  TBalance(ObjectItem).op_sum := StrToInt(eOp_sum.text);
  TBalance(ObjectItem).operation_id := 1;
  ObjectItem.InsUpdDel;
  ObjList.Refresh;
  Close;
end;

procedure TBalanceItemForm.FormCreate(Sender: TObject);
begin
  Height := 266;
  Width := 571;
end;

end.
