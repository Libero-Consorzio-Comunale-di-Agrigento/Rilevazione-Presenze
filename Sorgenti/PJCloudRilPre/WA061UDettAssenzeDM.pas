unit WA061UDettAssenzeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM, DB, OracleData, USelI010, A000UInterfaccia;

type
  TWA061FDettAssenzeDM = class(TWR300FBaseDM)
    selT256: TOracleDataSet;
    Q265: TOracleDataSet;
    selT255: TOracleDataSet;
    selT255COD_TIPOACCORPCAUSALI: TStringField;
    selT255DESCRIZIONE: TStringField;
    D255: TDataSource;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    selI010:TselI010;
  end;


implementation

{$R *.dfm}

procedure TWA061FDettAssenzeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
end;

end.
