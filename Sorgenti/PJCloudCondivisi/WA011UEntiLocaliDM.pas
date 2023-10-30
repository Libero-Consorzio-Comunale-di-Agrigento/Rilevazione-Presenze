unit WA011UEntiLocaliDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, C180FunzioniGenerali,
  medpIWMessageDlg, A000UMessaggi, A011UEntiLocaliMW;

type
  TWA011FEntiLocaliDM = class(TWR302FGestTabellaDM)
    T480: TOracleDataSet;
    T481: TOracleDataSet;
    T482: TOracleDataSet;
    T482COD_REGIONE: TStringField;
    T482DESCRIZIONE: TStringField;
    T482COD_IRPEF: TStringField;
    T482FISCALE: TStringField;
    T481COD_PROVINCIA: TStringField;
    T481DESCRIZIONE: TStringField;
    T481COD_REGIONE: TStringField;
    T481D_REGIONE: TStringField;
    T480CODICE: TStringField;
    T480CITTA: TStringField;
    T480CAP: TStringField;
    T480PROVINCIA: TStringField;
    T480D_PROVINCIA: TStringField;
    T480CODCATASTALE: TStringField;
    T480COD_REGIONE: TStringField;
    T480D_REGIONE: TStringField;
    D480: TDataSource;
    D481: TDataSource;
    D482: TDataSource;
    T483: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    D483: TDataSource;
    T480SOPPRESSO: TStringField;
    T480COD_IRPEF: TStringField;
    T480D_COD_IRPEF: TStringField;
    T480D_SOPPRESSO: TStringField;
    T480DATA_SOPPRESSIONE: TDateTimeField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
    A011FEntiLocaliMW: TA011FEntiLocaliMW;
  end;

implementation

uses WA011UEntiLocali, WR100UBase;

{$R *.dfm}

procedure TWA011FEntiLocaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A011FEntiLocaliMW:=TA011FEntiLocaliMW.Create(Self);
  A011FEntiLocaliMW.selEnte:=selTabella;
  T480.FieldByName('D_PROVINCIA').LookupDataSet:=A011FEntiLocaliMW.selT481;
  T480.FieldByName('COD_REGIONE').LookupDataSet:=A011FEntiLocaliMW.selT481;
  T480.FieldByName('D_REGIONE').LookupDataSet:=A011FEntiLocaliMW.selT481;
  T481.FieldByName('D_REGIONE').LookupDataSet:=A011FEntiLocaliMW.selT482;
  NonAprireSelTabella:=True;
  inherited;
  T481.Open;
  T482.Open;
  T483.Open;
end;

procedure TWA011FEntiLocaliDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if DataSet = T480 then
  begin
    A011FEntiLocaliMW.selEnteBeforePost('C');
    A011FEntiLocaliMW.ValidaCodiceCatastale;
  end
  else if DataSet = T482 then
    A011FEntiLocaliMW.selEnteBeforePost('R');
end;

end.
