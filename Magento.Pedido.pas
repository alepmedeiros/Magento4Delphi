unit Magento.Pedido;

interface

uses
  Magento.Interfaces, Data.DB;

type
  TMagentoPedido = class (TInterfacedObject, iMagentoPedido)
    private

    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMagentoPedido;
      function ListaFaturado(Value : TDataSet) : iMagentoPedido;
      function ListaItensPedito(Value : TDataSet) : iMagentoPedido;
  end;

implementation

uses
  System.JSON, REST.Response.Adapter, Magento.Factory, System.SysUtils;

{ TMagentoPedido }

constructor TMagentoPedido.Create;
begin

end;

destructor TMagentoPedido.Destroy;
begin

  inherited;
end;

function TMagentoPedido.ListaFaturado(Value: TDataSet): iMagentoPedido;
var
  lJSONObj, lSubObj, Obj : TJSONObject;
  lJSONArray, lArrayFatu : TJSONArray;

  lConv : TCustomJSONDataSetAdapter;
  lJSON : String;
  I, J: Integer;
begin
  Result := Self;

  lJSON := TMagentoFactory.New.MagentoHTTP.GetPedidos;

  lJSONObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(lJSON), 0) as TJSONObject;
  lConv := TCustomJSONDataSetAdapter.Create(nil);

  lJSONArray := lJSONObj.Get('items').JsonValue as TJSONArray;

  lArrayFatu := TJSONArray.Create;
  for I := 0 to lJSONArray.Size-1 do
  begin
    lSubObj := (lJSONArray.Get(i) as TJSONObject);

    Obj := TJSONObject.Create;
    for J := 0 to lSubObj.Size-1 do
    begin
      if lSubObj.Get(J).JsonString.Value='items' then
        Break;
      Obj.AddPair(lSubObj.Get(J).JsonString.Value,lSubObj.Get(J).JsonValue.Value);
    end;
    lArrayFatu.Add(Obj);
  end;

  try
    lConv.DataSet := Value;
    lConv.UpdateDataSet(lArrayFatu);
  finally
    lConv.Free;
  end;
end;

function TMagentoPedido.ListaItensPedito(Value: TDataSet): iMagentoPedido;
var
  lJSONObj, lSubObj, Obj,lobj : TJSONObject;
  lJSONArray, lArrayItens, lArray : TJSONArray;

  lConv : TCustomJSONDataSetAdapter;
  lJSON : String;
  I, J, L: Integer;
begin
  Result := Self;

  lJSON := TMagentoFactory.New.MagentoHTTP.GetPedidos;

  lJSONObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(lJSON), 0) as TJSONObject;
  lConv := TCustomJSONDataSetAdapter.Create(nil);

  lJSONArray := lJSONObj.Get('items').JsonValue as TJSONArray;

  lArrayItens := TJSONArray.Create;
  for I := 0 to lJSONArray.Size-1 do
  begin
    lSubObj := (lJSONArray.Get(i) as TJSONObject);

    lArray := lSubObj.Get('items').JsonValue as TJSONArray;

    for J := 0 to lArray.Size-1 do
    begin
      lobj := (lArray.Get(J) as TJSONObject);

      lobj.ToString;

      Obj := TJSONObject.Create;
      for L := 0 to lobj.Size-1 do
      begin
        Obj.AddPair(lobj.Get(L).JsonString.Value,lobj.Get(L).JsonValue.Value);
      end;
      lArrayItens.Add(Obj);
    end;
  end;

  try
    lConv.DataSet := Value;
    lConv.UpdateDataSet(lArrayItens);
  finally
    lConv.Free;
  end;
end;

class function TMagentoPedido.New: iMagentoPedido;
begin
  Result := self.Create;
end;

end.
