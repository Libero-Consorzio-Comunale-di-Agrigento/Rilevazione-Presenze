unit P684UDefinizioneFondiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, Oracle, OracleData, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  P684UDefinizioneFondiMW;

type
  TP684FDefinizioneFondiDtM = class(TR004FGestStoricoDtM)
    selP684: TOracleDataSet;
    dsrP684Ricerca: TDataSource;
    dsrP684Dec: TDataSource;
    selP684COD_FONDO: TStringField;
    selP684DECORRENZA_DA: TDateTimeField;
    selP684DECORRENZA_A: TDateTimeField;
    selP684DESCRIZIONE: TStringField;
    selP684COD_MACROCATEG: TStringField;
    selP684COD_RAGGR: TStringField;
    selP684DATA_COSTITUZ: TDateTimeField;
    selP684FILTRO_DIPENDENTI: TStringField;
    selP684DATA_ULTIMO_MONIT: TDateTimeField;
    selP690: TOracleDataSet;
    selP690PROGRESSIVO: TFloatField;
    selP690MATRICOLA: TStringField;
    selP690COGNOME: TStringField;
    selP690NOME: TStringField;
    selP690COD_POSIZIONE_ECONOMICA: TStringField;
    selP690COD_FONDO: TStringField;
    selP690DECORRENZA_DA: TDateTimeField;
    selP690CLASS_VOCE: TStringField;
    selP690COD_VOCE_GEN: TStringField;
    selP690COD_VOCE_DET: TStringField;
    selP690DATA_RETRIBUZIONE: TDateTimeField;
    selP690COD_CONTRATTO: TStringField;
    selP690COD_VOCE: TStringField;
    selP690Descrizione: TStringField;
    selP690IMPORTO: TFloatField;
    selP684NOTE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selP684AfterScroll(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selP690BeforePost(DataSet: TDataSet);
    procedure selP690CalcFields(DataSet: TDataSet);
    procedure selP690NewRecord(DataSet: TDataSet);
    procedure selP690DATA_RETRIBUZIONEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure selP690DATA_RETRIBUZIONESetText(Sender: TField; const Text: string);
  private
    { Private declarations }
  public
    { Public declarations }
    P684FDefinizioneFondiMW: TP684FDefinizioneFondiMW;
    procedure selP688RAfterScroll(DataSet: TDataSet);
    procedure selP688RAfterPost(DataSet: TDataSet);
    procedure selP688DAfterScroll(DataSet: TDataSet);
    procedure selP688DAfterPost(DataSet: TDataSet);
  end;

var
  P684FDefinizioneFondiDtM: TP684FDefinizioneFondiDtM;

implementation

uses P684UDefinizioneFondi, P684UDettaglioRisorse, P684UDettaglioDestin,
  P684UGenerale;

{$R *.dfm}

procedure TP684FDefinizioneFondiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP684,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  P684FDefinizioneFondiMW:=TP684FDefinizioneFondiMW.Create(Self);
  P684FDefinizioneFondiMW.selP684:=selP684;
  P684FDefinizioneFondiMW.selP690:=selP690;
  dsrP684Ricerca.DataSet:=P684FDefinizioneFondiMW.selP684Ricerca;
  dsrP684Dec.DataSet:=P684FDefinizioneFondiMW.selP684Dec;

  P684FDefinizioneFondiMW.selP688R.AfterScroll:=selP688RAfterScroll;
  P684FDefinizioneFondiMW.selP688R.AfterPost:=selP688RAfterPost;
  P684FDefinizioneFondiMW.selP688D.AfterScroll:=selP688DAfterScroll;
  P684FDefinizioneFondiMW.selP688D.AfterPost:=selP688DAfterPost;

  selP684.AfterScroll:=nil;
  selP684.Open;
  selP684.AfterScroll:=selP684AfterScroll;
  P684FDefinizioneFondiMW.selP684Ricerca.Filtered:=True;
end;

procedure TP684FDefinizioneFondiDtM.selP684AfterScroll(DataSet: TDataSet);
begin
  inherited;
  P684FDefinizioneFondi.dcmbMacroCategCloseUp(nil);
  P684FDefinizioneFondi.dcmbRaggrCloseUp(nil);
  P684FDefinizioneFondiMW.selP684AfterScroll;
  with P684FDefinizioneFondiMW do
  begin
    P684FDefinizioneFondi.edtTotRisorse.Text:=Format('%15.0n',[StrToFloatDef(VarToStr(selP688Tot.Field(0)),0)]);
    P684FDefinizioneFondi.edtTotSpeso.Text:=Format('%15.0n',[StrToFloatDef(VarToStr(selP688Tot.Field(1)),0)]);
    P684FDefinizioneFondi.edtTotResiduo.Text:=Format('%15.0n',[StrToFloatDef(VarToStr(selP688Tot.Field(2)),0)]);
  end;
  P684FDefinizioneFondi.AbilitazioniComponenti;
end;

procedure TP684FDefinizioneFondiDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  P684FDefinizioneFondiMW.selP684BeforePost;
  inherited;
end;

procedure TP684FDefinizioneFondiDtM.selP688RAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if P684FDettaglioRisorse <> nil then
  begin
    P684FDettaglioRisorse.dcmbCodVoceGenCloseUp(nil);
    P684FDettaglioRisorse.dedtImporto.ReadOnly:=False;
    if (not P684FDefinizioneFondiMW.selP688R.FieldByName('QUANTITA').IsNull) or (not P684FDefinizioneFondiMW.selP688R.FieldByName('DATOBASE').IsNull) or
       (not P684FDefinizioneFondiMW.selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
      P684FDettaglioRisorse.dedtImporto.ReadOnly:=True;
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP688RAfterPost(DataSet: TDataSet);
begin
  inherited;
  with P684FDefinizioneFondiMW do
  begin
    selP688RAfterPost(DataSet);
    if selP688R.FieldByName('COD_ARROTONDAMENTO').AsString = '' then
      R180MessageBox(A000MSG_P684_MSG_COD_ARROTONDAMENTO,INFORMA);
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP688DAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if P684FDettaglioDestin <> nil then
    P684FDettaglioDestin.dcmbCodVoceGenCloseUp(nil);
end;

procedure TP684FDefinizioneFondiDtM.selP688DAfterPost(DataSet: TDataSet);
begin
  inherited;
  with P684FDefinizioneFondiMW do
  begin
    selP688DAfterPost(DataSet);
    if selP688D.FieldByName('COD_ARROTONDAMENTO').AsString = '' then
      R180MessageBox(A000MSG_P684_MSG_COD_ARROTONDAMENTO,INFORMA);
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP690BeforePost(DataSet: TDataSet);
begin
  P684FDefinizioneFondiMW.selP690BeforePost;
end;

procedure TP684FDefinizioneFondiDtM.selP690CalcFields(DataSet: TDataSet);
begin
  P684FDefinizioneFondiMW.selP690CalcFields;
end;

procedure TP684FDefinizioneFondiDtM.selP690NewRecord(DataSet: TDataSet);
begin
  P684FDefinizioneFondiMW.selP690NewRecord;
end;

procedure TP684FDefinizioneFondiDtM.selP690DATA_RETRIBUZIONEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  P684FDefinizioneFondiMW.selP690DataRetribuzioneGetText(Sender,Text);
end;

procedure TP684FDefinizioneFondiDtM.selP690DATA_RETRIBUZIONESetText(Sender: TField; const Text: string);
begin
  P684FDefinizioneFondiMW.selP690DataRetribuzioneSetText(Sender,Text);
end;

end.
