unit Magento.Stock_Item;

interface

uses
  Magento.Interfaces, System.JSON;

type
  TMagentoStock_Item = class (TInterfacedObject, iMagentoStock_Item)
    private
      FParent : iMagentoExtensionAttributes;
      FJSON : TJSONObject;
    public
      constructor Create(Parent : iMagentoExtensionAttributes);
      destructor Destroy; override;
      class function New(Parent : iMagentoExtensionAttributes) : iMagentoStock_Item;
      function Qty(value : integer) : iMagentoStock_Item;
      function Is_in_stock(value : boolean) : iMagentoStock_Item;
      function &End : iMagentoExtensionAttributes;
  end;

implementation

{ TMagentoStock_Item }

uses Magento.Factory;

function TMagentoStock_Item.&End: iMagentoExtensionAttributes;
begin
  FParent.Stock_item(FJSON);
  Result := FParent;
end;

constructor TMagentoStock_Item.Create(Parent : iMagentoExtensionAttributes);
begin
  FJSON := TJSONObject.Create;
  FParent := Parent;
end;

destructor TMagentoStock_Item.Destroy;
begin
//  FJSON.DisposeOf;
  inherited;
end;

function TMagentoStock_Item.Is_in_stock(value: boolean): iMagentoStock_Item;
begin
  Result := Self;
  FJSON.AddPair('is_in_stock', TJSONBool.Create(value));
end;

class function TMagentoStock_Item.New(Parent : iMagentoExtensionAttributes) : iMagentoStock_Item;
begin
  Result := self.Create(Parent);
end;

function TMagentoStock_Item.Qty(value: integer): iMagentoStock_Item;
begin
  Result := Self;
  FJSON.AddPair('qty',TJSONNumber.Create(value));
end;

end.
