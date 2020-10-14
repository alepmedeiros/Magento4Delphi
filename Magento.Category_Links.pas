unit Magento.Category_Links;

interface

uses
  Magento.Interfaces, System.JSON;

type
  TMagentoCategory_Links = class (TInterfacedObject, iMagentoCategory_Links)
    private
      FParent : iMagentoExtensionAttributes;
      FJSONArray : TJSONArray;
      FJSON : TJSONObject;
    public
      constructor Create(Parent : iMagentoExtensionAttributes);
      destructor Destroy; override;
      class function New(Parent : iMagentoExtensionAttributes) : iMagentoCategory_Links;
      function Position(value : Integer) : iMagentoCategory_Links;
      function Category_id(value : String) : iMagentoCategory_Links;
      function Continuos : iMagentoCategory_Links;
      function &End : iMagentoExtensionAttributes;
  end;

implementation

{ TMagentoCategory_Links }

uses Magento.Factory;

function TMagentoCategory_Links.Category_id(
  value: String): iMagentoCategory_Links;
begin
  Result := Self;
  FJSON.AddPair('category_id',value);
end;

function TMagentoCategory_Links.&End: iMagentoExtensionAttributes;
begin
  FJSONArray.Add(FJSON);

  FParent.Category_Links(FJSONArray);
  Result := FParent;
end;

function TMagentoCategory_Links.Continuos: iMagentoCategory_Links;
begin
  Result := Self;
  FJSONArray.Add(FJSON);
  FJSON := TJSONObject.Create;
end;

constructor TMagentoCategory_Links.Create(Parent : iMagentoExtensionAttributes);
begin
  FParent := Parent;
  FJSONArray := TJSONArray.Create;
  FJSON := TJSONObject.Create;
end;

destructor TMagentoCategory_Links.Destroy;
begin

  inherited;
end;

class function TMagentoCategory_Links.New(Parent : iMagentoExtensionAttributes) : iMagentoCategory_Links;
begin
  Result := self.Create(Parent);
end;

function TMagentoCategory_Links.Position(
  value: Integer): iMagentoCategory_Links;
begin
  Result := Self;
  FJSON.AddPair('position',TJSONNumber.Create(value));
end;

end.
