unit Magento.GalleryContent;

interface

uses
  Magento.Interfaces, System.JSON, IdCoderMIME;

type
  TMagentoMediaGaleryContent = class (TInterfacedObject, iMagentoMediaGaleryContent)
    private
      FParent : iMagentoMediaGalleryEntries;
      FJSON : TJSONObject;
      FJSONArray : TJSONArray;
      function Base64_Encoding(FileName : String) : String;
    public
      constructor Create(Parent : iMagentoMediaGalleryEntries);
      destructor Destroy; override;
      class function New(Parent : iMagentoMediaGalleryEntries) : iMagentoMediaGaleryContent;
      function Base64EncodedData(value : String) : iMagentoMediaGaleryContent; //passar somente o caminho da imagem
      function &Type(value : string) : iMagentoMediaGaleryContent;//passar o tipo da imagem png,gif,bpm e jpeg(jpg)
      function Name(value : String) : iMagentoMediaGaleryContent;
      function &End : iMagentoMediaGalleryEntries;
  end;

implementation

uses
  System.Classes, System.SysUtils;

{ TMagentoMediaGaleryContent }

function TMagentoMediaGaleryContent.Base64EncodedData(
  value: String): iMagentoMediaGaleryContent;
begin
  Result := Self;
  FJSON.AddPair('base64EncodedData', Base64_Encoding(value));
end;

function TMagentoMediaGaleryContent.&End: iMagentoMediaGalleryEntries;
begin
  FJSONArray.Add(FJSON);

  FParent.Content(FJSON);
  Result := FParent;
end;

function TMagentoMediaGaleryContent.&Type(
  value: string): iMagentoMediaGaleryContent;
begin
  Result := Self;
  FJSON.AddPair('type',value);
end;

function TMagentoMediaGaleryContent.Base64_Encoding(FileName: String): String;
var
  stream: TFileStream;
  base64: TIdEncoderMIME;
  output: string;
begin
  Result := 'Error';
  if (FileExists(FileName)) then
  begin
    try
      base64 := TIdEncoderMIME.Create(nil);
      stream := TFileStream.Create(FileName, fmOpenRead);
      output := TIdEncoderMIME.EncodeStream(stream);
      stream.Free;
      base64.Free;
      if not(output = '') then
        Result := output
    except
      raise Exception.Create('Error convert image');
    end;
  end;
end;

constructor TMagentoMediaGaleryContent.Create(Parent : iMagentoMediaGalleryEntries);
begin
  FParent := Parent;
  FJSON := TJSONObject.Create;
  FJSONArray := TJSONArray.Create;
end;

destructor TMagentoMediaGaleryContent.Destroy;
begin

  inherited;
end;

function TMagentoMediaGaleryContent.Name(
  value: String): iMagentoMediaGaleryContent;
begin
  Result := Self;
  FJSON.AddPair('name', value);
end;

class function TMagentoMediaGaleryContent.New(Parent : iMagentoMediaGalleryEntries) : iMagentoMediaGaleryContent;
begin
  Result := self.Create(Parent);
end;

end.
