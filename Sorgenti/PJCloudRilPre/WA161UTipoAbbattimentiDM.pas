unit WA161UTipoAbbattimentiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A161UTipoAbbattimentiMW, A000UInterfaccia;

type
  TWA161FTipoAbbattimentiDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaRISPARMIO_BILANCIO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaNewRecord(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A161FTipoAbbattimentiMW: TA161FTipoAbbattimentiMW;
  end;

implementation

uses
  IWInit, IWApplication;

{$R *.dfm}

procedure TWA161FTipoAbbattimentiDM.BeforePostNoStorico(DataSet: TDataSet);
var Numerico:Boolean;
begin
  Numerico:=False;
  try
    StrToFloat(selTabella.FieldByName('CODICE').AsString);
    Numerico:=True;
  except
  end;
  if Numerico then
    raise Exception.Create('Impossibile specificare codici numerici!');

  inherited;
end;

procedure TWA161FTipoAbbattimentiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  selTabella.SetVariable('ORDERBY', 'order by codice');
  inherited;
  A161FTipoAbbattimentiMW:=TA161FTipoAbbattimentiMW.Create(Self);
  A161FTipoAbbattimentiMW.selT766:=selTabella;
  selTabella.Open;
end;

procedure TWA161FTipoAbbattimentiDM.selTabellaNewRecord(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('RISPARMIO_BILANCIO').AsString:='N';
end;

end.
