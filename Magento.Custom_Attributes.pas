unit Magento.Custom_Attributes;

interface

uses
  Magento.Interfaces, System.JSON;

type
  TMagnetoCustom_attributes = class (TInterfacedObject, iMagnetoCustom_attributes)
    private
      FParent : iMagentoEntidadeProduto;
      FJSON : TJSONObject;
      FJSONArray : TJSONArray;
    public
      constructor Create(Parent : iMagentoEntidadeProduto);
      destructor Destroy; override;
      class function New(Parent : iMagentoEntidadeProduto) : iMagnetoCustom_attributes;
      function Attribute_code(value : String) : iMagnetoCustom_attributes;
      function Value(aValue : String) : iMagnetoCustom_attributes;
      function Continuos : iMagnetoCustom_attributes;
      function &End : iMagentoEntidadeProduto;
  end;

implementation

{ TMagnetoCustom_attributes }

uses Magento.Factory;

function TMagnetoCustom_attributes.Attribute_code(
  value: String): iMagnetoCustom_attributes;
begin
  Result := Self;
  FJSON.AddPair('attribute_code',value);
end;

function TMagnetoCustom_attributes.&End: iMagentoEntidadeProduto;
begin
  FJSONArray.Add(FJSON);

  FParent.Custom_attributes(FJSONArray);
  Result := FParent;
end;

function TMagnetoCustom_attributes.Continuos: iMagnetoCustom_attributes;
begin
  Result := Self;
  FJSONArray.Add(FJSON);
  FJSON := TJSONObject.Create;
end;

constructor TMagnetoCustom_attributes.Create(Parent : iMagentoEntidadeProduto);
begin
  FParent := Parent;

  FJSON := TJSONObject.Create;
  FJSONArray := TJSONArray.Create;
end;

destructor TMagnetoCustom_attributes.Destroy;
begin

  inherited;
end;

class function TMagnetoCustom_attributes.New(Parent : iMagentoEntidadeProduto) : iMagnetoCustom_attributes;
begin
  Result := self.Create(Parent);
end;

function TMagnetoCustom_attributes.Value(
  aValue: String): iMagnetoCustom_attributes;
begin
  Result := Self;
  FJSON.AddPair('value', aValue);
end;

end.
