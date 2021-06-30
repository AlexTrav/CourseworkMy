unit ProductUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomUnit, StdCtrls, ExtCtrls, ClassesUnit, Buttons;

type
  TProductForm = class(TCustomItemForm)
    iProduct: TImage;
    lRedactor: TLabel;
    l1: TLabel;
    eName: TEdit;
    l2: TLabel;
    ePrice: TEdit;
    l3: TLabel;
    eInf: TEdit;
    l4: TLabel;
    eProv: TEdit;
    l5: TLabel;
    eCount: TEdit;
    l6: TLabel;
    bbLoadPhoto: TBitBtn;
    dOpen: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
    procedure bbCloseClick(Sender: TObject);
    procedure bbLoadPhotoClick(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

procedure TProductForm.FormCreate(Sender: TObject);
begin
  Height := 431;
  Width := 735;
end;

procedure TProductForm.bbOkClick(Sender: TObject);
begin
  TProduct(ObjectItem).name := eName.Text;
  TProduct(ObjectItem).price := StrToInt(ePrice.Text);
  TProduct(ObjectItem).information := eInf.Text;
  TProduct(ObjectItem).provider := eProv.Text;
  TProduct(ObjectItem).count := StrToInt(eCount.Text);
  ObjectItem.InsUpdDel;
  ObjList.Refresh;
  parent.SetDataSet;
  Close;
end;

procedure TProductForm.bbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TProductForm.bbLoadPhotoClick(Sender: TObject);
var
  fn, dir, src, dest: String;
begin
  dir := ExtractFilePath(Application.ExeName)+'images\';
  if dOpen.Execute then
  begin
    src := dOpen.FileName;
    fn := ExtractFileName(src);
    dest := dir+fn;
    CopyFile(PAnsiChar(src),PAnsiChar(dest), false);
    iProduct.Picture.LoadFromFile(dest);
    TProduct(ObjectItem).photo := fn;
  end;
end;
end.
