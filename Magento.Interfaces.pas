unit Magento.Interfaces;

interface

uses
  System.JSON, Data.DB, System.Generics.Collections, System.Classes;

type
  TTipoProduto = (tpConfigurable, tpSimple);

  TTipoProdutoHelper = record helper for TTipoProduto
    function ToString : String;
  end;

  iMagentoExtensionAttributes = interface;
  iMagentoCategory_Links = interface;
  iMagentoStock_Item = interface;
  iMagnetoCustom_attributes = interface;
  iMagentoMediaGalleryEntries = interface;
  iMagentoMediaGaleryContent = interface;
  iMagentoSearchCriteria = interface;


  iMagentoHTTP = interface
    ['{ADB73D98-6973-426B-A01B-E25338BB5860}']
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

  iMagentoHTTP_V1 = interface
    ['{53117502-9CED-4153-A6BA-1900D1B7B87C}']
    function Get(Value : String) : iMagentoHTTP_V1;
    function Post(Value, Body : String) : iMagentoHTTP_V1;
    function Put(Value, Body : String) : iMagentoHTTP_V1;
    function Delete(Value, Body : String) : iMagentoHTTP_V1;
    function SearchCriteria : iMagentoSearchCriteria;
    function Status : Integer;
  end;

  iMagentoSearchCriteria = interface
    ['{388244A1-89F7-400C-B080-24F25B1D1EEA}']
    function Field(Value : String) : iMagentoSearchCriteria;
    function Value(aValue : String) : iMagentoSearchCriteria;
    function Condition_type(Value : String) : iMagentoSearchCriteria;
    function AndOr(Value : Boolean) : iMagentoSearchCriteria;
    function Get(Value : String) : iMagentoSearchCriteria; overload;
    function &End : iMagentoHTTP_V1;
  end;

  iMagentoEntidadeProduto = interface
    ['{283FD3BA-0678-480E-AB8C-664D445765E1}']
    function NewProduto : iMagentoEntidadeProduto;
    function Sku(value : String) : iMagentoEntidadeProduto;
    function Name(value : String) : iMagentoEntidadeProduto;
    function Attribute_set_id(value : Integer) : iMagentoEntidadeProduto;
    function Price(value : Real) : iMagentoEntidadeProduto;
    function Status(value : Boolean) : iMagentoEntidadeProduto;
    function Visibility(value : Boolean) : iMagentoEntidadeProduto;
    function Type_id(value : TTipoProduto) : iMagentoEntidadeProduto;
    function Weight(value : String) : iMagentoEntidadeProduto;
    function Extension_attributes : iMagentoExtensionAttributes; overload;
    function Extension_attributes(value : TJSONObject) : iMagentoEntidadeProduto; overload;
    function Custom_attributes : iMagnetoCustom_attributes; overload;
    function Custom_attributes(value : TJSONArray) : iMagentoEntidadeProduto; overload;
    function Custom_attributes(value : TDictionary<String,String>) : iMagentoEntidadeProduto; overload;
    function MediaGalleryEntries : iMagentoMediaGalleryEntries; overload;
    function MediaGalleryEntries(value : TJSONArray) : iMagentoEntidadeProduto; overload;
    function &End : TJSONObject;
  end;

  iMagentoExtensionAttributes = interface
    ['{1DCF8FC4-6C4B-43A2-AF62-5ED3A96E8DFD}']
    function Category_Links : iMagentoCategory_Links; overload;
    function Category_Links(value : TJSONArray) : iMagentoExtensionAttributes; overload;
    function Category_Links(value : TDictionary<Integer, String>) : iMagentoExtensionAttributes; overload;
    function Stock_item :iMagentoStock_Item; overload;
    function Stock_item(value : TJSONObject) : iMagentoExtensionAttributes; overload;
    function &End : iMagentoEntidadeProduto;
  end;

  iMagentoCategory_Links = interface
    ['{C4445EB6-CA90-466D-8A2C-51E58AF2833F}']
    function Position(value : Integer) : iMagentoCategory_Links;
    function Category_id(value : String) : iMagentoCategory_Links;
    function Continuos : iMagentoCategory_Links;
    function &End : iMagentoExtensionAttributes;
  end;

  iMagentoStock_Item = interface
  ['{88A4FF1C-7CA6-4618-8200-98C284066762}']
    function Qty(value : integer) : iMagentoStock_Item;
    function Is_in_stock(value : boolean) : iMagentoStock_Item;
    function &End : iMagentoExtensionAttributes;
  end;

  iMagnetoCustom_attributes = interface
    ['{58341560-D21A-442F-B66A-B876D92BB618}']
    function Attribute_code(value : String) : iMagnetoCustom_attributes;
    function Value(aValue : String) : iMagnetoCustom_attributes;
    function Continuos : iMagnetoCustom_attributes;
    function &End : iMagentoEntidadeProduto;
  end;

  iMagentoMediaGalleryEntries = interface
    ['{6FF3E9AB-D02A-4B55-A65A-41A02F281BF7}']
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

  iMagentoMediaGaleryContent = interface
    ['{C8A0BFF7-8E53-45D1-862F-23FF1165D67F}']
    function Base64EncodedData(value : String) : iMagentoMediaGaleryContent; //passar somente o caminho da imagem
    function &Type(value : string) : iMagentoMediaGaleryContent;//passar o tipo da imagem png,gif,bpm e jpeg(jpg)
    function Name(value : String) : iMagentoMediaGaleryContent;
    function &End : iMagentoMediaGalleryEntries;
  end;

  iMagentoAttributeSets = interface
    ['{20F40DAF-09B8-431E-9C73-E45D36D0CCE0}']
    function AttributeSetID(Value : Integer) : iMagentoAttributeSets;
    function AttibuteSetName(Value : String) : iMagentoAttributeSets;
    function SortOrder(Value : Integer) : iMagentoAttributeSets;
    function EntityTypeID(Value : Integer) : iMagentoAttributeSets;
    function ListAttibuteSets(Value : TDataSet) : iMagentoAttributeSets;
    function ListAttributeSetsID(Value : TDataSet; ID : String) : iMagentoAttributeSets;
    function &End : String;
  end;

  iMagentoCategories = interface
    ['{8A8FC1BB-3010-4167-BF98-475289B0F1C5}']
    function ID(Value : Integer) : iMagentoCategories;
    function Name(Value : String) : iMagentoCategories;
    function Is_active(Value : Boolean) : iMagentoCategories;
    function Position(Value : Integer) : iMagentoCategories;
    function Level(Value : Integer)  : iMagentoCategories;
    function Include_in_menu(Value : Boolean) : iMagentoCategories;
    function CategoriaMae(Value : Integer) : iMagentoCategories;
    function ListCategories(Value : TDataSet) : iMagentoCategories;
    function &End : String;
  end;

  iMagentoPedido = interface
    ['{C0CC3E9F-9EA9-45F6-8592-1D50CFA1E1DE}']
    function ListaFaturado(Value : TDataSet) : iMagentoPedido;
    function ListaItensPedito(Value : TDataSet) : iMagentoPedido;
  end;

  iMagentoFactory = interface
    ['{BDBF6FEE-B787-4C3D-8FC3-5AEC79E82CEC}']
    function EntidadeProduto : iMagentoEntidadeProduto;
    function ExtensionAttributes(Parent : iMagentoEntidadeProduto) : iMagentoExtensionAttributes;
    function Category_Links(Parent : iMagentoExtensionAttributes) : iMagentoCategory_Links;
    function Stock_Item(Parent : iMagentoExtensionAttributes) : iMagentoStock_Item;
    function Custom_attributes(Parent : iMagentoEntidadeProduto) : iMagnetoCustom_attributes;
    function MediaGalleryEntries(Parent : iMagentoEntidadeProduto) : iMagentoMediaGalleryEntries;
    function MediaGalleryContent(Parent : iMagentoMediaGalleryEntries) : iMagentoMediaGaleryContent;
    function MagentoHTTP : iMagentoHTTP;
    function MagentoAttibuteSets : iMagentoAttributeSets;
    function MagentoCategories : iMagentoCategories;
    function MagentoPedido : iMagentoPedido;
  end;

  iCommand = interface
    ['{60B68B66-74A7-4867-A282-8D114FEE5E64}']
    function Execute : iCommand;
  end;

  iInvoker = interface
    ['{56C5BD6D-AF21-4CE8-9EE1-4C6D7F4F6DC5}']
    function Add(value : iCommand) : iInvoker;
    function Execute : iInvoker;
  end;

implementation

uses
  System.TypInfo;

{ TTipoProdutoHelper }

function TTipoProdutoHelper.ToString: String;
begin
  Result :=  GetEnumName(TypeInfo(TTipoProduto), Integer(self));
end;

end.
