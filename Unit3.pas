unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Classes;

type
  TForm3 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FID : Integer;
    FName : String;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  System.JSON, Magento.Factory, System.Generics.Collections;

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
var
  jsonObj, lSubObj : TJSONObject;
  lJSONValue : TJSONValue;
  lArray,lJAr,lAr : TJSONArray;

  Lista : TDictionary<Integer, String>;
  I, J, L, Key: Integer;
begin
  jsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TMagentoFactory.New.MagentoHTTP.GetCatagorias), 0) as TJSONObject;

  Lista := TDictionary<Integer, String>.Create;

  Lista.Add(StrToInt(jsonObj.Get('id').JsonValue.Value),jsonObj.Get('name').JsonValue.Value);

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
        lSubObj := (lJAr.Get(L) as TJSONObject);

        Lista.Add(StrToInt(lSubObj.Get(0).JsonValue.Value),
          lSubObj.Get(2).JsonValue.Value);
      end;
    end;
  end;

  for key in Lista.Keys do
    ComboBox1.items.AddObject(IntToStr(key),TObject(Lista.Items[key]));
end;

end.
