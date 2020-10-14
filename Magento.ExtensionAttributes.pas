unit Magento.ExtensionAttributes;

interface

uses
  Magento.Interfaces, System.JSON, System.Generics.Collections;

type
  TMagentoExtensionAttributes = class (TInterfacedObject, iMagentoExtensionAttributes)
    private
      FParent : iMagentoEntidadeProduto;
      FJSON : TJSONObject;
      FCategoryLink : iMagentoCategory_Links;
    public
      constructor Create(Parent : iMagentoEntidadeProduto);
      destructor Destroy; override;
      class function New(Parent : iMagentoEntidadeProduto) : iMagentoExtensionAttributes;
      function Category_Links : iMagentoCategory_Links; overload;
      function Category_Links(value : TJSONArray) : iMagentoExtensionAttributes; overload;
      function Category_Links(value : TDictionary<Integer, String>) : iMagentoExtensionAttributes; overload;
      function Stock_item :iMagentoStock_Item; overload;
      function Stock_item(value : TJSONObject) : iMagentoExtensionAttributes; overload;
      function &End : iMagentoEntidadeProduto;
  end;

implementation

{ TMagentoExtensionAttributes }

uses Magento.Factory, System.SysUtils;

function TMagentoExtensionAttributes.Category_Links: iMagentoCategory_Links;
begin
  Result := TMagentoFactory.New.Category_Links(Self);
end;

function TMagentoExtensionAttributes.&End: iMagentoEntidadeProduto;
begin
  FParent.Extension_attributes(FJSON);
  Result := FParent;
end;

function TMagentoExtensionAttributes.Category_Links(
  value: TJSONArray): iMagentoExtensionAttributes;
begin
  Result := Self;
  FJSON.AddPair('category_Links',value);
end;

function TMagentoExtensionAttributes.Category_Links(
  value: TDictionary<Integer, String>): iMagentoExtensionAttributes;
var
  Key : Integer;
  lJSONArray : TJSONArray;
  lJSON : TJSONObject;
begin
  Result := Self;
  value.Add(3,'0');

  lJSONArray := TJSONArray.Create;
  for Key in Value.Keys do
  begin
    lJSON := TJSONObject.Create;
    lJSON.AddPair('position',TJSONNumber.Create(StrToInt(Value.Items[key])));
    lJSON.AddPair('category_id',IntToStr(key));
    lJSONArray.Add(lJSON);
  end;
  FJSON.AddPair('category_Links',lJSONArray);
end;

constructor TMagentoExtensionAttributes.Create(Parent : iMagentoEntidadeProduto);
begin
  FParent := Parent;
  FJSON := TJSONObject.Create;
end;

destructor TMagentoExtensionAttributes.Destroy;
begin
//  FJSON.DisposeOf;
  inherited;
end;

class function TMagentoExtensionAttributes.New(Parent : iMagentoEntidadeProduto) : iMagentoExtensionAttributes;
begin
  Result := self.Create(Parent);
end;

function TMagentoExtensionAttributes.Stock_item(
  value: TJSONObject): iMagentoExtensionAttributes;
begin
  Result := Self;
  FJSON.AddPair('stock_item', value);
end;

function TMagentoExtensionAttributes.Stock_item: iMagentoStock_Item;
begin
  Result := TMagentoFactory.New.Stock_Item(Self);
end;

end.
