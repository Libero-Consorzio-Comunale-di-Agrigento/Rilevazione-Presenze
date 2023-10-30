unit A210URegoleArchiviazioneDoc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, OracleData, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, ImgList, ToolWin, ActnList,A000UCostanti, A000USessione, A000UInterfaccia, Variants,
  System.Actions, A000UMessaggi, A003UDataLavoroBis, C180FunzioniGenerali,
  System.ImageList;

type
  TA210FRegoleArchiviazioneDoc = class(TR001FGestTab)
    lblDTipoDocumento: TLabel;
    dedtDTipoDocumento: TDBEdit;
    OpenDialog1: TOpenDialog;
    pgcMain: TPageControl;
    tshLocale: TTabSheet;
    tshRemoto: TTabSheet;
    lblPathFile: TLabel;
    dedtPathFile: TDBEdit;
    btnPathFile: TButton;
    lblFilePdf: TLabel;
    dedtFilePdf: TDBEdit;
    lblFileXml: TLabel;
    dedtFileXml: TDBEdit;
    lblCampiXml: TLabel;
    dedtCampiXml: TDBEdit;
    dchkSostituzioneFile: TDBCheckBox;
    dchkSvuotaCartella: TDBCheckBox;
    lblServerSFTP: TLabel;
    dedtServerSFTP: TDBEdit;
    lblUsername: TLabel;
    dedtUsername: TDBEdit;
    lblPassword: TLabel;
    lblDirArch: TLabel;
    dedtDirArch: TDBEdit;
    lblPathPSCP: TLabel;
    dedtPathPSCP: TDBEdit;
    btnBrowsePSCP: TButton;
    dedtPassword: TDBEdit;
    lblDataUltimaArch: TLabel;
    dedtDataRifUltimaElab: TDBEdit;
    spdDataRifUltimaElab: TSpeedButton;
    dcmbTipologiaDocumenti: TDBLookupComboBox;
    lblTipologiaDocumenti: TLabel;
    rgpTipoMetadati: TDBRadioGroup;
    lblBucketId: TLabel;
    dedtBucketId: TDBEdit;
    dchkVerificaValidazione: TDBCheckBox;
    lblScriptVerificaValidazione: TLabel;
    dedtScriptVerificaValidazione: TDBEdit;
    lblScriptNote: TLabel;
    dedtScriptNote: TDBEdit;
    lblScriptPostArchiviazione: TLabel;
    dedtScriptPostArchiviazione: TDBEdit;
    dchkInviaRegistro: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnPathFileClick(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure dchkSvuotaCartellaClick(Sender: TObject);
    procedure btnBrowsePSCPClick(Sender: TObject);
    procedure spdDataRifUltimaElabClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure rgpTipoMetadatiChange(Sender: TObject);
  private
    procedure GestioneCheckboxArchLocale;
  public
    { Public declarations }
  end;

var
  A210FRegoleArchiviazioneDoc: TA210FRegoleArchiviazioneDoc;

procedure OpenA210FRegoleArchiviazioneDoc;

implementation

uses A210URegoleArchiviazioneDocDtM;

{$R *.DFM}

procedure OpenA210FRegoleArchiviazioneDoc;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA210FRegoleArchiviazioneDoc') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA210FRegoleArchiviazioneDoc, A210FRegoleArchiviazioneDoc);
  Application.CreateForm(TA210FRegoleArchiviazioneDocDtM, A210FRegoleArchiviazioneDocDtM);
  try
    A210FRegoleArchiviazioneDoc.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A210FRegoleArchiviazioneDoc.Free;
    A210FRegoleArchiviazioneDocDtM.Free;
  end;
end;

procedure TA210FRegoleArchiviazioneDoc.FormCreate(Sender: TObject);
begin
  inherited;
  //R001LinkC700:=False;
  //{$IFDEF DEBUG}Parametri.Applicazione:='RILPRE';{$ENDIF DEBUG} // in debug imposta RILPRE
  //{$IFDEF DEBUG}Parametri.Applicazione:='PAGHE';{$ENDIF DEBUG} // in debug imposta PAGHE
end;

procedure TA210FRegoleArchiviazioneDoc.FormShow(Sender: TObject);
begin
  inherited;
  // la scelta tipologia documenti è legata alla presenza del modulo di gestione documentale ed è disponibile solo per il tipo cartellino
  lblTipologiaDocumenti.Enabled:=Parametri.ModuloInstallato['ARCHIVIAZIONE_SOSTITUTIVA']and
                                 (DButton.DataSet.FieldByName('TIPO_DOCUMENTO').AsString = 'CAR') or
                                 (DButton.DataSet.FieldByName('TIPO_DOCUMENTO').AsString = 'TAB');
  dcmbTipologiaDocumenti.Enabled:=lblTipologiaDocumenti.Enabled;

    lblScriptVerificaValidazione.Enabled:=(Parametri.ModuloInstallato['ARCHIVIAZIONE_SOSTITUTIVA']) and
                                        (DButton.DataSet.FieldByName('TIPO_DOCUMENTO').AsString = 'CAR');
  dedtScriptVerificaValidazione.Enabled:=lblScriptVerificaValidazione.Enabled;
  lblScriptNote.Enabled:=lblScriptVerificaValidazione.Enabled;
  dedtScriptNote.Enabled:=lblScriptVerificaValidazione.Enabled;
  lblScriptPostArchiviazione.Enabled:=lblScriptVerificaValidazione.Enabled;
  dedtScriptPostArchiviazione.Enabled:=lblScriptVerificaValidazione.Enabled;
  dchkVerificaValidazione.Enabled:=lblScriptVerificaValidazione.Enabled;
  dchkInviaRegistro.Enabled:=lblScriptVerificaValidazione.Enabled;
end;

procedure TA210FRegoleArchiviazioneDoc.btnBrowsePSCPClick(Sender: TObject);
begin
  OpenDialog1.Title:='Scelta percorso dell''eseguibile di PSCP';
  OpenDialog1.InitialDir:=R180GetFilePath(A210FRegoleArchiviazioneDocDtM.A210MW.selI210.FieldByName('PATH_PSCP').AsString);
  OpenDialog1.FileName:=A210FRegoleArchiviazioneDocDtM.A210MW.selI210.FieldByName('PATH_PSCP').AsString;
  OpenDialog1.Options:=[ofPathMustExist,ofHideReadOnly,ofEnableSizing];
  OpenDialog1.Filter:='Eseguibili (*.exe)|*.exe|Tutti i file|*.*';
  if OpenDialog1.Execute then
    A210FRegoleArchiviazioneDocDtM.A210MW.selI210.FieldByName('PATH_PSCP').AsString:=OpenDialog1.FileNamE;
end;

procedure TA210FRegoleArchiviazioneDoc.btnPathFileClick(Sender: TObject);
begin
  OpenDialog1.Title:='Scelta percorso di archiviazione';
  OpenDialog1.InitialDir:=A210FRegoleArchiviazioneDocDtM.A210MW.selI210.FieldByName('PATH_FILE').AsString;
  OpenDialog1.FileName:='x';
  OpenDialog1.Options:=[ofPathMustExist,ofHideReadOnly,ofEnableSizing];
  OpenDialog1.Filter:='Tutti i file (*.*)|*.*';
  if OpenDialog1.Execute then
    A210FRegoleArchiviazioneDocDtM.A210MW.selI210.FieldByName('PATH_FILE').AsString:=R180GetFilePath(OpenDialog1.FileName);
end;

procedure TA210FRegoleArchiviazioneDoc.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  // la scelta tipologia documenti è legata alla presenza del modulo di gestione documentale ed è disponibile solo per il tipo cartellino
  lblTipologiaDocumenti.Enabled:=(Parametri.ModuloInstallato['ARCHIVIAZIONE_SOSTITUTIVA']) and
                                 (DButton.DataSet.FieldByName('TIPO_DOCUMENTO').AsString = 'CAR') or
                                 (DButton.DataSet.FieldByName('TIPO_DOCUMENTO').AsString = 'TAB');
  dcmbTipologiaDocumenti.Enabled:=lblTipologiaDocumenti.Enabled;

  lblScriptVerificaValidazione.Enabled:=(Parametri.ModuloInstallato['ARCHIVIAZIONE_SOSTITUTIVA']) and
                                        (DButton.DataSet.FieldByName('TIPO_DOCUMENTO').AsString = 'CAR');
  dedtScriptVerificaValidazione.Enabled:=lblScriptVerificaValidazione.Enabled;
  lblScriptNote.Enabled:=lblScriptVerificaValidazione.Enabled;
  dedtScriptNote.Enabled:=lblScriptVerificaValidazione.Enabled;
  lblScriptPostArchiviazione.Enabled:=lblScriptVerificaValidazione.Enabled;
  dedtScriptPostArchiviazione.Enabled:=lblScriptVerificaValidazione.Enabled;
  dchkVerificaValidazione.Enabled:=lblScriptVerificaValidazione.Enabled;
  dchkInviaRegistro.Enabled:=lblScriptVerificaValidazione.Enabled;

  if rgpTipoMetadati.ItemIndex = 0 then
    dchkSvuotaCartella.Enabled:=True
  else
  begin
    dchkSvuotaCartella.Checked:=False;
    dchkSvuotaCartella.Enabled:=False;
  end;
end;

procedure TA210FRegoleArchiviazioneDoc.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnPathFile.Enabled:=DButton.DataSet.State in [dsEdit,dsInsert];
  btnBrowsePSCP.Enabled:=DButton.DataSet.State in [dsEdit,dsInsert];
  spdDataRifUltimaElab.Enabled:=DButton.DataSet.State in [dsEdit,dsInsert];
end;

procedure TA210FRegoleArchiviazioneDoc.dchkSvuotaCartellaClick(Sender: TObject);
begin
  GestioneCheckboxArchLocale;
end;

procedure TA210FRegoleArchiviazioneDoc.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT DECODE(t1.tipo_documento,''CAR'',''Cartellino'',''CED'',''Cedolino'',''CU'',''CU'') D_TIPO_DOCUMENTO,t1.path_file,t1.file_pdf,t1.file_xml,t1.campi_xml,t1.sostituzione_file');
  QueryStampa.Add('FROM   I210_REGOLE_ARCHIVIAZIONE t1');
  QueryStampa.Add('WHERE  t1.applicazione = ''' + Parametri.Applicazione + '''');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('D_TIPO_DOCUMENTO');
  NomiCampiR001.Add('t1.path_file');
  NomiCampiR001.Add('t1.file_pdf');
  NomiCampiR001.Add('t1.file_xml');
  NomiCampiR001.Add('t1.campi_xml');
  NomiCampiR001.Add('t1.sostituzione_file');
  inherited;
end;

procedure TA210FRegoleArchiviazioneDoc.GestioneCheckboxArchLocale;
begin
  dchkSostituzioneFile.Enabled:=not dchkSvuotaCartella.Checked;
  if dchkSvuotaCartella.Checked then
    A210FRegoleArchiviazioneDocDtM.selI210.FieldByName('SOSTITUZIONE_FILE').AsString:='N';
end;

procedure TA210FRegoleArchiviazioneDoc.rgpTipoMetadatiChange(Sender: TObject);
begin
  inherited;
  if rgpTipoMetadati.ItemIndex = 0 then
    dchkSvuotaCartella.Enabled:=True
  else
  begin
    dchkSvuotaCartella.Checked:=False;
    dchkSvuotaCartella.Enabled:=False;
  end;
end;

procedure TA210FRegoleArchiviazioneDoc.spdDataRifUltimaElabClick(
  Sender: TObject);
begin
  dedtDataRifUltimaElab.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(dedtDataRifUltimaElab.Text),'Data di riferimento ultima elaborazione','G'));

end;

end.
