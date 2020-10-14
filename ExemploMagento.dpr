program ExemploMagento;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Magento.Category_Links in 'Magento.Category_Links.pas',
  Magento.Custom_Attributes in 'Magento.Custom_Attributes.pas',
  Magento.Entidade.Produto in 'Magento.Entidade.Produto.pas',
  Magento.ExtensionAttributes in 'Magento.ExtensionAttributes.pas',
  Magento.Factory in 'Magento.Factory.pas',
  Magento.GalleryContent in 'Magento.GalleryContent.pas',
  Magento.GalleryTypes in 'Magento.GalleryTypes.pas',
  Magento.Interfaces in 'Magento.Interfaces.pas',
  Magento.MediaGalleryEntries in 'Magento.MediaGalleryEntries.pas',
  Magento.Stock_Item in 'Magento.Stock_Item.pas',
  MagentoHTTP in 'MagentoHTTP.pas',
  MagentoInvoker in 'MagentoInvoker.pas',
  ServerMagento.Model.Env in 'ServerMagento.Model.Env.pas',
  MagentoHTTP_V1 in 'MagentoHTTP_V1.pas',
  MagentoSearchCriteria in 'MagentoSearchCriteria.pas',
  Magento.AttributeSets in 'Magento.AttributeSets.pas',
  Magento.Categories in 'Magento.Categories.pas',
  Unit4 in 'Unit4.pas' {Form4},
  Magento.Pedido in 'Magento.Pedido.pas',
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
