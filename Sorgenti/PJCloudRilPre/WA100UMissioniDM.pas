unit WA100UMissioniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  WR303UGestMasterDetailDM, Data.DB, OracleData, A000UInterfaccia, A100UMissioniMW,
  WR302UGestTabellaDM,MedpIWMessageDlg,Controls,A000UMessaggi, C180FunzioniGenerali;

type
  TWA100FMissioniDM = class(TWR303FGestMasterDetailDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaMESESCARICO: TDateTimeField;
    selTabellaDATADA: TDateTimeField;
    selTabellaDATAA: TDateTimeField;
    selTabellaMESECOMPETENZA: TDateTimeField;
    selTabellaORADA: TStringField;
    selTabellaTIPOREGISTRAZIONE: TStringField;
    selTabellaPROTOCOLLO: TStringField;
    selTabellaORAA: TStringField;
    selTabellaTOTALEGG: TFloatField;
    selTabellaDURATA: TStringField;
    selTabellaTARIFFAINDINTERA: TFloatField;
    selTabellaOREINDINTERA: TFloatField;
    selTabellaIMPORTOINDINTERA: TFloatField;
    selTabellaTARIFFAINDRIDOTTAH: TFloatField;
    selTabellaOREINDRIDOTTAH: TFloatField;
    selTabellaIMPORTOINDRIDOTTAH: TFloatField;
    selTabellaTARIFFAINDRIDOTTAG: TFloatField;
    selTabellaOREINDRIDOTTAG: TFloatField;
    selTabellaIMPORTOINDRIDOTTAG: TFloatField;
    selTabellaTARIFFAINDRIDOTTAHG: TFloatField;
    selTabellaOREINDRIDOTTAHG: TFloatField;
    selTabellaIMPORTOINDRIDOTTAHG: TFloatField;
    selTabellaFLAG_MODIFICATO: TStringField;
    selTabellaTotaleOreIndennita: TFloatField;
    selTabellaTotaleImportiIndennita: TFloatField;
    selTabellaTotaleKmIndennita: TFloatField;
    selTabellaTotaleImportiKmIndennita: TFloatField;
    selTabellaTotaleMissione: TFloatField;
    selTabellaCostoMissione: TFloatField;
    selTabellaPARTENZA: TStringField;
    selTabellaDESTINAZIONE: TStringField;
    selTabellaNOTE_RIMBORSI: TStringField;
    selTabellaCOMMESSA: TStringField;
    selTabellaSTATO: TStringField;
    selTabellaCOD_TARIFFA: TStringField;
    selTabellaCOD_RIDUZIONE: TStringField;
    selTabelladesctariffa: TStringField;
    selTabellaID_MISSIONE: TIntegerField;
    selTabellaTIPO_RICHIESTA: TStringField;
    selTabellaD_ANNULLATA: TStringField;
    selTabellaFLAG_DESTINAZIONE: TStringField;
    selTabellaFLAG_ISPETTIVA: TStringField;
    selTabelladesctipomissione: TStringField;
    selTabelladesccommessa: TStringField;
    selTabelladescpartenza: TStringField;
    dsrM050: TDataSource;
    selTabellaID: TFloatField;
    selTabellaMISSIONE_RIAPERTA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selTabellaMESESCARICOSetText(Sender: TField; const Text: string);
    procedure selTabellaMESESCARICOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure INDRIDOTTAHValidate(Sender: TField);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure dsrTabellaDataChange(Sender: TObject; Field: TField);
    procedure selTabellaTARIFFAINDINTERAValidate(Sender: TField);
    procedure selTabellaTARIFFAINDRIDOTTAGValidate(Sender: TField);
    procedure selTabellaTARIFFAINDRIDOTTAHGValidate(Sender: TField);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    // AOSTA_REGIONE - chiamata 91104.ini
    procedure AfterDelete(DataSet: TDataSet); override;
    // AOSTA_REGIONE - chiamata 91104.fine
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selTabellaApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure selTabellaPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    ApriCartellino: boolean;
    procedure MessaggioAvviso(msg: String);
    procedure ResultConfermaPostSelTabella(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    // AOSTA_REGIONE - chiamata 91104.ini
    procedure ResultConfermaDeleteSelTabella(Sender: TObject;Res: TmeIWModalResult; KeyID: String);
    // AOSTA_REGIONE - chiamata 91104.fine
    procedure AfterPostStep2;
    procedure AfterPostStep3;
    procedure AfterPostStep4;
    procedure AfterPostStep5;
    procedure ResultAfterPostPasso1(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure ResultAfterPostPasso2(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure ResultAfterPostPasso3(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure ResultAfterPostPasso4(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    lstMessaggiAvviso: TStringList;
    A100FMissioniMW: TA100FMissioniMW;
  end;

implementation

uses WA100UMissioni;

{$R *.dfm}

procedure TWA100FMissioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  lstMessaggiAvviso:=TStringList.Create();
  selTabella.SetVariable('ORDERBY','ORDER BY M040.DATADA');
  NonAprireSelTabella:=True;
  inherited;
  A100FMissioniMW:=TA100FMissioniMW.Create(Self);
  A100FMissioniMW.MessaggioAvviso:=MessaggioAvviso;
  A100FMissioniMW.SelM040_Funzioni:=selTabella;
  selTabella.FieldByName('desctipomissione').LookupDataSet:=A100FMissioniMW.QM011;
  selTabella.FieldByName('desccommessa').LookupDataSet:=A100FMissioniMW.QCommessa;
  selTabella.FieldByName('descpartenza').LookupDataSet:=A100FMissioniMW.QSede;
  //Su Cloud non readOnly
  A100FMissioniMW.QM052.ReadOnly:=False;
  A100FMissioniMW.Q050.ReadOnly:=False;
  A100FMissioniMW.M051.ReadOnly:=False;
  dsrM050.DataSet:=A100FMissioniMW.Q050;
  //per cloud devo togliere editmask
  A100FMissioniMW.M051.FieldByName('DATARIMBORSO').EditMask:='';
  selTabella.Open;
  A100FMissioniMW.InizializzaM066;
  //DEVO APRIRE IL DATASET PER LA MEDPGRID
  A100FMissioniMW.QM052.Open;
  A100FMissioniMW.Q050.Open;
   //per cloud devo togliere editmask
  A100FMissioniMW.selM043.FieldByName('DATA').EditMask:='';
  A100FMissioniMW.selM043.Open;
  // MONDOEDP - commessa MAN/02 SVILUPPO#129.ini
  A100FMissioniMW.selT960.Open;
  // MONDOEDP - commessa MAN/02 SVILUPPO#129.fine
end;

procedure TWA100FMissioniDM.ResultAfterPostPasso1(Sender: TObject;Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) then
  begin
    ApriCartellino:=True;
    A100FMissioniMW.Cancellare:=False;
  end;
  AfterPostStep2;
end;

procedure TWA100FMissioniDM.AfterPost(DataSet: TDataSet);
var Msg: String;
begin
  ApriCartellino:=False;
  Msg:=A100FMissioniMW.M040AfterPostPasso1;
  if Msg <> '' then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultAfterPostPasso1,'');
    Abort;
  end;
  AfterPostStep2;
end;

procedure TWA100FMissioniDM.ResultAfterPostPasso2(Sender: TObject;Res: TmeIWModalResult; KeyID: String);
begin
  A100FMissioniMW.Inserire:=(Res = mrYes);
  AfterPostStep3;
end;

procedure TWA100FMissioniDM.AfterPostStep2;
var Msg: String;
begin
  Msg:=A100FMissioniMW.M040AfterPostPasso2;
  if Msg <> '' then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultAfterPostPasso2,'');
    Abort;
  end;
  AfterPostStep3;
end;

procedure TWA100FMissioniDM.ResultAfterPostPasso3(Sender: TObject;Res: TmeIWModalResult; KeyID: String);
begin
  A100FMissioniMW.Cancellare:=(Res = mrYes);
  AfterPostStep4;
end;

procedure TWA100FMissioniDM.AfterPostStep3;
var Msg: String;
begin
  Msg:=A100FMissioniMW.M040AfterPostPasso3;
  if Msg <> '' then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultAfterPostPasso3,'');
    Abort;
  end;
  AfterPostStep4;
end;

procedure TWA100FMissioniDM.ResultAfterPostPasso4(Sender: TObject;Res: TmeIWModalResult; KeyID: String);
begin
  AfterPostStep5;
end;

procedure TWA100FMissioniDM.AfterPostStep4;
begin
  if not A100FMissioniMW.M040AfterPostPasso4  then
  begin
    MsgBox.WebMessageDlg(A000MSG_A100_MSG_ANOMALIE,mtInformation,[mbOk],ResultAfterPostPasso4,'');
    Abort;
  end;
  AfterPostStep5;
end;

procedure TWA100FMissioniDM.AfterPostStep5;
var evAfterScroll:TEvDataset;
  StrRowId: String;
begin
  A100FMissioniMW.Azione:='';
  A100FMissioniMW.Causale:='';
  A100FMissioniMW.CausaleOld:='';
  evAfterScroll:=selTabella.AfterScroll;
  selTabella.AfterScroll:=nil;
  try
    DoAfterPost;
  finally
    selTabella.AfterScroll:=evAfterScroll;
  end;
  SessioneOracle.Commit;
  // ================================================================================================
  // ESEGUO UN REFRESH DELLA M040 PER EVITARE ALCUNI COMPORTAMENTI SCORRETTI DEGLI EVENTI DEL DATASET
  // ESEGUO UNA SEARCHRECORD PER NN RIPOSIZIONARMI SUL PRIMO RECORD
  // ================================================================================================
  StrRowId:=selTabella.RowId;
  selTabella.Refresh;
  selTabella.SearchRecord('ROWID', StrRowId, [srFromBeginning]);
  if ApriCartellino then
    (Self.Owner as TWA100FMissioni).AccediForm(7,'PROGRESSIVO=' + A100FMissioniMW.selAnagrafe.FieldByName('PROGRESSIVO').AsString,True);
end;

procedure TWA100FMissioniDM.AfterScroll(DataSet: TDataSet);
begin
  A100FMissioniMW.selM040AfterScroll;

  inherited; // bugfix

  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
  // azione di riapertura missione disponibile se si verificano queste condizioni:
  // - la missione arriva da web (ID non nullo)
  // - la missione non è già stata riaperta (ovvio)
  // - lo stato è da liquidare o liquidata
  // - par. aziendale dettaglio rimborsi = 'S' (Parametri.CampiRiferimento.C8_W032RimborsiDett)
  // - par. aziendale riapertura trasferte liquidate = 'S' (Parametri.CampiRiferimento.C8_W032RiapriMissione)
  (Self.Owner as TWA100FMissioni).actRiapriRichiestaMissione.Enabled:=(not selTabella.FieldByName('ID').IsNull) and
                                                                      (selTabella.FieldByName('MISSIONE_RIAPERTA').AsString <> 'S') and
                                                                      (R180In(selTabella.FieldByName('STATO').AsString,['D','L'])) and
                                                                      (Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S') and
                                                                      (Parametri.CampiRiferimento.C8_W032RiapriMissione = 'S');
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
end;

procedure TWA100FMissioniDM.MessaggioAvviso(msg: String);
begin
  //tempdario visualizzare in render del form e svuotare quando presentata msgbox
  lstMessaggiAvviso.Add(msg)
end;

procedure TWA100FMissioniDM.OnNewRecord(DataSet: TDataSet);
begin
  A100FMissioniMW.M040NewRecord;
  inherited;
end;

procedure TWA100FMissioniDM.RelazionaTabelleFiglie;
begin
  inherited;
end;

procedure TWA100FMissioniDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  DataSet.Last;
  A100FMissioniMW.M040AfterOpen;
end;

procedure TWA100FMissioniDM.selTabellaApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  A100FMissioniMW.M040Apply(Action);
end;

procedure TWA100FMissioniDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A100FMissioniMW.CalcolaTotaliIndennitaOrarie;
  A100FMissioniMW.CalcolaTotaliIndennitaKm;
end;

procedure TWA100FMissioniDM.selTabellaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=A100FMissioniMW.M040FiltroDizionario;
end;

procedure TWA100FMissioniDM.selTabellaMESESCARICOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('mm/yyyy', Sender.AsDateTime);
end;

procedure TWA100FMissioniDM.selTabellaMESESCARICOSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  Sender.AsDateTime:=EncodeDate(strtoint(Copy(Text, 4, 4)),strtoint(Copy(Text, 1, 2)), 1);
end;

procedure TWA100FMissioniDM.selTabellaPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  A100FMissioniMW.M040PostError(E);
  inherited;
end;

procedure TWA100FMissioniDM.selTabellaTARIFFAINDINTERAValidate(Sender: TField);
begin
  inherited;
  A100FMissioniMW.M040INDINTERAValidate;
end;

procedure TWA100FMissioniDM.selTabellaTARIFFAINDRIDOTTAGValidate(
  Sender: TField);
begin
  inherited;
  A100FMissioniMW.M040INDRIDOTTAGValidate;
end;

procedure TWA100FMissioniDM.selTabellaTARIFFAINDRIDOTTAHGValidate(
  Sender: TField);
begin
  inherited;
  A100FMissioniMW.M040INDRIDOTTAHGValidate;
end;

procedure TWA100FMissioniDM.ResultConfermaPostSelTabella(Sender: TObject;Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) or (Res = mrOk) then
    selTabella.Post
  else
    MsgBox.clearKeys;
end;

procedure TWA100FMissioniDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;

  // AOSTA_REGIONE - chiamata 91104.ini
  if not MsgBox.KeyExists('BEFORE_DELETE_STEP1') then
  begin
    if selTabella.FieldByName('ID').AsInteger > 0 then
    begin
      MsgBox.WebMessageDlg('La trasferta è collegata ad una richiesta web.'#13#10'Eliminare comunque?'#13#10'Rispondendo Sì, la richiesta web sarà annullata.',mtConfirmation,[mbYes,mbNo],ResultConfermaDeleteSelTabella,'BEFORE_DELETE_STEP1');
      Abort;
    end;
  end;
  // AOSTA_REGIONE - chiamata 91104.fine

  A100FMissioniMW.M040BeforeDelete;
end;

// AOSTA_REGIONE - chiamata 91104.ini
procedure TWA100FMissioniDM.ResultConfermaDeleteSelTabella(Sender: TObject;Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    //selTabella.Delete
    (Self.Owner as TWA100FMissioni).EseguiDelete
  else
    MsgBox.ClearKeys;
end;

procedure TWA100FMissioniDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A100FMissioniMW.M040AfterDelete;
end;
// AOSTA_REGIONE - chiamata 91104.fine

procedure TWA100FMissioniDM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  A100FMissioniMW.M040BeforeEdit;
end;

procedure TWA100FMissioniDM.BeforePostNoStorico(DataSet: TDataSet);
var Msg:String;
begin
  inherited;

  if (not selTabella.FieldByName('NOTE_RIMBORSI').IsNull) and (A100FMissioniMW.Q050.RecordCount = 0) then
    raise Exception.Create(A000MSG_A100_ERR_NOTERIMBORSI);

  if (not MsgBox.KeyExists('PUNTO_FINE')) then
  begin
    if (not MsgBox.KeyExists('PUNTO_1')) then
    begin
      A100FMissioniMW.M040BeforePostPasso1;
      if A100FMissioniMW.TestMeseScarico then
      begin
        MsgBox.WebMessageDlg(A000MSG_A100_ERR_DATA_MISS_SUCC,mtConfirmation,[mbYes,mbNo],ResultConfermaPostSelTabella,'PUNTO_1');
        Abort;
      end;
    end;

    if (not MsgBox.KeyExists('PUNTO_2')) then
    begin
      Msg:=A100FMissioniMW.M040BeforePostPasso2;
      if Msg <> '' then
      begin
        MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultConfermaPostSelTabella,'PUNTO_2');
        Abort;
      end;
    end;

    Msg:=A100FMissioniMW.AnticipiDaUnire;
    if Msg <> '' then
    begin
      if (not MsgBox.KeyExists('PUNTO_3')) then
      begin
        MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultConfermaPostSelTabella,'PUNTO_3');
        Abort;
      end;
      msg:=A100FMissioniMW.UnisciAnticipi;
      if msg <> '' then
      begin
        MsgBox.WebMessageDlg(Msg,mtInformation,[mbOk],ResultConfermaPostSelTabella,'PUNTO_FINE');
        Abort;
      end;
    end
    else
    begin
      msg:=A100FMissioniMW.AnticipiSospesi;
      if msg <> '' then
      begin
        MsgBox.WebMessageDlg(Msg,mtInformation,[mbOk],ResultConfermaPostSelTabella,'PUNTO_FINE');
        Abort;
      end;
    end;
  end;
end;

procedure TWA100FMissioniDM.dsrTabellaDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (selTabella.State <> dsBrowse) and (Field = selTabella.FieldByName('COD_TARIFFA')) then
  begin
    A100FMissioniMW.selM066.Close;
    A100FMissioniMW.selM066.SetVariable('DATOLIB',Parametri.CampiRiferimento.C8_Missione);
    A100FMissioniMW.selM066.SetVariable('PROGRESSIVO',A100FMissioniMW.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    A100FMissioniMW.selM066.SetVariable('COD_TARIFF',selTabella.FieldByName('COD_TARIFFA').AsString);
    A100FMissioniMW.selM066.SetVariable('DATA',selTabella.FieldByName('DATADA').AsDateTime);
    A100FMissioniMW.selM066.Open;
    A100FMissioniMW.ElaboraDaTariffe;
   (Self.Owner as TWA100FMissioni).WDettaglioFM.dataset2Componenti;
  end;
  if (selTabella.State <> dsBrowse) and (selTabella.FieldByName('COD_TARIFFA').AsString <> '') and
       (selTabella.FieldByName('COD_RIDUZIONE').AsString <> '') and ((Field = selTabella.FieldByName('COD_TARIFFA')) or
       (Field = selTabella.FieldByName('COD_RIDUZIONE'))) then
  begin
    A100FMissioniMW.ElaboraDaTariffe;
    (Self.Owner as TWA100FMissioni).WDettaglioFM.dataset2Componenti;
  end;
end;

procedure TWA100FMissioniDM.INDRIDOTTAHValidate(
  Sender: TField);
begin
  inherited;
  A100FMissioniMW.M040INDRIDOTTAHValidate;
end;

procedure TWA100FMissioniDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A100FMissioniMW);
  FreeAndNil(lstMessaggiAvviso);
  inherited;
end;

end.
