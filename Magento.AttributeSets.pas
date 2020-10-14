unit Magento.AttributeSets;

interface

uses
  Magento.Interfaces, System.Classes,REST.Response.Adapter, System.JSON, Data.DB,
  SysUtils;

type
  TMagentoAttributeSets = class (TInterfacedObject, iMagentoAttributeSets)
    private
      FAttributeSetID : Integer;
      FAttibuteSetName : String;
      FSortOrder : Integer;
      FEntityTypeID : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMagentoAttributeSets;

      function ListAttibuteSets(Value : TDataSet) : iMagentoAttributeSets;
      function ListAttributeSetsID(Value : TDataSet; ID : String) : iMagentoAttributeSets;

      function AttributeSetID(Value : Integer) : iMagentoAttributeSets;
      function AttibuteSetName(Value : String) : iMagentoAttributeSets;
      function SortOrder(Value : Integer) : iMagentoAttributeSets;
      function EntityTypeID(Value : Integer) : iMagentoAttributeSets;
      function &End : String;
  end;

implementation

{ TMagentoAttributeSets }

uses Magento.Factory;

function TMagentoAttributeSets.&End: String;
var
    lObj,lJSON : TJSONObject;
begin
    lObj := TJSONObject.Create;
    lJSON := TJSONObject.Create;

    lObj.AddPair('skeletonId',TJSONNumber.Create(4));
    lJSON.AddPair('attribute_set_id',TJSONNull.Create);
    lJSON.AddPair('attribute_set_name', FAttibuteSetName);
    lJSON.AddPair('sort_order',TJSONNumber.Create(FSortOrder));
    lJSON.AddPair('entity_type_id',TJSONNumber.Create(FEntityTypeID));
    lJSON.AddPair('extension_attributes', TJSONNull.Create);
    lObj.AddPair('attributeSet',lJSON);
    lObj.AddPair('entityTypeCode','catalog_product');

    Result := lObj.ToString;
end;

function TMagentoAttributeSets.AttibuteSetName(
  Value: String): iMagentoAttributeSets;
begin
  Result := Self;
  FAttibuteSetName := Value;
end;

function TMagentoAttributeSets.AttributeSetID(
  Value: Integer): iMagentoAttributeSets;
begin
  Result := Self;
  FAttributeSetID := Value;
end;

constructor TMagentoAttributeSets.Create;
begin

end;

destructor TMagentoAttributeSets.Destroy;
begin

  inherited;
end;

function TMagentoAttributeSets.EntityTypeID(
  Value: Integer): iMagentoAttributeSets;
begin
  Result := Self;
  FEntityTypeID := Value;
end;

function TMagentoAttributeSets.ListAttibuteSets(Value : TDataSet) : iMagentoAttributeSets;
var
  lJSONObj : TJSONObject;
  lJSONArray : TJSONArray;

  lConv : TCustomJSONDataSetAdapter;
  lJSON : String;
begin
  Result := Self;

  lJSON := TMagentoFactory.New.MagentoHTTP.GetAtributo;

  lJSONObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(lJSON), 0) as TJSONObject;
  lConv := TCustomJSONDataSetAdapter.Create(nil);

  lJSONArray := lJSONObj.Get('items').JsonValue as TJSONArray;

  try
    lConv.DataSet := Value;
    lConv.UpdateDataSet(lJSONArray);
  finally
    lConv.Free;
  end;
end;

function TMagentoAttributeSets.ListAttributeSetsID(Value: TDataSet;
  ID: String): iMagentoAttributeSets;
var
  lJSONObj, lArray, JSONArray : TJSONArray;
  lObj, lSubObj, JSONObj : TJSONObject;

  lConv : TCustomJSONDataSetAdapter;
  lJSON,Select_Value : String;
  I, J: Integer;
begin
  Result := Self;

  lJSON := TMagentoFactory.New.MagentoHTTP.GetAtributoID(ID);

  lJSONObj := TJSONObject.ParseJSONValue(lJSON) as TJSONArray;

  JSONArray := TJSONArray.Create;
  for I := 0 to lJSONObj.Size-1 do
  begin
    lObj := TJSONObject.Create;
    Select_Value := '';
    lSubObj := (lJSONObj.Get(I) as TJSONObject);

    lObj.AddPair('default_frontend_label',lSubObj.Get(7).JsonValue.Value);
    lObj.AddPair('attribute_id',lSubObj.Get(0).JsonValue.Value);
    lObj.AddPair('attribute_code',lSubObj.Get(1).JsonValue.Value);

    lArray := lSubObj.Get(5).JsonValue as TJSONArray;
    for J := 0 to lArray.Size-1 do
    begin
      JSONObj := (lArray.Get(J) as TJSONObject);
      if Select_Value='' then
        Select_Value := JSONObj.Get(1).JsonValue.Value+' ('+JSONObj.Get(0).JsonValue.Value+')'
       else
        Select_Value := Select_Value+','+JSONObj.Get(1).JsonValue.Value+' ('+JSONObj.Get(0).JsonValue.Value+')';
    end;
    lObj.AddPair('Attribute_Value',Select_Value);
    JSONArray.Add(lObj);
  end;


  lConv := TCustomJSONDataSetAdapter.Create(nil);

  try
    lConv.DataSet := Value;
    lConv.UpdateDataSet(JSONArray);
  finally
    lConv.Free;
  end;
end;

class function TMagentoAttributeSets.New: iMagentoAttributeSets;
begin
  Result := self.Create;
end;

function TMagentoAttributeSets.SortOrder(Value: Integer): iMagentoAttributeSets;
begin
  Result := Self;
  FSortOrder := Value;
end;

end.
