unit Magento.Factory;

interface

uses
  Magento.Interfaces;

type
  TMagentoFactory = class (TInterfacedObject, iMagentoFactory)
    private

    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMagentoFactory;
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

implementation

uses
  Magento.ExtensionAttributes, Magento.Category_Links, Magento.Stock_Item,
  Magento.Custom_Attributes, Magento.Entidade.Produto, Magento.GalleryContent,
  Magento.GalleryTypes, Magento.MediaGalleryEntries, MagentoHTTP,
  Magento.AttributeSets, Magento.Categories, Magento.Pedido;

{ TMagentoFactory }

function TMagentoFactory.Category_Links(Parent : iMagentoExtensionAttributes): iMagentoCategory_Links;
begin
  Result := TMagentoCategory_Links.New(Parent);
end;

constructor TMagentoFactory.Create;
begin

end;

function TMagentoFactory.Custom_attributes(Parent : iMagentoEntidadeProduto) : iMagnetoCustom_attributes;
begin
  Result := TMagnetoCustom_attributes.New(Parent);
end;

destructor TMagentoFactory.Destroy;
begin

  inherited;
end;

function TMagentoFactory.EntidadeProduto: iMagentoEntidadeProduto;
begin
  Result := TMagentoEntidadeProduto.New;
end;

function TMagentoFactory.ExtensionAttributes(Parent : iMagentoEntidadeProduto): iMagentoExtensionAttributes;
begin
  Result := TMagentoExtensionAttributes.New(Parent);
end;

function TMagentoFactory.MagentoAttibuteSets: iMagentoAttributeSets;
begin
  Result := TMagentoAttributeSets.New;
end;

function TMagentoFactory.MagentoCategories: iMagentoCategories;
begin
  Result := TMagentoCategories.New;
end;

function TMagentoFactory.MagentoHTTP: iMagentoHTTP;
begin
  Result := TMagentoHTTP.New;
end;

function TMagentoFactory.MagentoPedido: iMagentoPedido;
begin
  Result := TMagentoPedido.New;
end;

function TMagentoFactory.MediaGalleryContent(
  Parent: iMagentoMediaGalleryEntries): iMagentoMediaGaleryContent;
begin
  Result := TMagentoMediaGaleryContent.New(Parent);
end;

function TMagentoFactory.MediaGalleryEntries(Parent : iMagentoEntidadeProduto) : iMagentoMediaGalleryEntries;
begin
  Result := TMagentoMediaGalleryEntries.New(Parent);
end;

class function TMagentoFactory.New: iMagentoFactory;
begin
  Result := self.Create;
end;

function TMagentoFactory.Stock_Item(Parent : iMagentoExtensionAttributes) : iMagentoStock_Item;
begin
  Result := TMagentoStock_Item.New(Parent);
end;

end.
