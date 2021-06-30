unit ProductListUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridUnit, DB, Grids, DBGrids, StdCtrls, ExtCtrls, Buttons,
  ActnList;

type
  TProductListForm = class(TGridForm)
    pnPhoto: TPanel;
    iPhotoProduct: TImage;
    l6: TLabel;
    bbAddProduct: TBitBtn;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure MainGridCellClick(Column: TColumn);
    procedure bbAddProductClick(Sender: TObject);
    procedure MainGridDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses DMunit, ClassesUnit, ProductUnit, LoginUnit;

{$R *.dfm}

procedure TProductListForm.FormCreate(Sender: TObject);
begin
  Height := 516;
  Width := 1563;
end;

procedure TProductListForm.MainGridCellClick(Column: TColumn);
var
  dir, fn: string;
begin
  inherited;

  dir := ExtractFilePath(Application.ExeName)+'images\';
  fn := '';
  if DataSource.DataSet.RecordCount > 0 then
  begin
    if ObjItem.ClassNameIs('TProduct') then
      fn := TProduct(ObjItem).photo
    else if ObjItem.ClassNameIs('TBasket') then
    with TProduct.Create(dm.MainConnection, TBasket(ObjItem).product_id) do
    begin
      fn := photo;
      Free;
    end;
    if fn <> '' then
      fn := dir + fn;
    if FileExists(fn) then
      iPhotoProduct.Picture.LoadFromFile(fn);
  end;
end;

procedure TProductListForm.bbAddProductClick(Sender: TObject);
var
  AProduct: TProduct;
begin
  with TProductForm.Create(Self) do
  begin
    AProduct := TProduct.Create(dm.MainConnection, 0);
    lRedactor.Caption := 'Добавление';
    Caption := 'Продукты';
    ObjectItem := AProduct;
    ObjList := Obj;
    Show;
  end;
end;

procedure TProductListForm.MainGridDblClick(Sender: TObject);
var
  fn: string;
  bs: Integer; {bs: ButtonSelected}
begin
  inherited;

  if dm.Tag = 0 then
  begin
    with TProductForm.Create(Self) do
    begin
      ObjectItem := TProduct(ObjItem);
      eName.Text := TProduct(ObjectItem).name;
      ePrice.Text := IntToStr(TProduct(ObjectItem).price);
      eInf.Text := TProduct(ObjectItem).information;
      eProv.Text := TProduct(ObjectItem).provider;
      eCount.Text := IntToStr(TProduct(ObjectItem).count);

      fn := ExtractFilePath(Application.ExeName)+'images\'+TProduct(ObjectItem).photo;
      iProduct.Picture.LoadFromFile(fn);

      ObjList := Obj;
      parent := self;
      Show;
    end;
  end else
  begin
  if LoginForm.tag = 0 then
  begin
    if DataSource.DataSet.RecordCount > 0 then
    begin
      bs := MessageDlg('Добавить в корзину', mtConfirmation , [mbYes, mbNo], 0);
      if bs = mrYes then
      begin
        with TBasket.Create(dm.MainConnection, 0) do
        try
          customer_id := dm.customer_id;
          product_id := TProduct(ObjItem).id;
          count := 1;
          InsUpdDel;
        finally
          Free;
        end;
      end;
    end;
  end;
  end;
end;

procedure TProductListForm.Button1Click(Sender: TObject);
begin
  if Trim(Edit1.Text) <> '' then
  begin
    MainGrid.DataSource.DataSet.Filtered := false;
    MainGrid.DataSource.DataSet.Filter := 'name='+QuotedStr(Trim(Edit1.Text));
    MainGrid.DataSource.DataSet.Filtered := true;
  end else
  begin
    MainGrid.DataSource.DataSet.Filtered := false;
    MainGrid.DataSource.DataSet.Filter := '';
  end;
end;

end.
