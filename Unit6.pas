unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids;

type
  TForm6 = class(TForm)
    DBGrid1: TDBGrid;
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses
  Datasnap.DBClient, Magento.Factory;

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
var
  lItensFaturado, FClientDataSet : TClientDataSet;
begin
  FClientDataSet := TClientDataSet.Create(nil);

  TMagentoFactory.New.MagentoPedido.ListaFaturado(FClientDataSet);

  DataSource1.DataSet := FClientDataSet;

  lItensFaturado := TClientDataSet.Create(nil);

  TMagentoFactory.New.MagentoPedido.ListaItensPedito(lItensFaturado);

  DataSource2.DataSet := lItensFaturado;
end;

end.
