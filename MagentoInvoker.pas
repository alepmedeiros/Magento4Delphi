unit MagentoInvoker;

interface

uses
  Magento.Interfaces, System.Classes;

type
  TMagentoInvoker = class (TInterfacedObject, iInvoker)
    private
//      FList : TList<iCommand>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iInvoker;

      function Add(value : iCommand) : iInvoker;
      function Execute : iInvoker;
  end;

implementation

{ TMagentoInvoker }

function TMagentoInvoker.Add(value: iCommand): iInvoker;
begin
  Result := Self;

//  FList.Add(value);
end;

constructor TMagentoInvoker.Create;
begin
//  FList := TList<iCommand>.Create;
end;

destructor TMagentoInvoker.Destroy;
begin
//  FList.DisposeOf;
  inherited;
end;

function TMagentoInvoker.Execute: iInvoker;
var
  Command : iCommand;
begin
  Result := Self;

//  for Command in FList do
//  begin
//    TThread.CreateAnonymousThread(
//      procedure
//      begin
//        Command.Execute;
//      end;
//    );
//  end;

end;

class function TMagentoInvoker.New: iInvoker;
begin
  Result := self.Create;
end;

end.
