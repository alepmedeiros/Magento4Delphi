unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  TForm5 = class(TForm)
    DBGrid1: TDBGrid;
    edtAttributeCode: TLabeledEdit;
    edtValue: TLabeledEdit;
    Button1: TButton;
    DataSource1: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses Unit1, Datasnap.DBClient, Magento.Factory;

procedure TForm5.Button1Click(Sender: TObject);
begin
  Form1.FListaCustom_attributes.Add(edtAttributeCode.Text,
    edtValue.Text);
    edtAttributeCode.Clear;
    edtValue.Clear;
end;

procedure TForm5.FormShow(Sender: TObject);
var
  FClientDataSet : TClientDataSet;
begin
  FClientDataSet := TClientDataSet.Create(nil);

  TMagentoFactory.New.MagentoAttibuteSets.ListAttributeSetsID(FClientDataSet,IntToStr(form1.FAttributeId));

  DataSource1.DataSet := FClientDataSet;
end;

end.
