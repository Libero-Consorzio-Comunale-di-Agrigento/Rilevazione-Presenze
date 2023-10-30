unit S031UFamiliariDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Db, Oracle, OracleData, A000UCostanti, A000USessione,A000UInterfaccia,
  C180FUNZIONIGENERALI, C700USelezioneAnagrafe, Variants, S031UFamiliariMW, A000UMessaggi;

type
  TS031FFamiliariDtM = class(TR004FGestStoricoDtM)
    QSG101: TOracleDataSet;
    QSG101PROGRESSIVO: TFloatField;
    QSG101DECORRENZA: TDateTimeField;
    QSG101NUMORD: TFloatField;
    QSG101COGNOME: TStringField;
    QSG101NOME: TStringField;
    QSG101COMNAS: TStringField;
    QSG101DATANAS: TDateTimeField;
    QSG101GRADOPAR: TStringField;
    QSG101TIPO_DETRAZIONE: TStringField;
    QSG101PERC_CARICO: TFloatField;
    QSG101DATAMAT: TDateTimeField;
    QSG101DATASEP: TDateTimeField;
    QSG101D_PROVINCIA: TStringField;
    QSG101D_DESCOMNAS: TStringField;
    QSG101DETR_FIGLIO_HANDICAP: TStringField;
    QSG101MATRICOLA: TStringField;
    dsrT030: TDataSource;
    QSG101DATAADOZ: TDateTimeField;
    QSG101SESSO: TStringField;
    QSG101CODFISCALE: TStringField;
    QSG101COMPONENTE_ANF: TStringField;
    QSG101REDDITO_ANF: TFloatField;
    QSG101REDDITO_ALTRO_ANF: TFloatField;
    QSG101SPECIALE_ANF: TStringField;
    QSG101INABILE_ANF: TStringField;
    QSG101D_CODCATASTALE: TStringField;
    QSG101DECORRENZA_FINE: TDateTimeField;
    QSG101Desc_Grado: TStringField;
    QSG101Desc_Detrazione: TStringField;
    QSG101DATANAS_PRESUNTA: TDateTimeField;
    QSG101CAUSALI_ABILITATE: TStringField;
    QSG101NOME_PA: TStringField;
    QSG101INDIRIZZO: TStringField;
    QSG101COMUNE: TStringField;
    QSG101CAP: TStringField;
    QSG101TELEFONO: TStringField;
    QSG101Desc_Comune: TStringField;
    QSG101Prov_Comune: TStringField;
    QSG101CAPNAS: TStringField;
    QSG101D_CAPNAS: TStringField;
    QSG101D_CAP: TStringField;
    QSG101DATA_ULT_FAM_CAR: TDateTimeField;
    QSG101NUMGRADO: TStringField;
    QSG101TIPOPAR: TStringField;
    QSG101DETR_FIGLIO_100_AFFID: TStringField;
    QSG101NOTE: TStringField;
    QSG101DURATA_PA: TStringField;
    QSG101ANNO_AVV: TFloatField;
    QSG101ANNO_AVV_FAM: TFloatField;
    QSG101TIPO_DISABILITA: TStringField;
    QSG101MOTIVO_GRADO_3: TStringField;
    QSG101ALTERNATIVA: TStringField;
    QSG101NOME_PA_ALT: TStringField;
    QSG101MOTIVO_GRADO_3_ALT: TStringField;
    QSG101Desc_TipoPar: TStringField;
    QSG101Desc_TipoDisab: TStringField;
    QSG101TIPO_ADOZ_AFFID: TStringField;
    QSG101GRAV_INIZIO_TEOR: TDateTimeField;
    QSG101GRAV_INIZIO_SCELTA: TDateTimeField;
    QSG101GRAV_INIZIO_EFF: TDateTimeField;
    QSG101GRAV_FINE: TDateTimeField;
    QSG101DATA_PREADOZ: TDateTimeField;
    QSG101ANNO_REVISIONE: TDateTimeField;
    QSG101Desc_Inabile: TStringField;
    QSG101Desc_ANF: TStringField;
    QSG101NAZIONE: TStringField;
    QSG101MOTIVO_ESCLUSIONE: TStringField;
    QSG101CARTA_ID_NUMERO: TStringField;
    QSG101CARTA_ID_DATA_RIL: TDateTimeField;
    QSG101CARTA_ID_DATA_SCAD: TDateTimeField;
    QSG101INSERIMENTO_CU: TStringField;
    QSG101PASSAPORTO_NUMERO: TStringField;
    QSG101PASSAPORTO_DATA_RILDATE: TDateTimeField;
    QSG101PASSAPORTO_DATA_SCADDATE: TDateTimeField;
    QSG101ID_ESTERNO: TFloatField;
    procedure QSG101CalcFields(DataSet: TDataSet);
    procedure QSG101AfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure QSG101MATRICOLAValidate(Sender: TField);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure QSG101DATANASGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QSG101DATANAS_PRESUNTAChange(Sender: TField);
    procedure QSG101GRAV_INIZIO_SCELTAChange(Sender: TField);
    procedure QSG101GRAV_INIZIO_EFFChange(Sender: TField);
    procedure QSG101DATANASChange(Sender: TField);
    procedure QSG101DATAADOZChange(Sender: TField);
    procedure QSG101AfterOpen(DataSet: TDataSet);
    procedure DataGenericaValidate(Sender: TField);
  private
    procedure VerificaParentela;
    function VerificaStoricizzInCorso: boolean;
    function ValoriOriginali: TStringList;
  public
    S031FFamiliariMW:TS031FFamiliariMW;
    procedure SettaProgressivo;
  end;

var
  S031FFamiliariDtM: TS031FFamiliariDtM;

implementation

uses S031UFamiliari;

{$R *.DFM}

procedure TS031FFamiliariDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
//  Parametri.Applicazione:='PAGHE';
  InterfacciaR004:=S031FFamiliari.InterfacciaR004;
  InizializzaDataSet(QSG101,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  S031FFamiliariMW:=TS031FFamiliariMW.Create(Self);
  S031FFamiliariMW.selSG101:=QSG101;
  S031FFamiliariMW.selSG101OldValues.SetDataSet(QSG101);
  with S031FFamiliariMW do
  begin
    ChiavePrimaria:=InterfacciaR004.LChiavePrimaria;
    VerificaParentelaEvents:=VerificaParentela;
    VerificaStoricizzazioneEvents:=VerificaStoricizzInCorso;
    TrovaValoriOriginali:=ValoriOriginali;
  end;
  S031FFamiliari.DButton.DataSet:=QSG101;
  S031FFamiliari.dcmbNazionalita.ListSource:=S031FFamiliariMW.dsrT483;
end;

procedure TS031FFamiliariDtM.SettaProgressivo;
begin
  QSG101.Close;
  QSG101.SetVariable('Progressivo',C700Progressivo);
  QSG101.Open;
end;

procedure TS031FFamiliariDtM.QSG101AfterOpen(DataSet: TDataSet);
begin
  S031FFamiliariMW.selSG101OldValues.CreaStruttura;
  if QSG101.RecordCOunt = 0 then
    QSG101AfterScroll(QSG101);
end;

procedure TS031FFamiliariDtM.OnNewRecord(DataSet: TDataSet);
begin
  S031FFamiliariMW.QSG101NuovoRecord;
end;

procedure TS031FFamiliariDtM.QSG101MATRICOLAValidate(Sender: TField);
begin
  inherited;
  S031FFamiliariMW.QSG101ValidaMatricola;
end;

procedure TS031FFamiliariDtM.BeforeDelete(DataSet: TDataSet);
begin
  S031FFamiliariMW.EliminaFamiliareSelezionato;
  inherited;
end;

procedure TS031FFamiliariDtM.BeforePost(DataSet: TDataSet);
begin
  S031FFamiliariMW.QSG101ValidaFields;
  S031FFamiliariMW.MsgErrore:='';
  S031FFamiliariMW.QSG101ValidaFieldsNonBloccanti;
  if S031FFamiliariMW.MsgErrore <> '' then
    R180MessageBox('Attenzione: ' + CRLF + S031FFamiliariMW.MsgErrore + A000MSG_P000_MSG_DATI_SALVATI,INFORMA);

  if (QSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'DF') or (QSG101.FieldByName('PERC_CARICO').AsFloat <> 100) then
    QSG101.FieldByName('DETR_FIGLIO_100_AFFID').AsString:='N';
  if S031FFamiliariMW.IsDataDichiarazDaAggiornare then
    if (R180MessageBox(Format(A000MSG_S031_DLG_FMT_DATA_DICHIARAZIONE,[DateToStr(Trunc(R180Sysdate(SessioneOracle)))]),DOMANDA) = mrYes) then
      QSG101.FieldByName('DATA_ULT_FAM_CAR').AsDateTime:=Trunc(R180Sysdate(SessioneOracle));
  if S031FFamiliariMW.IsDataDichiarazVuota then
    if (R180MessageBox(A000MSG_S031_DLG_DATA_DICHIARAZIONE_VUOTA,DOMANDA) <> mrYes) then
      abort;
  if (Not QSG101.FieldByName('PASSAPORTO_DATA_RIL').isNull and Not QSG101.FieldByName('PASSAPORTO_DATA_SCAD').isNull) and
    (QSG101.FieldByName('PASSAPORTO_DATA_RIL').AsDateTime > QSG101.FieldByName('PASSAPORTO_DATA_SCAD').AsDateTime) then
    raise Exception.Create('La data di rilascio passaporto deve essere antecedente alla data di scaenza.');

  //In caso di modifica senza storicizzazione propaga i valori dei campi fissi su tutte le storicizzazioni
  if (QSG101.State = dsEdit) and (not InterfacciaR004.StoricizzazioneInCorso) then
    S031FFamiliariMW.AllineaDatiFissi;

  inherited;
end;

procedure TS031FFamiliariDtM.AfterPost(DataSet: TDataSet);
begin
  S031FFamiliariMW.QSG101AfterPost;
  inherited;
end;

procedure TS031FFamiliariDtM.QSG101AfterScroll(DataSet: TDataSet);
begin
  inherited;
  S031FFamiliariMW.AggiornaT960;

  S031FFamiliari.AllineaComponenti;
  S031FFamiliari.AbilitaComponenti;

  S031FFamiliariMW.selSG101OldValues.Aggiorna;
end;

procedure TS031FFamiliariDtM.QSG101CalcFields(DataSet: TDataSet);
begin
  inherited;
  if QSG101.FieldByName('GRADOPAR').AsString = 'NS' then
    QSG101.FieldByName('Desc_Grado').AsString:='Nessuno/Sè stesso'
  else if QSG101.FieldByName('GRADOPAR').AsString = 'CG' then
    QSG101.FieldByName('Desc_Grado').AsString:='Coniuge'
  else if QSG101.FieldByName('GRADOPAR').AsString = 'FG' then
    QSG101.FieldByName('Desc_Grado').AsString:='Figlio/Figlia'
  else if QSG101.FieldByName('GRADOPAR').AsString = 'GT' then
    QSG101.FieldByName('Desc_Grado').AsString:='Genitore'
  else if QSG101.FieldByName('GRADOPAR').AsString = 'FR' then
    QSG101.FieldByName('Desc_Grado').AsString:='Fratello/Sorella'
  else if QSG101.FieldByName('GRADOPAR').AsString = 'NP' then
    QSG101.FieldByName('Desc_Grado').AsString:='Nipote'
  else if QSG101.FieldByName('GRADOPAR').AsString = 'NF' then
    QSG101.FieldByName('Desc_Grado').AsString:='Nipote equiparato figlio'
  else if QSG101.FieldByName('GRADOPAR').AsString = 'AL' then
    QSG101.FieldByName('Desc_Grado').AsString:='Altro'
  else if QSG101.FieldByName('GRADOPAR').AsString = 'AF' then
    QSG101.FieldByName('Desc_Grado').AsString:='Affidato'
  else if QSG101.FieldByName('GRADOPAR').AsString = 'UC' then           
    QSG101.FieldByName('Desc_Grado').AsString:='Unito civilmente'
  else if QSG101.FieldByName('GRADOPAR').AsString = 'CF' then
    QSG101.FieldByName('Desc_Grado').AsString:='Convivente di fatto';
  if QSG101.FieldByName('TIPO_DETRAZIONE').AsString = 'ND' then
    QSG101.FieldByName('Desc_Detrazione').AsString:='Nessuna'
  else if QSG101.FieldByName('TIPO_DETRAZIONE').AsString = 'DC' then
    QSG101.FieldByName('Desc_Detrazione').AsString:='Coniuge'
  else if QSG101.FieldByName('TIPO_DETRAZIONE').AsString = 'DF' then
    QSG101.FieldByName('Desc_Detrazione').AsString:='Figlio'
  else if QSG101.FieldByName('TIPO_DETRAZIONE').AsString = 'DA' then
    QSG101.FieldByName('Desc_Detrazione').AsString:='Altri';
  if QSG101.FieldByName('TIPOPAR').AsString = 'P' then
    QSG101.FieldByName('Desc_TipoPar').AsString:='Parente'
  else if QSG101.FieldByName('TIPOPAR').AsString = 'A' then
    QSG101.FieldByName('Desc_TipoPar').AsString:='Affine';
  if QSG101.FieldByName('TIPO_DISABILITA').AsString = '1' then
    QSG101.FieldByName('Desc_TipoDisab').AsString:='Rivedibile'
  else if QSG101.FieldByName('TIPO_DISABILITA').AsString = '2' then
    QSG101.FieldByName('Desc_TipoDisab').AsString:='Non rivedibile'
  else if QSG101.FieldByName('TIPO_DISABILITA').AsString = '3' then
    QSG101.FieldByName('Desc_TipoDisab').AsString:='Provvisorio';
  if QSG101.FieldByName('COMPONENTE_ANF').AsString = 'S' then
    QSG101.FieldByName('Desc_ANF').AsString:='Si'
  else
    QSG101.FieldByName('Desc_ANF').AsString:='No';
  if QSG101.FieldByName('INABILE_ANF').AsString = 'S' then
    QSG101.FieldByName('Desc_Inabile').AsString:='Si'
  else
    QSG101.FieldByName('Desc_Inabile').AsString:='No';
end;

procedure TS031FFamiliariDtM.QSG101DATAADOZChange(Sender: TField);
begin
  inherited;
  with S031FFamiliari do
  begin
    gpbGravidanza.Visible:=(cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]) and
      (QSG101.FieldByName('DATAADOZ').IsNull) and (QSG101.FieldByName('DATA_PREADOZ').IsNull);    //Figlio o affidato con data adozione nulla
    if gpbGravidanza.Visible then
    begin
      lblGravInizioTeorico.Enabled:=False;  //mai abilitato perchè deve essere in sola visualizzazione
      dedtGravInizioTeorico.Enabled:=False;
      btnGravInizioTeorico.Enabled:=False;
      lblGravInizioScelto.Enabled:=Parametri.Applicazione <> 'PAGHE';
      dedtGravInizioScelto.Enabled:=Parametri.Applicazione <> 'PAGHE';
      btnGravInizioScelto.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE');
      lblGravInizioEffettivo.Enabled:=Parametri.Applicazione <> 'PAGHE';
      dedtGravInizioEffettivo.Enabled:=Parametri.Applicazione <> 'PAGHE';
      btnGravInizioEffettivo.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE');
      lblGravFine.Enabled:=Parametri.Applicazione <> 'PAGHE';
      dedtGravFine.Enabled:=Parametri.Applicazione <> 'PAGHE';
      btnGravFine.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE');
    end
    else if (DButton.State in [dsEdit,dsInsert]) then
    begin
      dedtGravInizioTeorico.Field.Clear;
      dedtGravInizioScelto.Field.Clear;
      dedtGravInizioEffettivo.Field.Clear;
      dedtGravFine.Field.Clear;
    end;
  end;
end;

procedure TS031FFamiliariDtM.QSG101DATANASChange(Sender: TField);
begin
  inherited;
  S031FFamiliariMW.selSG101DATANASChange(S031FFamiliari.gpbGravidanza.Visible);
end;

procedure TS031FFamiliariDtM.QSG101DATANASGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('dd/mm/yyyy hh:nn',Sender.AsDateTime);
end;

procedure TS031FFamiliariDtM.QSG101DATANAS_PRESUNTAChange(Sender: TField);
begin
  inherited;
  S031FFamiliariMW.selSG101DATANAS_PRESUNTAChange(S031FFamiliari.gpbGravidanza.Visible);
end;

procedure TS031FFamiliariDtM.DataGenericaValidate(Sender: TField);
begin
  inherited;
  S031FFamiliariMW.DataGenericaValidate(Sender);
end;

procedure TS031FFamiliariDtM.QSG101GRAV_INIZIO_EFFChange(Sender: TField);
begin
  inherited;
  S031FFamiliariMW.selSG101GRAV_INIZIO_EFFChange(S031FFamiliari.gpbGravidanza.Visible);
end;

procedure TS031FFamiliariDtM.QSG101GRAV_INIZIO_SCELTAChange(Sender: TField);
begin
  inherited;
  S031FFamiliariMW.selSG101GRAV_INIZIO_SCELTAChange(S031FFamiliari.gpbGravidanza.Visible);
end;

function TS031FFamiliariDtM.VerificaStoricizzInCorso: boolean;
begin
  Result:=InterfacciaR004.StoricizzazioneInCorso;
end;

function TS031FFamiliariDtM.ValoriOriginali: TStringList;
begin
  Result:=InterfacciaR004.LValoriOriginali;
end;

procedure TS031FFamiliariDtM.VerificaParentela;
begin
  with S031FFamiliari do
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

end.
