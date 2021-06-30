unit CustomUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentUnit, ExtCtrls, StdCtrls, ClassesUnit, Buttons, GridUnit;

type
  TCustomItemForm = class(TParentForm)
    bbOk: TBitBtn;
    bbClose: TBitBtn;
    procedure bbCloseClick(Sender: TObject);
  private
    FObjectItem: TCustomItem;
    FObjectList: TCustom;
  public
    parent: TGridForm;
    property ObjectItem: TCustomItem read FObjectItem write FObjectItem;
    property ObjList: TCustom read FObjectList write FObjectList;
  end;

implementation

{$R *.dfm}

procedure TCustomItemForm.bbCloseClick(Sender: TObject);
begin
  Close;
end;

end.
