unit S740URegoleValutazioniDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, USelI010, A000UCostanti, A000USessione, Math,
  A000UInterfaccia, C180FunzioniGenerali, {DbTables,} StrUtils, Oracle, S740URegoleValutazioniMW;

type
  TS740FRegoleValutazioniDtM = class(TR004FGestStoricoDtM)
    SG741: TOracleDataSet;
    SG741DATO_STAMPA_1: TStringField;
    SG741DATO_STAMPA_2: TStringField;
    SG741DATO_STAMPA_3: TStringField;
    SG741DATO_STAMPA_4: TStringField;
    SG741DATO_STAMPA_5: TStringField;
    SG741DECORRENZA: TDateTimeField;
    SG741DECORRENZA_FINE: TDateTimeField;
    SG741GIORNI_MINIMI: TIntegerField;
    SG741LOGO_LARGHEZZA: TIntegerField;
    SG741LOGO_ALTEZZA: TIntegerField;
    SG741DATO_STAMPA_6: TStringField;
    SG741DESC_LUNGA_1: TStringField;
    SG741DESC_LUNGA_3: TStringField;
    SG741DESC_LUNGA_5: TStringField;
    SG741PATH_ISTRUZIONI: TStringField;
    SG741DATO_VARIAZIONE_VALUTATORE: TStringField;
    SG741TESTO_VALUTAZIONI_COMPLESSIVE: TStringField;
    SG741ABILITA_COMMENTI_VALUTATO: TStringField;
    SG741AREA_FORMATIVA_OBBLIGATORIA: TStringField;
    SG741AGGIORNA_DATA_COMPILAZIONE: TStringField;
    SG741ABILITA_AREE_FORMATIVE: TStringField;
    SG741ABILITA_ACCETTAZIONE_VALUTATO: TStringField;
    SG741STAMPA_VARIAZIONI_5: TStringField;
    SG741DATA_DA_OBIETTIVI: TDateTimeField;
    SG741DATA_A_OBIETTIVI: TDateTimeField;
    SG741CODICE: TStringField;
    SG741DESCRIZIONE: TStringField;
    SG741FILTRO_ANAGRAFE: TStringField;
    SG741PAGINE_ABILITATE: TStringField;
    SG741ASSEGN_PREVENTIVA_OBIETTIVI: TStringField;
    SG741COD_TIPI_RAPPORTO: TStringField;
    SG741CAMPI_OPZIONALI_STAMPA: TStringField;
    SG741CAMPI_OPZIONALI_COMPILAZIONE: TStringField;
    SG741STAMPA_PERIODO_VALUTAZIONE: TStringField;
    SG741MODIFICA_NOTE_SUPERVISOREVALUT: TStringField;
    SG741VALUTA_CESSATI_RUOLO: TStringField;
    SG741PATH_FILEPDF: TStringField;
    SG741D_PARPROTOCOLLO: TStringField;
    SG741COD_PARPROTOCOLLO: TStringField;
    SG741PATH_INFORMAZIONI: TStringField;
    SG741INVIO_EMAIL: TStringField;
    SG741COMMENTI_VALUTATO_DIP: TStringField;
    SG741REGISTRA_DATA_ACCETTAZIONE_VAL: TStringField;
    SG741TIPO_ARROTONDAMENTO: TStringField;
    SG741TESTO_AVVISO_PRESA_VISIONE: TStringField;
    SG741CODTIPOQUOTA_STAMPA: TStringField;
    SG741D_TIPOQUOTA_STAMPA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure SG741AfterScroll(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure SG741CalcFields(DataSet: TDataSet);
    procedure SG741AfterOpen(DataSet: TDataSet);
  public
    { Public declarations }
    S740FRegoleValutazioniMW: TS740FRegoleValutazioniMW;
  end;

var
  S740FRegoleValutazioniDtM: TS740FRegoleValutazioniDtM;

implementation

{$R *.dfm}
uses
  S740URegoleValutazioni;

procedure TS740FRegoleValutazioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=S740FRegoleValutazioni.InterfacciaR004;
  InizializzaDataSet(SG741,[evBeforeEdit,
                            evBeforeInsert,
                            evBeforePost,
                            evBeforeDelete,
                            evAfterDelete,
                            evAfterPost,
                            evOnNewRecord,
                            evOnTranslateMessage]);

  S740FRegoleValutazioniMW:=TS740FRegoleValutazioniMW.Create(Self);
  S740FRegoleValutazioniMW.SG741_Funzioni:=SG741;
  S740FRegoleValutazioniMW.SG741_FunzioniOldValues.SetDataSet(SG741);
  S740FRegoleValutazioni.DButton.DataSet:=SG741;
  SG741.Open;
  S740FRegoleValutazioniMW.GetPeriodoCorrente;
end;

procedure TS740FRegoleValutazioniDtM.SG741AfterOpen(DataSet: TDataSet);
begin
  S740FRegoleValutazioniMW.SG741AfterOpen;
end;

procedure TS740FRegoleValutazioniDtM.SG741AfterScroll(DataSet: TDataSet);
begin
  inherited;
  S740FRegoleValutazioniMW.SG741AfterScroll;
end;

procedure TS740FRegoleValutazioniDtM.SG741CalcFields(DataSet: TDataSet);
begin
  inherited;
  S740FRegoleValutazioniMW.SG741CalcFields;
end;

procedure TS740FRegoleValutazioniDtM.AfterPost(DataSet: TDataSet);
var svDecorrenza:TDateTime;
    svCodice:String;
begin
  svDecorrenza:=SG741.FieldByName('DECORRENZA').AsDateTime;
  svCodice:=SG741.FieldByName('CODICE').AsString;
  inherited;
  S740FRegoleValutazioniMW.SG741AfterPost(svDecorrenza, svCodice);
end;

procedure TS740FRegoleValutazioniDtM.BeforeDelete(DataSet: TDataSet);
begin
  S740FRegoleValutazioniMW.SG741BeforeDelete;
  inherited;
end;

procedure TS740FRegoleValutazioniDtM.BeforePost(DataSet: TDataSet);
var i,k:Integer;
    res:String;
    selArray: array of Boolean;
begin
  SetLength(selArray, Length(S740FRegoleValutazioniMW.CampiOpzionali));
  for i:=0 to High(selArray) do
  begin
    selArray[i]:=False;
    k:=S740FRegoleValutazioni.clbCampiOpzionaliStampa.Items.IndexOf(S740FRegoleValutazioniMW.CampiOpzionali[i].Desc);
    if k >= 0 then
      selArray[i]:=S740FRegoleValutazioni.clbCampiOpzionaliStampa.Checked[k];
  end;
  S740FRegoleValutazioniMW.SetCampiOpzionali(selArray, 'CAMPI_OPZIONALI_STAMPA');
  for i:=0 to High(selArray) do
  begin
    selArray[i]:=False;
    k:=S740FRegoleValutazioni.clbCampiOpzionaliCompilazione.Items.IndexOf(S740FRegoleValutazioniMW.CampiOpzionali[i].Desc);
    if k >= 0 then
      selArray[i]:=S740FRegoleValutazioni.clbCampiOpzionaliCompilazione.Checked[k];
  end;
  S740FRegoleValutazioniMW.SetCampiOpzionali(selArray, 'CAMPI_OPZIONALI_COMPILAZIONE');

  //Periodo di assegn. preventiva obiettivi
  res:=S740FRegoleValutazioniMW.ValDateAssegnazione;
  if (res <> '') then
  begin
    S740FRegoleValutazioni.pgcRegole.ActivePage:=S740FRegoleValutazioni.tshP2;
    raise exception.Create(res);
  end;
  res:=S740FRegoleValutazioniMW.OrdineDateAssegnazione;
  if (res <> '') then
  begin
    S740FRegoleValutazioni.pgcRegole.ActivePage:=S740FRegoleValutazioni.tshP2;
    raise exception.Create(res);
  end;

  //Altri controlli
  res:=S740FRegoleValutazioniMW.AbilitaValutato;
  if (res <> '') then
  begin
    S740FRegoleValutazioni.pgcRegole.ActivePage:=S740FRegoleValutazioni.tshP4;
    raise exception.Create(res + S740FRegoleValutazioni.drgpAbilitaCommentiValutato.Caption + '"!');
  end;

  res:=S740FRegoleValutazioniMW.ValFirma;
  if (res <> '') then
  begin
    S740FRegoleValutazioni.pgcRegole.ActivePage:=S740FRegoleValutazioni.tshStampa;
    S740FRegoleValutazioni.pgcStampa.ActivePage:=S740FRegoleValutazioni.tshEtichette;
    raise Exception.Create(res + S740FRegoleValutazioni.gbxDatiStampa.Caption + '"!');
  end;

  res:=S740FRegoleValutazioniMW.ValFirma6;
  if (res <> '') then
  begin
    S740FRegoleValutazioni.pgcRegole.ActivePage:=S740FRegoleValutazioni.tshStampa;
    S740FRegoleValutazioni.pgcStampa.ActivePage:=S740FRegoleValutazioni.tshVarie;
    raise Exception.Create('"' + S740FRegoleValutazioni.lblDatoVariazioneValutatore.Caption + res + '!');
  end;

  SessioneOracle.ApplyUpdates([S740FRegoleValutazioniMW.SG742],True);
  S740FRegoleValutazioniMW.Assegnazioni;
  S740FRegoleValutazioniMW.Storicizzato:=InterfacciaR004.StoricizzazioneInCorso;
  res:=S740FRegoleValutazioniMW.ValAnnoObiettivi;
  if (res <> '') then
    ShowMessage(res);
  inherited;
end;

end.

