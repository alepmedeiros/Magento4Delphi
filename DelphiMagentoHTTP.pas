unit DelphiMagentoHTTP;

interface

uses
  REST.Response.Adapter, Data.DB, Datasnap.DBClient, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, Magento.Interfaces;

type
  TModelMagentoHTTP = class (TInterfacedObject, iMagentoHTTP)
    private
      FRestClient: TRESTClient;
      FRestRequest: TRESTRequest;
      FRestResponse: TRESTResponse;
      FBody : String;
      procedure DefineEndPoint(URI : String; EndPoint : TRESTRequestMethod);
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMagentoHTTP;
      function GetAtributo : String;
      function Field(Value : String) : iMagentoHTTP;
      function Value(aValue : String) : iMagentoHTTP;
      function Condition_type(Value : String) : iMagentoHTTP;
      function GetCatagorias : String;
      function PostProduto(value : String) : iMagentoHTTP;
  end;

implementation

{ TModelMagentoHTTP }

function TModelMagentoHTTP.Condition_type(Value: String): iMagentoHTTP;
begin

end;

constructor TModelMagentoHTTP.Create;
begin

end;

destructor TModelMagentoHTTP.Destroy;
begin

  inherited;
end;

function TModelMagentoHTTP.Field(Value: String): iMagentoHTTP;
begin

end;

function TModelMagentoHTTP.GetAtributo: String;
begin

end;

function TModelMagentoHTTP.GetCatagorias: String;
begin

end;

class function TModelMagentoHTTP.New: iMagentoHTTP;
begin
  Result := self.Create;
end;

function TModelMagentoHTTP.PostProduto(value: String): iMagentoHTTP;
begin
  FBody := Value;
  DefineEndPoint('http://192.168.1.66/magento2/rest/V1/products', rmPOST);
end;

function TModelMagentoHTTP.Value(aValue: String): iMagentoHTTP;
begin

end;

procedure TModelMagentoHTTP.DefineEndPoint(URI : String; EndPoint : TRESTRequestMethod);
begin
  FRestClient := TRESTClient.Create(URI);
  FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestClient.AcceptEncoding := '';
  FRestClient.AutoCreateParams := true;
  FRestClient.AllowCookies := True;
  FRestClient.BaseURL := URI;
  FRestClient.ContentType := '';
  FRestClient.FallbackCharsetEncoding := 'utf-8';
  FRestClient.HandleRedirects := True;
  FRestResponse := TRESTResponse.Create(FRestClient);
  FRestResponse.ContentType := 'application/json';
  FRestRequest := TRESTRequest.Create(FRestClient);
  FRestRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestRequest.AcceptEncoding := '';
  FRestRequest.AutoCreateParams := true;
  FRestRequest.Client := FRestClient;
  FRestRequest.Method := EndPoint;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.Response := FRestResponse;
  FRestRequest.Params.Add;
  FRestRequest.Params[0].ContentType := ctNone;
  FRestRequest.Params[0].Kind := pkHTTPHEADER;
  FRestRequest.Params[0].Name := 'Authorization';
  FRestRequest.Params[0].Value := 'Bearer sgb5tdt944r6n4g18pvcdc6dplfx26vn';
  FRestRequest.Params[0].Options := [poDoNotEncode];

  if EndPoint = rmPOST then
  begin
    FRestRequest.Params.Add;
    FRestRequest.Params[1].ContentType := ctAPPLICATION_JSON;
    FRestRequest.Params[1].Kind := pkREQUESTBODY;
    FRestRequest.Params[1].Name := 'body';
    FRestRequest.Params[1].Value := FBody;
    FRestRequest.Params[1].Options := [poDoNotEncode];
  end;
  FRestRequest.Execute;
end;

end.
