unit WA020UCausPresenzeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, medpIWMessageDlg, C180FunzioniGenerali,
  A000UInterfaccia, A000UMessaggi, A020UCausPresenzeMW, A020UCausPresenzeStoricoMW;

type
  TWA020FCausPresenzeDM = class(TWR302FGestTabellaDM)
    selTabellaCodice: TStringField;
    selTabellaDescrizione: TStringField;
    selTabellaCodRaggr: TStringField;
    selTabellaTipoConteggio: TStringField;
    selTabellaRipFasce: TStringField;
    selTabellaOreNormali: TStringField;
    selTabellaArrotondamento: TFloatField;
    selTabellaStampe: TStringField;
    selTabellaScostamento: TDateTimeField;
    selTabellaVocePaghe1: TStringField;
    selTabellaVocePaghe2: TStringField;
    selTabellaVocePaghe3: TStringField;
    selTabellaVocePaghe4: TStringField;
    selTabellaVOCEPAGHELIQ1: TStringField;
    selTabellaVOCEPAGHELIQ2: TStringField;
    selTabellaVOCEPAGHELIQ3: TStringField;
    selTabellaVOCEPAGHELIQ4: TStringField;
    selTabellaLIQUIDABILE: TStringField;
    selTabellaD_CodRaggr: TStringField;
    selTabellaDETREPERIB: TStringField;
    selTabellaRIPLIQ: TStringField;
    selTabellaMATURAMENSA: TStringField;
    selTabellaSIGLA: TStringField;
    selTabellaMAXMINUTI: TIntegerField;
    selTabellaPIANIFREP: TStringField;
    selTabellaLFSCAVMEZ: TStringField;
    selTabellaABBATTE_BUDGET: TStringField;
    selTabellaRESIDUABILE: TStringField;
    selTabellaMINMINUTI: TIntegerField;
    selTabellaTIPO_MINMINIMI: TStringField;
    selTabellaTIPO_NONAUTORIZZATE: TStringField;
    selTabellaTIPO_U_NONAUTORIZZATE: TStringField;
    selTabellaGETTONE_ORE: TStringField;
    selTabellaGETTONE_TIPO_OREINF: TStringField;
    selTabellaGETTONE_TIPO_ORESUP: TStringField;
    selTabellaGETTONE_INDENNITA: TStringField;
    selTabellaGETTONE_SPEZZONI: TStringField;
    selTabellaLIMITE_DEBITOGG: TStringField;
    selTabellaSENZA_FLESSIBILITA: TStringField;
    selTabellaNO_LIMITE_MENSILE_LIQ: TStringField;
    selTabellaSCOST_PUNTI_NOMINALI: TStringField;
    selTabellaSTACCO_MINIMO_SCOST: TStringField;
    selTabellaNO_ECCEDENZA_IN_FASCIA: TStringField;
    selTabellaLINK_ASSENZA: TStringField;
    selTabellaD_LINK_ASSENZA: TStringField;
    selTabellaCOMPETENZE_AUTOGIUST: TStringField;
    selTabellaESCLUSIONE_FASCIA_OBB: TStringField;
    selTabellaFLESSIBILITA_ORARIO: TStringField;
    selTabellaSOGLIA_FASCE_OBBLFAC: TIntegerField;
    selTabellaRESIDUO_LIQUIDABILE: TStringField;
    selTabellaCAUS_FUORI_TURNO: TStringField;
    selTabellaPERC_INAIL: TStringField;
    selTabellaGETTONE_DALLE: TStringField;
    selTabellaGETTONE_ALLE: TStringField;
    selTabellaTIMB_PM: TStringField;
    selTabellaINCLUDI_INDTURNO: TStringField;
    selTabellaARROT_RIEPGG: TStringField;
    selTabellaARROT_RIEPGG_ORENORM: TStringField;
    selTabellaARROT_RIEPGG_FASCE: TStringField;
    selTabellaE_IN_FLESSIBILITA: TStringField;
    selTabellaAUTOGIUST_DALLEALLE: TStringField;
    selTabellaUM_INSERIMENTO_H: TStringField;
    selTabellaUM_INSERIMENTO_D: TStringField;
    selTabellaCOMP_CAUS_OREMAX: TStringField;
    selTabellaAUTOCOMPLETAMENTO_UE: TStringField;
    selTabellaTIPO_RICHIESTA_WEB: TStringField;
    selTabellaCONSIDERA_SCELTA_ORARIO: TStringField;
    selTabellaFLEX_TIMBR_CAUS: TStringField;
    selTabellaINCLUSIONE_SALDI_CAUSALI: TStringField;
    selTabellaFORZA_NOTTE_SPEZZATA: TStringField;
    selTabellaCAUSALIZZA_TIMB_INTERSECANTI: TStringField;
    selTabellaTIMB_PM_DETRAZ: TStringField;
    selTabellaPERIODICITA_ABBATTIMENTO: TIntegerField;
    selTabellaGIUST_DAA_TIMB: TStringField;
    selTabellaCUMULA_RICHIESTE_WEB: TStringField;
    selTabellaINTERSEZIONE_TIMBRATURE: TStringField;
    selTabellaSEMPRE_APPOGGIATA: TStringField;
    selTabellaNO_ECCED_IN_FASCIA_CONS_ASS: TStringField;
    selTabellaD_GETTONE_INDENNITA: TStringField;
    selTabellaD_CAUS_FUORI_TURNO: TStringField;
    selTabellaCAUSCOMP_DEBITOGG: TStringField;
    selTabellaFORZA_CAUSECCEDENZA: TStringField;
    selTabellaLIQUIDAZIONE_MESIPREC: TStringField;
    selTabellaNO_LIMITE_ANNUALE_LIQ: TStringField;
    selTabellaINSERIMENTO_TIMB: TStringField;
    selTabellaINSERIMENTO_TIMBVIRT: TStringField;
    selTabellaTIMB_PM_H: TStringField;
    selTabellaID: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterCancel(DataSet: TDataSet);override;
    procedure AfterPost(DataSet: TDataSet);override;
    procedure AfterScroll(DataSet: TDataSet);override;
    procedure BeforeDelete(DataSet: TDataSet);override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure BeforePostNoStorico(DataSet: TDataSet);Override;
    procedure selTabellaCodRaggrChange(Sender: TField);
    procedure selTabellaScostamentoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure selTabellaScostamentoSetText(Sender: TField; const Text: string);
    procedure selTabellaArrotondamentoValidate(Sender: TField);
    procedure selTabellaCodiceValidate(Sender: TField);
    procedure selTabellaRESIDUABILEValidate(Sender: TField);
    procedure selTabellaGETTONE_OREValidate(Sender: TField);
    procedure OnNewRecord(DataSet: TDataSet);override;
    procedure dsrTabellaStateChange(Sender: TObject);
  private
    IsSelTabellaDelete: boolean;
    procedure RefreshVociPagheGrid;
    procedure ShowMessage(Msg: String);
    procedure CheckGrdTipoGiorno(TipoGiorno: String);
    procedure ControlloVociPagheBeforeDelete(Msg: String);
    procedure ControlloVociPagheBeforePost(Msg: String);
    procedure ControlloVocePaghe1(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ControlloVocePaghe2(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ControlloVocePaghe3(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ControlloVocePaghe4(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ControlloVocePagheLiq1(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ControlloVocePagheLiq2(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ControlloVocePagheLiq3(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ControlloVocePagheLiq4(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ControlloVocePaghe(FieldName: String; Res: TmeIWModalResult);
    procedure VociPagheBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure VociPagheBeforeDelete(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    A020MW:TA020FCausPresenzeMW;
    A020StoricoMW:TA020FCausPresenzeStoricoMW;
    ParamStoricizMostraSoloPeriodoCorrente:Boolean;
    procedure PreparaDataSetParamStorici;
    procedure AggiornaCDSParamStoriciz(DataPeriodo:TDateTime);
  end;

implementation

uses WA020UCausPresenze, WA020UCausPresenzeDettFM, WA020UCausPresenzeBrowseFM;

{$R *.dfm}

procedure TWA020FCausPresenzeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  NonAprireSelTabella:=True;
  A020StoricoMW:=TA020FCausPresenzeStoricoMW.Create(Self);
  inherited;
  IsSelTabellaDelete:=False;
  A020MW:=TA020FCausPresenzeMW.Create(Self);
  A020MW.SelT275:=SelTabella;
  A020MW.CheckTipoGiorno:=CheckGrdTipoGiorno;
  A020MW.ShowCustomMessage:=ShowMessage;
  A020MW.ControlloVociPagheBeforeDelete:=ControlloVociPagheBeforeDelete;
  A020MW.ControlloVociPagheBeforePost:=ControlloVociPagheBeforePost;
  A020MW.RefreshVociPagheGrid:=RefreshVociPagheGrid;
  A020MW.InizializzaDataSet;
  A020MW.SelT277.Open;
  A020MW.selT276.Open;
  SelTabella.Open;
end;

procedure TWA020FCausPresenzeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  if A020MW <> nil then
    FreeAndNil(A020MW);
end;

procedure TWA020FCausPresenzeDM.OnNewRecord(DataSet: TDataSet);
begin
  A020MW.T275AfterScroll;
  inherited;
end;

procedure TWA020FCausPresenzeDM.selTabellaArrotondamentoValidate(Sender: TField);
begin
  A020MW.ValidataArrotondamento(Sender);
end;

procedure TWA020FCausPresenzeDM.selTabellaCodiceValidate(Sender: TField);
begin
  A020MW.T275CodiceValidate;
end;

procedure TWA020FCausPresenzeDM.selTabellaCodRaggrChange(Sender: TField);
begin
  inherited;
  ((Self.Owner as TWA020FCausPresenze).WDettaglioFM as TWA020FCausPresenzeDettFM).AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDM.selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  A020MW.FilterRecord(DataSet,Accept);
end;

procedure TWA020FCausPresenzeDM.selTabellaGETTONE_OREValidate(Sender: TField);
begin
  R180OraValidate(Sender.AsString);
end;

procedure TWA020FCausPresenzeDM.selTabellaRESIDUABILEValidate(Sender: TField);
begin
  OreMinutiValidate(Sender.AsString);
end;

procedure TWA020FCausPresenzeDM.selTabellaScostamentoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TWA020FCausPresenzeDM.selTabellaScostamentoSetText(Sender: TField; const Text: string);
begin
  A020MW.ValidataCampoOra(Sender,Text);
end;

procedure TWA020FCausPresenzeDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  A020MW.T275AfterCancel;
end;

procedure TWA020FCausPresenzeDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A020MW.T275AfterPost;
end;

procedure TWA020FCausPresenzeDM.AfterScroll(DataSet: TDataSet);
var
  FMDettaglio:TWA020FCausPresenzeDettFM;
begin
  FMDettaglio:=((Self.Owner as TWA020FCausPresenze).WDettaglioFM as TWA020FCausPresenzeDettFM);
  A020MW.T275AfterScroll;
  inherited;
  A020StoricoMW.SvuotaCDSStoriaDati;
  if FMDettaglio <> nil then
    FMDettaglio.cmbDecParStor.Items.Clear;

  if (selTabella.State <> dsInsert) and (not InterfacciaWR102.CopiaInCorso) and
     (selTabella.RecordCount > 0) then
  begin
    PreparaDataSetParamStorici;
    AggiornaCDSParamStoriciz(Parametri.DataLavoro);
  end;

  if FMDettaglio <> nil then
  begin
    FMDettaglio.AggiornaGridParamStoricizzati;
    FMDettaglio.btnModificaParStor.Enabled:=not(selTabella.State in [dsEdit,dsInsert]);
  end;
end;

procedure TWA020FCausPresenzeDM.BeforeDelete(DataSet: TDataSet);
begin
  IsSelTabellaDelete:=True;
  A020MW.T275BeforeDelete;
  IsSelTabellaDelete:=False;
  inherited;
  //Massimo 23/05/2013  nell'elaborazione del beforeDelete possono essere visualizzati dei messaggi all'utente.
  //Se l'utente sceglie di proseguire viene rifatto il Delete del DataSet; ma a questo punto il CDS non verrebbe più
  //aggiornato perchè non viene più richiamato 'actEliminaExecute' di WR102UGestTabella.
  ((Self.Owner as TWA020FCausPresenze).WBrowseFM as TWA020FCausPresenzeBrowseFM).grdTabella.medpAggiornaCDS;
end;

procedure TWA020FCausPresenzeDM.BeforePostNoStorico(DataSet: TDataSet);
{Controllo che il codice non sia già usato per altre causali}
var VoceOld:String;
begin
  with A020MW do
  begin
    T275BeforePostStep1;
    // Controllo voci paghe
    // voce paghe 1
    if not MsgBox.KeyExists('CHECK_VOCEPAGHE1') then
    begin
      if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHE1').medpOldValue = null) then
        VoceOld:=''
      else
        VoceOld:=selT275.FieldByName('VOCEPAGHE1').medpOldValue;
      if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHE1').AsString) then
      begin
        MsgBox.WebMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ControlloVocePaghe1,'CHECK_VOCEPAGHE1');
        Abort;
      end;
    end;
    // voce paghe 2
    if not MsgBox.KeyExists('CHECK_VOCEPAGHE2') then
    begin
      if (DataSet.State = dsInsert)  or (selT275.FieldByName('VOCEPAGHE2').medpOldValue = null) then
        VoceOld:=''
      else
        VoceOld:=selT275.FieldByName('VOCEPAGHE2').medpOldValue;
      if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHE2').AsString) then
      begin
        MsgBox.WebMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ControlloVocePaghe2,'CHECK_VOCEPAGHE2');
        Abort;
      end;
    end;
    // voce paghe 3
    if not MsgBox.KeyExists('CHECK_VOCEPAGHE3') then
    begin
      if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHE3').medpOldValue = null)  then
        VoceOld:=''
      else
        VoceOld:=selT275.FieldByName('VOCEPAGHE3').medpOldValue;
      if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHE3').AsString) then
      begin
        MsgBox.WebMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ControlloVocePaghe3,'CHECK_VOCEPAGHE3');
        Abort;
      end;
   end;
   // voce paghe 4
   if not MsgBox.KeyExists('CHECK_VOCEPAGHE4') then
   begin
      if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHE4').medpOldValue = null) then
        VoceOld:=''
      else
        VoceOld:=selT275.FieldByName('VOCEPAGHE4').medpOldValue;
      if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHE4').AsString) then
      if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHE3').AsString) then
      begin
        MsgBox.WebMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ControlloVocePaghe4,'CHECK_VOCEPAGHE4');
        Abort;
      end;
   end;
   // voce paghe liq. 1
   if not MsgBox.KeyExists('CHECK_VOCEPAGHELIQ1') then
   begin
    if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHELIQ1').medpOldValue = null)  then
      VoceOld:=''
    else
      VoceOld:=selT275.FieldByName('VOCEPAGHELIQ1').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHELIQ1').AsString) then
    begin
      MsgBox.WebMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ControlloVocePagheLiq1,'CHECK_VOCEPAGHELIQ1');
      Abort;
    end;
   end;
   // voce paghe liq. 2
   if not MsgBox.KeyExists('CHECK_VOCEPAGHELIQ2') then
   begin
    if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHELIQ2').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selT275.FieldByName('VOCEPAGHELIQ2').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHELIQ2').AsString) then
    begin
      MsgBox.WebMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ControlloVocePagheLiq2,'CHECK_VOCEPAGHELIQ2');
      Abort;
    end;
   end;
   // voce paghe liq. 3
    if not MsgBox.KeyExists('CHECK_VOCEPAGHELIQ3') then
    begin
      if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHELIQ3').medpOldValue = null) then
        VoceOld:=''
      else
        VoceOld:=selT275.FieldByName('VOCEPAGHELIQ3').medpOldValue;
      if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHELIQ3').AsString) then
      begin
        MsgBox.WebMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ControlloVocePagheLiq3,'CHECK_VOCEPAGHELIQ3');
        Abort;
      end;
    end;
    // voce paghe liq. 4
    if not MsgBox.KeyExists('CHECK_VOCEPAGHELIQ4') then
    begin
      if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHELIQ4').medpOldValue = null) then
        VoceOld:=''
      else
        VoceOld:=selT275.FieldByName('VOCEPAGHELIQ4').medpOldValue;
      if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHELIQ4').AsString) then
       begin
        MsgBox.WebMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ControlloVocePagheLiq4,'CHECK_VOCEPAGHELIQ4');
        Abort;
      end;
    end;
    if not selT275.FieldByName('ARROT_RIEPGG').IsNull then
      R180OraValidate(selT275.FieldByName('ARROT_RIEPGG').AsString);
    T275BeforePostStep2;
  end;
  MsgBox.ClearKeys;
  inherited;
end;

procedure TWA020FCausPresenzeDM.CheckGrdTipoGiorno(TipoGiorno: String);
begin
  (*
  if R180IndexOf(A020FCausPresenze.dGrdFasce.Columns[0].Picklist,TipoGiorno,1) = -1 then
    raise Exception.Create(A000MSG_A020_ERR_TIPO_GIORNO);
  *)
  if ((Self.Owner as TWA020FCausPresenze).WDettaglioFM as TWA020FCausPresenzeDettFM).grdFasce.medpDataSet.FieldByName('TIPO_GIORNO').AsString = '' then
    raise Exception.Create(A000MSG_A020_ERR_TIPO_GIORNO);
end;

procedure TWA020FCausPresenzeDM.ControlloVociPagheBeforeDelete(Msg: String);
begin
  if not MsgBox.KeyExists('VociPagheBeforeDelete') then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],VociPagheBeforeDelete,'VociPagheBeforeDelete');
    Abort;
  end;
  MsgBox.ClearKeys;
end;

procedure TWA020FCausPresenzeDM.VociPagheBeforeDelete(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    if IsSelTabellaDelete then
      SelTabella.Delete
    else
      A020MW.SelT276.Delete;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA020FCausPresenzeDM.ControlloVociPagheBeforePost(Msg: String);
begin
  if not MsgBox.KeyExists('VociPagheBeforePost') then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],VociPagheBeforePost,'VociPagheBeforePost');
    Abort;
  end;
  MsgBox.ClearKeys;
end;

procedure TWA020FCausPresenzeDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  A020MW.selT276.ReadOnly:=not(SelTabella.State in [dsEdit]);
  A020MW.selT277.ReadOnly:=not(SelTabella.State in [dsEdit]);
  if ((Self.Owner as TWA020FCausPresenze).WDettaglioFM <> nil) then
    ((Self.Owner as TWA020FCausPresenze).WDettaglioFM as TWA020FCausPresenzeDettFM).EvtStateChange;
end;

procedure TWA020FCausPresenzeDM.VociPagheBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    A020MW.SelControlloVociPaghe.ValutaInserimentoVocePaghe(A020MW.selT276.FieldByName('VOCEPAGHE').AsString);
    A020MW.selT276.Post;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA020FCausPresenzeDM.RefreshVociPagheGrid;
begin
  //Massimo 23/05/2013  la griglia in questione, nel beforePost, potrebbe visualizzare dei messaggi all'utente.
  //Se l'utente sceglie di proseguire viene rifatto il Post del DataSet; ma a questo punto il CDS non verrebbe più
  //aggiornato perchè non viene più richiamato 'imgCancellaClick' di medpIWDBGrid. ES: cancellare un record dalla tabella grdVociSuddivise
  ((Self.Owner as TWA020FCausPresenze).WDettaglioFM as TWA020FCausPresenzeDettFM).grdVociSuddivise.medpAggiornaCDS;
end;

procedure TWA020FCausPresenzeDM.ShowMessage(Msg: String);
begin
  MsgBox.WebMessageDlg(Msg,mtInformation,[mbOK],nil,'');
end;

procedure TWA020FCausPresenzeDM.ControlloVocePaghe1(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  ControlloVocePaghe('VOCEPAGHE1',Res);
end;

procedure TWA020FCausPresenzeDM.ControlloVocePaghe2(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  ControlloVocePaghe('VOCEPAGHE2',Res);
end;

procedure TWA020FCausPresenzeDM.ControlloVocePaghe3(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  ControlloVocePaghe('VOCEPAGHE3',Res);
end;

procedure TWA020FCausPresenzeDM.ControlloVocePaghe4(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  ControlloVocePaghe('VOCEPAGHE4',Res);
end;

procedure TWA020FCausPresenzeDM.ControlloVocePagheLiq1(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  ControlloVocePaghe('VOCEPAGHELIQ1',Res);
end;

procedure TWA020FCausPresenzeDM.ControlloVocePagheLiq2(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  ControlloVocePaghe('VOCEPAGHELIQ2',Res);
end;

procedure TWA020FCausPresenzeDM.ControlloVocePagheLiq3(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  ControlloVocePaghe('VOCEPAGHELIQ3',Res);
end;

procedure TWA020FCausPresenzeDM.ControlloVocePagheLiq4(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  ControlloVocePaghe('VOCEPAGHELIQ4',Res);
end;

procedure TWA020FCausPresenzeDM.ControlloVocePaghe(FieldName: String;Res: TmeIWModalResult);
begin
  if Res = mrYes then
  begin
    A020MW.SelControlloVociPaghe.ValutaInserimentoVocePaghe(A020MW.SelT275.FieldByName(FieldName).AsString);
    SelTabella.Post;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA020FCausPresenzeDM.PreparaDataSetParamStorici;
var
  FMDettaglio:TWA020FCausPresenzeDettFM;
  ElencoDecorrenze:TArray<TDateTime>;
  I,IdCausale:Integer;
begin
  FMDettaglio:=((Self.Owner as TWA020FCausPresenze).WDettaglioFM as TWA020FCausPresenzeDettFM);
  IdCausale:=selTabella.FieldByName('ID').AsInteger;
  A020StoricoMW.Inizializza(IdCausale);
  A020StoricoMW.ApriT235;

  if (A020StoricoMW.selT235.RecordCount = 0) then
  begin
    // Se per qualche motivo nella tabella dei parametri storicizzati non è presente
    // neanche un record corrispondente a questa causale, ne creiamo uno di default.
    A020StoricoMW.ChiudiT235;
    A020StoricoMW.CreaRecordVuoto(IdCausale);
    A020StoricoMW.ApriT235;
  end;

  // Controlli decorrenza parametri storicizzati
  A020StoricoMW.ElaboraArrayDecorrenze(Parametri.DataLavoro);

  if FMDettaglio <> nil then
  begin
    FMDettaglio.chkVistaPeriodoCorr.Checked:=False;
    // Combo date decorrenza
    ElencoDecorrenze:=A020StoricoMW.Decorrenze;
    for I:=0 to (Length(ElencoDecorrenze) - 1) do
    begin
      FMDettaglio.cmbDecParStor.Items.Add(DateToStr(ElencoDecorrenze[I])); // Uso il FormatSettings globale
    end;
    FMDettaglio.cmbDecParStor.ItemIndex:=A020StoricoMW.IndiceDecorrenzaCorrente;
  end;
end;

procedure TWA020FCausPresenzeDM.AggiornaCDSParamStoriciz(DataPeriodo:TDateTime);
begin
  A020StoricoMW.ElaboraStoriaDati(DataPeriodo);
  A020StoricoMW.ValorizzaCDSStoriaDati;
end;

end.
