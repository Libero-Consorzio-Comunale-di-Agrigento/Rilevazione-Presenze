unit B028UPrintServer;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, B028PPrintServer_COM_TLB, StdVcl;

type
  TB028PrintServer = class(TTypedComObject, IB028PrintServer)
  protected
  end;

implementation

uses ComServ;

initialization
  TTypedComObjectFactory.Create(ComServer, TB028PrintServer, Class_B028PrintServer,
    ciSingleInstance, tmSingle);
end.
