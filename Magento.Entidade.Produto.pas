unit Magento.Entidade.Produto;

interface

uses
  Magento.Interfaces, System.JSON, System.SysUtils,
  System.Generics.Collections;

type
  TMagentoEntidadeProduto = class (TInterfacedObject, iMagentoEntidadeProduto)
    private
      FJSON : TJSONObject;
      FJSONProduct : TJSONObject;
      FJSONArray : TJSONArray;
      FSku : String;
      FName : String;
      FAttribute_set_id : String;
      FPrice : Real;
      FStatus : Integer;
      FVisibility : Integer;
      FType_id : TTipoProduto;
      FWeight : String;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMagentoEntidadeProduto;
      function NewProduto : iMagentoEntidadeProduto;
      function Sku(value : String) : iMagentoEntidadeProduto;
      function Name(value : String) : iMagentoEntidadeProduto;
      function Attribute_set_id(value : Integer) : iMagentoEntidadeProduto;
      function Price(value : Real) : iMagentoEntidadeProduto;
      function Status(value : Boolean) : iMagentoEntidadeProduto;
      function Visibility(value : Boolean) : iMagentoEntidadeProduto;
      function Type_id(value : TTipoProduto) : iMagentoEntidadeProduto;
      function Weight(value : String) : iMagentoEntidadeProduto;
      function Extension_attributes : iMagentoExtensionAttributes; overload;
      function Extension_attributes(value : TJSONObject) : iMagentoEntidadeProduto; overload;
      function Custom_attributes : iMagnetoCustom_attributes; overload;
      function Custom_attributes(value : TJSONArray) : iMagentoEntidadeProduto; overload;
      function Custom_attributes(value : TDictionary<String,String>) : iMagentoEntidadeProduto; overload;
      function MediaGalleryEntries : iMagentoMediaGalleryEntries; overload;
      function MediaGalleryEntries(value : TJSONArray) : iMagentoEntidadeProduto; overload;
      function &End : TJSONObject;
  end;

implementation

{ TMagentoEntidadeProduto }

uses Magento.Factory;

function TMagentoEntidadeProduto.Attribute_set_id(
  value: Integer): iMagentoEntidadeProduto;
begin
  Result := Self;
  FJSON.AddPair('attribute_set_id',TJSONNumber.Create(value));
end;

function TMagentoEntidadeProduto.&End: TJSONObject;
begin
  Result := TJSONObject.Create.AddPair('product', FJSON);
end;

function TMagentoEntidadeProduto.Extension_attributes(
  value: TJSONObject): iMagentoEntidadeProduto;
begin
  Result := Self;
  FJSON.AddPair('extension_attributes', value);
end;

function TMagentoEntidadeProduto.MediaGalleryEntries(
  value: TJSONArray): iMagentoEntidadeProduto;
begin
  Result := Self;
  FJSON.AddPair('mediaGalleryEntries', value);
end;

function TMagentoEntidadeProduto.MediaGalleryEntries: iMagentoMediaGalleryEntries;
begin
  Result := TMagentoFactory.New.MediaGalleryEntries(Self);
end;

constructor TMagentoEntidadeProduto.Create;
begin
  FJSON := TJSONObject.Create;
end;

function TMagentoEntidadeProduto.Custom_attributes(
  value: TDictionary<String, String>): iMagentoEntidadeProduto;
var
  Key : String;
  lJSONArray : TJSONArray;
  lJSON : TJSONObject;
begin
  Result := Self;

  lJSONArray := TJSONArray.Create;
  for Key in Value.Keys do
  begin
    lJSON := TJSONObject.Create;
    lJSON.AddPair('attribute_code',key);
    lJSON.AddPair('value',Value.Items[key]);
    lJSONArray.Add(lJSON);
  end;
  FJSON.AddPair('custom_attributes',lJSONArray);
end;

function TMagentoEntidadeProduto.Custom_attributes: iMagnetoCustom_attributes;
begin
  Result := TMagentoFactory.New.Custom_attributes(self);
end;

function TMagentoEntidadeProduto.Custom_attributes(
  value: TJSONArray): iMagentoEntidadeProduto;
begin
  Result := Self;
  FJSON.AddPair('custom_attributes', value);
end;

destructor TMagentoEntidadeProduto.Destroy;
begin
  FJSON.DisposeOf;
  inherited;
end;

function TMagentoEntidadeProduto.Extension_attributes: iMagentoExtensionAttributes;
begin
  Result := TMagentoFactory.New.ExtensionAttributes(Self);
end;

function TMagentoEntidadeProduto.NewProduto: iMagentoEntidadeProduto;
begin
  Result := Self;
end;

class function TMagentoEntidadeProduto.New: iMagentoEntidadeProduto;
begin
  Result := self.Create;
end;

function TMagentoEntidadeProduto.Name(value: String): iMagentoEntidadeProduto;
begin
  Result := Self;
  FJSON.AddPair('name',value);
end;

function TMagentoEntidadeProduto.Price(value: Real): iMagentoEntidadeProduto;
begin
  Result := Self;
  FJSON.AddPair('price',TJSONNumber.Create(value));
end;

function TMagentoEntidadeProduto.Sku(value: String): iMagentoEntidadeProduto;
begin
  Result := Self;
  FJSON.AddPair('sku',value);
end;

function TMagentoEntidadeProduto.Status(value : Boolean) : iMagentoEntidadeProduto;
begin
  Result := Self;
  if Value then
    FJSON.AddPair('status', TJSONNumber.Create(1));
end;

function TMagentoEntidadeProduto.Type_id(
  value: TTipoProduto): iMagentoEntidadeProduto;
var
  lTipo : String;
begin
  Result := Self;
  lTipo := LowerCase(TTipoProduto(value).ToString);
  FJSON.AddPair('type_id',Copy(lTipo,3,Length(lTipo)));
end;

function TMagentoEntidadeProduto.Visibility(value : Boolean) : iMagentoEntidadeProduto;
begin
  Result := Self;
  if Value then
    FJSON.AddPair('visibility', TJSONNumber.Create(4));
end;

function TMagentoEntidadeProduto.Weight(value: String): iMagentoEntidadeProduto;
begin
  Result := Self;
  FJSON.AddPair('weight', value);
end;

end.
