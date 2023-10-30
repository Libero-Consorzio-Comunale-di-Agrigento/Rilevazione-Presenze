{ Invokable interface IB020IrisWebSvc01 }

unit B020UIrisWebSvc01Intf;

interface

uses InvokeRegistry, Types, XSBuiltIns;

type

  TEnumTest = (etNone, etAFew, etSome, etAlot);

  TDoubleArray = array of Double;

  TMyEmployee = class(TRemotable)
  private
    FLastName: AnsiString;
    FFirstName: AnsiString;
    FSalary: Double;
  published
    property LastName: AnsiString read FLastName write FLastName;
    property FirstName: AnsiString read FFirstName write FFirstName;
    property Salary: Double read FSalary write FSalary;
  end;

  { Invokable interfaces must derive from IInvokable }
  IB020IrisWebSvc01 = interface(IInvokable)
  ['{6C86AD23-A4C6-4B9C-BDFB-5042A2DBA408}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
    function echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
    function echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
    function echoDouble(const Value: Double): Double; stdcall;
    function CartellinoPDF(const Db,Azienda,Matricola,Dal,Al,Parametrizzazione,FilePdf: WideString): WideString; stdcall;
    function R600GetAssenze(const DB,Azienda,Matricola,DataRiferimento,Causale,DataNasFam: WideString): WideString; stdcall;
    function R502Conteggi(const DB,Azienda,Matricola,DataRiferimento: WideString): WideString; stdcall;
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IB020IrisWebSvc01));

end.
