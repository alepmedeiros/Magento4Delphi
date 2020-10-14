unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.JSON, System.Generics.Collections, Magento.Factory;

type
  TForm4 = class(TForm)
    edtDescricao: TLabeledEdit;
    ComboBox1: TComboBox;
    Button1: TButton;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
    FID : Integer;
    FName : String;
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  TMagentoFactory.New
    .MagentoHTTP
    .PostCategorias(
      TMagentoFactory.New
        .MagentoCategories
        .CategoriaMae(FID)
        .Name(edtDescricao.Text)
        .Is_active(true)
        .Include_in_menu(true)
      .&End);
end;

procedure TForm4.ComboBox1Change(Sender: TObject);
begin
  FID := Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
  FName:= ComboBox1.Items[ComboBox1.ItemIndex];
end;

procedure TForm4.FormShow(Sender: TObject);
var
  jsonObj, lSubObj : TJSONObject;
  lJSONValue : TJSONValue;
  lArray,lJAr,lAr : TJSONArray;

  Lista : TDictionary<Integer, String>;
  I, J, L, Key: Integer;
begin
  jsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TMagentoFactory.New.MagentoHTTP.GetCatagorias), 0) as TJSONObject;

  Lista := TDictionary<Integer, String>.Create;

//  Lista.Add(StrToInt(jsonObj.Get('id').JsonValue.Value),jsonObj.Get('name').JsonValue.Value);

  lJSONValue := jsonObj.Get('children_data').JsonValue;
  lArray := lJSONValue as TJSONArray;

  for I := 0 to lArray.Size-1 do
  begin
    lSubObj := (lArray.Get(i) as TJSONObject);
    Lista.Add(StrToInt(lSubObj.Get(0).JsonValue.Value),
      lSubObj.Get(2).JsonValue.Value);

    lJSONValue := lSubObj.Get(7).JsonValue;
    lJAr := lJSONValue as TJSONArray;
    for J := 0 to lJAr.Size-1 do
    begin
      lSubObj := (lJAr.Get(J) as TJSONObject);

      Lista.Add(StrToInt(lSubObj.Get(0).JsonValue.Value),
      lSubObj.Get(2).JsonValue.Value);

      lJSONValue := lSubObj.Get(7).JsonValue;
      lAr := lJSONValue as TJSONArray;
      for L := 0 to lAr.Size-1 do
      begin
        lSubObj := (lAr.Get(L) as TJSONObject);

        Lista.Add(StrToInt(lSubObj.Get(0).JsonValue.Value),
          lSubObj.Get(2).JsonValue.Value);
      end;
    end;
  end;

  for key in Lista.Keys do
    ComboBox1.items.AddObject(Lista.Items[key],TObject(key));
end;

end.
