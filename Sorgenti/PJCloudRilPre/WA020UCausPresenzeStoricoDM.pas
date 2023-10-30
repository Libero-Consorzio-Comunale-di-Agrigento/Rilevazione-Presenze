unit WA020UCausPresenzeStoricoDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, OracleData,
  A020UCausPresenzeStoricoMW, WR302UGestTabellaDM;
type
  TWA020FCausPresenzeStoricoDM = class(TWR302FGestTabellaDM)
    selTabellaID: TIntegerField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaNONABILITATA_ELIMINATIMB: TStringField;
    selTabellaNONACCOPPIATA_ANOMBLOCC: TStringField;
    selTabellaCODICE: TStringField;
    selTabellaDESC_CAUSALE: TStringField;
    selTabellaCAUSCOMP_DEBITOGG: TStringField;
    selTabellaDETRAZ_RIEPPR_SEQ: TIntegerField;
    selTabellaGIUST_DAA_RECUP_FLEX: TStringField;
    selTabellaITER_AUTSTR_ARROT_LIQ: TStringField;
    selTabellaITER_AUTSTR_ARROT_LIQ_FASCE: TStringField;
    selTabellaCONTEGGIO_TIMB_INTERNA: TStringField;
    selTabellaMATURAMENSA: TStringField;
    selTabellaTIMB_PM: TStringField;
    selTabellaTIMB_PM_DETRAZ: TStringField;
    selTabellaTIMB_PM_H: TStringField;
    selTabellaINTERSEZIONE_TIMBRATURE: TStringField;
    selTabellaAUTOCOMPLETAMENTO_UE: TStringField;
    selTabellaSEPARA_CAUSALI_UE: TStringField;
    selTabellaSPEZZ_STRAORD: TStringField;
    selTabellaRICONOSCIMENTO_TURNO: TStringField;
    selTabellaCONDIZIONE_ABILITAZIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    IDCausale:Integer;
    A020MW: TA020FCausPresenzeStoricoMW;
    procedure Inizializza;
  end;

implementation

{$R *.dfm}

procedure TWA020FCausPresenzeStoricoDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
end;

procedure TWA020FCausPresenzeStoricoDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  A020MW.ValidazioneQueryCdzAbilitazione(selTabella.FieldByName('CONDIZIONE_ABILITAZIONE').AsString);
end;

procedure TWA020FCausPresenzeStoricoDM.Inizializza;
begin
  A020MW:=TA020FCausPresenzeStoricoMW.Create(Self);
  A020MW.Inizializza(IdCausale);
  selTabella.FieldByName('CODICE').LookupDataSet:=A020MW.selT275;
  selTabella.FieldByName('DESC_CAUSALE').LookupDataSet:=A020MW.selT275;
  A020MW.selT275.Open;
  selTabella.SetVariable('ID',IDCausale);
  selTabella.Open;
end;

end.
