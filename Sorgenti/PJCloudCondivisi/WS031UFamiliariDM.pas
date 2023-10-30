unit WS031UFamiliariDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, S031UFamiliariMW, medpIWMessageDlg,
  C180FunzioniGenerali, A000UInterfaccia, A000UMessaggi, Oracle, C190FunzioniGeneraliWeb;

type
  TWS031FFamiliariDM = class(TWR302FGestTabellaDM)
    QSG101PROGRESSIVO: TFloatField;
    QSG101DECORRENZA: TDateTimeField;
    QSG101NUMORD: TFloatField;
    QSG101COGNOME: TStringField;
    QSG101NOME: TStringField;
    selTabellaMATRICOLA: TStringField;
    selTabellaCOMNAS: TStringField;
    selTabellaDATANAS: TDateTimeField;
    selTabellaGRADOPAR: TStringField;
    selTabellaTIPO_DETRAZIONE: TStringField;
    selTabellaPERC_CARICO: TFloatField;
    selTabellaDETR_FIGLIO_HANDICAP: TStringField;
    selTabellaDATAMAT: TDateTimeField;
    selTabellaDATASEP: TDateTimeField;
    selTabellaD_PROVINCIA: TStringField;
    selTabellaD_DESCOMNAS: TStringField;
    selTabellaCAPNAS: TStringField;
    selTabellaDATAADOZ: TDateTimeField;
    selTabellaSESSO: TStringField;
    selTabellaCODFISCALE: TStringField;
    selTabellaCOMPONENTE_ANF: TStringField;
    selTabellaREDDITO_ANF: TFloatField;
    selTabellaREDDITO_ALTRO_ANF: TFloatField;
    selTabellaSPECIALE_ANF: TStringField;
    selTabellaINABILE_ANF: TStringField;
    selTabellaD_CODCATASTALE: TStringField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaDATANAS_PRESUNTA: TDateTimeField;
    selTabellaCAUSALI_ABILITATE: TStringField;
    selTabellaNOME_PA: TStringField;
    selTabellaINDIRIZZO: TStringField;
    selTabellaCOMUNE: TStringField;
    selTabellaCAP: TStringField;
    selTabellaTELEFONO: TStringField;
    selTabellaDesc_Comune: TStringField;
    selTabellaProv_Comune: TStringField;
    selTabellaD_CAPNAS: TStringField;
    selTabellaD_CAP: TStringField;
    selTabellaDATA_ULT_FAM_CAR: TDateTimeField;
    selTabellaNUMGRADO: TStringField;
    selTabellaTIPOPAR: TStringField;
    selTabellaDETR_FIGLIO_100_AFFID: TStringField;
    selTabellaNOTE: TStringField;
    selTabellaDURATA_PA: TStringField;
    selTabellaANNO_AVV: TFloatField;
    selTabellaANNO_AVV_FAM: TFloatField;
    selTabellaTIPO_DISABILITA: TStringField;
    selTabellaALTERNATIVA: TStringField;
    selTabellaMOTIVO_GRADO_3_ALT: TStringField;
    selTabellaNOME_PA_ALT: TStringField;
    selTabellaMOTIVO_GRADO_3: TStringField;
    selTabellaTIPO_ADOZ_AFFID: TStringField;
    selTabellaGRAV_INIZIO_TEOR: TDateTimeField;
    selTabellaGRAV_INIZIO_SCELTA: TDateTimeField;
    selTabellaGRAV_INIZIO_EFF: TDateTimeField;
    selTabellaGRAV_FINE: TDateTimeField;
    selTabellaDATA_PREADOZ: TDateTimeField;
    selTabellaD_GRADOPAR: TStringField;
    selTabellaD_DETRAZIONE: TStringField;
    selTabellaD_TIPOPAR: TStringField;
    selTabellaD_DISABILITA: TStringField;
    selTabellaD_FAMILIARE: TStringField;
    selTabellaANNO_REVISIONE: TDateTimeField;
    selTabellaD_ANF: TStringField;
    selTabellaD_INABILE: TStringField;
    selTabellaNAZIONE: TStringField;
    selTabellaMOTIVO_ESCLUSIONE: TStringField;
    selTabellaCARTA_ID_NUMERO: TStringField;
    selTabellaCARTA_ID_DATA_RIL: TDateTimeField;
    selTabellaCARTA_ID_DATA_SCAD: TDateTimeField;
    selTabellaINSERIMENTO_CU: TStringField;
    selTabellaPASSAPORTO_NUMERO: TStringField;
    selTabellaPASSAPORTO_DATA_RIL: TDateTimeField;
    selTabellaPASSAPORTO_DATA_SCAD: TDateTimeField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet);Override;
    procedure AfterScroll(DataSet: TDataSet);Override;
    procedure BeforeDelete(DataSet: TDataSet);Override;
    procedure BeforePost(DataSet: TDataSet);Override;
    procedure OnNewRecord(DataSet: TDataSet);Override;
    procedure selTabellaMATRICOLAValidate(Sender: TField);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure DataGenericaValidate(Sender: TField);
  private
    procedure VerificaParentela;
    function VerificaStoricizzInCorso:boolean;
    function ValoriOriginali:TStringList;
    procedure ImpostaDataFamACarico(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure SvuotaDataFamACarico(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    S031FFamiliariMW:TS031FFamiliariMW;
  end;

implementation

uses WS031UFamiliari, WS031UFamiliariDettFM;

{$R *.dfm}

procedure TWS031FFamiliariDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  //Per testare il progetto
//  Parametri.Applicazione:='PAGHE';
  selTabella.SetVariable('ORDERBY','ORDER BY SG101.NUMORD');
  NonAprireSelTabella:=True;
  inherited;
  S031FFamiliariMW:=TS031FFamiliariMW.Create(Self);
  with S031FFamiliariMW do
  begin
    selSG101:=SelTabella;
    selSG101OldValues.SetDataSet(selSG101);
    ChiavePrimaria:=InterfacciaWR102.LChiavePrimaria;
    VerificaParentelaEvents:=VerificaParentela;
    VerificaStoricizzazioneEvents:=VerificaStoricizzInCorso;
    TrovaValoriOriginali:=ValoriOriginali;
  end;
  SelTabella.Open;
end;

procedure TWS031FFamiliariDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  S031FFamiliariMW.selSG101OldValues.CreaStruttura;
  if selTabella.RecordCount = 0 then
    AfterScroll(selTabella);
end;

procedure TWS031FFamiliariDM.DataGenericaValidate(Sender: TField);
begin
  inherited;
  S031FFamiliariMW.DataGenericaValidate(Sender);
end;

procedure TWS031FFamiliariDM.AfterPost(DataSet: TDataSet);
begin
  S031FFamiliariMW.QSG101AfterPost;
  inherited;
end;

procedure TWS031FFamiliariDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  S031FFamiliariMW.selSG101OldValues.Aggiorna;
  if ((Self.Owner as TWS031FFamiliari).WDettaglioFM as TWS031FFamiliariDettFM) <> nil then
    ((Self.Owner as TWS031FFamiliari).WDettaglioFM as TWS031FFamiliariDettFM).AbilitaComponenti;

  // leggo i documenti associati al familiare
  S031FFamiliariMW.AggiornaT960;

  if ((Self.Owner as TWS031FFamiliari).WDettaglioFM as TWS031FFamiliariDettFM) <> nil then
    ((Self.Owner as TWS031FFamiliari).WDettaglioFM as TWS031FFamiliariDettFM).AbilitaGrdDocumenti;
end;

procedure TWS031FFamiliariDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  S031FFamiliariMW.EliminaFamiliareSelezionato;
end;

procedure TWS031FFamiliariDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  with S031FFamiliariMW do
  begin
    if ((not selTabella.FieldByName('PASSAPORTO_DATA_RIL').IsNull) and (not selTabella.FieldByName('PASSAPORTO_DATA_SCAD').IsNull)) and
      (selTabella.FieldByName('PASSAPORTO_DATA_RIL').AsDateTime > selTabella.FieldByName('PASSAPORTO_DATA_SCAD').AsDateTime) then
    begin
      MsgBox.MessageBox('La data di rilascio passaporto deve essere antecedente alla data di scadenza.',ERRORE,'Errore','');
      Abort;
    end;
    if not MsgBox.KeyExists('PUNTO_1') then
    begin
      QSG101ValidaFields;

      if (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'DF') or (selSG101.FieldByName('PERC_CARICO').AsFloat <> 100) then
        selSG101.FieldByName('DETR_FIGLIO_100_AFFID').AsString:='N';

      if IsDataDichiarazDaAggiornare then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_S031_DLG_FMT_DATA_DICHIARAZIONE,[DateToStr(Trunc(R180Sysdate(SessioneOracle)))]),mtConfirmation,[mbYes,mbNo],ImpostaDataFamACarico,'PUNTO_1');
        Abort;
      end;
    end;
    if not MsgBox.KeyExists('PUNTO_2') then
    begin
      if IsDataDichiarazVuota then
      begin
        MsgBox.WebMessageDlg(A000MSG_S031_DLG_DATA_DICHIARAZIONE_VUOTA,mtConfirmation,[mbYes,mbNo],SvuotaDataFamACarico,'PUNTO_2');
        Abort;
      end;
    end;

    // in caso di modifica senza storicizzazione propaga i valori dei campi fissi su tutte le storicizzazioni
    if (selSG101.State = dsEdit) and (not InterfacciaWR102.StoricizzazioneInCorso) then
      AllineaDatiFissi;

    MsgBox.ClearKeys;

    QSG101ValidaFieldsNonBloccanti;
    if MsgErrore <> '' then
    begin
      MsgBox.WebMessageDlg('Attenzione: ' + CRLF + MsgErrore + A000MSG_P000_MSG_DATI_SALVATI,mtInformation,[mbOk],nil,'');
      MsgErrore:='';
    end;
  end;
end;

procedure TWS031FFamiliariDM.ImpostaDataFamACarico(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    ((Self.Owner as TWS031FFamiliari).WDettaglioFM as TWS031FFamiliariDettFM).dedtUltimaDich.Text:=DateToStr(Trunc(R180Sysdate(SessioneOracle)));
  selTabella.Post;
end;

procedure TWS031FFamiliariDM.SvuotaDataFamACarico(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    selTabella.Post
  else
    MsgBox.ClearKeys;
end;

procedure TWS031FFamiliariDM.OnNewRecord(DataSet: TDataSet);
begin
  S031FFamiliariMW.QSG101NuovoRecord;
  inherited;
end;

procedure TWS031FFamiliariDM.selTabellaMATRICOLAValidate(Sender: TField);
begin
  S031FFamiliariMW.QSG101ValidaMatricola;
  if selTabella.FieldByName('DATANAS').IsNull then
    ((Self.Owner as TWS031FFamiliari).WDettaglioFM as TWS031FFamiliariDettFM).dedtDataNas.Text:=''
  else
    ((Self.Owner as TWS031FFamiliari).WDettaglioFM as TWS031FFamiliariDettFM).dedtDataNas.Text:=FormatDateTime('dd/mm/yyyy hh:nn',selTabella.FieldByName('DATANAS').AsDateTime);
end;

function TWS031FFamiliariDM.ValoriOriginali: TStringList;
begin
  Result:=InterfacciaWR102.LValoriOriginali;
end;

procedure TWS031FFamiliariDM.VerificaParentela;
begin
  with ((Self.Owner as TWS031FFamiliari).WDettaglioFM as TWS031FFamiliariDettFM) do
  begin
    S031FFamiliariMW.cmbParentelaSelItemIndex:=cmbParentela.ItemIndex;
    S031FFamiliariMW.cmbTipoParSelItemIndex:=cmbTipoPar.ItemIndex;
    S031FFamiliariMW.cmbMotivoTerzoGradoSelItemIndex:=cmbMotivoTerzoGrado.ItemIndex;
    S031FFamiliariMW.cmbTipoAdozSelItemIndex:=cmbTipoAdoz.ItemIndex;
    S031FFamiliariMW.cmbTipoDisabilitaSelItemIndex:=cmbTipoDisabilita.ItemIndex;
    S031FFamiliariMW.cmbDurataContrattoSelItemIndex:=cmbDurataContratto.ItemIndex;
    S031FFamiliariMW.cmbAlternativaSelItemIndex:=cmbAlternativa.ItemIndex;
    S031FFamiliariMW.cmbAlternativaMotivoTerzoGradoSelItemIndex:=cmbAlternativaMotivoTerzoGrado.ItemIndex;
    S031FFamiliariMW.cmbNomeSelPAText:=cmbNomePA.Text;
    S031FFamiliariMW.cmbAlternativaNomeSelPAText:=cmbAlternativaNomePA.Text;
    S031FFamiliariMW.cmbMotivoEsclusioneSelItemIndex:=cmbMotivoEsclusione.ItemIndex;
  end;
  S031FFamiliariMW.AllineaParentela;
end;

function TWS031FFamiliariDM.VerificaStoricizzInCorso: boolean;
begin
  Result:=InterfacciaWR102.StoricizzazioneInCorso;
end;

end.
