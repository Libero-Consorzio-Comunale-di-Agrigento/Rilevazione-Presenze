unit WA154UGestioneDocumentaleDM;

interface

uses
  System.SysUtils, System.Variants,
  System.Classes, WR302UGestTabellaDM, Data.DB, OracleData,
  A000UInterfaccia, A000UMessaggi,
  A154UGestioneDocumentaleMW, C021UDocumentiManagerDM;

type
  TWA154FGestioneDocumentaleDM = class(TWR302FGestTabellaDM)
    selTabellaID: TFloatField;
    selTabellaDATA_CREAZIONE: TDateTimeField;
    selTabellaUTENTE: TStringField;
    selTabellaNOME_UTENTE: TStringField;
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaTIPOLOGIA: TStringField;
    selTabellaUFFICIO: TStringField;
    selTabellaNOME_FILE: TStringField;
    selTabellaEXT_FILE: TStringField;
    selTabellaDIMENSIONE: TFloatField;
    selTabellaPERIODO_DAL: TDateTimeField;
    selTabellaPERIODO_AL: TDateTimeField;
    selTabellaNOTE: TStringField;
    selTabellaD_NOME_FILE: TStringField;
    selTabellaD_CARTELLA_FILE: TStringField;
    selTabellaD_DIMENSIONE: TStringField;
    selTabellaWEB_MATRICOLA: TStringField;
    selTabellaD_PROPRIETARIO: TStringField;
    selTabellaD_TIPOLOGIA: TStringField;
    selTabellaD_UFFICIO: TStringField;
    selTabellaWEB_NOMINATIVO: TStringField;
    selTabellaDATA_ACCESSO: TDateTimeField;
    selTabellaUTENTE_ACCESSO: TStringField;
    selTabellaD_DATI_ACCESSO: TStringField;
    selTabellaACCESSO_RESPONSABILE: TStringField;
    selTabellaD_ACCESSO_RESPONSABILE: TStringField;
    selTabellaDATA_LETTURA_PROGRESSIVO: TDateTimeField;
    selTabellaAUTOCERTIFICAZIONE: TStringField;
    selTabellaRICHIEDERE_ENTE: TStringField;
    selTabellaDATA_RICEHISTA_ENTE: TDateTimeField;
    selTabellaDATA_RICEZIONE_ENTE: TDateTimeField;
    selTabellaPATH_STORAGE: TStringField;
    selTabellaDATA_RILASCIO: TDateTimeField;
    selTabellaDATA_NOTIFICA: TDateTimeField;
    selTabellaACCESSO_PORTALE: TStringField;
    selTabellaD_ACCESSO_PORTALE: TStringField;
    selTabellaD_PATH_STORAGE: TStringField;
    selTabellaPROVENIENZA: TStringField;
    selTabellaCF_FAMILIARE: TStringField;
    selTabellaVERSIONE: TFloatField;
    selTabellaHASH: TStringField;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure dsrTabellaStateChange(Sender: TObject);
  public
    A154MW: TA154FGestioneDocumentaleMW;
  end;

implementation

uses WA154UGestioneDocumentale, WA154UGestioneDocumentaleDettFM;

{$R *.dfm}

procedure TWA154FGestioneDocumentaleDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('AZIENDA',Parametri.Azienda);
  selTabella.SetVariable('ORDERBY','order by decode(T960.DATA_LETTURA_PROGRESSIVO,null,0,1), D_TIPOLOGIA, D_UFFICIO, T960.PERIODO_DAL DESC, T960.NOME_FILE, T960.VERSIONE');
  NonAprireSelTabella:=True;
  inherited;
  A154MW:=TA154FGestioneDocumentaleMW.Create(Self);
  A154MW.selT960_Funzioni:=selTabella;
  //A154MW.ModuloGestioneDocumentale:=DebugHook = 0;
  //Nascondo i dati dei file se gestione moduloe documentale è false
  selTabella.FieldByName('D_NOME_FILE').Visible:=A154MW.ModuloGestioneDocumentale;
  selTabella.FieldByName('D_DIMENSIONE').Visible:=A154MW.ModuloGestioneDocumentale;
  selTabella.FieldByName('DATA_NOTIFICA').Visible:=A154MW.ModuloGestioneDocumentale;
  //selTabella.FieldByName('PATH_STORAGE').Visible:=A154MW.ModuloGestioneDocumentale;
  //selTabella.FieldByName('RICHIEDERE_ENTE').Visible:=A154MW.ModuloGestioneDocumentale;
  selTabella.Open;
end;

procedure TWA154FGestioneDocumentaleDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A154MW);
  inherited;
end;

procedure TWA154FGestioneDocumentaleDM.dsrTabellaStateChange(Sender: TObject);
var
  LIsTipologiaIter: Boolean;
  LDettFM: TWA154FGestioneDocumentaleDettFM;
begin
  inherited;
  if Self.Owner = nil then
    Exit;
  if (Self.Owner as TWA154FGestioneDocumentale).WDettaglioFM = nil then
    Exit;
  LIsTipologiaIter:=dsrTabella.DataSet.FieldByName('TIPOLOGIA').AsString <> DOC_TIPOL_ITER;

  // impostazioni frame dettaglio
  LDettFM:=((Self.Owner as TWA154FGestioneDocumentale).WDettaglioFM as TWA154FGestioneDocumentaleDettFM);
  //LDettFM.IWFile.Visible:=dsrTabella.State = dsInsert;
  LDettFM.IWFile.Visible:=((dsrTabella.State = dsInsert) or ((dsrTabella.State = dsEdit) and A154MW.EditNomeFile)) and A154MW.ModuloGestioneDocumentale;
  LDettFM.lblNomeFile.Caption:='Nome file';
  if LDettFM.IWFile.Visible then
    LDettFM.lblNomeFile.Caption:=LDettFM.lblNomeFile.Caption + ' ' +
                                 Format(A000TraduzioneStringhe(A000MSG_A154_MSG_FMT_INFO_DIM_DOCUMENTO),[StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5)]);

  LDettFM.IWFile.Enabled:=(dsrTabella.State = dsInsert) or ((dsrTabella.State = dsEdit) and A154MW.EditNomeFile);
  LDettFM.dedtDNomeFile.Visible:=not((dsrTabella.State = dsInsert) or ((dsrTabella.State = dsEdit) and A154MW.EditNomeFile) or not A154MW.ModuloGestioneDocumentale);
  //LDettFM.dedtDNomeFile.Visible:=dsrTabella.State <> dsInsert;
  LDettFM.dedtPeriodoDal.Enabled:=(dsrTabella.State <> dsEdit) or (LIsTipologiaIter);
  LDettFM.dedtPeriodoAl.Enabled:=LDettFM.dedtPeriodoDal.Enabled;
  LDettFM.dcmbTipologia.Enabled:=(dsrTabella.State <> dsEdit) or (LIsTipologiaIter);
  LDettFM.btnResetDatiLettura.Enabled:=(not TWA154FGestioneDocumentale(Owner).SolaLettura) and
                                       (dsrTabella.State = dsBrowse) and
                                       (not dsrTabella.DataSet.FieldByName('UTENTE_ACCESSO').IsNull);
  LDettFM.drgpPathStorage.Visible:=A154MW.ModuloGestioneDocumentale;
  LDettFM.drgpPathStorage.Enabled:=False;
  LDettFM.dchkAccessoPortale.Enabled:=(dsrTabella.DataSet.FieldByName('UTENTE').AsString <> '');
end;

procedure TWA154FGestioneDocumentaleDM.AfterDelete(DataSet: TDataSet);
// sovrascrivo il metodo perché non deve richiamare AfterPost!
begin
  // noop
end;

procedure TWA154FGestioneDocumentaleDM.AfterPost(DataSet: TDataSet);
begin
  A154MW.AfterPost;
  inherited;
end;

procedure TWA154FGestioneDocumentaleDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A154MW.BeforeDelete;
end;

procedure TWA154FGestioneDocumentaleDM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  A154MW.BeforeEdit;
end;

procedure TWA154FGestioneDocumentaleDM.BeforePostNoStorico(DataSet: TDataSet);
var
  LDettFM: TWA154FGestioneDocumentaleDettFM;
begin
  inherited;
  LDettFM:=((Self.Owner as TWA154FGestioneDocumentale).WDettaglioFM as TWA154FGestioneDocumentaleDettFM);
  { DONE : TEST IW 14 OK }
  A154MW.EditNomeFile:=(selTabella.State = dsInsert) and (LDettFM.IWFile.IsPresenteFileUploadato);
  A154MW.EditNomeFile:=A154MW.EditNomeFile or ((selTabella.State = dsEdit) and selTabella.FieldByName('NOME_FILE').IsNull and (LDettFM.IWFile.IsPresenteFileUploadato));
  A154MW.EditNomeFile:=A154MW.EditNomeFile and A154MW.ModuloGestioneDocumentale;
  // in fase di inserimento effettua l'upload del file
  //if selTabella.State = dsInsert then
  if A154MW.EditNomeFile then
  begin
    LDettFM.EffettuaUpload;
  end;

  // metodo condiviso su mw
  A154MW.BeforePost;
end;

procedure TWA154FGestioneDocumentaleDM.OnNewRecord(DataSet: TDataSet);
begin
  //inherited // no, perché imposta field decorrenza!
  A154MW.OnNewRecord;
  DataSet.FieldByName('PROGRESSIVO').AsInteger:=A154MW.SelAnagrafe.FieldByName('Progressivo').AsInteger;
end;

procedure TWA154FGestioneDocumentaleDM.AfterScroll(DataSet: TDataSet);
var
  LEsisteFile: Boolean;
  LDettFM: TWA154FGestioneDocumentaleDettFM;
begin
  inherited;
  if Self.Owner = nil then
    Exit;
  if (Self.Owner as TWA154FGestioneDocumentale).WDettaglioFM = nil then
    Exit;

  // gestione lato interfaccia
  LDettFM:=((Self.Owner as TWA154FGestioneDocumentale).WDettaglioFM as TWA154FGestioneDocumentaleDettFM);
  LDettFM.GestioneAfterScroll;
end;

procedure TWA154FGestioneDocumentaleDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  A154MW.OnCalcFields;
end;

end.
