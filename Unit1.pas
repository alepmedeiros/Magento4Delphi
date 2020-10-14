unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  Vcl.Imaging.jpeg, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, JSON, System.Generics.Collections, Magento.Interfaces;

type
  TEnumUtils<T> = class
    class procedure EnumToList(Value : TStrings);
  end;

  TForm1 = class(TForm)
    EdtSku: TLabeledEdit;
    Button1: TButton;
    EdtDescricao: TLabeledEdit;
    cbAtributo: TComboBox;
    Label1: TLabel;
    edtPreco: TLabeledEdit;
    ckSatus: TCheckBox;
    ckVisivel: TCheckBox;
    cbTipo: TComboBox;
    Label2: TLabel;
    EdtPeso: TLabeledEdit;
    Panel1: TPanel;
    Image1: TImage;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    Button5: TButton;
    TreeView1: TTreeView;
    Label4: TLabel;
    Button4: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    edtEstoque: TLabeledEdit;
    Button9: TButton;
    Button11: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cbAtributoChange(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbTipoChange(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
    procedure ListaCategoria;
    procedure ListaAtributos;

    procedure ProdutoSimples;
  public
    { Public declarations }
    FAttributeId : Integer;
    FAttributeValue : String;
    FListaCategoryLinks : TDictionary<Integer, String>;
    FClientDataSet : TClientDataSet;
    FTipoProd : TTipoProduto;
    FListaCustom_attributes : TDictionary<String,String>;
    FListaProdutoSimples : TStringList;
    FMagentoFactory : iMagentoFactory;
  end;

var
  Form1: TForm1;

implementation

uses
  Magento.Factory, Unit3, Unit4, System.TypInfo, Magento.AttributeSets, Unit5,
  Unit6;

{$R *.dfm}

procedure TForm1.Button11Click(Sender: TObject);
begin
//FMagentoFactory.MagentoHTTP.PostProduto(
memo1.Clear;
memo1.Lines.Add(
  FMagentoFactory
  .EntidadeProduto
    .NewProduto
      .Sku(EdtSku.Text)
      .Name(EdtDescricao.Text)
      .Attribute_set_id(FAttributeId)
      .Price(StrToInt(edtPreco.Text))
      .Status(ckSatus.Checked)
      .Visibility(ckVisivel.Checked)
      .Type_id(FTipoProd)
      .Weight(EdtPeso.Text)
      .Extension_attributes
        .Category_Links(FListaCategoryLinks)
        .Stock_item
          .Qty(StrToInt(edtEstoque.Text))
          .Is_in_stock(true)
        .&End
      .&End
      .Custom_attributes(FListaCustom_attributes)
      .MediaGalleryEntries
        .MediaType('image')
        .&Label(ExtractFileName(OpenDialog1.FileName))
        .Position(1)
        .Disabled(false)
        .&File(ExtractFileName(OpenDialog1.FileName))
        .Types
        .Content
          .Base64EncodedData(OpenDialog1.FileName)
          .&Type('image/jpeg')
          .Name(ExtractFileName(OpenDialog1.FileName))
        .&End
      .&End
    .&End.ToString);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FMagentoFactory.MagentoHTTP.PostProduto(
  FMagentoFactory
  .EntidadeProduto
    .NewProduto
      .Sku(EdtSku.Text)
      .Name(EdtDescricao.Text)
      .Attribute_set_id(FAttributeId)
      .Price(StrToInt(edtPreco.Text))
      .Status(ckSatus.Checked)
      .Visibility(ckVisivel.Checked)
      .Type_id(FTipoProd)
      .Weight(EdtPeso.Text)
      .Extension_attributes
        .Category_Links(FListaCategoryLinks)
      .&End
      .Custom_attributes(FListaCustom_attributes)
      .MediaGalleryEntries
        .MediaType('image')
        .&Label(ExtractFileName(OpenDialog1.FileName))
        .Position(1)
        .Disabled(false)
        .&File(ExtractFileName(OpenDialog1.FileName))
        .Types
        .Content
          .Base64EncodedData(OpenDialog1.FileName)
          .&Type('image/jpeg')
          .Name(ExtractFileName(OpenDialog1.FileName))
        .&End
      .&End
    .&End);

    if FMagentoFactory.MagentoHTTP.Status=200 then
    begin
      ShowMessage('Produto Configuravel salvo com sucesso, para saber mais acesse a area administrativa do portal');
//      EdtSku.Clear;
//      EdtDescricao.Clear;
//      edtPreco.Clear;
//      EdtPeso.Clear;
//      FListaCategoryLinks.Clear;
//      FListaCustom_attributes.Clear;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ListaAtributos;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  FListaCategoryLinks.Add(
  StrToint(Copy(TreeView1.Selected.Text,1,Pos('-',TreeView1.Selected.Text)-1)),
  Copy(TreeView1.Selected.Text,Pos('-',TreeView1.Selected.Text)+1,
  Pos('-',TreeView1.Selected.Text)-2));
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ListaCategoria;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Form5.ShowModal;
//  FClientDataSet := TClientDataSet.Create(nil);
//
//  TMagentoFactory.New.MagentoAttibuteSets.ListAttributeSetsID(FClientDataSet,IntToStr(FAttributeId));
//
//  DataSource1.DataSet := FClientDataSet;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Form4.ShowModal;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Form6.ShowModal;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  FListaCategoryLinks.Clear;
end;

procedure TForm1.cbAtributoChange(Sender: TObject);
begin
  FAttributeId := Integer(cbAtributo.Items.Objects[cbAtributo.ItemIndex]);
  FAttributeValue:=cbAtributo.Items[cbAtributo.ItemIndex];
end;

procedure TForm1.cbTipoChange(Sender: TObject);
begin
  FTipoProd := TTipoProduto(GetEnumValue(TypeInfo(TTipoProduto), cbTipo.Items[cbTipo.ItemIndex]));
  if cbTipo.Text='tpConfigurable' then
    edtEstoque.Enabled := False
  else
    edtEstoque.Enabled := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FListaCategoryLinks := TDictionary<Integer, String>.Create;
  FListaCustom_attributes := TDictionary<String, String>.Create;
  FListaProdutoSimples := TStringList.Create;
  FMagentoFactory := TMagentoFactory.New;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  TEnumUtils<TTipoProduto>.EnumToList(cbTipo.Items);
  ListaCategoria;
  ListaAtributos;
end;

procedure TForm1.ListaCategoria;
var
  jsonObj, jSubObj: TJSONObject;
  ja,jj,jl: TJSONArray;
  jv: TJSONValue;
  i,j,l: Integer;
  p:string;
  tn, tn2: TTreeNode;
begin
  jsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TMagentoFactory.New.MagentoHTTP.GetCatagorias), 0) as TJSONObject;

  jv := jsonObj.Get('children_data').JsonValue;
  ja := jv as TJSONArray;

  for i := 0 to ja.Size - 1 do
  begin
    jSubObj := (ja.Get(i) as TJSONObject);
    jv := jSubObj.Get(0).JsonValue;

    tn := TreeView1.Items.Add(nil, jSubObj.Get(0).JsonValue.Value+'-'+
      jSubObj.Get(4).JsonValue.Value+'-'+jSubObj.Get(2).JsonValue.Value);

    jv := jSubObj.Get(7).JsonValue;
    jj := jv as TJSONArray;
    for J := 0 to jj.Size-1 do
    begin
      jSubObj := (jj.Get(j) as TJSONObject);

      tn2 := TreeView1.Items.AddChild(tn, jSubObj.Get(0).JsonValue.Value+'-'+
      jSubObj.Get(4).JsonValue.Value+'-'+jSubObj.Get(2).JsonValue.Value);

      jv := jSubObj.Get(7).JsonValue;
      jl := jv as TJSONArray;
      for l := 0 to jl.Size-1 do
      begin
        jSubObj := (jl.Get(l) as TJSONObject);

        TreeView1.Items.AddChild(tn2, jSubObj.Get(0).JsonValue.Value+'-'+
        jSubObj.Get(4).JsonValue.Value+'-'+jSubObj.Get(2).JsonValue.Value);
      end;
    end;

  end;
end;

procedure TForm1.ProdutoSimples;
begin
//  Memo1.Lines.Add(
//  FMagentoFactory
//  .EntidadeProduto
//    .NewProduto
//      .Sku(EdtSku.Text)
//      .Name(EdtDescricao.Text)
//      .Attribute_set_id(FAttributeId)
//      .Price(StrToInt(edtPreco.Text))
//      .Status(ckSatus.Checked)
//      .Visibility(ckVisivel.Checked)
//      .Type_id(FTipoProd)
//      .Weight(EdtPeso.Text)
//      .Extension_attributes
//        .Category_Links(FListaCategoryLinks)
//        .Stock_item
//          .Qty(StrToInt(edtEstoque.Text))
//          .Is_in_stock(true)
//        .&End
//      .&End
//      .Custom_attributes(FListaCustom_attributes)
//      .MediaGalleryEntries
//        .MediaType('image')
//        .&Label(ExtractFileName(OpenDialog1.FileName))
//        .Position(1)
//        .Disabled(false)
//        .&File(ExtractFileName(OpenDialog1.FileName))
//        .Types
//        .Content
//          .Base64EncodedData(OpenDialog1.FileName)
//          .&Type('image/jpeg')
//          .Name(ExtractFileName(OpenDialog1.FileName))
//        .&End
//      .&End
//    .&End);
end;

procedure TForm1.ListaAtributos;
begin
  FClientDataSet := TClientDataSet.Create(nil);
  TMagentoFactory.New.MagentoAttibuteSets.ListAttibuteSets(FClientDataSet);
  while not FClientDataSet.Eof do
  begin
    cbAtributo.Items.AddObject(FClientDataSet.Fields[1].AsString, TObject(FClientDataSet.Fields[0].AsInteger));
    FClientDataSet.Next;
  end;
end;

{ TEnumUtils<T> }

class procedure TEnumUtils<T>.EnumToList(Value: TStrings);
var
  Aux: String;
  I, Pos : Integer;
begin
  Value.Clear;
  I := 0;
  repeat
    Aux := GetEnumName(TypeInfo(T), I);
    Pos := GetEnumValue(TypeInfo(T), Aux);
    if Pos <> -1 then Value.Add(Aux);
    inc(I);
  until Pos < 0;
end;

end.
