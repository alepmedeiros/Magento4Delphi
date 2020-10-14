unit Magento.MediaGalleryEntries;

interface

uses
  Magento.Interfaces, System.JSON;

type
  TMagentoMediaGalleryEntries = class (TInterfacedObject, iMagentoMediaGalleryEntries)
    private
      FParent : iMagentoEntidadeProduto;
      FJSON : TJSONObject;
      FJSONArray : TJSONArray;
    public
      constructor Create(Parent : iMagentoEntidadeProduto);
      destructor Destroy; override;
      class function New(Parent : iMagentoEntidadeProduto) : iMagentoMediaGalleryEntries;
      function MediaType(value : String) : iMagentoMediaGalleryEntries;
      function &Label(value : String) : iMagentoMediaGalleryEntries;
      function Position(value : Integer) : iMagentoMediaGalleryEntries;
      function Disabled(value : Boolean) : iMagentoMediaGalleryEntries;
      function &File(value : String) : iMagentoMediaGalleryEntries;
      function Types : iMagentoMediaGalleryEntries;
      function Content : iMagentoMediaGaleryContent; overload;
      function Content(value : TJSONObject) : iMagentoMediaGalleryEntries; overload;
      function &End : iMagentoEntidadeProduto;
  end;

implementation

{ TMagentoMediaGalleryEntries }

uses Magento.Factory;

function TMagentoMediaGalleryEntries.&End: iMagentoEntidadeProduto;
begin
  FJSONArray.Add(FJSON);

  FParent.MediaGalleryEntries(FJSONArray);
  Result := FParent;
end;

function TMagentoMediaGalleryEntries.&File(
  value: String): iMagentoMediaGalleryEntries;
begin
  Result := Self;
  FJSON.AddPair('file', value);
end;

function TMagentoMediaGalleryEntries.&Label(
  value: String): iMagentoMediaGalleryEntries;
begin
  Result := Self;
  FJSON.AddPair('label', value);
end;

function TMagentoMediaGalleryEntries.Content(
  value: TJSONObject): iMagentoMediaGalleryEntries;
begin
  Result := Self;
  FJSON.AddPair('content',value);
end;

function TMagentoMediaGalleryEntries.Content: iMagentoMediaGaleryContent;
begin
  Result := TMagentoFactory.New.MediaGalleryContent(Self);
end;

constructor TMagentoMediaGalleryEntries.Create(Parent : iMagentoEntidadeProduto);
begin
  FParent := Parent;
  FJSON := TJSONObject.Create;
  FJSONArray := TJSONArray.Create;
end;

destructor TMagentoMediaGalleryEntries.Destroy;
begin

  inherited;
end;

function TMagentoMediaGalleryEntries.Disabled(
  value: Boolean): iMagentoMediaGalleryEntries;
begin
  Result := Self;
  FJSON.AddPair('disabled', TJSONBool.Create(value));
end;

function TMagentoMediaGalleryEntries.MediaType(
  value: String): iMagentoMediaGalleryEntries;
begin
  Result := Self;
  FJSON.AddPair('mediaType', value);
end;

class function TMagentoMediaGalleryEntries.New(Parent : iMagentoEntidadeProduto) : iMagentoMediaGalleryEntries;
begin
  Result := self.Create(Parent);
end;

function TMagentoMediaGalleryEntries.Position(
  value: Integer): iMagentoMediaGalleryEntries;
begin
  Result := Self;
  FJSON.AddPair('position', TJSONNumber.Create(value));
end;

function TMagentoMediaGalleryEntries.Types: iMagentoMediaGalleryEntries;
var
  lJSONArray : TJSONArray;
begin
  Result := Self;
  lJSONArray := TJSONArray.Create;
  lJSONArray.Add('image');
  lJSONArray.Add('thumbnail');
  lJSONArray.Add('small_image');
  FJSON.AddPair('types', lJSONArray);
end;

end.
