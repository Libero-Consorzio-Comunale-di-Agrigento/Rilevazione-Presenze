unit WS740URegoleValutazioniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  S740URegoleValutazioniMW, A000UInterfaccia, C180FunzioniGenerali, medpIWMessageDlg;

type
  TWS740FRegoleValutazioniDM = class(TWR302FGestTabellaDM)
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaFILTRO_ANAGRAFE: TStringField;
    selTabellaPATH_ISTRUZIONI: TStringField;
    selTabellaPATH_INFORMAZIONI: TStringField;
    selTabellaCOD_TIPI_RAPPORTO: TStringField;
    selTabellaGIORNI_MINIMI: TIntegerField;
    selTabellaVALUTA_CESSATI_RUOLO: TStringField;
    selTabellaPAGINE_ABILITATE: TStringField;
    selTabellaAGGIORNA_DATA_COMPILAZIONE: TStringField;
    selTabellaLOGO_LARGHEZZA: TIntegerField;
    selTabellaLOGO_ALTEZZA: TIntegerField;
    selTabellaDATO_STAMPA_1: TStringField;
    selTabellaDESC_LUNGA_1: TStringField;
    selTabellaDATO_STAMPA_2: TStringField;
    selTabellaDATO_STAMPA_3: TStringField;
    selTabellaDESC_LUNGA_3: TStringField;
    selTabellaDATO_STAMPA_4: TStringField;
    selTabellaDATO_STAMPA_5: TStringField;
    selTabellaDESC_LUNGA_5: TStringField;
    selTabellaSTAMPA_VARIAZIONI_5: TStringField;
    selTabellaDATO_STAMPA_6: TStringField;
    selTabellaDATO_VARIAZIONE_VALUTATORE: TStringField;
    selTabellaTESTO_VALUTAZIONI_COMPLESSIVE: TStringField;
    selTabellaASSEGN_PREVENTIVA_OBIETTIVI: TStringField;
    selTabellaDATA_DA_OBIETTIVI: TDateTimeField;
    selTabellaDATA_A_OBIETTIVI: TDateTimeField;
    selTabellaABILITA_AREE_FORMATIVE: TStringField;
    selTabellaAREA_FORMATIVA_OBBLIGATORIA: TStringField;
    selTabellaABILITA_ACCETTAZIONE_VALUTATO: TStringField;
    selTabellaABILITA_COMMENTI_VALUTATO: TStringField;
    selTabellaCAMPI_OPZIONALI_STAMPA: TStringField;
    selTabellaCAMPI_OPZIONALI_COMPILAZIONE: TStringField;
    selTabellaSTAMPA_PERIODO_VALUTAZIONE: TStringField;
    selTabellaMODIFICA_NOTE_SUPERVISOREVALUT: TStringField;
    selTabellaPATH_FILEPDF: TStringField;
    selTabellaCOD_PARPROTOCOLLO: TStringField;
    selTabellaD_PARPROTOCOLLO: TStringField;
    selTabellaINVIO_EMAIL: TStringField;
    selTabellaCOMMENTI_VALUTATO_DIP: TStringField;
    selTabellaREGISTRA_DATA_ACCETTAZIONE_VAL: TStringField;
    selTabellaTIPO_ARROTONDAMENTO: TStringField;
    selTabellaTESTO_AVVISO_PRESA_VISIONE: TStringField;
    selTabellaCODTIPOQUOTA_STAMPA: TStringField;
    selTabellaD_TIPOQUOTA_STAMPA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet);  override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selTabellaAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    S740FRegoleValutazioniMW: TS740FRegoleValutazioniMW;
  end;

implementation

{$R *.dfm}
uses
  WR102UGestTabella, WS740URegoleValutazioniDettFM;


procedure TWS740FRegoleValutazioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE, DECORRENZA');
  S740FRegoleValutazioniMW:=TS740FRegoleValutazioniMW.Create(Self);
  S740FRegoleValutazioniMW.SG741_Funzioni:=selTabella;
  S740FRegoleValutazioniMW.SG741_FunzioniOldValues.SetDataSet(selTabella);
  inherited;
end;

procedure TWS740FRegoleValutazioniDM.AfterPost(DataSet: TDataSet);
var svDecorrenza:TDateTime;
    svCodice:String;
begin
  svDecorrenza:=selTabella.FieldByName('DECORRENZA').AsDateTime;
  svCodice:=selTabella.FieldByName('CODICE').AsString;
  inherited;
  S740FRegoleValutazioniMW.SG741AfterPost(svDecorrenza, svCodice);
end;

procedure TWS740FRegoleValutazioniDM.AfterScroll(DataSet: TDataSet);
begin
  S740FRegoleValutazioniMW.SG741AfterScroll;
  inherited;
end;

procedure TWS740FRegoleValutazioniDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  S740FRegoleValutazioniMW.SG741AfterOpen;
end;

procedure TWS740FRegoleValutazioniDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  S740FRegoleValutazioniMW.SG741CalcFields;
end;

procedure TWS740FRegoleValutazioniDM.BeforeDelete(DataSet: TDataSet);
begin
  S740FRegoleValutazioniMW.SG741BeforeDelete;
  inherited;
end;

procedure TWS740FRegoleValutazioniDM.BeforePost(DataSet: TDataSet);
var pos:Integer;
    res, err:String;
begin
  inherited;
  res:=S740FRegoleValutazioniMW.ValDateAssegnazione;
  if (res <> '') then
  begin
    ((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).grdTabDetail.ActiveTab:=((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).WS740ObiettiviRG;
    raise exception.Create(res);
  end;

  res:=S740FRegoleValutazioniMW.OrdineDateAssegnazione;
  if (res <> '') then
  begin
    ((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).grdTabDetail.ActiveTab:=((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).WS740ObiettiviRG;
    raise exception.Create(res);
  end;

  res:=S740FRegoleValutazioniMW.AbilitaValutato;
  if (res <> '') then
  begin
    ((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).grdTabDetail.ActiveTab:=((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).WS740CommentiRG;
    pos:=selTabella.FieldByName('ABILITA_COMMENTI_VALUTATO').AsInteger - 1;
    err:=(TWS740FRegoleValutazioniDettFM(TWR102FGestTabella(Self.Owner).WDettaglioFM)).drgpAbilitaCommentiValutato.Items[pos];
    raise exception.Create(res + err + '"!');
  end;

  res:=S740FRegoleValutazioniMW.ValFirma;
  if (res <> '') then
  begin
  ((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).grdTabDetail.ActiveTab:=((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).WS740StampaRG;
  ((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).grdTabDetail2.ActiveTab:=((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).WS740DatiAnagraficiRG;
    raise Exception.Create(res + (TWS740FRegoleValutazioniDettFM(TWR102FGestTabella(Self.Owner).WDettaglioFM)).lblDatiDaStampare.Caption + '"!');
  end;

  res:=S740FRegoleValutazioniMW.ValFirma6;
  if (res <> '') then
  begin
    ((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).grdTabDetail.ActiveTab:=((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).WS740StampaRG;
    ((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).grdTabDetail2.ActiveTab:=((Self.Owner as TWR102FGestTabella).WDettaglioFM  as TWS740FRegoleValutazioniDettFM).WS740VarieRG;
    raise Exception.Create('"' + (TWS740FRegoleValutazioniDettFM(TWR102FGestTabella(Self.Owner).WDettaglioFM)).lblDatoVariazioneValutatore.Caption + res + '!');
  end;

  SessioneOracle.ApplyUpdates([S740FRegoleValutazioniMW.SG742],True);
  S740FRegoleValutazioniMW.Assegnazioni;
  S740FRegoleValutazioniMW.Storicizzato:=InterfacciaWR102.StoricizzazioneInCorso;

  res:=S740FRegoleValutazioniMW.ValAnnoObiettivi;
  if (res <> '') then
  begin
    MsgBox.WebMessageDlg(res,mtInformation,[mbOk],nil,'');
  end;
end;

procedure TWS740FRegoleValutazioniDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(S740FRegoleValutazioniMW);
  inherited;
end;

end.
