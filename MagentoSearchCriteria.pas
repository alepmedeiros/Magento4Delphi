unit MagentoSearchCriteria;

interface

uses
  Magento.Interfaces;

type
  TMagentoSearchCriteria = class (TInterfacedObject, iMagentoSearchCriteria)
    private
      FParent : iMagentoHTTP_V1;
      FField : String;
      FValue : String;
      FCondition_Type : String;
      FAndOr : Boolean;
    public
      constructor Create(Parent : iMagentoHTTP_V1);
      destructor Destroy; override;
      class function New(Parent : iMagentoHTTP_V1) : iMagentoSearchCriteria;
      function Field(Value : String) : iMagentoSearchCriteria;
      function Value(aValue : String) : iMagentoSearchCriteria;
      function Condition_type(Value : String) : iMagentoSearchCriteria;
      function AndOr(Value : Boolean) : iMagentoSearchCriteria;
      function Get(Value : String) : iMagentoSearchCriteria; overload;
      function &End : iMagentoHTTP_V1;
  end;

implementation

{ TMagentoSearchCriteria }

function TMagentoSearchCriteria.AndOr(Value: Boolean): iMagentoSearchCriteria;
begin
  Result := Self;
  FAndOr := Value;
end;

function TMagentoSearchCriteria.Condition_type(
  Value: String): iMagentoSearchCriteria;
begin
  Result := Self;
  FCondition_Type := Value;
end;

function TMagentoSearchCriteria.&End: iMagentoHTTP_V1;
begin
  Result := FParent;
end;

constructor TMagentoSearchCriteria.Create(Parent : iMagentoHTTP_V1);
begin
  FParent := Parent;
end;

destructor TMagentoSearchCriteria.Destroy;
begin

  inherited;
end;

function TMagentoSearchCriteria.Field(Value: String): iMagentoSearchCriteria;
begin
  Result := Self;
  FField := Value;
end;

function TMagentoSearchCriteria.Get(Value: String): iMagentoSearchCriteria;
begin
  Result := Self;
end;

class function TMagentoSearchCriteria.New(Parent : iMagentoHTTP_V1) : iMagentoSearchCriteria;
begin
  Result := self.Create(Parent);
end;

function TMagentoSearchCriteria.Value(aValue: String): iMagentoSearchCriteria;
begin
  Result := Self;
  FValue := aValue;
end;

end.
