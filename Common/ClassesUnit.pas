unit ClassesUnit;

interface

uses
  SysUtils, Classes, DB, ADODB, DBTables, Variants, StrUtils;

type
  TParent = class(TObject)
    constructor Create(AConn: TADOConnection);
    destructor Destroy; override;

    protected
      FSelectQuery: TADOQuery;
  end;

  TCustom = class(TParent)
    public
      procedure Refresh;
      property DataSet: TADOQuery read FSelectQuery;
  end;

  TCustomItem = class(TCustom)
    constructor Create(AConn: TADOConnection);
    destructor Destroy; override;
    private
      procedure AssignParameters; virtual;
    protected
      FInsertComand, FUpdateComand: string;
      Fid: integer;
      Fis_deleted: boolean;
      FExecQuery: TADOQuery;
    public
      function CheckLogin(Alogin, Apwd: string): integer; virtual;
      function InsUpdDel: boolean; virtual;
      property id: integer read Fid write Fid;
      property is_deleted: boolean read Fis_deleted write Fis_deleted;
  end;

  TUser = class(TCustomItem)
    constructor Create(AConn: TADOConnection; AId: Integer);
    destructor Destroy; override;
    private
      Flogin: string;
      Fpwd: string;
      Ffio: string;
      Femail: string;
      Fsex: boolean;
      Fdate_birth: TDateTime;
      procedure SetLogin(AValue: string);
      procedure AssignParameters; override;
    public
      function CheckLogin(Alogin, Apwd: string): integer; override;
      function CheckUniqLogin: boolean;

      property login: string read Flogin write SetLogin;
      property pwd: string read Fpwd write Fpwd;
      property fio: string read Ffio write Ffio;
      property email: string read Femail write Femail;
      property sex: boolean read Fsex write Fsex;
      property date_birth: TDateTime read Fdate_birth write Fdate_birth;
  end;

  TUsers = class(TCustom)
    constructor Create(AConn: TADOConnection);
    destructor Destroy; override;
    private
      FCurrentUser: TUser;

    public
      procedure AssignUser;
      property CurrentUser: TUser read FCurrentUser;
  end;

  TCustomer = class(TCustomItem)
    constructor Create(AConn: TADOConnection; AId: Integer);
    destructor Destroy; override;
    private
      Flogin: string;
      Fpwd: string;
      Ffio: string;
      Femail: string;
      Fsex: boolean;
      Fdate_birth: TDateTime;
      Fcountry: string;
      Fcity: string;
      Fadress: string;
      Ftelephone: string;
      procedure SetLogin(AValue: string);
      procedure AssignParameters; override;
    public
      function CheckLogin(Alogin, Apwd: string): integer; override;
      function CheckUniqLogin: boolean;
      function GetBalance: integer;

      property login: string read Flogin write SetLogin;
      property pwd: string read Fpwd write Fpwd;
      property fio: string read Ffio write Ffio;
      property email: string read Femail write Femail;
      property sex: boolean read Fsex write Fsex;
      property date_birth: TDateTime read Fdate_birth write Fdate_birth;
      property country: string read Fcountry write Fcountry;
      property city: string read Fcity write Fcity;
      property adress: string read Fadress write Fadress;
      property telephone: string read Ftelephone write Ftelephone;
  end;

  TCustomers = class(TCustom)
    constructor Create(AConn: TADOConnection);
    destructor Destroy; override;
    private
      FCurrentCustomer: TCustomer;

    public
      procedure AssignCustomer;
      property CurrentCustomer: TCustomer read FCurrentCustomer;
  end;

  TProduct = class(TCustomItem)
    constructor Create(AConn: TADOConnection; AId: Integer);
    destructor Destroy; override;
    private
      Fname: string;
      Fprice: integer;
      Fphoto: string;
      Finformation: string;
      Fprovider: string;
      Fcount: integer;
      procedure AssignParameters; override;
    public
      property name: string read Fname write Fname;
      property price: integer read Fprice write Fprice;
      property photo: string read Fphoto write Fphoto;
      property information: string read Finformation write Finformation;
      property provider: string read Fprovider write Fprovider;
      property count: integer read Fcount write Fcount;
  end;

  TProducts = class(TCustom)
    constructor Create(AConn: TADOConnection);
    destructor Destroy; override;
    private
      FCurrentProduct: TProduct;

    public
     procedure AssignProduct;
     property CurrentProducts: TProduct read FCurrentProduct;
  end;

  TBalance = class(TCustomItem)
    constructor Create(AConn: TADOConnection; AId: Integer);
    destructor Destroy; override;
    private
      Fcustomer_id: integer;
      Fop_sum: integer;
      Foperation_id: integer;
      Fop_date: TDateTime;
      procedure AssignParameters; override;
    public
      property customer_id: integer read Fcustomer_id write Fcustomer_id;
      property op_sum: integer read Fop_sum write Fop_sum;
      property operation_id: integer read Foperation_id write Foperation_id;
      property op_date: TDateTime read Fop_date write Fop_date;
  end;

  TBalances = class(TCustom)
    constructor Create(AConn: TADOConnection; Acustomer_id: integer);
    destructor Destroy; override;
    private
      FCurrentBalance: TBalance;
      Fcustomer_id: integer;
    public
      procedure AssignBalance;
      property CurrentBalance: TBalance read FCurrentBalance;
      property customer_id: integer read Fcustomer_id write Fcustomer_id;
  end;

  TOperation = class(TCustomItem)
    constructor Create(AConn: TADOConnection; AId: Integer);
    destructor Destroy; override;
    private
      Fop_name: string;
      procedure AssignParameters; override;
    public
      property op_name: string read Fop_name write Fop_name;
  end;

  TOperations = class(TCustom)
    constructor Create(AConn: TADOConnection);
    destructor Destroy; override;
    private
      FCurrentOperation: TOperation;

    public
      procedure AssignOperation;
      property CurrentOperation: TOperation read FCurrentOperation;
  end;

  TOrder = class(TCustomItem)
    constructor Create(AConn: TADOConnection; AId: Integer);
    destructor Destroy; override;
    private
      Fcustomer_id: integer;
      Forder_date: TDateTime;
      procedure AssignParameters; override;
    public
      function InsUpdDel: boolean; override;

      property customer_id: integer read Fcustomer_id write Fcustomer_id;
      property order_date: TDateTime read Forder_date write Forder_date;
  end;

  TOrders = class(TCustom)
    constructor Create(AConn: TADOConnection; Acustomer_id: integer);
    destructor Destroy; override;
    private
      FCurrentOrder: TOrder;

    public
      procedure AssignOrder;
      property CurrentOrder: TOrder read FCurrentOrder;
  end;

  TOrderItem = class(TCustomItem)
    constructor Create(AConn: TADOConnection; AId: Integer);
    destructor Destroy; override;
    private
      Forder_id: integer;
      Fcustomer_id: integer;
      Fproduct_id: integer;
      Fcount: integer;
      procedure AssignParameters; override;
    public
      property order_id: integer read Forder_id write Forder_id;
      property customer_id: integer read Fcustomer_id write Fcustomer_id;
      property product_id: integer read Fproduct_id write Fproduct_id;
      property count: integer read Fcount write Fcount;
  end;

  TOrdersItems = class(TCustom)
    constructor Create(AConn: TADOConnection);
    destructor Destroy; override;
    private
      FCurrentOrderItem: TOrderItem;

    public
      procedure AssignOrderItem;
      property CurrentOrderItem: TOrderItem read FCurrentOrderItem;
  end;

  TBasket = class(TCustomItem)
    constructor Create(AConn: TADOConnection; AId: Integer);
    destructor Destroy; override;
    private
      Fcustomer_id: integer;
      Fproduct_id: integer;
      Forder_date: TDateTime;
      Fcount: integer;
      procedure AssignParameters; override;
    public
      function InsUpdDel: boolean; override;
      property customer_id: integer read Fcustomer_id write Fcustomer_id;
      property product_id: integer read Fproduct_id write Fproduct_id;
      property order_date: TDateTime read Forder_date write Forder_date;
      property count: integer read Fcount write Fcount;
  end;

  TBaskets = class(TCustom)
    constructor Create(AConn: TADOConnection; Acustomer_id: integer);
    destructor Destroy; override;
    private
      Fcustomer_id: integer;
      FCurrentBasket: TBasket;
      FExecQuery: TADOQuery;
      FDelQuery: TADOQuery;
    public
      function GetCosts: integer;
      procedure AssignBasket;
      procedure MakeOrders(Aorder_id: integer);
      property CurrentBasket: TBasket read FCurrentBasket;
  end;

implementation

{ TParent }

constructor TParent.Create(AConn: TADOConnection);
begin
  FSelectQuery := TADOQuery.Create(nil);
  FSelectQuery.Connection := AConn;
end;

destructor TParent.Destroy;
begin
  if Assigned(FSelectQuery) then FSelectQuery.Free;
end;

{ TUser }

constructor TUser.Create(AConn: TADOConnection; AId: integer);
begin
  inherited Create(AConn);

  Fid := AId;

  FInsertComand := 'insert into Users(login, pwd, fio, email, sex, date_birth) values(:login, :pwd, :fio, :email, :sex, :date_birth)';
  FUpdateComand := 'update Users set login=:login, pwd=:pwd, is_deleted=:is_deleted, fio=:fio, email=:email, sex=:sex, date_birth =:date_birth where id = :id';

  FSelectQuery.SQL.Text := 'select * from Users where id = :id';
  FSelectQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FSelectQuery.Parameters.ParamByName('id').Direction := pdInput;
  FSelectQuery.Parameters.ParamByName('id').Value := FId;
  FSelectQuery.Open;
  try
    Flogin := FSelectQuery.FieldByName('login').AsString;
    Fpwd := FSelectQuery.FieldByName('pwd').AsString;
    Fis_deleted := FSelectQuery.FieldByName('is_deleted').AsBoolean;
    Ffio := FSelectQuery.FieldByName('fio').AsString;
    Femail := FSelectQuery.FieldByName('email').AsString;
    Fsex := FSelectQuery.FieldByName('sex').AsBoolean;
    Fdate_birth := FSelectQuery.FieldByName('date_birth').AsDateTime;
  finally
    FSelectQuery.Close;
  end;
  FExecQuery.SQL.Text := FUpdateComand;
  FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('login').DataType := ftString;
  FExecQuery.Parameters.ParamByName('login').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('pwd').DataType := ftString;
  FExecQuery.Parameters.ParamByName('pwd').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('fio').DataType := ftString;
  FExecQuery.Parameters.ParamByName('fio').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('email').DataType := ftString;
  FExecQuery.Parameters.ParamByName('email').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('sex').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('sex').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('date_birth').DataType := ftDateTime;
  FExecQuery.Parameters.ParamByName('date_birth').Direction := pdInput;
end;

destructor TUser.Destroy;
begin

  inherited;
end;

procedure TUser.AssignParameters;
begin
  if Assigned(FExecQuery.Parameters.FindParam('id')) then
  begin
    FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('id').Value := FId;
  end;
  FExecQuery.Parameters.ParamByName('login').DataType := ftString;
  FExecQuery.Parameters.ParamByName('login').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('login').Value := Flogin;
  FExecQuery.Parameters.ParamByName('pwd').DataType := ftString;
  FExecQuery.Parameters.ParamByName('pwd').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('pwd').Value := Fpwd;
  if Assigned(FExecQuery.Parameters.FindParam('is_deleted')) then
  begin
  FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('is_deleted').Value := Fis_deleted;
  end;
  FExecQuery.Parameters.ParamByName('fio').DataType := ftString;
  FExecQuery.Parameters.ParamByName('fio').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('fio').Value := Ffio;
  FExecQuery.Parameters.ParamByName('email').DataType := ftString;
  FExecQuery.Parameters.ParamByName('email').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('email').Value := Femail;
  FExecQuery.Parameters.ParamByName('sex').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('sex').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('sex').Value := Fsex;

  FExecQuery.Parameters.ParamByName('date_birth').DataType := ftDateTime;
  FExecQuery.Parameters.ParamByName('date_birth').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('date_birth').Value := Fdate_birth;
end;

function TUser.CheckLogin(Alogin, Apwd: string): integer;
begin
  Result := 0;
  FExecQuery.Close;
  FExecQuery.SQL.Text := 'select id from Users where is_deleted=0 and login=:login and pwd=:pwd';
  FExecQuery.Parameters.ParamByName('login').Value := Alogin;
  FExecQuery.Parameters.ParamByName('pwd').Value := Apwd;
  FExecQuery.Open;
  try
    if FExecQuery.RecordCount > 0 then Result := FExecQuery.Fields[0].AsInteger;
  finally
    FExecQuery.Close;
  end;
end;

function TUser.CheckUniqLogin: boolean;
begin
  Result := False;
  if Fid = 0 then
  begin
    FExecQuery.Close;
    FExecQuery.SQL.Text := 'select id from users where login = :login';
    FExecQuery.Parameters.ParamByName('login').Value := Flogin;
    FExecQuery.Open;
    try
      if FExecQuery.RecordCount = 0 then Result := true;
    finally
      FExecQuery.Close;
    end;
  end else
    Result := true;
end;

procedure TUser.SetLogin(AValue: string);
begin
  if Fid = 0 then
    Flogin := AValue;
end;

{ TUsers }

procedure TUsers.AssignUser;
begin
  with FSelectQuery, FCurrentUser do
  begin
    id := 0;
    login := FieldByName('login').AsString;
    pwd := FieldByName('pwd').AsString;
    is_deleted := FieldByName('is_deleted').AsBoolean;
    fio := FieldByName('fio').AsString;
    email := FieldByName('email').AsString;
    sex := FieldByName('sex').AsBoolean;
    date_birth := FieldByName('date_birth').AsDateTime;
    id := FieldByName('id').AsInteger;
  end;
end;

constructor TUsers.Create(AConn: TADOConnection);
begin
  inherited Create(AConn);

  FSelectQuery.SQL.Text := 'select * from Users where is_deleted = 0';
  FSelectQuery.Open;

  FCurrentUser := TUser.Create(AConn, 0);
  AssignUser;
end;

destructor TUsers.Destroy;
begin
  FCurrentUser.Free;
  
  inherited;
end;

{ TCustomer }

constructor TCustomer.Create(AConn: TADOConnection; AId: Integer);
begin
  inherited Create(AConn);

  Fid := AId;

  FInsertComand := 'insert into Customers(login, pwd, fio, email, sex, date_birth, country, city, adress, telephone) values(:login, :pwd, :fio, :email, :sex, :date_birth, :country, :city, :adress, :telephone)';
  FUpdateComand := 'update Customers set login=:login, pwd=:pwd, is_deleted=:is_deleted, fio=:fio, email=:email, sex=:sex, date_birth=:date_birth, country=:country, city=:city, adress=:adress, telephone=:telephone where id = :id';

  FSelectQuery.SQL.Text := 'select * from Customers where id = :id';
  FSelectQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FSelectQuery.Parameters.ParamByName('id').Direction := pdInput;
  FSelectQuery.Parameters.ParamByName('id').Value := FId;
  FSelectQuery.Open;
  try
    Flogin := FSelectQuery.FieldByName('login').AsString;
    Fpwd := FSelectQuery.FieldByName('pwd').AsString;
    Fis_deleted := FSelectQuery.FieldByName('is_deleted').AsBoolean;
    Ffio := FSelectQuery.FieldByName('fio').AsString;
    Femail := FSelectQuery.FieldByName('email').AsString;
    Fsex := FSelectQuery.FieldByName('sex').AsBoolean;
    Fdate_birth := FSelectQuery.FieldByName('date_birth').AsDateTime;
    Fcountry := FSelectQuery.FieldByName('country').AsString;
    Fcity := FSelectQuery.FieldByName('city').AsString;
    Fadress := FSelectQuery.FieldByName('adress').AsString;
    Ftelephone := FSelectQuery.FieldByName('telephone').AsString;
  finally
    FSelectQuery.Close;
  end;
  FExecQuery.SQL.Text := FUpdateComand;
  FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('login').DataType := ftString;
  FExecQuery.Parameters.ParamByName('login').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('pwd').DataType := ftString;
  FExecQuery.Parameters.ParamByName('pwd').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('fio').DataType := ftString;
  FExecQuery.Parameters.ParamByName('fio').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('email').DataType := ftString;
  FExecQuery.Parameters.ParamByName('email').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('sex').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('sex').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('date_birth').DataType := ftDateTime;
  FExecQuery.Parameters.ParamByName('date_birth').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('country').DataType := ftString;
  FExecQuery.Parameters.ParamByName('country').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('city').DataType := ftString;
  FExecQuery.Parameters.ParamByName('city').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('adress').DataType := ftString;
  FExecQuery.Parameters.ParamByName('adress').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('telephone').DataType := ftString;
  FExecQuery.Parameters.ParamByName('telephone').Direction := pdInput;
end;

destructor TCustomer.Destroy;
begin

  inherited;
end;

procedure TCustomer.SetLogin(AValue: string);
begin
  if Fid = 0 then
    Flogin := AValue;
end;

procedure TCustomer.AssignParameters;
begin
  if Assigned(FExecQuery.Parameters.FindParam('id')) then
  begin
    FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('id').Value := FId;
  end;
  FExecQuery.Parameters.ParamByName('login').DataType := ftString;
  FExecQuery.Parameters.ParamByName('login').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('login').Value := Flogin;
  FExecQuery.Parameters.ParamByName('pwd').DataType := ftString;
  FExecQuery.Parameters.ParamByName('pwd').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('pwd').Value := Fpwd;
  if Assigned(FExecQuery.Parameters.FindParam('is_deleted')) then
  begin
    FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
    FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('is_deleted').Value := Fis_deleted;
  end;
  FExecQuery.Parameters.ParamByName('fio').DataType := ftString;
  FExecQuery.Parameters.ParamByName('fio').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('fio').Value := Ffio;
  FExecQuery.Parameters.ParamByName('email').DataType := ftString;
  FExecQuery.Parameters.ParamByName('email').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('email').Value := Femail;
  FExecQuery.Parameters.ParamByName('sex').Value := Fsex;
  FExecQuery.Parameters.ParamByName('sex').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('sex').Direction := pdInput;

  FExecQuery.Parameters.ParamByName('date_birth').DataType := ftDateTime;
  FExecQuery.Parameters.ParamByName('date_birth').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('date_birth').Value := Fdate_birth;

  FExecQuery.Parameters.ParamByName('country').DataType := ftString;
  FExecQuery.Parameters.ParamByName('country').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('country').Value := Fcountry;
  FExecQuery.Parameters.ParamByName('city').DataType := ftString;
  FExecQuery.Parameters.ParamByName('city').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('city').Value := Fcity;
  FExecQuery.Parameters.ParamByName('adress').DataType := ftString;
  FExecQuery.Parameters.ParamByName('adress').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('adress').Value := Fadress;
  FExecQuery.Parameters.ParamByName('telephone').DataType := ftString;
  FExecQuery.Parameters.ParamByName('telephone').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('telephone').Value := Ftelephone;
end;

function TCustomer.CheckLogin(Alogin, Apwd: string): integer;
begin
  Result := 0;
  FExecQuery.Close;
  FExecQuery.SQL.Text := 'select id from Customers where is_deleted=0 and login=:login and pwd=:pwd';
  FExecQuery.Parameters.ParamByName('login').Value := Alogin;
  FExecQuery.Parameters.ParamByName('pwd').Value := Apwd;
  FExecQuery.Open;
  try
    if FExecQuery.RecordCount > 0 then Result := FExecQuery.Fields[0].AsInteger;
  finally
    FExecQuery.Close;
  end;
end;

function TCustomer.CheckUniqLogin: boolean;
begin
  Result := false;
  FExecQuery.Close;
  FExecQuery.SQL.Text := 'select id from customers where login = :login';
  FExecQuery.Parameters.ParamByName('login').Value := Flogin;
  FExecQuery.Open;
  try
    if FExecQuery.RecordCount = 0 then Result := true;
  finally
    FExecQuery.Close;
  end;
end;

function TCustomer.GetBalance: integer;
begin
  FExecQuery.Close;
  FExecQuery.SQL.Text := 'select sum(op_sum) from Balance where is_deleted = 0 and customer_id = '+IntToStr(id);
  FExecQuery.Open;
  try
    Result := FExecQuery.Fields[0].AsInteger;
  finally
    FExecQuery.Close;
  end;
end;

{ TCustomers }

constructor TCustomers.Create(AConn: TADOConnection);
begin
  inherited Create(AConn);

  FSelectQuery.SQL.Text := 'select * from Customers where is_deleted = 0';
  FSelectQuery.Open;

  FCurrentCustomer := TCustomer.Create(AConn, 0);
  AssignCustomer;
end;

destructor TCustomers.Destroy;
begin
  FCurrentCustomer.Free;

  inherited;
end;

procedure TCustomers.AssignCustomer;
begin
  with FSelectQuery, FCurrentCustomer do
  begin
    id := 0;
    login := FieldByName('login').AsString;
    pwd := FieldByName('pwd').AsString;
    is_deleted := FieldByName('is_deleted').AsBoolean;
    fio := FieldByName('fio').AsString;
    email := FieldByName('email').AsString;
    sex := FieldByName('sex').AsBoolean;
    date_birth := FieldByName('date_birth').AsDateTime;
    country := FieldByName('country').AsString;
    city := FieldByName('city').AsString;
    adress := FieldByName('adress').AsString;
    telephone := FieldByName('telephone').AsString;
    id := FieldByName('id').AsInteger;
  end;
end;

{ TProduct }

constructor TProduct.Create(AConn: TADOConnection; AId: Integer);
begin
  inherited Create(AConn);

  Fid := AId;

  FInsertComand := 'insert into Products(name, price, photo, information, provider, is_deleted, [count]) values(:name, :price, :photo, :information, :provider, :is_deleted, :count)';
  FUpdateComand := 'update Products set name=:name, price=:price, photo=:photo, information=:information, provider=:provider, is_deleted=:is_deleted, [count]=:count where id= :id';

  FSelectQuery.SQL.Text := 'select * from Products where id = :id and [count] > 0';
  FSelectQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FSelectQuery.Parameters.ParamByName('id').Direction := pdInput;
  FSelectQuery.Parameters.ParamByName('id').Value := FId;
  FSelectQuery.Open;
  try
     Fname := FSelectQuery.FieldByName('name').AsString;
     Fprice := FSelectQuery.FieldByName('price').AsInteger;
     Fphoto := FSelectQuery.FieldByName('photo').AsString;
     Finformation := FSelectQuery.FieldByName('information').AsString;
     Fprovider := FSelectQuery.FieldByName('provider').AsString;
     Fis_deleted := FSelectQuery.FieldByName('is_deleted').AsBoolean;
     Fcount := FSelectQuery.FieldByName('count').AsInteger;
  finally
    FSelectQuery.Close;
  end;
  FExecQuery.SQL.Text := FUpdateComand;
  FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('name').DataType := ftString;
  FExecQuery.Parameters.ParamByName('name').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('price').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('price').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('photo').DataType := ftString;
  FExecQuery.Parameters.ParamByName('photo').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('information').DataType := ftString;
  FExecQuery.Parameters.ParamByName('information').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('provider').DataType := ftString;
  FExecQuery.Parameters.ParamByName('provider').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('count').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('count').Direction := pdInput;
end;

destructor TProduct.Destroy;
begin

  inherited;
end;

procedure TProduct.AssignParameters;
begin
  FExecQuery.Close;
  if Assigned(FExecQuery.Parameters.FindParam('id')) then
  begin
    FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('id').Value := FId;
  end;
  FExecQuery.Parameters.ParamByName('name').DataType := ftString;
  FExecQuery.Parameters.ParamByName('name').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('name').Value := Fname;
  FExecQuery.Parameters.ParamByName('price').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('price').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('price').Value := Fprice;
  FExecQuery.Parameters.ParamByName('photo').DataType := ftString;
  FExecQuery.Parameters.ParamByName('photo').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('photo').Value := Fphoto;
  FExecQuery.Parameters.ParamByName('information').DataType := ftString;
  FExecQuery.Parameters.ParamByName('information').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('information').Value := Finformation;
  FExecQuery.Parameters.ParamByName('provider').DataType := ftString;
  FExecQuery.Parameters.ParamByName('provider').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('provider').Value := Fprovider;
  if Assigned(FExecQuery.Parameters.FindParam('is_deleted')) then
  begin
    FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
    FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('is_deleted').Value := Fis_deleted;
  end;
  FExecQuery.Parameters.ParamByName('count').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('count').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('count').Value := Fcount;
end;

{ TProducts }

constructor TProducts.Create(AConn: TADOConnection);
begin
  inherited Create(AConn);

  FSelectQuery.SQL.Text := 'select * from Products where is_deleted = 0';
  FSelectQuery.Open;

  FCurrentProduct := TProduct.Create(AConn, 0);
  AssignProduct;
end;

destructor TProducts.Destroy;
begin
  FCurrentProduct.Free;

  inherited;
end;

procedure TProducts.AssignProduct;
begin
  with FSelectQuery, FCurrentProduct do
  begin
    id := 0;
    name := FieldByName('name').AsString;
    price := FieldByName('price').AsInteger;
    photo := FieldByName('photo').AsString;
    information := FieldByName('information').AsString;
    provider := FieldByName('provider').AsString;
    is_deleted := FieldByName('is_deleted').AsBoolean;
    count := FieldByName('count').AsInteger;
    id := FieldByName('id').AsInteger;
  end;
end;

{ TCustomItem }

procedure TCustomItem.AssignParameters;
begin
//
end;

function TCustomItem.CheckLogin(Alogin, Apwd: string): integer;
begin
  Result := 0;
end;

constructor TCustomItem.Create(AConn: TADOConnection);
begin
  inherited Create(AConn);

  FExecQuery := TADOQuery.Create(nil);
  FExecQuery.Connection := AConn;
end;

destructor TCustomItem.Destroy;
begin
  if Assigned(FExecQuery) then FExecQuery.Free;

  inherited;
end;

function TCustomItem.InsUpdDel: boolean;
begin
  if Fid > 0 then
    FExecQuery.SQL.Text := FUpdateComand
  else
    FExecQuery.SQL.Text := FInsertComand;
  AssignParameters;
  FExecQuery.ExecSQL;
  Result := true;
end;

{ TBalance }

constructor TBalance.Create(AConn: TADOConnection; AId: Integer);
begin
  inherited Create(AConn);

  Fid := AId;

  FInsertComand := 'insert into Balance(customer_id, op_sum, operation_id) values(:customer_id, :op_sum, :operation_id)';
  FUpdateComand := 'update Balance set customer_id=:customer_id, op_sum=:op_sum, operation_id=:operation_id, is_deleted=:is_deleted, op_date=:op_date where id = :id';

  FSelectQuery.SQL.Text := 'select * from Balance where id = :id';
  FSelectQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FSelectQuery.Parameters.ParamByName('id').Direction := pdInput;
  FSelectQuery.Parameters.ParamByName('id').Value := FId;
  FSelectQuery.Open;
  try
     Fcustomer_id := FSelectQuery.FieldByName('customer_id').AsInteger;
     Fop_sum := FSelectQuery.FieldByName('op_sum').AsInteger;
     Foperation_id := FSelectQuery.FieldByName('operation_id').AsInteger;
     Fis_deleted := FSelectQuery.FieldByName('is_deleted').AsBoolean;
     Fop_date := FSelectQuery.FieldByName('op_date').AsDateTime;
  finally
    FSelectQuery.Close;
  end;
  FExecQuery.SQL.Text := FUpdateComand;
  FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('customer_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('customer_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('op_sum').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('op_sum').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('operation_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('operation_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('op_date').DataType := ftDateTime;
  FExecQuery.Parameters.ParamByName('op_date').Direction := pdInput;
end;

destructor TBalance.Destroy;
begin

  inherited;
end;

procedure TBalance.AssignParameters;
begin
  if Assigned(FExecQuery.Parameters.FindParam('id')) then
  begin
    FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('id').Value := FId;
  end;
  FExecQuery.Parameters.ParamByName('customer_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('customer_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('customer_id').Value := Fcustomer_id;
  if Assigned(FExecQuery.Parameters.FindParam('op_sum')) then
  begin
    FExecQuery.Parameters.ParamByName('op_sum').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('op_sum').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('op_sum').Value := Fop_sum;
  end;
  FExecQuery.Parameters.ParamByName('operation_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('operation_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('operation_id').Value := Foperation_id;
  if Assigned(FExecQuery.Parameters.FindParam('is_deleted')) then
  begin
  FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('is_deleted').Value := Fis_deleted;
  end;
  if Assigned(FExecQuery.Parameters.FindParam('op_date')) then
  begin
    FExecQuery.Parameters.ParamByName('op_date').DataType := ftDateTime;
    FExecQuery.Parameters.ParamByName('op_date').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('op_date').Value := Fop_date;
  end;
end;

{ TBalances }

constructor TBalances.Create(AConn: TADOConnection; Acustomer_id: integer);
begin
  inherited Create(AConn);

  Fcustomer_id := Acustomer_id;
  FSelectQuery.SQL.Text := 'select b.*, c.login from Balance b inner join Customers c on c.id = b.customer_id'+
  ' where b.is_deleted = 0 and b.customer_id = '+IntToStr(Acustomer_id);
  FSelectQuery.Open;

  FCurrentBalance := TBalance.Create(AConn, 0);
  AssignBalance;
end;

destructor TBalances.Destroy;
begin
  FCurrentBalance.Free;

  inherited;
end;
       
procedure TBalances.AssignBalance;
begin
  with FSelectQuery, FCurrentBalance do
  begin
    id := 0;
    customer_id := FieldByName('customer_id').AsInteger;
    op_sum := FieldByName('op_sum').AsInteger;
    operation_id := FieldByName('operation_id').AsInteger;
    is_deleted := FieldByName('is_deleted').AsBoolean;
    op_date := FieldByName('op_date').AsDateTime;
    id := FieldByName('id').AsInteger;
  end;
end;

{ TOperation }

constructor TOperation.Create(AConn: TADOConnection; AId: Integer);
begin
  inherited Create(AConn);

  Fid := AId;

  FInsertComand := 'insert into Operations(op_name, is_deleted) values(:op_name, :is_deleted)';
  FUpdateComand := 'update Operations set op_name=:op_name, is_deleted=:is_deleted where id = :id';

  FSelectQuery.SQL.Text := 'select * from Operations where id = :id';
  FSelectQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FSelectQuery.Parameters.ParamByName('id').Direction := pdInput;
  FSelectQuery.Parameters.ParamByName('id').Value := FId;
  FSelectQuery.Open;
  try
     Fop_name := FSelectQuery.FieldByName('op_name').AsString;
     Fis_deleted := FSelectQuery.FieldByName('is_deleted').AsBoolean;
  finally
    FSelectQuery.Close;
  end;
  FExecQuery.SQL.Text := FUpdateComand;
  FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('op_name').DataType := ftString;
  FExecQuery.Parameters.ParamByName('op_name').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
end;

destructor TOperation.Destroy;
begin

  inherited;
end;

procedure TOperation.AssignParameters;
begin
  if Assigned(FExecQuery.Parameters.FindParam('id')) then
  begin
    FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('id').Value := FId;
  end;
  FExecQuery.Parameters.ParamByName('op_name').DataType := ftString;
  FExecQuery.Parameters.ParamByName('op_name').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('op_name').Value := Fop_name;
  if Assigned(FExecQuery.Parameters.FindParam('is_deleted')) then
  begin
    FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
    FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('is_deleted').Value := Fis_deleted;
  end;
end;

{ TOperations }

constructor TOperations.Create(AConn: TADOConnection);
begin
  inherited Create(AConn);

  FSelectQuery.SQL.Text := 'select * from Operations where is_deleted = 0';
  FSelectQuery.Open;

  FCurrentOperation := TOperation.Create(AConn, 0);
  AssignOperation;
end;

destructor TOperations.Destroy;
begin
  FCurrentOperation.Free;

  inherited;
end;

procedure TOperations.AssignOperation;
begin
  with FSelectQuery, FCurrentOperation do
  begin
    id := 0;
    op_name := FieldByName('op_name').AsString;
    is_deleted := FieldByName('is_deleted').AsBoolean;
    id := FieldByName('id').AsInteger;
  end;
end;

{ TOrder }

constructor TOrder.Create(AConn: TADOConnection; AId: Integer);
begin
  inherited Create(AConn);

  Fid := AId;

  FInsertComand := 'insert into Orders(customer_id) values(:customer_id)';
  FUpdateComand := 'update Orders set customer_id=:customer_id, is_deleted=:is_deleted, order_date=:order_date where id = :id';

  FSelectQuery.SQL.Text := 'select * from Orders where is_deleted = 0 and id = :id';
  FSelectQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FSelectQuery.Parameters.ParamByName('id').Direction := pdInput;
  FSelectQuery.Parameters.ParamByName('id').Value := FId;
  FSelectQuery.Open;
  try
     Fcustomer_id := FSelectQuery.FieldByName('customer_id').AsInteger;
     Fis_deleted := FSelectQuery.FieldByName('is_deleted').AsBoolean;
     Forder_date := FSelectQuery.FieldByName('order_date').AsDateTime;     
  finally
    FSelectQuery.Close;
  end;
  FExecQuery.SQL.Text := FUpdateComand;
  FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('customer_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('customer_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('order_date').DataType := ftDateTime;
  FExecQuery.Parameters.ParamByName('order_date').Direction := pdInput;
end;

destructor TOrder.Destroy;
begin

  inherited;
end;

procedure TOrder.AssignParameters;
begin
  if Assigned(FExecQuery.Parameters.FindParam('id')) then
  begin
    FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('id').Value := FId;
  end;
  FExecQuery.Parameters.ParamByName('customer_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('customer_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('customer_id').Value := Fcustomer_id;
  if Assigned(FExecQuery.Parameters.FindParam('is_deleted')) then
  begin
    FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
    FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('is_deleted').Value := Fis_deleted;
  end;
  if Assigned(FExecQuery.Parameters.FindParam('order_date')) then
  begin
    FExecQuery.Parameters.ParamByName('order_date').DataType := ftDateTime;
    FExecQuery.Parameters.ParamByName('order_date').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('order_date').Value := Forder_date;
  end;
end;

function TOrder.InsUpdDel: boolean;
begin
  inherited InsUpdDel;
  
  if Fid = 0 then
  begin
    FExecQuery.Close;
    FExecQuery.SQL.Text := 'select top 1 id from Orders where is_deleted = 0 and customer_id = '+IntToStr(Fcustomer_id)+' order by order_date desc';
    FExecQuery.Open;
    try
      if FExecQuery.RecordCount > 0 then
        Fid := FExecQuery.Fields[0].AsInteger;
    finally
      FExecQuery.Close;
    end;
  end;
  Result := true;
end;

{ TOrders }

constructor TOrders.Create(AConn: TADOConnection; Acustomer_id: integer);
begin
  inherited Create(AConn);

  FSelectQuery.SQL.Text := 'select * from Orders where is_deleted = 0 and customer_id = ' + IntToStr(Acustomer_id);
  FSelectQuery.Open;

  FCurrentOrder := TOrder.Create(AConn, 0);
  AssignOrder;
end;

destructor TOrders.Destroy;
begin
  FCurrentOrder.Free;

  inherited;
end;

procedure TOrders.AssignOrder;
begin
  with FSelectQuery, FCurrentOrder do
  begin
    id := 0;
    customer_id := FieldByName('customer_id').AsInteger;
    is_deleted := FieldByName('is_deleted').AsBoolean;
    order_date := FieldByName('order_date').AsDateTime;
    id := FieldByName('id').AsInteger;
  end;
end;


{ TOrderItem }

constructor TOrderItem.Create(AConn: TADOConnection; AId: Integer);
begin
  inherited Create(AConn);

  Forder_id := AId;

  FInsertComand := 'insert into OrdersItems(customer_id, product_id, [count]) values(:customer_id, :product_id, :count)';
  FUpdateComand := 'update OrdersItems set customer_id=:customer_id, is_deleted=:is_deleted where order_id = :order_id and product_id=:product_id';

  FSelectQuery.SQL.Text := 'select * from OrdersItems where order_id = :order_id';
  FSelectQuery.Parameters.ParamByName('order_id').DataType := ftInteger;
  FSelectQuery.Parameters.ParamByName('order_id').Direction := pdInput;
  FSelectQuery.Parameters.ParamByName('order_id').Value := Forder_id;
  FSelectQuery.Open;
  try
     Fcustomer_id := FSelectQuery.FieldByName('customer_id').AsInteger;
     Fproduct_id := FSelectQuery.FieldByName('product_id').AsInteger;
     Fis_deleted := FSelectQuery.FieldByName('is_deleted').AsBoolean;
     Fcount := FSelectQuery.FieldByName('count').AsInteger;
  finally
    FSelectQuery.Close;
  end;
  FExecQuery.SQL.Text := FUpdateComand;
  FExecQuery.Parameters.ParamByName('order_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('order_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('customer_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('customer_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('product_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('product_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('count').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('count').Direction := pdInput;
end;

destructor TOrderItem.Destroy;
begin

  inherited;
end;

procedure TOrderItem.AssignParameters;
begin
  if Assigned(FExecQuery.Parameters.FindParam('order_id')) then
  begin
    FExecQuery.Parameters.ParamByName('order_id').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('order_id').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('order_id').Value := Forder_id;
  end;
  FExecQuery.Parameters.ParamByName('customer_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('customer_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('customer_id').Value := Fcustomer_id;
  FExecQuery.Parameters.ParamByName('product_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('product_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('product_id').Value := Fproduct_id;
  if Assigned(FExecQuery.Parameters.FindParam('is_deleted')) then
  begin
    FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
    FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('is_deleted').Value := Fis_deleted;
  end;
  if Assigned(FExecQuery.Parameters.FindParam('count')) then
  begin
    FExecQuery.Parameters.ParamByName('count').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('count').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('count').Value := Fcount;
  end;
end;

{ TOrdersItems }

constructor TOrdersItems.Create(AConn: TADOConnection);
begin
  inherited Create(AConn);

  FSelectQuery.SQL.Text := 'select * from OrdersItems where is_deleted = 0';
  FSelectQuery.Open;

  FCurrentOrderItem := TOrderItem.Create(AConn, 0);
  AssignOrderItem;
end;

destructor TOrdersItems.Destroy;
begin
  FCurrentOrderItem.Free;

  inherited;
end;

procedure TOrdersItems.AssignOrderItem;
begin
  with FSelectQuery, FCurrentOrderItem do
  begin
    order_id := 0;
    customer_id := FieldByName('customer_id').AsInteger;
    product_id := FieldByName('product_id').AsInteger;
    is_deleted := FieldByName('is_deleted').AsBoolean;
    order_id := FieldByName('order_id').AsInteger;
  end;
end;

{ TBaskets }

procedure TBaskets.AssignBasket;
begin
  with FSelectQuery, FCurrentBasket do
  begin
    id := 0;
    customer_id := FieldByName('customer_id').AsInteger;
    product_id := FieldByName('product_id').AsInteger;
    order_date := FieldByName('order_date').AsDateTime;
    is_deleted := FieldByName('is_deleted').AsBoolean;
    count := FieldByName('count').AsInteger;
    id := FieldByName('id').AsInteger;
  end;
end;

constructor TBaskets.Create(AConn: TADOConnection; Acustomer_id: integer);
begin
  inherited Create(AConn);

  FExecQuery := TADOQuery.Create(nil);
  FExecQuery.Connection := AConn;

  FDelQuery := TADOQuery.Create(nil);
  FDelQuery.Connection := AConn;

  Fcustomer_id := Acustomer_id;

  FSelectQuery.SQL.Text := 'select b.*, c.login, p.name, (p.price * b.count) as [total price] from Basket b, Customers c, Products p '+
    //' inner join Customers c on c.id = b.customer_id '+
    //' inner join Products p on p.id = b.product_id '+
    ' where b.is_deleted = 0 and b.customer_id = ' + IntToStr(Fcustomer_id)+
    ' and c.id = b.customer_id and p.id = b.product_id';
  FSelectQuery.Open;

  FCurrentBasket := TBasket.Create(AConn, 0);
  AssignBasket;
end;

destructor TBaskets.Destroy;
begin
  FCurrentBasket.Free;
  FExecQuery.Free;
  FDelQuery.Free;

  inherited;
end;

function TBaskets.GetCosts: integer;
begin
  FExecQuery.Close;
  FExecQuery.SQL.Text := 'select sum(p.price*b.[count]) from Basket b inner join Products p on p.id = b.product_id where b.is_deleted = 0 and b.customer_id = '+IntToStr(Fcustomer_id);
  FExecQuery.Open;
  try
    Result := FExecQuery.Fields[0].AsInteger;
  finally
    FExecQuery.Close;
  end;
end;

procedure TBaskets.MakeOrders(Aorder_id: integer);
begin
  {FExecQuery.Close;
  FExecQuery.SQL.Text := 'update Products set [count] = p.[count] - b.[count] from Products p, Baskets b where p.id = b.product_id';}

  FExecQuery.Close;
  FExecQuery.SQL.Text := 'insert into OrdersItems(order_id, customer_id, product_id, [count]) '+
    'select :order_id, customer_id, product_id, [count] from Basket where customer_id = :customer_id';
  FExecQuery.Parameters.ParamByName('order_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('order_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('customer_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('customer_id').Direction := pdInput;

  FDelQuery.Close;
  FDelQuery.SQL.Text := 'delete from Basket where customer_id = :customer_id';
  FDelQuery.Parameters.ParamByName('customer_id').DataType := ftInteger;
  FDelQuery.Parameters.ParamByName('customer_id').Direction := pdInput;


  FExecQuery.Parameters.ParamByName('order_id').Value := Aorder_id;
  FExecQuery.Parameters.ParamByName('customer_id').Value := Fcustomer_id;
  FExecQuery.ExecSQL;

  FDelQuery.Parameters.ParamByName('customer_id').Value := Fcustomer_id;
  FDelQuery.ExecSQL;
end;

{ TBasket }

constructor TBasket.Create(AConn: TADOConnection; AId: Integer);
begin
  inherited Create(AConn);

  Fid := AId;

  FInsertComand := 'insert into Basket(customer_id, product_id) values(:customer_id, :product_id)';
  FUpdateComand := 'update Basket set customer_id=:customer_id, product_id=:product_id, is_deleted=:is_deleted, [count]=:count where id = :id';

  FSelectQuery.SQL.Text := 'select * from Basket where is_deleted = 0 and id = :id';
  FSelectQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FSelectQuery.Parameters.ParamByName('id').Direction := pdInput;
  FSelectQuery.Parameters.ParamByName('id').Value := Fid;
  FSelectQuery.Open;
  try
     Fcustomer_id := FSelectQuery.FieldByName('customer_id').AsInteger;
     Fproduct_id := FSelectQuery.FieldByName('product_id').AsInteger;
     Forder_date := FSelectQuery.FieldByName('order_date').AsDateTime;
     Fis_deleted := FSelectQuery.FieldByName('is_deleted').AsBoolean;
     Fcount := FSelectQuery.FieldByName('count').AsInteger;
  finally
    FSelectQuery.Close;
  end;
  FExecQuery.SQL.Text := FUpdateComand;
  FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('customer_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('customer_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('product_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('product_id').Direction := pdInput;
  if Assigned(FExecQuery.Parameters.FindParam('order_date')) then
  begin
    FExecQuery.Parameters.ParamByName('order_date').DataType := ftDateTime;
    FExecQuery.Parameters.ParamByName('order_date').Direction := pdInput;
  end;
  FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
  FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('count').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('count').Direction := pdInput;
end;

procedure TBasket.AssignParameters;
begin
  if Assigned(FExecQuery.Parameters.FindParam('id')) then
  begin
    FExecQuery.Parameters.ParamByName('id').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('id').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('id').Value := Fid;
  end;
  FExecQuery.Parameters.ParamByName('customer_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('customer_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('customer_id').Value := Fcustomer_id;
  FExecQuery.Parameters.ParamByName('product_id').DataType := ftInteger;
  FExecQuery.Parameters.ParamByName('product_id').Direction := pdInput;
  FExecQuery.Parameters.ParamByName('product_id').Value := Fproduct_id;
  if Assigned(FExecQuery.Parameters.FindParam('order_date')) then
  begin
    FExecQuery.Parameters.ParamByName('order_date').DataType := ftDateTime;
    FExecQuery.Parameters.ParamByName('order_date').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('order_date').Value := DateToStr(Forder_date);
  end;
  if Assigned(FExecQuery.Parameters.FindParam('is_deleted')) then
  begin
    FExecQuery.Parameters.ParamByName('is_deleted').DataType := ftBoolean;
    FExecQuery.Parameters.ParamByName('is_deleted').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('is_deleted').Value := Fis_deleted;
  end;
  if Assigned(FExecQuery.Parameters.FindParam('count')) then
  begin
    FExecQuery.Parameters.ParamByName('count').DataType := ftInteger;
    FExecQuery.Parameters.ParamByName('count').Direction := pdInput;
    FExecQuery.Parameters.ParamByName('count').Value := Fcount;
  end;
end;

destructor TBasket.Destroy;
begin

  inherited;
end;

function TBasket.InsUpdDel: boolean;
var
  Acount: integer;
begin
  Acount := 0;
  FExecQuery.Close;
  FExecQuery.SQL.Text := 'select id, [count] from Basket where customer_id = :customer_id and product_id = :product_id';
  AssignParameters;
  FExecQuery.Open;
  try
    if FExecQuery.RecordCount > 0 then
    begin
      Fid := FExecQuery.Fields[0].AsInteger;
      Acount := FExecQuery.Fields[1].AsInteger;
    end else
      Fid := 0;
  finally
  end;

  if Fid > 0 then
  begin
    Fcount := Fcount + Acount;
    FExecQuery.SQL.Text := FUpdateComand
  end else
    FExecQuery.SQL.Text := FInsertComand;
  AssignParameters;
  FExecQuery.ExecSQL;
  Result := true;
end;

{ TCustom }

procedure TCustom.Refresh;
var
  i, fc: integer;
  fn: string;
  f: TField;
begin
  FSelectQuery.Close;
  FSelectQuery.Open;
  fc := FSelectQuery.FieldCount;
  for i := 0 to fc-1 do
  begin
    f := FSelectQuery.Fields[i];
    fn := f.FieldName;
    if (LowerCase(RightStr(fn, 2)) = 'id') or (fn = 'is_deleted') then
      f.Visible := false;
  end;
end;

end.
