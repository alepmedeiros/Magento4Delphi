unit MagentoHTTP;

interface

uses
  REST.Response.Adapter, Data.DB, Datasnap.DBClient, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, Magento.Interfaces,
  System.Classes;

type
  TMagentoHTTP = class (TInterfacedObject, iMagentoHTTP)
    private
      FRestClient: TRESTClient;
      FRestRequest: TRESTRequest;
      FRestResponse: TRESTResponse;
      FField : String;
      FValue : String;
      FCondition_Type : String;
      FURI : String;
      FStatus : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMagentoHTTP;
      function GetAtributo : String;
      function GetAtributoID(Value : String) : String;
      function PostAttribute(Value : String) : iMagentoHTTP;
      function Field(Value : String) : iMagentoHTTP;
      function Value(aValue : String) : iMagentoHTTP;
      function Condition_type(Value : String) : iMagentoHTTP;
      function GetCatagorias : String;
      function PostCategorias(Value : String) : iMagentoHTTP;
      function GetPedidos : String;
      function PostProduto(value : TJSONObject) : iMagentoHTTP; overload;
      function PostProduto(value : TStringList) : iMagentoHTTP; overload;
      function Status : Integer;
  end;

implementation

{ TMagentoHTTP }

uses ServerMagento.Model.Env, System.SysUtils;

function TMagentoHTTP.Condition_type(Value: String): iMagentoHTTP;
begin
  Result := Self;
  FCondition_Type := Value;
end;

constructor TMagentoHTTP.Create;
begin

end;

destructor TMagentoHTTP.Destroy;
begin

  inherited;
end;

function TMagentoHTTP.Field(Value: String): iMagentoHTTP;
begin
  Result := Self;
  FField := Value;
end;

function TMagentoHTTP.GetAtributo: String;
begin
  FURI := '';
  FURI := API +
        '/eav/attribute-sets/list?searchCriteria[filterGroups][0]'+
        '[filters][0][field]=attribute_set_name&searchCriteria[filterGroups]'+
        '[0][filters][0][value]=&searchCriteria[filterGroups][0][filters][0][conditionType]=neq';
  try
    FRestClient := TRESTClient.Create(FURI);
    FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    FRestClient.AcceptEncoding := '';
    FRestClient.AutoCreateParams := true;
    FRestClient.AllowCookies := True;
    FRestClient.BaseURL := FURI;
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
    FRestRequest.Method := rmGET;
    FRestRequest.SynchronizedEvents := False;
    FRestRequest.Response := FRestResponse;

    FRestRequest.Params.Add;
    FRestRequest.Params[0].ContentType := ctNone;
    FRestRequest.Params[0].Kind := pkHTTPHEADER;
    FRestRequest.Params[0].Name := 'Authorization';
    FRestRequest.Params[0].Value := 'Bearer ' + ACCES_TOKEN;
    FRestRequest.Params[0].Options := [poDoNotEncode];
    FRestRequest.Execute;

    Result := FRestResponse.Content;
    FStatus := FRestResponse.StatusCode;
  except

  end;
end;

function TMagentoHTTP.GetAtributoID(Value: String): String;
begin
  FURI := '';
  FURI := API + '/products/attribute-sets/'+Value+'/attributes';
  try
    FRestClient := TRESTClient.Create(FURI);
    FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    FRestClient.AcceptEncoding := '';
    FRestClient.AutoCreateParams := true;
    FRestClient.AllowCookies := True;
    FRestClient.BaseURL := FURI;
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
    FRestRequest.Method := rmGET;
    FRestRequest.SynchronizedEvents := False;
    FRestRequest.Response := FRestResponse;

    FRestRequest.Params.Add;
    FRestRequest.Params[0].ContentType := ctNone;
    FRestRequest.Params[0].Kind := pkHTTPHEADER;
    FRestRequest.Params[0].Name := 'Authorization';
    FRestRequest.Params[0].Value := 'Bearer ' + ACCES_TOKEN;
    FRestRequest.Params[0].Options := [poDoNotEncode];
    FRestRequest.Execute;

    Result := FRestResponse.Content;

    FStatus := FRestResponse.StatusCode;
  except

  end;
end;

function TMagentoHTTP.GetCatagorias: String;
begin
  FURI := '';
  FURI := API + '/categories?'+
    'searchCriteria[filter_groups][0][filters][0][field]=id&'+
    'searchCriteria[filter_groups][0][filters][0][value]=1&'+
    'searchCriteria[filter_groups][0][filters][0][condition_type]=gte';
  try
    FRestClient := TRESTClient.Create(FURI);
    FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    FRestClient.AcceptEncoding := '';
    FRestClient.AutoCreateParams := true;
    FRestClient.AllowCookies := True;
    FRestClient.BaseURL := FURI;
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
    FRestRequest.Method := rmGET;
    FRestRequest.SynchronizedEvents := False;
    FRestRequest.Response := FRestResponse;

    FRestRequest.Params.Add;
    FRestRequest.Params[0].ContentType := ctNone;
    FRestRequest.Params[0].Kind := pkHTTPHEADER;
    FRestRequest.Params[0].Name := 'Authorization';
    FRestRequest.Params[0].Value := 'Bearer ' + ACCES_TOKEN;
    FRestRequest.Params[0].Options := [poDoNotEncode];
    FRestRequest.Execute;

    Result := FRestResponse.Content;

    FStatus := FRestResponse.StatusCode;
  except

  end;
end;

function TMagentoHTTP.GetPedidos: String;
begin
  FURI := '';
  FURI := API + '/orders?searchCriteria[filterGroups][0][filters][0][field]=entity_id'+
        '&searchCriteria[filterGroups][0][filters][0][value]='+
        '&searchCriteria[filterGroups][0][filters][0][conditionType]=neq';
  try
    FRestClient := TRESTClient.Create(FURI);
    FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    FRestClient.AcceptEncoding := '';
    FRestClient.AutoCreateParams := true;
    FRestClient.AllowCookies := True;
    FRestClient.BaseURL := FURI;
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
    FRestRequest.Method := rmGET;
    FRestRequest.SynchronizedEvents := False;
    FRestRequest.Response := FRestResponse;

    FRestRequest.Params.Add;
    FRestRequest.Params[0].ContentType := ctNone;
    FRestRequest.Params[0].Kind := pkHTTPHEADER;
    FRestRequest.Params[0].Name := 'Authorization';
    FRestRequest.Params[0].Value := 'Bearer ' + ACCES_TOKEN;
    FRestRequest.Params[0].Options := [poDoNotEncode];
    FRestRequest.Execute;

    Result := FRestResponse.Content;

    FStatus := FRestResponse.StatusCode;
  except

  end;
end;

class function TMagentoHTTP.New: iMagentoHTTP;
begin
  Result := self.Create;
end;

function TMagentoHTTP.PostAttribute(Value: String): iMagentoHTTP;
begin
  Result := Self;
  FURI := '';
  FURI := API + '/products/attribute-sets';
  try
    FRestClient := TRESTClient.Create(FURI);
    FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    FRestClient.AcceptEncoding := '';
    FRestClient.AutoCreateParams := true;
    FRestClient.AllowCookies := True;
    FRestClient.BaseURL := FURI;
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
    FRestRequest.Method := rmPOST;
    FRestRequest.SynchronizedEvents := False;
    FRestRequest.Response := FRestResponse;

    FRestRequest.Params.Add;
    FRestRequest.Params[0].ContentType := ctNone;
    FRestRequest.Params[0].Kind := pkHTTPHEADER;
    FRestRequest.Params[0].Name := 'Authorization';
    FRestRequest.Params[0].Value := 'Bearer ' + ACCES_TOKEN;
    FRestRequest.Params[0].Options := [poDoNotEncode];

    FRestRequest.Params.Add;
    FRestRequest.Params[1].ContentType := ctAPPLICATION_JSON;
    FRestRequest.Params[1].Kind := pkREQUESTBODY;
    FRestRequest.Params[1].Name := 'body';
    FRestRequest.Params[1].Value := value;
    FRestRequest.Params[1].Options := [poDoNotEncode];
    FRestRequest.Execute;

    FStatus := FRestResponse.StatusCode;
  except

  end;
end;

function TMagentoHTTP.PostCategorias(Value: String): iMagentoHTTP;
begin
  Result := Self;
  FURI := '';
  FURI := API + '/categories';
  try
    FRestClient := TRESTClient.Create(FURI);
    FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    FRestClient.AcceptEncoding := '';
    FRestClient.AutoCreateParams := true;
    FRestClient.AllowCookies := True;
    FRestClient.BaseURL := FURI;
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
    FRestRequest.Method := rmPOST;
    FRestRequest.SynchronizedEvents := False;
    FRestRequest.Response := FRestResponse;

    FRestRequest.Params.Add;
    FRestRequest.Params[0].ContentType := ctNone;
    FRestRequest.Params[0].Kind := pkHTTPHEADER;
    FRestRequest.Params[0].Name := 'Authorization';
    FRestRequest.Params[0].Value := 'Bearer ' + ACCES_TOKEN;
    FRestRequest.Params[0].Options := [poDoNotEncode];

    FRestRequest.Params.Add;
    FRestRequest.Params[1].ContentType := ctAPPLICATION_JSON;
    FRestRequest.Params[1].Kind := pkREQUESTBODY;
    FRestRequest.Params[1].Name := 'body';
    FRestRequest.Params[1].Value := value;
    FRestRequest.Params[1].Options := [poDoNotEncode];
    FRestRequest.Execute;

    FStatus := FRestResponse.StatusCode;
  except

  end;
end;

function TMagentoHTTP.PostProduto(value: TStringList): iMagentoHTTP;
var
  i:integer;
  aux:TStringList;
begin
  Result := Self;
  FURI := '';
  FURI := API + '/products';

  aux:=TStringList.Create;

  for I := 0 to Pred(value.Count) do
  begin
    try
      FRestClient := TRESTClient.Create(FURI);
      FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
      FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
      FRestClient.AcceptEncoding := '';
      FRestClient.AutoCreateParams := true;
      FRestClient.AllowCookies := True;
      FRestClient.BaseURL := FURI;
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
      FRestRequest.Method := rmPOST;
      FRestRequest.SynchronizedEvents := False;
      FRestRequest.Response := FRestResponse;

      FRestRequest.Params.Add;
      FRestRequest.Params[0].ContentType := ctNone;
      FRestRequest.Params[0].Kind := pkHTTPHEADER;
      FRestRequest.Params[0].Name := 'Authorization';
      FRestRequest.Params[0].Value := 'Bearer ' + ACCES_TOKEN;
      FRestRequest.Params[0].Options := [poDoNotEncode];

      FRestRequest.Params.Add;
      FRestRequest.Params[1].ContentType := ctAPPLICATION_JSON;
      FRestRequest.Params[1].Kind := pkREQUESTBODY;
      FRestRequest.Params[1].Name := 'body';
      FRestRequest.Params[1].Value := value.Strings[I];
      FRestRequest.Params[1].Options := [poDoNotEncode];
      FRestRequest.Execute;

      FStatus := FRestResponse.StatusCode;
    except

    end;
  end;
end;

function TMagentoHTTP.PostProduto(value: TJSONObject): iMagentoHTTP;
begin
  Result := Self;
  FURI := '';
  FURI := API + '/products';
  try
    FRestClient := TRESTClient.Create(FURI);
    FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    FRestClient.AcceptEncoding := '';
    FRestClient.AutoCreateParams := true;
    FRestClient.AllowCookies := True;
    FRestClient.BaseURL := FURI;
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
    FRestRequest.Method := rmPOST;
    FRestRequest.SynchronizedEvents := False;
    FRestRequest.Response := FRestResponse;

    FRestRequest.Params.Add;
    FRestRequest.Params[0].ContentType := ctNone;
    FRestRequest.Params[0].Kind := pkHTTPHEADER;
    FRestRequest.Params[0].Name := 'Authorization';
    FRestRequest.Params[0].Value := 'Bearer ' + ACCES_TOKEN;
    FRestRequest.Params[0].Options := [poDoNotEncode];

    FRestRequest.Params.Add;
    FRestRequest.Params[1].ContentType := ctAPPLICATION_JSON;
    FRestRequest.Params[1].Kind := pkREQUESTBODY;
    FRestRequest.Params[1].Name := 'body';
    FRestRequest.Params[1].Value := value.ToString;
    FRestRequest.Params[1].Options := [poDoNotEncode];
    FRestRequest.Execute;

    FStatus := FRestResponse.StatusCode;
  except

  end;
end;

function TMagentoHTTP.Status: Integer;
begin
  Result := FStatus;
end;

function TMagentoHTTP.Value(aValue: String): iMagentoHTTP;
begin
  Result := Self;
  FValue := aValue;
end;

end.
