unit WA082UCdcPercentDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DBClient, DB, OracleData,C180FunzioniGenerali,
  A000UInterfaccia,A000UCostanti, A000USessione,A082UCdcPercentMW,WR100UBase, A000UMessaggi;

type
  TWA082FCdcPercentDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaCODICE: TStringField;
    selTabellaPERCENTUALE: TFloatField;
    selTabellaD_CODICE: TStringField;
    selT433Count: TOracleDataSet;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
  private
    procedure eseguiControlli;
  public
    A082FCdcPercentMW: TA082FCdcPercentMW;
    Anomalie: String;
  end;

implementation uses WA082UCdcPercent;

{$R *.dfm}

procedure TWA082FCdcPercentDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A082FCdcPercentMW.ElaboraPeriodi;
  A082FCdcPercentMW.SituazioneModificata:=True;
  eseguiControlli;
end;

procedure TWA082FCdcPercentDM.AfterPost(DataSet: TDataSet);
begin
  A082FCdcPercentMW.ElaboraPeriodi;
  A082FCdcPercentMW.SituazioneModificata:=True;
  eseguiControlli;
  inherited;
end;

procedure TWA082FCdcPercentDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  with selTabella do
  begin
    if FieldByName('DECORRENZA_FINE').IsNull then
      FieldByName('DECORRENZA_FINE').AsDateTime:=DATE_MAX;
    if (FieldByName('DECORRENZA').AsDateTime > FieldByName('DECORRENZA_FINE').AsDateTime) then
    begin
      MsgBox.MessageBox(A000MSG_ERR_DECOR_SUP_SCAD, ERRORE);
      Abort;
    end;

    if (FieldByName('PERCENTUALE').asFloat <= 0) or
       (FieldByName('PERCENTUALE').asFloat > 100) or
       (FieldByName('PERCENTUALE').IsNull) then
    begin
      MsgBox.MessageBox(A000MSG_ERR_PERCENTUALE, ERRORE);
      Abort;
    end;
  end;
end;

procedure TWA082FCdcPercentDM.eseguiControlli;
begin
  Anomalie:=A082FCdcPercentMW.Controlli;
  TWA082FCdcPercent(self.Owner).AggiornaVisualizzazione;
  //se non ci sono anomalie ricarico il clientdataset per il ripristino
  if Anomalie = '' then
      A082FCdcPercentMW.CaricacdsT433;
end;

procedure TWA082FCdcPercentDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A082FCdcPercentMW:=TA082FCdcPercentMW.Create(Self);
  A082FCdcPercentMW.selT433_Funzioni:=selTabella;

  selTabella.FieldByName('CODICE').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C13_CdcPercentualizzati);
  with A082FCdcPercentMW do
  begin
    if A000LookupTabella(Parametri.CampiRiferimento.C13_CdcPercentualizzati,selCdcPercent) then
    begin
      AggiornaElencoCdc(selCdcPercent);
      selTabella.Open;
      A082FCdcPercentMW.CreacdsT433;
    end;
  end;
end;

procedure TWA082FCdcPercentDM.OnNewRecord(DataSet: TDataSet);
var
  cdc: String;
begin
  inherited;
  cdc:=Parametri.CampiRiferimento.C13_CdcPercentualizzati;
  selTabella.FieldByName('PROGRESSIVO').AsInteger:=TWR100FBase(Self.Owner).grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;

  with A082FCdcPercentMW do
  begin
    OpenT430(cdc,selTabella.FieldByName('PROGRESSIVO').AsInteger,Parametri.DataLavoro);
    if selT430.FieldByName(cdc).AsString <> '' then
      selTabella.FieldByName('CODICE').AsString:=selT430.FieldByName(cdc).AsString;
  end;
end;

procedure TWA082FCdcPercentDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //Esegue controlli sui periodi. eseguito anche sul cambio progressivo.
  //Sulla create il progressivo è ancora nullo
  if SelTabella.GetVariable('PROGRESSIVO') <> Null then
  begin
    A082FCdcPercentMW.cdsT433.EmptyDataSet;
    A082FCdcPercentMW.SituazioneModificata:=False;
    eseguiControlli;
  end;
end;

procedure TWA082FCdcPercentDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  with A082FCdcPercentMW do
  begin
    AggiornaElencoCdc(selCdcPercent);
    if selCdcPercent.Active then
    begin
      selCdcPercent.SearchRecord('CODICE',selTabella.FieldByName('CODICE').AsString,[srFromBeginning]);
      selTabella.FieldByName('D_CODICE').AsString:=selCdcPercent.FieldByName('DESCRIZIONE').AsString;
    end;
  end;
end;

procedure TWA082FCdcPercentDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A082FCdcPercentMW);
  selTabella.Close;
  inherited;
end;
end.
