unit MagentoHTTP_V1;

interface

uses
  Magento.Interfaces, REST.Response.Adapter, Data.DB, Datasnap.DBClient, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TMagentoAPI = class (TInterfacedObject, iMagentoHTTP_V1)
    private
      FBody : String;
      FResult : String;
      FStatus : Integer;
      FField : String;
      FValue : String;
      FCondition_type : String;
      FAndOr : Boolean;
      FRestClient: TRESTClient;
      FRestRequest: TRESTRequest;
      FRestResponse: TRESTResponse;

      procedure RestHTTP(URI : String; vMethod : TRESTRequestMethod);
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMagentoHTTP_V1;
      function Get(Value : String) : iMagentoHTTP_V1;
      function Post(Value, Body : String) : iMagentoHTTP_V1;
      function Put(Value, Body : String) : iMagentoHTTP_V1;
      function Delete(Value, Body : String) : iMagentoHTTP_V1;
      function SearchCriteria : iMagentoSearchCriteria;
      function Status : Integer;
  end;

implementation

uses
  System.SysUtils, ServerMagento.Model.Env;

{ TMagentoAPI }

constructor TMagentoAPI.Create;
begin

end;

function TMagentoAPI.Delete(Value, Body : String) : iMagentoHTTP_V1;
begin
  Result := Self;
  FBody := Body;

  RestHTTP(Value, rmDELETE);
end;

destructor TMagentoAPI.Destroy;
begin

  inherited;
end;

function TMagentoAPI.Get(Value: String): iMagentoHTTP_V1;
begin
  Result := Self;

  RestHTTP(Value, rmGET);
end;

class function TMagentoAPI.New: iMagentoHTTP_V1;
begin

end;

function TMagentoAPI.Post(Value, Body : String) : iMagentoHTTP_V1;
begin
  Result := Self;
  FBody := Body;

  RestHTTP(Value, rmPOST);
end;

function TMagentoAPI.Put(Value, Body : String) : iMagentoHTTP_V1;
begin
  Result := Self;
  FBody := Body;

  RestHTTP(Value, rmPUT);
end;

procedure TMagentoAPI.RestHTTP(URI : String; vMethod : TRESTRequestMethod);
begin
  try
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
    FRestRequest.Method := vMethod;
    FRestRequest.SynchronizedEvents := False;
    FRestRequest.Response := FRestResponse;
    FRestRequest.Params.Add;
    FRestRequest.Params[0].ContentType := ctNone;
    FRestRequest.Params[0].Kind := pkHTTPHEADER;
    FRestRequest.Params[0].Name := 'Authorization';
    FRestRequest.Params[0].Value := 'Bearer ' + ACCES_TOKEN;
    FRestRequest.Params[0].Options := [poDoNotEncode];

    if vMethod <> rmGET then
    begin
      FRestRequest.Params.Add;
      FRestRequest.Params[1].ContentType := ctAPPLICATION_JSON;
      FRestRequest.Params[1].Kind := pkREQUESTBODY;
      FRestRequest.Params[1].Name := 'body';
      FRestRequest.Params[1].Value := FBody;
      FRestRequest.Params[1].Options := [poDoNotEncode];
      FRestRequest.Execute;
    end;

    FStatus := FRestResponse.StatusCode;

    FResult := FRestResponse.Content;
  except
    raise Exception.Create('Error');
  end;
end;

function TMagentoAPI.SearchCriteria: iMagentoSearchCriteria;
begin

end;

function TMagentoAPI.Status: Integer;
begin
  Result := FStatus;
end;

end.
