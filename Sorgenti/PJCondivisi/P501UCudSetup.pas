unit P501UCudSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, ImgList, ToolWin, ActnList,A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  A003UDataLavoroBis, OracleData, Variants, C180FunzioniGenerali, System.Actions,
  System.ImageList;

type
  TP501FCudSetup = class(TR001FGestTab)
    pgcPrincipale: TPageControl;
    tshDatiGenerali: TTabSheet;
    tshDati770: TTabSheet;
    lblCodFiscale: TLabel;
    lblDenominazione: TLabel;
    lblProvincia: TLabel;
    lblComune: TLabel;
    lblCap: TLabel;
    lblEmail: TLabel;
    lblIndirizzo: TLabel;
    dedtProvincia: TDBEdit;
    dedtComune: TDBEdit;
    dedtCap: TDBEdit;
    dedtCodFiscale: TDBEdit;
    dedtDenominazione: TDBEdit;
    dedtEmail: TDBEdit;
    dedtIndirizzo: TDBEdit;
    lblTipoFornitore: TLabel;
    dedtTipoFornitore: TDBEdit;
    lblCodiceAttivita: TLabel;
    dedCodiceAttivita: TDBEdit;
    lblStatoEnte: TLabel;
    dedtStatoEnte: TDBEdit;
    lblNaturaGiuridica: TLabel;
    dedtNaturaGiuridica: TDBEdit;
    lblSituazioneEnte: TLabel;
    dedtSituazioneEnte: TDBEdit;
    lblCodFiscaleDicastero: TLabel;
    dedtCodFiscaleDicastero: TDBEdit;
    tshDatiCUD: TTabSheet;
    lblCodValuta: TLabel;
    dcbxValutaStampa: TDBLookupComboBox;
    dlblValuta: TDBText;
    lblFirmatario: TLabel;
    dedtFirmatario: TDBEdit;
    tshDatiBanca: TTabSheet;
    lblCodSIA: TLabel;
    dedtCodSIA: TDBEdit;
    lblCodABI: TLabel;
    dedtCodABI: TDBEdit;
    lblCodCAB: TLabel;
    dedtCodCAB: TDBEdit;
    lblContoCorrente: TLabel;
    dedtContoCorrente: TDBEdit;
    lblTelefono: TLabel;
    dedtTelefono: TDBEdit;
    lblFax: TLabel;
    dedtFax: TDBEdit;
    tshDatiDMA: TTabSheet;
    tshFirmatario: TTabSheet;
    gpbDatiFirmatario: TGroupBox;
    lblCodFiscaleFirma: TLabel;
    lblCodiceCarica: TLabel;
    lblCognomeFirma: TLabel;
    lblNomeFirma: TLabel;
    lblDataNascitaFirma: TLabel;
    lblComuneNascitaFirma: TLabel;
    lblProvinciaNascitaFirma: TLabel;
    lblComuneResidenzaFirma: TLabel;
    lblProvinciaResidenzaFirma: TLabel;
    lblCapResidenzaFirma: TLabel;
    lblIndirizzoResidenzaFirma: TLabel;
    lblTelefonoFirma: TLabel;
    dedtCodFiscaleFirma: TDBEdit;
    dedtCodiceCarica: TDBEdit;
    dedtCognomeFirma: TDBEdit;
    dedtNomeFirma: TDBEdit;
    drgpSessoFirma: TDBRadioGroup;
    dedtDataNascitaFirma: TDBEdit;
    dedtComuneNascitaFirma: TDBEdit;
    dedtProvinciaNascitaFirma: TDBEdit;
    dedtComuneResidenzaFirma: TDBEdit;
    dedtProvinciaResidenzaFirma: TDBEdit;
    dedtCapResidenzaFirma: TDBEdit;
    dedtIndirizzoResidenzaFirma: TDBEdit;
    dedtTelefonoFirma: TDBEdit;
    lblCodComune: TLabel;
    dedtCodComune: TDBEdit;
    GroupBox1: TGroupBox;
    lblAnno: TLabel;
    dedtAnno: TDBEdit;
    lblCodFornitura: TLabel;
    lblTipoFornit: TLabel;
    lblCodInpdap: TLabel;
    lblCodAteco: TLabel;
    lblCodFirmaGiurid: TLabel;
    lblCodFiscSw: TLabel;
    dedtCodFornitura: TDBEdit;
    dedtTipoFornitoreDMA: TDBEdit;
    dedtCodINPDAP: TDBEdit;
    dedtCodATECO: TDBEdit;
    dedtCodFormaGiurid: TDBEdit;
    dedtCodFiscaleProdut: TDBEdit;
    dchkFirmaDenuncia: TDBCheckBox;
    tshDatiEMens: TTabSheet;
    lblMatricolaInps: TLabel;
    dedtMatricolaInps: TDBEdit;
    lblCodFiscaleSw: TLabel;
    dedtCodFiscaleSw: TDBEdit;
    lblCodSedeInps: TLabel;
    lblCodFiscMittente: TLabel;
    lblCodIstat: TLabel;
    dedtCodSedeInps: TDBEdit;
    dedtCodFiscMittente: TDBEdit;
    dedtCodIstat: TDBEdit;
    lblCodATECO1: TLabel;
    dedtCodATECO1: TDBEdit;
    tshPostel: TTabSheet;
    lblIdAbbonato: TLabel;
    lblTipologiaInvio: TLabel;
    lblColore: TLabel;
    lblProcedura: TLabel;
    dedtIdAbbonato: TDBEdit;
    dedtTipologiaInvio: TDBEdit;
    dedtColore: TDBEdit;
    dedtProcedura: TDBEdit;
    lblTrattamento: TLabel;
    lblCentroCosto: TLabel;
    dedtTrattamento: TDBEdit;
    dedtCentroCosto: TDBEdit;
    dedtDecorrenzaCaricaFirma: TDBEdit;
    lblDecorrenzaCaricaFirma: TLabel;
    dedtCodFiscSw2: TDBEdit;
    lblCodFiscSw2: TLabel;
    lblIndirizzoDomicilio: TLabel;
    dcmbIndirizzoDomicilio: TDBLookupComboBox;
    lblCAPDomicilio: TLabel;
    dcmbCAPDomicilio: TDBLookupComboBox;
    lblComuneDomicilio: TLabel;
    dcmbComuneDomicilio: TDBLookupComboBox;
    lblProvinciaDomicilio: TLabel;
    dcmbProvinciaDomicilio: TDBLookupComboBox;
    lblDescIndirizzoDomicilio: TLabel;
    lblDescCAPDomicilio: TLabel;
    lblDescComuneDomicilio: TLabel;
    lblDescProvinciaDomicilio: TLabel;
    tshCedolino: TTabSheet;
    lblSedeServizio: TLabel;
    dcmbSedeServizio: TDBLookupComboBox;
    lblUnitaOperativa: TLabel;
    dcmbUnitaOperativa: TDBLookupComboBox;
    lblQualifica: TLabel;
    dcmbQualifica: TDBLookupComboBox;
    lblDescSedeServizio: TLabel;
    lblDescUnitaOperativa: TLabel;
    lblDescQualifica: TLabel;
    grpWEB: TGroupBox;
    chkWEBStampa: TDBCheckBox;
    dedtWEBPathIstruzioni: TDBEdit;
    lblWebPathIstruzioni: TLabel;
    OpenDialog1: TOpenDialog;
    lblWebAnnotazioni: TLabel;
    dmemoWEBAnnotazioni: TDBMemo;
    lblWEBDataStampa: TLabel;
    dedtWebDataStampa: TDBEdit;
    lblInizioRapporto: TLabel;
    dcmbInizioRapporto: TDBLookupComboBox;
    lblDescInizioRapporto: TLabel;
    tshFamiliari: TTabSheet;
    grpDichiarazioneFamiliari: TGroupBox;
    dchkFamStatoCivile: TDBCheckBox;
    lblFamPathIstruzioni: TLabel;
    dedtFamPathIstruzioni: TDBEdit;
    dmemFamNote: TDBMemo;
    lblFamNote: TLabel;
    grpPeriodoDichiarazione: TGroupBox;
    lblFamDataDa: TLabel;
    lblFamDataA: TLabel;
    dedtFamDataDa: TDBEdit;
    dedtFamDataA: TDBEdit;
    btnFamDataDa: TButton;
    btnFamDataA: TButton;
    dedtCodComparto: TDBEdit;
    lblCodComparto: TLabel;
    dedtCodSottoComparto: TDBEdit;
    lblCodSottoComparto: TLabel;
    lblPartitaIva: TLabel;
    dcmbPartitaIva: TDBLookupComboBox;
    lblDescPartitaIva: TLabel;
    tshDatiINPGI: TTabSheet;
    dedtCodInpgi: TDBEdit;
    lblCodInpgi: TLabel;
    dedtCodFiscaleFirmaDMA2: TDBEdit;
    lblCodFiscaleFirmaDMA2: TLabel;
    dedtCodFormaGiuridDMA2: TDBEdit;
    lblCodFormaGiuridDMA2: TLabel;
    dedtCodContrattoDMA2: TDBEdit;
    lblCodContrattoDMA2: TLabel;
    dedtCodINPDAPDMA2: TDBEdit;
    lblCodINPDAPDMA2: TLabel;
    lblPathFilePDFCed: TLabel;
    dedtPathFilePDFCed: TDBEdit;
    btnPathFilePDFCed: TButton;
    tshDatiEnpam: TTabSheet;
    dedtCodEnpam: TDBEdit;
    lblCodEnpam: TLabel;
    GroupBox2: TGroupBox;
    dedtGennaio: TDBEdit;
    lblGennaio: TLabel;
    btnGennaio: TButton;
    btnFebbraio: TButton;
    dedtFebbraio: TDBEdit;
    lblFebbraio: TLabel;
    lblMarzo: TLabel;
    dedtMarzo: TDBEdit;
    btnMarzo: TButton;
    btnAprile: TButton;
    dedtAprile: TDBEdit;
    lblAprile: TLabel;
    lblMaggio: TLabel;
    dedtMaggio: TDBEdit;
    btnMaggio: TButton;
    lblGiugno: TLabel;
    dedtGiugno: TDBEdit;
    btnGiugno: TButton;
    dedtLuglio: TDBEdit;
    lblLuglio: TLabel;
    btnLuglio: TButton;
    btnAgosto: TButton;
    dedtAgosto: TDBEdit;
    lblAgosto: TLabel;
    lblSettembre: TLabel;
    dedtSettembre: TDBEdit;
    btnSettembre: TButton;
    btnOttobre: TButton;
    dedtOttobre: TDBEdit;
    lblOttobre: TLabel;
    lblNovembre: TLabel;
    dedtNovembre: TDBEdit;
    btnNovembre: TButton;
    lblDicembre: TLabel;
    dedtDicembre: TDBEdit;
    btnDicembre: TButton;
    dedtCodIBAN: TDBEdit;
    lblCodIBAN: TLabel;
    btnWebDataStampa: TButton;
    btnDataNascitaFirma: TButton;
    btnDecorrenzaCaricaFirma: TButton;
    dedtCUCodFiscaleSW: TDBEdit;
    lblCUCodFiscaleSW: TLabel;
    dedtCUTipoFornitore: TDBEdit;
    lblCUTipoFornitore: TLabel;
    lblNomeFilePDFCed: TLabel;
    dedtNomeFilePDFCed: TDBEdit;
    btnNomeFilePDFCed: TButton;
    lblCodAziendaBase: TLabel;
    dcmbCodAziendaBase: TDBLookupComboBox;
    dlblDAziendaBase: TDBText;
    lblPathFilePDFCU: TLabel;
    dedtPathFilePDFCU: TDBEdit;
    dedtMatricolaInpsVF: TDBEdit;
    lblMatricolaInpsVF: TLabel;
    lblEmailPEC: TLabel;
    dedtEmailPEC: TDBEdit;
    tshDatiOnaosi: TTabSheet;
    grpRespUOOnaosi: TGroupBox;
    lblNominRespUOOnaosi: TLabel;
    dedtNominRespUOOnaosi: TDBEdit;
    lblCodOnaosi: TLabel;
    dedtCodOnaosi: TDBEdit;
    lblTelefonoRespUOOnaosi: TLabel;
    dedtTelefonoRespUOOnaosi: TDBEdit;
    lblEmailRespUOOnaosi: TLabel;
    dedtEmailRespUOOnaosi: TDBEdit;
    grpRespProcOnaosi: TGroupBox;
    lblNominRespProcOnaosi: TLabel;
    lblTelefonoRespProcOnaosi: TLabel;
    lblEmailRespProcOnaosi: TLabel;
    dedtNominRespProcOnaosi: TDBEdit;
    dedtTelefonoRespProcOnaosi: TDBEdit;
    dedtEmailRespProcOnaosi: TDBEdit;
    procedure FormActivate(Sender: TObject);
    procedure dcmbDomicilioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure dcmbDomicilioExit(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnFamDataDaClick(Sender: TObject);
    procedure btnFamDataAClick(Sender: TObject);
    procedure btnPathFilePDFCedClick(Sender: TObject);
    procedure btnGennaioClick(Sender: TObject);
    procedure btnFebbraioClick(Sender: TObject);
    procedure btnMarzoClick(Sender: TObject);
    procedure btnAprileClick(Sender: TObject);
    procedure btnMaggioClick(Sender: TObject);
    procedure btnGiugnoClick(Sender: TObject);
    procedure btnLuglioClick(Sender: TObject);
    procedure btnAgostoClick(Sender: TObject);
    procedure btnSettembreClick(Sender: TObject);
    procedure btnOttobreClick(Sender: TObject);
    procedure btnNovembreClick(Sender: TObject);
    procedure btnDicembreClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure dedtWebDataStampaChange(Sender: TObject);
    procedure btnWebDataStampaClick(Sender: TObject);
    procedure btnDataNascitaFirmaClick(Sender: TObject);
    procedure btnDecorrenzaCaricaFirmaClick(Sender: TObject);
    procedure btnNomeFilePDFCedClick(Sender: TObject);
  private
    ModPAGHEAttivato:Boolean;
    procedure AggiornaDescrizioni;
    procedure AbilitazioniMultiAzienda;
  public
    { Public declarations }
  end;

var
  P501FCudSetup: TP501FCudSetup;

procedure OpenP501FCudSetup();

implementation

uses P501UCudSetupDtM;

{$R *.DFM}

procedure OpenP501FCudSetup();
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP501FCudSetup') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP501FCudSetup, P501FCudSetup);
  Application.CreateForm(TP501FCudSetupDtM, P501FCudSetupDtM);
  try
    P501FCudSetup.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P501FCudSetup.Free;
    P501FCudSetupDtM.Free;
  end;
end;

procedure TP501FCudSetup.FormActivate(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    DButton.DataSet:=selP500;
    selP500.Open;
    selP500.Last;
    selP500.SearchRecord('COD_AZIENDA_BASE;ANNO',VarArrayOf([T440AZIENDA_BASE,selP500.FieldByName('ANNO').AsInteger]),[srFromBeginning]);
  end;
  pgcPrincipale.ActivePage:=tshDatiGenerali;
  tshPostel.TabVisible:=False;
  tshFamiliari.TabVisible:=False;
end;

procedure TP501FCudSetup.FormShow(Sender: TObject);
var
  i:integer;
begin
  inherited;
  //Invisibilità 9.3 per futura eliminazione
  dcmbIndirizzoDomicilio.Visible:=False;
  lblIndirizzoDomicilio.Visible:=False;
  lblDescIndirizzoDomicilio.Visible:=False;
  dcmbCAPDomicilio.Visible:=False;
  lblCAPDomicilio.Visible:=False;
  lblDescCAPDomicilio.Visible:=False;
  dcmbComuneDomicilio.Visible:=False;
  lblComuneDomicilio.Visible:=False;
  lblDescComuneDomicilio.Visible:=False;
  dcmbProvinciaDomicilio.Visible:=False;
  lblProvinciaDomicilio.Visible:=False;
  lblDescProvinciaDomicilio.Visible:=False;

  dcmbCodAziendaBase.ListSource:=P501FCudSetupDtM.P501FCudSetupMW.dsrT440;
  dcmbIndirizzoDomicilio.ListSource:=P501FCudSetupDtM.P501FCudSetupMW.dsrI010;
  dcmbCAPDomicilio.ListSource:=P501FCudSetupDtM.P501FCudSetupMW.dsrI010;
  dcmbComuneDomicilio.ListSource:=P501FCudSetupDtM.P501FCudSetupMW.dsrI010;
  dcmbProvinciaDomicilio.ListSource:=P501FCudSetupDtM.P501FCudSetupMW.dsrI010;
  dcmbSedeServizio.ListSource:=P501FCudSetupDtM.P501FCudSetupMW.dsrI010;
  dcmbUnitaOperativa.ListSource:=P501FCudSetupDtM.P501FCudSetupMW.dsrI010;
  dcmbQualifica.ListSource:=P501FCudSetupDtM.P501FCudSetupMW.dsrI010;
  dcmbInizioRapporto.ListSource:=P501FCudSetupDtM.P501FCudSetupMW.dsrI010;
  dcmbPartitaIva.ListSource:=P501FCudSetupDtM.P501FCudSetupMW.dsrI010;

  //Gestione abilitazioni visitefiscali
  //Solo se la maschera è richiamata dall'applicativo presenze
  lblMatricolaInpsVF.Visible:=False;
  dedtMatricolaInpsVF.Visible:=False;
  //Verifico se il Modulo paghe è installato
  ModPAGHEAttivato:=Parametri.ApplicativiDisponibili.IndexOf('PAGHE') >= 0;
  //ModPAGHEAttivato:=False;
  if Parametri.Applicazione = 'RILPRE' then
  begin
    if ModPAGHEAttivato then
    begin
      actInserisci.Visible:=False;
      actModifica.Visible:=False;
      actCancella.Visible:=False;
    end
    else
    begin
      lblMatricolaInpsVF.Visible:=True;
      dedtMatricolaInpsVF.Visible:=True;
      for i:=0 to pgcPrincipale.PageCount - 1 do
      begin
        pgcPrincipale.Pages[i].TabVisible:=pgcPrincipale.Pages[i] = tshDatiGenerali;
      end;
    end;
  end;
end;

procedure TP501FCudSetup.btnPathFilePDFCedClick(Sender: TObject);
begin
  with P501FCudSetupDtM do
  begin
    OpenDialog1.Title:='Scelta percorso iniziale dell''archivio dei singoli cedolini in formato PDF';
    OpenDialog1.InitialDir:=selP500.FieldByName('PATH_FILEPDF_CED').AsString;
    OpenDialog1.FileName:='x';
    OpenDialog1.Options:=[ofPathMustExist,ofHideReadOnly,ofEnableSizing];
    OpenDialog1.Filter:='Tutti i file (*.*)|*.*';
    if OpenDialog1.Execute then
      selP500.FieldByName('PATH_FILEPDF_CED').AsString:=R180GetFilePath(OpenDialog1.FileName);
  end;
end;

procedure TP501FCudSetup.btnNomeFilePDFCedClick(Sender: TObject);
begin
  with P501FCudSetupDtM do
  begin
    OpenDialog1.Title:='Scelta nome file di esportazione della stampa massiva dei cedolini in formato PDF';
    OpenDialog1.InitialDir:=R180GetFilePath(selP500.FieldByName('NOME_FILEPDF_CED').AsString);
    OpenDialog1.FileName:=R180GetFileName(selP500.FieldByName('NOME_FILEPDF_CED').AsString);
    OpenDialog1.Options:=[ofPathMustExist,ofHideReadOnly,ofEnableSizing];
    OpenDialog1.Filter:='File PDF (*.pdf)|*.pdf';
    if OpenDialog1.Execute then
      selP500.FieldByName('NOME_FILEPDF_CED').AsString:=OpenDialog1.FileName;
  end;
end;

procedure TP501FCudSetup.TInserClick(Sender: TObject);
begin
  inherited;
  pgcPrincipale.ActivePage:=tshDatiGenerali;
end;

procedure TP501FCudSetup.btnFamDataDaClick(Sender: TObject);
var D:TDateTime;
begin  //NON VISIBILE
  if dedtFamDataDa.Text = '  /  /    ' then
    D:=DataOut(Parametri.DataLavoro,'Data inizio periodo','G',True)
  else
    D:=DataOut(StrToDate(dedtFamDataDa.Text),'Data inizio periodo','G',True);
  if D <> 0 then
    P501FCudSetupDtM.selP500.FieldByName('FAM_DATA_DA').AsDateTime:=D;
end;

procedure TP501FCudSetup.btnFamDataAClick(Sender: TObject);
var D:TDateTime;
begin  //NON VISIBILE
  if dedtFamDataA.Text = '  /  /    ' then
    D:=DataOut(Parametri.DataLavoro,'Data fine periodo','G',True)
  else
    D:=DataOut(StrToDate(dedtFamDataA.Text),'Data fine periodo','G',True);
  if D <> 0 then
    P501FCudSetupDtM.selP500.FieldByName('FAM_DATA_A').AsDateTime:=D;
end;

procedure TP501FCudSetup.btnWebDataStampaClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  if dedtWebDataStampa.Text = '  /  /    ' then
    D:=DataOut(Parametri.DataLavoro,'Data di stampa','G',True)
  else
    D:=DataOut(StrToDate(dedtWebDataStampa.Text),'Data di stampa','G',True);
  if D <> 0 then
    P501FCudSetupDtM.selP500.FieldByName('WEB_DATA_STAMPA').AsDateTime:=D;
end;

procedure TP501FCudSetup.btnDataNascitaFirmaClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  if dedtDataNascitaFirma.Text = '  /  /    ' then
    D:=DataOut(Parametri.DataLavoro,'Data di nascita','G',True)
  else
    D:=DataOut(StrToDate(dedtDataNascitaFirma.Text),'Data di nascita','G',True);
  if D <> 0 then
    P501FCudSetupDtM.selP500.FieldByName('DATA_NASCITA_FIRMA').AsDateTime:=D;
end;

procedure TP501FCudSetup.btnDecorrenzaCaricaFirmaClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  if dedtDecorrenzaCaricaFirma.Text = '  /  /    ' then
    D:=DataOut(Parametri.DataLavoro,'Decorrenza carica 770','G',True)
  else
    D:=DataOut(StrToDate(dedtDecorrenzaCaricaFirma.Text),'Decorrenza carica 770','G',True);
  if D <> 0 then
    P501FCudSetupDtM.selP500.FieldByName('DECORRENZA_CARICA_FIRMA').AsDateTime:=D;
end;

procedure TP501FCudSetup.btnGennaioClick(Sender: TObject);
begin
  inherited;
  //Richiamato da doubleclick dell'edit stesso
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF01').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF01').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(01);
    if Sender = btnGennaio then
      selP500.FieldByName('DATA_VERS_IRPEF01').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF01').AsDateTime,'Data versamento gennaio','G');
  end;
end;

procedure TP501FCudSetup.btnFebbraioClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF02').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF02').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(02);
    if Sender = btnFebbraio then
      selP500.FieldByName('DATA_VERS_IRPEF02').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF02').AsDateTime,'Data versamento febbraio','G');
  end;
end;

procedure TP501FCudSetup.btnMarzoClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF03').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF03').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(03);
    if Sender = btnMarzo then
      selP500.FieldByName('DATA_VERS_IRPEF03').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF03').AsDateTime,'Data versamento marzo','G');
  end;
end;

procedure TP501FCudSetup.btnAprileClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF04').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF04').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(04);
    if Sender = btnAprile then
      selP500.FieldByName('DATA_VERS_IRPEF04').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF04').AsDateTime,'Data versamento aprile','G');
  end;
end;

procedure TP501FCudSetup.btnMaggioClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF05').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF05').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(05);
    if Sender = btnMaggio then
      selP500.FieldByName('DATA_VERS_IRPEF05').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF05').AsDateTime,'Data versamento maggio','G');
  end;
end;

procedure TP501FCudSetup.btnGiugnoClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF06').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF06').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(06);
    if Sender = btnGiugno then
      selP500.FieldByName('DATA_VERS_IRPEF06').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF06').AsDateTime,'Data versamento giugno','G');
  end;
end;

procedure TP501FCudSetup.btnLuglioClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF07').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF07').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(07);
    if Sender = btnLuglio then
      selP500.FieldByName('DATA_VERS_IRPEF07').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF07').AsDateTime,'Data versamento luglio','G');
  end;
end;

procedure TP501FCudSetup.btnAgostoClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF08').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF08').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(08);
    if Sender = btnAgosto then
      selP500.FieldByName('DATA_VERS_IRPEF08').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF08').AsDateTime,'Data versamento agosto','G');
  end;
end;

procedure TP501FCudSetup.btnSettembreClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF09').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF09').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(09);
    if Sender = btnSettembre then
      selP500.FieldByName('DATA_VERS_IRPEF09').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF09').AsDateTime,'Data versamento settembre','G');
  end;
end;

procedure TP501FCudSetup.btnOttobreClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF10').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF10').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(10);
    if Sender = btnOttobre then
      selP500.FieldByName('DATA_VERS_IRPEF10').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF10').AsDateTime,'Data versamento ottobre','G');
  end;
end;

procedure TP501FCudSetup.btnNovembreClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF11').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF11').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(11);
    if Sender = btnNovembre then
      selP500.FieldByName('DATA_VERS_IRPEF11').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF11').AsDateTime,'Data versamento novembre','G');
  end;
end;

procedure TP501FCudSetup.btnDicembreClick(Sender: TObject);
begin
  inherited;
  with P501FCudSetupDtM do
  begin
    if (selP500.FieldByName('DATA_VERS_IRPEF12').IsNull) and (selP500.State in [dsEdit,dsInsert]) then
      selP500.FieldByName('DATA_VERS_IRPEF12').AsDateTime:=P501FCudSetupMW.MeseSuccessivo(12);
    if Sender = btnDicembre then
      selP500.FieldByName('DATA_VERS_IRPEF12').AsDateTime:=DataOut(selP500.FieldByName('DATA_VERS_IRPEF12').AsDateTime,'Data versamento dicembre','G');
  end;
end;

procedure TP501FCudSetup.dcmbDomicilioExit(Sender: TObject);
begin
  inherited;
  AggiornaDescrizioni;
end;

procedure TP501FCudSetup.dcmbDomicilioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=Null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TP501FCudSetup.dedtWebDataStampaChange(Sender: TObject);
begin
  inherited;
  R180ClearDBEditDateTime(Sender);
end;

procedure TP501FCudSetup.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  AggiornaDescrizioni;
  AbilitazioniMultiAzienda;
end;

procedure TP501FCudSetup.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dcmbCodAziendaBase.Enabled:=DButton.State <> dsEdit;
  btnPathFilePDFCed.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnNomeFilePDFCed.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnWebDataStampa.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataNascitaFirma.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDecorrenzaCaricaFirma.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnGennaio.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnFebbraio.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnMarzo.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnAprile.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnMaggio.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnGiugno.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnLuglio.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnAgosto.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnSettembre.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnOttobre.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnNovembre.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDicembre.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnFamDataDa.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnFamDataA.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TP501FCudSetup.AggiornaDescrizioni;
begin
  with P501FCudSetupDtM do
  begin
    lblDescIndirizzoDomicilio.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',selP500.FieldByName('IND_DOM_POSTEL').AsString,'NOME_LOGICO'));
    lblDescCAPDomicilio.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',selP500.FieldByName('CAP_DOM_POSTEL').AsString,'NOME_LOGICO'));
    lblDescComuneDomicilio.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',selP500.FieldByName('COM_DOM_POSTEL').AsString,'NOME_LOGICO'));
    lblDescProvinciaDomicilio.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',selP500.FieldByName('PRV_DOM_POSTEL').AsString,'NOME_LOGICO'));
    lblDescSedeServizio.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',selP500.FieldByName('SEDE_SERVIZIO_CED').AsString,'NOME_LOGICO'));
    lblDescUnitaOperativa.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',selP500.FieldByName('UNITA_OP_CED').AsString,'NOME_LOGICO'));
    lblDescQualifica.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',selP500.FieldByName('QUALIFICA_CED').AsString,'NOME_LOGICO'));
    lblDescInizioRapporto.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',selP500.FieldByName('DATA_INIZIO_CED').AsString,'NOME_LOGICO'));
    lblDescPartitaIva.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',selP500.FieldByName('PIVA_CED').AsString,'NOME_LOGICO'));
  end;
end;

procedure TP501FCudSetup.AbilitazioniMultiAzienda;
var AziendaBaseBASE:Boolean;
begin
  AziendaBaseBASE:=P501FCudSetupDtM.P501FCudSetupMW.selP500.FieldByName('COD_AZIENDA_BASE').AsString = T440AZIENDA_BASE;
  //Azienda
  dcmbCodAziendaBase.Visible:=P501FCudSetupDtM.P501FCudSetupMW.selT440.RecordCount > 1;
  lblCodAziendaBase.Visible:=dcmbCodAziendaBase.Visible;
  dlblDAziendaBase.Visible:=dcmbCodAziendaBase.Visible;
  //Tab CU: Valuta
  dcbxValutaStampa.Visible:=AziendaBaseBASE;
  lblCodValuta.Visible:=dcbxValutaStampa.Visible;
  dlblValuta.Visible:=dcbxValutaStampa.Visible;
  //Tab CU: Stampa da web: Abilitata
  chkWEBStampa.Visible:=AziendaBaseBASE;
  //Tab CU: Stampa da web: Data firma
  dedtWebDataStampa.Visible:=AziendaBaseBASE;
  lblWEBDataStampa.Visible:=dedtWebDataStampa.Visible;
  btnWebDataStampa.Visible:=dedtWebDataStampa.Visible;
  //Tab CU: Stampa da web: Nome file allegato istruzioni
  dedtWEBPathIstruzioni.Visible:=AziendaBaseBASE;
  lblWebPathIstruzioni.Visible:=dedtWEBPathIstruzioni.Visible;
  (*abilitazione prevista per un'eventuale riutilizzo futuro
  //Tab Postel
  tshPostel.TabVisible:=AziendaBaseBASE;*)
  //Tab Cedolino
  tshCedolino.TabVisible:=AziendaBaseBASE {*Bruno: 10/04/2018 (visite fiscali)*}and ((Parametri.Applicazione = 'PAGHE') or ModPAGHEAttivato){*};
  (*abilitazione prevista per un'eventuale riutilizzo futuro
  //Tab Familiari
  tshFamiliari.TabVisible:=AziendaBaseBASE;*)
end;

end.
