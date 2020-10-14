unit Magento.Categories;

interface

uses
  Magento.Interfaces, Data.DB, System.JSON, REST.Response.Adapter,SysUtils,
  System.Generics.Collections, StrUtils;

type
  TMagentoCategories = class (TInterfacedObject, iMagentoCategories)
    private
      FJSON : TJSONObject;
      FID : Integer;
      FName : String;
      FIsActive : Boolean;
      FLevel : Integer;
      FInclude_in_menu : Boolean;
      FCategoriaMae : Integer;
      FPosition : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMagentoCategories;
      function ID(Value : Integer) : iMagentoCategories;
      function Name(Value : String) : iMagentoCategories;
      function Is_active(Value : Boolean) : iMagentoCategories;
      function Position(Value : Integer) : iMagentoCategories;
      function Level(Value : Integer)  : iMagentoCategories;
      function Include_in_menu(Value : Boolean) : iMagentoCategories;
      function CategoriaMae(Value : Integer) : iMagentoCategories;
      function ListCategories(Value : TDataSet) : iMagentoCategories;
      function &End : String;
  end;

implementation

{ TMagentoCategories }

uses Magento.Factory;

function TMagentoCategories.&End: String;
var
  lObj,lJSON : TJSONObject;
  lArray : TJSONArray;
begin
  lObj := TJSONObject.Create;
  FJSON := TJSONObject.Create;
  lArray := TJSONArray.Create;

  FJSON.AddPair('parent_id', TJSONNumber.Create(FCategoriaMae));
  FJSON.AddPair('id',TJSONNumber.Create(FID));
  FJSON.AddPair('include_in_menu',TJSONBool.Create(FInclude_in_menu));
  FJSON.AddPair('is_active',TJSONBool.Create(FIsActive));
  FJSON.AddPair('level', TJSONNumber.Create(FLevel));
  FJSON.AddPair('name',FName);
  FJSON.AddPair('position',TJSONNumber.Create(FPosition));

  lObj.AddPair('attribute_code','url_key');
  lObj.AddPair('value', LowerCase(FName));

  lArray.Add(lObj);

  FJSON.AddPair('custom_attributes',lArray);

  Result := TJSONObject.Create.AddPair('category',FJSON).ToString;
end;

function TMagentoCategories.CategoriaMae(Value: Integer): iMagentoCategories;
begin
  Result := Self;
  FCategoriaMae := Value;
end;

constructor TMagentoCategories.Create;
begin

end;

destructor TMagentoCategories.Destroy;
begin

  inherited;
end;

function TMagentoCategories.ID(Value: Integer): iMagentoCategories;
begin
  Result := Self;
  FID := Value;
end;

function TMagentoCategories.Include_in_menu(Value: Boolean): iMagentoCategories;
begin
  Result := Self;
  FInclude_in_menu := Value;
end;

function TMagentoCategories.Is_active(Value: Boolean): iMagentoCategories;
begin
  Result := Self;
  FIsActive := Value;
end;

function TMagentoCategories.Level(Value: Integer): iMagentoCategories;
begin
  Result := Self;
  FLevel := Value;
end;

function TMagentoCategories.ListCategories(Value: TDataSet): iMagentoCategories;
var
  lJSONObj : TJSONObject;
  lJSONArray : TJSONArray;

  lConv : TCustomJSONDataSetAdapter;
  lJSON : String;
begin
  Result := Self;

  lJSON := TMagentoFactory.New.MagentoHTTP.GetCatagorias;

  lJSONObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(lJSON), 0) as TJSONObject;
  lConv := TCustomJSONDataSetAdapter.Create(nil);

  lJSONArray := lJSONObj.Get('children_data').JsonValue as TJSONArray;

  lJSONArray.ToString;

  try
    lConv.DataSet := Value;
    lConv.UpdateDataSet(lJSONArray);
  finally
    lConv.Free;
  end;
end;

function TMagentoCategories.Name(Value: String): iMagentoCategories;
begin
  Result := Self;
  FName := Value;
end;

class function TMagentoCategories.New: iMagentoCategories;
begin
  Result := self.Create;
end;

function TMagentoCategories.Position(Value: Integer): iMagentoCategories;
begin
  Result := Self;
  FPosition := Value;
end;

end.
