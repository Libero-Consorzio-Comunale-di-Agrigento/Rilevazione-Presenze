unit WA206UCondizioniTurniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, Math,
  A206UCondizioniTurniMW;

type
  TWA206FCondizioniTurniDM = class(TWR302FGestTabellaDM)
    selTabellaMATRICOLA: TStringField;
    selTabellaCOGNOME: TStringField;
    selTabellaNOME: TStringField;
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaCOD_SQUADRA: TStringField;
    selTabellaDESC_SQUADRA: TStringField;
    selTabellaCOD_TIPOOPE: TStringField;
    selTabellaDESC_TIPOOPE: TStringField;
    selTabellaCOD_ORARIO: TStringField;
    selTabellaDESC_ORARIO: TStringField;
    selTabellaSIGLA_TURNO: TStringField;
    selTabellaDESC_SIGLATURNO: TStringField;
    selTabellaCOD_GIORNO: TStringField;
    selTabellaCOD_CONDIZIONE: TStringField;
    selTabellaPRIORITA: TIntegerField;
    selTabellaLIVELLO_ANOMALIA: TIntegerField;
    selTabellaMINIMO: TIntegerField;
    selTabellaOTTIMALE: TIntegerField;
    selTabellaMASSIMO: TIntegerField;
    selTabellaVALORE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaDESC_GIORNO: TStringField;
    selTabellaDESC_CONDIZIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A206MW: TA206FCondizioniTurniMW;
  end;

implementation

uses WA206UCondizioniTurni, WA206UCondizioniTurniDettFM;

{$R *.dfm}

procedure TWA206FCondizioniTurniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('PROGRESSIVO',-1);
  selTabella.SetVariable('ORDERBY','ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA, T606.PROGRESSIVO, T606.COD_SQUADRA, T606.COD_TIPOOPE, T606.COD_GIORNO, T606.COD_ORARIO, T606.SIGLA_TURNO, T606.COD_CONDIZIONE, T606.DECORRENZA');
  A206MW:=TA206FCondizioniTurniMW.Create(Self);
  A206MW.selT606:=selTabella;
  selTabella.FieldByName('DESC_GIORNO').LookupDataSet:=A206MW.selGiorni;
  selTabella.FieldByName('DESC_CONDIZIONE').LookupDataSet:=A206MW.selT605;
  inherited;
end;

procedure TWA206FCondizioniTurniDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A206MW.selT606AfterScroll;
  if (Self.Owner as TWA206FCondizioniTurni).WDettaglioFM <> nil then
    with ((Self.Owner as TWA206FCondizioniTurni).WDettaglioFM as TWA206FCondizioniTurniDettFM) do
      AbilitaComponenti;
end;

procedure TWA206FCondizioniTurniDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A206MW.selT606OnCalcFields;
end;

procedure TWA206FCondizioniTurniDM.selTabellaFilterRecord(DataSet: TDataSet;  var Accept: Boolean);
begin
  inherited;
  Accept:=Accept and A206MW.selT606FilterRecord;
end;

procedure TWA206FCondizioniTurniDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A206MW.selT606OnNewRecord(IfThen(A206MW.TipoCond = 'I',(Self.Owner as TWA206FCondizioniTurni).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger,-1));
end;

procedure TWA206FCondizioniTurniDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  A206MW.selT606BeforePost;
end;

end.
