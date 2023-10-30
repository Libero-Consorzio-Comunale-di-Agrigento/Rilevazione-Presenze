unit WA006UModelliOrarioDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, medpIWMessageDlg, OracleData, A000UMessaggi, A000UInterfaccia,
  A006UMOdelliOrarioMW;

type
  TWA006FModelliOrarioDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPOORA: TStringField;
    selTabellaPERLAV: TStringField;
    selTabellaTIPOFLE: TStringField;
    selTabellaOBBLFAC: TStringField;
    selTabellaORETEOR: TStringField;
    selTabellaOREMIN: TStringField;
    selTabellaOREMAX: TStringField;
    selTabellaCOMPDETR: TStringField;
    selTabellaARRFUOENT: TStringField;
    selTabellaARRFUOUSC: TStringField;
    selTabellaARRPOS: TStringField;
    selTabellaARRNEG: TStringField;
    selTabellaTOLLPRES: TStringField;
    selTabellaMMINDPRES: TStringField;
    selTabellaFLAGPRES: TStringField;
    selTabellaCOMPNOT: TStringField;
    selTabellaMMINDMPRES: TStringField;
    selTabellaFLAGMPRES: TStringField;
    selTabellaFRAZDEB: TStringField;
    selTabellaNOTTEENTRATA: TStringField;
    selTabellaMIN_USCITA_NOTTE: TStringField;
    selTabellaINDFESTIVA: TStringField;
    selTabellaOREINDFEST: TStringField;
    selTabellaINDTURNO: TStringField;
    selTabellaMATURA_RIPCOM: TStringField;
    selTabellaTIPOMENSA: TStringField;
    selTabellaCAUOBFAC: TStringField;
    selTabellaMMMINIMI: TStringField;
    selTabellaMINPERCORR: TStringField;
    selTabellaTIMBRATURAMENSA: TStringField;
    selTabellaINTERSEZIONEMENSA: TStringField;
    selTabellaPAUSAMENSA_AUTOMATICA: TStringField;
    selTabellaPM_AUTO_URIT: TStringField;
    selTabellaDETRAUTCONT: TStringField;
    selTabellaRIENTRO_MINIMO: TStringField;
    selTabellaCOMPFASCIA: TStringField;
    selTabellaTUTTOCOMP: TStringField;
    selTabellaMINSCOSTR: TStringField;
    selTabellaORAMAX_COMPENSABILE: TStringField;
    selTabellaARRSCOSTR: TStringField;
    selTabellaARRSCOSTR_COMP: TStringField;
    selTabellaCOMPLIQ: TStringField;
    selTabellaMINIMISTR: TStringField;
    selTabellaARRIVRANG: TStringField;
    selTabellaMINGIOSTR: TStringField;
    selTabellaARROTGIOR: TStringField;
    selTabellaMAXGIOSTR: TStringField;
    selTabellaINTERUSC: TStringField;
    selTabellaSTR_DOPO_HHMAX: TStringField;
    selTabellaINDPRESSTR: TStringField;
    selTabellaINDFESTSTR: TStringField;
    selTabellaINDNOTSTR: TStringField;
    selTabellaCARENZA_OBB_NO_LIQ: TStringField;
    selTabellaRICALCOLO_DEBITO_GG: TStringField;
    selTabellaRICALCOLO_MIN: TStringField;
    selTabellaRICALCOLO_MAX: TStringField;
    selTabellaARR_ECCED_LIQ: TStringField;
    selTabellaPAUSAMENSA_ESTERNA: TStringField;
    selTabellaREGOLE_PROFILO: TStringField;
    selTabellaECC_COMP_CAUSALIZZATA: TStringField;
    selTabellaSTRRIPFASCE: TStringField;
    selTabellaCOPERTURA_CARENZA: TStringField;
    selTabellaARR_ECCED_FASCE: TStringField;
    selTabellaARROT_COMP: TStringField;
    selTabellaARR_TIMB_INTERNE: TStringField;
    selTabellaARR_ECC_FASCE_COMP: TStringField;
    selTabellaPM_RECUP_USCITA: TStringField;
    selTabellaTIMBRATURAMENSA_INTERNA: TStringField;
    selTabellaPMT_TIMB_AUTORIZZATE: TStringField;
    selTabellaPMA_PRESERVA_TIMBINFASCIA: TStringField;
    selTabellaSCOSTGG_MIN_SOGLIA: TStringField;
    selTabellaPMT_TOLLERANZA: TStringField;
    selTabellaDEBITO_RIPCOM: TStringField;
    selTabellaTIMBRATURAMENSA_DETRAZIONE: TStringField;
    selTabellaPMT_TIMB_MATURAMENSA: TStringField;
    selTabellaPMT_SOLO_TIMBMENSA: TStringField;
    selTabellaTIMBRATURAMENSA_DETRTOT: TStringField;
    selTabellaPM_OREMINIME_INF: TStringField;
    selTabellaPM_STACCO_INF: TStringField;
    selTabellaMINIMISTR_COMP: TStringField;
    selTabellaCAUSALE_FASCE: TStringField;
    selTabellaRICALCOLO_SPOSTA_PN: TStringField;
    selTabellaRICALCOLO_OFF_NOTIMB: TStringField;
    selTabellaRICALCOLO_DEB_MIN: TStringField;
    selTabellaRICALCOLO_DEB_MAX: TStringField;
    selTabellaRICALCOLO_CAUS_NEG: TStringField;
    selTabellaRICALCOLO_CAUS_POS: TStringField;
    selTabellaPMT_LIMITE_FLEX: TStringField;
    selTabellaTIMBRATURAMENSA_FLEX: TStringField;
    selTabellaXPARAM: TStringField;
    selTabellaSPEZZNONCAUS_SCARTOECC: TStringField;
    selTabellaFLEXDOPOMEZZANOTTE: TStringField;
    selTabellaINTERSEZ_AUTOGIUST: TStringField;
    selTabellaRIPCOM_GGNONLAV: TStringField;
    selTabellaPMT_STACCOMIN: TStringField;
    selTabellaPMT_USCITARIT: TStringField;
    selTabellaCAUSALI_ECCEDENZA: TStringField;
    selTabellaARRSCOSTR_SOTTOSOGLIA: TStringField;
    selTabellaRIENTRO_POMERIDIANO: TStringField;
    selTabellaFESTLAV_LIQ: TStringField;
    selTabellaFESTLAV_CMP_LIQ: TStringField;
    selTabellaFESTLAV_CMP_LIQ_TURN: TStringField;
    selTabellaD_FESTLAV_LIQ: TStringField;
    selTabellaD_FESTLAV_CMP_LIQ: TStringField;
    selTabellaD_FESTLAV_CMP_LIQ_TURN: TStringField;
    selTabellaD_CAUSALE_FASCE: TStringField;
    selTabellaCAUSALE_DISABIL_BLOCCANTE: TStringField;
    selTabellaCAUSALE_INIZIOORARIO: TStringField;
    selTabellaCAUSALE_FINEORARIO: TStringField;
    selTabellaMINUTICAUS_INIZIOORARIO: TStringField;
    selTabellaMINUTICAUS_FINEORARIO: TStringField;
    selTabellaRIPCOM_DEBITOGG: TStringField;
    selTabellaMMINDPRESMAG: TStringField;
    selTabellaCOEFF_INDPRESMAG: TFloatField;
    selTabellaORETEOR_GGASS: TStringField;
    selTabellaFESTLAV_GGSETT: TStringField;
    selTabellaCAUS_RIDUZPN: TStringField;
    selTabellaPMT_TIMBRATURAMENSA: TStringField;
    selTabellaPMT_NOOREMIN_TIMBMENSA: TStringField;
    selTabellaFASCIA_NOTTFEST_COMPLETA: TStringField;
    selTabellaINDFESTIVA_USA_NOTTE_COMPLETA: TStringField;
    selTabellaXPARAM_COMP_OLDVERS: TStringField;
    selTabellaDETRAZ_RIEPPR_NORM: TStringField;
    selTabellaORARI_SCAMBIO: TStringField;
    selTabellaSTR_NOTTE_SPEZZATO: TStringField;
    selTabellaDETRAZ_PARZ_STACCO_INF: TStringField;
    selTabellaTURNI_INIZIOORARIO: TStringField;
    selTabellaTURNI_FINEORARIO: TStringField;
    selTabellaCAUS_RIDUZPN_CHECKPMT: TStringField;
    selTabellaANOM_BLOCC_23LIV: TStringField;
    selTabellaMINUTICAUS_PRIORITARI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet);Override;
    procedure AfterCancel(DataSet: TDataSet);Override;
    procedure AfterPost(DataSet: TDataSet);Override;
    procedure BeforePost(DataSet: TDataSet);Override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure ValidateOreMinuti(Sender: TField);
  private
    function IsStoricoOttimizzato:Boolean;
    function T020FieldValue(Field: String): String;
    function GetCmbTipoMensaValue: String;
    procedure CheckConferma(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    A006MW: TA006FMOdelliOrarioMW;
  end;

implementation

uses WA006UModelliOrario, WA006UModelliOrarioDettFM;

{$R *.dfm}

procedure TWA006FModelliOrarioDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  SelTabella.SetVariable('ORDERBY','ORDER BY CODICE,DECORRENZA');
  A006MW:=TA006FMOdelliOrarioMW.Create(Self);
  A006MW.selT020:=selTabella;
  inherited;
  A006MW.evT020FieldValue:=T020FieldValue;
  A006MW.evGetCmbTipoMensaValue:=GetCmbTipoMensaValue;
  A006MW.evStoricoOttimizzato:=IsStoricoOttimizzato;
  selTabella.Open;
  SetTabelleRelazionate([selTabella,A006MW.selT021PN]);
end;

procedure TWA006FModelliOrarioDM.selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  A006MW.selT020FilterRecord(DataSet,Accept);
end;

function TWA006FModelliOrarioDM.T020FieldValue(Field: String): String;
begin
  Result:=SelTabella.FieldByName(Field).AsString;
end;

function TWA006FModelliOrarioDM.GetCmbTipoMensaValue: String;
begin
  Result:=SelTabella.FieldByName('TipoMensa').AsString;
end;

procedure TWA006FModelliOrarioDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  A006MW.SelT020AfterCancel;
end;

procedure TWA006FModelliOrarioDM.AfterPost(DataSet: TDataSet);
begin
  A006MW.SelT020AfterPostStep1;
  inherited;
  A006MW.SelT020AfterPostStep2;
end;

procedure TWA006FModelliOrarioDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A006MW.SelT020fterScroll;
  if (Self.Owner as TWA006FModelliOrario).WDettaglioFM <> nil then
  begin
    ((Self.Owner as TWA006FModelliOrario).WDettaglioFM as TWA006FModelliOrarioDettFM).grdTimbrature.medpAggiornaCDS(True);
    ((Self.Owner as TWA006FModelliOrario).WDettaglioFM as TWA006FModelliOrarioDettFM).grdPausaMensa.medpAggiornaCDS(True);
    ((Self.Owner as TWA006FModelliOrario).WDettaglioFM as TWA006FModelliOrarioDettFM).grdStraordinario.medpAggiornaCDS(True);
    ((Self.Owner as TWA006FModelliOrario).WDettaglioFM as TWA006FModelliOrarioDettFM).grdXParam.medpAggiornaCDS(True);
    ((Self.Owner as TWA006FModelliOrario).WDettaglioFM as TWA006FModelliOrarioDettFM).grdXParamComp.medpAggiornaCDS(True);
  end;
end;

procedure TWA006FModelliOrarioDM.BeforePost(DataSet: TDataSet);
begin
  A006MW.ResetVariabili;
  //Conferma della registrazione se sono abilitate le modifiche sugli storici precedenti/successivi
  if not MsgBox.KeyExists('PUNTO1') then
  begin
  if (InterfacciaWR102.StoriciPrec or InterfacciaWR102.StoriciSucc) and
     ((A006MW.selT021PN.UpdatesPending) or (A006MW.selT021PM.UpdatesPending) or (A006MW.selT021STR.UpdatesPending)) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A006_DLG_CONFERMA_REGISTRAZIONE,mtConfirmation,[mbYes,mbNo],CheckConferma,'PUNTO1');
      Abort;
    end;
  end;
  if not MsgBox.KeyExists('PUNTO2') then
  begin
    if (A006MW.selT020.State = dsEdit) and (A006MW.selT020.FieldByName('CODICE').Value <> A006MW.selT020.FieldByName('CODICE').medpOldValue) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A006_DLG_CONFERMA_MODIFICA_COD,mtConfirmation,[mbYes,mbNo],CheckConferma,'PUNTO2');
      Abort;
    end;
  end;

  A006MW.SelT020BeforePost;
  inherited;
  MsgBox.ClearKeys;
end;

procedure TWA006FModelliOrarioDM.CheckConferma(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    selTabella.Post
  else
    MsgBox.ClearKeys;
end;

procedure TWA006FModelliOrarioDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  A006MW.selT021PN.ReadOnly:=SelTabella.State = dsBrowse;
  A006MW.selT021PM.ReadOnly:=SelTabella.State = dsBrowse;
  A006MW.selT021STR.ReadOnly:=SelTabella.State = dsBrowse;
  if (Self.Owner as TWA006FModelliOrario).WDettaglioFM <> nil then
    ((Self.Owner as TWA006FModelliOrario).WDettaglioFM as TWA006FModelliOrarioDettFM).evtStateChange;
end;

procedure TWA006FModelliOrarioDM.ValidateOreMinuti(Sender: TField);
begin
  A006MW.ValidateOreMinuti(Sender);
end;

function TWA006FModelliOrarioDM.IsStoricoOttimizzato: Boolean;
begin
  Result:=StoricoOttimizzato;
end;

end.
