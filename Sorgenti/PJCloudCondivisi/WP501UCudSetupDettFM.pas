unit WP501UCudSetupDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, meIWRegion, IWCompGrids, meIWGrid, medpIWTabControl,
  A000UInterfaccia, medpIWMultiColumnComboBox, IWCompMemo, meIWDBMemo, IWCompCheckbox, meIWDBCheckBox, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, IWCompListbox, meIWDBLookupComboBox, IWCompButton, meIWButton, meIWEdit,
  DB, A000UCostanti;

type
  TWP501FCudSetupDettFM = class(TWR205FDettTabellaFM)
    lblAnno: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    WP501DatiGeneraliRG: TmeIWRegion;
    TemplateDatiGeneraliRG: TIWTemplateProcessorHTML;
    WP501DatiCudRG: TmeIWRegion;
    TemplateDatiCudRG: TIWTemplateProcessorHTML;
    WP501Dati770RG: TmeIWRegion;
    TemplateDati770RG: TIWTemplateProcessorHTML;
    WP501DatiDMARG: TmeIWRegion;
    TemplateDatiDMARG: TIWTemplateProcessorHTML;
    WP501DatiEMensRG: TmeIWRegion;
    TemplateDatiEMensRG: TIWTemplateProcessorHTML;
    WP501DatiINPGIRG: TmeIWRegion;
    TemplateDatiINPGIRG: TIWTemplateProcessorHTML;
    WP501DatiEnpamRG: TmeIWRegion;
    TemplateDatiEnpamRG: TIWTemplateProcessorHTML;
    TemplateDatiOnaosiRG: TIWTemplateProcessorHTML;
    WP501FirmatarioRG: TmeIWRegion;
    TemplateDatiFirmatarioRG: TIWTemplateProcessorHTML;
    WP501DatiBancaRG: TmeIWRegion;
    TemplateDatiBancaRG: TIWTemplateProcessorHTML;
    WP501PostelRG: TmeIWRegion;
    TemplatePostelRG: TIWTemplateProcessorHTML;
    WP501CedolinoRG: TmeIWRegion;
    TemplateCedolinoRG: TIWTemplateProcessorHTML;
    WP501FamiliariRG: TmeIWRegion;
    TemplateFamiliariRG: TIWTemplateProcessorHTML;
    grdTabDetail: TmedpIWTabControl;
    lblCodFiscale: TmeIWLabel;
    dedtCodFiscale: TmeIWDBEdit;
    dedtDenominazione: TmeIWDBEdit;
    lblDenominazione: TmeIWLabel;
    dedtComune: TmeIWDBEdit;
    lblComune: TmeIWLabel;
    dedtProvincia: TmeIWDBEdit;
    lblProvincia: TmeIWLabel;
    dedtIndirizzo: TmeIWDBEdit;
    lblIndirizzo: TmeIWLabel;
    dedtTelefono: TmeIWDBEdit;
    lblTelefono: TmeIWLabel;
    dedtEmail: TmeIWDBEdit;
    lblEmail: TmeIWLabel;
    dedtCodComune: TmeIWDBEdit;
    lblCodComune: TmeIWLabel;
    dedtCap: TmeIWDBEdit;
    lblCap: TmeIWLabel;
    dedtFax: TmeIWDBEdit;
    lblFax: TmeIWLabel;
    lblCodValuta: TmeIWLabel;
    lblCodAteco: TmeIWLabel;
    lblFirmatario: TmeIWLabel;
    dedtCodATECO1: TmeIWDBEdit;
    dedtFirmatario: TmeIWDBEdit;
    cmbValutaStampa: TMedpIWMultiColumnComboBox;
    lblDescrValuta: TmeIWLabel;
    lblStampaWeb: TmeIWLabel;
    chkWEBStampa: TmeIWDBCheckBox;
    lblWEBDataStampa: TmeIWLabel;
    dedtWebDataStampa: TmeIWDBEdit;
    lblWebPathIstruzioni: TmeIWLabel;
    dedtWEBPathIstruzioni: TmeIWDBEdit;
    dmemoWEBAnnotazioni: TmeIWDBMemo;
    lblWebAnnotazioni: TmeIWLabel;
    dedCodiceAttivita: TmeIWDBEdit;
    lblCodiceAttivita: TmeIWLabel;
    dedtStatoEnte: TmeIWDBEdit;
    lblStatoEnte: TmeIWLabel;
    dedtNaturaGiuridica: TmeIWDBEdit;
    lblNaturaGiuridica: TmeIWLabel;
    dedtSituazioneEnte: TmeIWDBEdit;
    lblSituazioneEnte: TmeIWLabel;
    dedtCodFiscaleDicastero: TmeIWDBEdit;
    lblCodFiscaleDicastero: TmeIWLabel;
    lblDataVersamento: TmeIWLabel;
    lblGennaio: TmeIWLabel;
    lblFebbraio: TmeIWLabel;
    lblMarzo: TmeIWLabel;
    lblAprile: TmeIWLabel;
    lblMaggio: TmeIWLabel;
    lblGiugno: TmeIWLabel;
    lblLuglio: TmeIWLabel;
    lblAgosto: TmeIWLabel;
    lblSettembre: TmeIWLabel;
    lblOttobre: TmeIWLabel;
    lblNovembre: TmeIWLabel;
    lblDicembre: TmeIWLabel;
    lblCodFornitura: TmeIWLabel;
    dedtCodFornitura: TmeIWDBEdit;
    lblTipoFornitoreDMA: TmeIWLabel;
    dedtTipoFornitoreDMA: TmeIWDBEdit;
    lblCodINPDAP: TmeIWLabel;
    lblCodATECO2: TmeIWLabel;
    lblCodFormaGiurid: TmeIWLabel;
    dedtCodFormaGiurid: TmeIWDBEdit;
    lblCodComparto: TmeIWLabel;
    dedtCodComparto: TmeIWDBEdit;
    lblCodSottoComparto: TmeIWLabel;
    dedtCodSottoComparto: TmeIWDBEdit;
    lblCodFiscSw: TmeIWLabel;
    dchkFirmaDenuncia: TmeIWDBCheckBox;
    lblMatricolaInps: TmeIWLabel;
    dedtMatricolaInps: TmeIWDBEdit;
    dedtCodiceInps: TmeIWDBEdit;
    lblCodiceInps: TmeIWLabel;
    dedtCodFiscaleMitt: TmeIWDBEdit;
    lblCodFiscaleMitt: TmeIWLabel;
    dedtCodiceIstat: TmeIWDBEdit;
    lblCodiceIstat: TmeIWLabel;
    lblCodFiscaleProdut1: TmeIWLabel;
    dedtCodINPDAPDMA2: TmeIWDBEdit;
    lblCodINPDAPDMA2: TmeIWLabel;
    lblCodFiscaleFirmaDMA2: TmeIWLabel;
    dedtCodFormaGiuridDMA2: TmeIWDBEdit;
    lblCodFormaGiuridDMA2: TmeIWLabel;
    dedtCodContrattoDMA2: TmeIWDBEdit;
    lblCodContrattoDMA2: TmeIWLabel;
    lblCodINPGI: TmeIWLabel;
    dedtCodINPGI: TmeIWDBEdit;
    dedtCodEnpam: TmeIWDBEdit;
    lblCodEnpam: TmeIWLabel;
    lblFirmatarioGrp: TmeIWLabel;
    lblCodFiscaleFirma: TmeIWLabel;
    dedtCodFiscaleFirma: TmeIWDBEdit;
    dedtCognomeFirma: TmeIWDBEdit;
    lblCognomeFirma: TmeIWLabel;
    dedtComuneNascitaFirma: TmeIWDBEdit;
    lblComuneNascitaFirma: TmeIWLabel;
    dedtComuneResidenzaFirma: TmeIWDBEdit;
    lblComuneResidenzaFirma: TmeIWLabel;
    dedtIndirizzoResidenzaFirma: TmeIWDBEdit;
    lblIndirizzoResidenzaFirma: TmeIWLabel;
    dedtCodiceCarica: TmeIWDBEdit;
    lblCodiceCarica: TmeIWLabel;
    drgpSessoFirma: TmeIWDBRadioGroup;
    lblSesso: TmeIWLabel;
    lblNomeFirma: TmeIWLabel;
    dedtNomeFirma: TmeIWDBEdit;
    dedtProvinciaNascitaFirma: TmeIWDBEdit;
    lblProvinciaNascitaFirma: TmeIWLabel;
    dedtProvinciaResidenzaFirma: TmeIWDBEdit;
    lblProvinciaResidenzaFirma: TmeIWLabel;
    dedtTelefonoFirma: TmeIWDBEdit;
    lblTelefonoFirma: TmeIWLabel;
    dedtDecorrenzaCaricaFirma: TmeIWDBEdit;
    lblDecorrenzaCaricaFirma: TmeIWLabel;
    dedtDataNascitaFirma: TmeIWDBEdit;
    lblDataNascitaFirma: TmeIWLabel;
    dedtCapResidenzaFirma: TmeIWDBEdit;
    lblCapResidenzaFirma: TmeIWLabel;
    dedtCodSIA: TmeIWDBEdit;
    lblCodSIA: TmeIWLabel;
    dedtCodABI: TmeIWDBEdit;
    lblCodABI: TmeIWLabel;
    dedtCodCAB: TmeIWDBEdit;
    lblCodCAB: TmeIWLabel;
    dedtContoCorrente: TmeIWDBEdit;
    lblContoCorrente: TmeIWLabel;
    lblIdAbbonato: TmeIWLabel;
    dedtIdAbbonato: TmeIWDBEdit;
    dedtTipologiaInvio: TmeIWDBEdit;
    lblTipologiaInvio: TmeIWLabel;
    dedtColore: TmeIWDBEdit;
    lblColore: TmeIWLabel;
    dedtCentroCosto: TmeIWDBEdit;
    lblCentroCosto: TmeIWLabel;
    dedtTrattamento: TmeIWDBEdit;
    lblTrattamento: TmeIWLabel;
    dedtProcedura: TmeIWDBEdit;
    lblProcedura: TmeIWLabel;
    lblIndirizzoDomicilio: TmeIWLabel;
    lblDescIndirizzoDomicilio: TmeIWLabel;
    lblCAPDomicilio: TmeIWLabel;
    lblDescCAPDomicilio: TmeIWLabel;
    lblComuneDomicilio: TmeIWLabel;
    lblDescComuneDomicilio: TmeIWLabel;
    lblProvinciaDomicilio: TmeIWLabel;
    lblDescProvinciaDomicilio: TmeIWLabel;
    dcmbIndirizzoDomicilio: TmeIWDBLookupComboBox;
    dcmbCAPDomicilio: TmeIWDBLookupComboBox;
    dcmbComuneDomicilio: TmeIWDBLookupComboBox;
    dcmbProvinciaDomicilio: TmeIWDBLookupComboBox;
    lblSedeServizio: TmeIWLabel;
    dcmbSedeServizio: TmeIWDBLookupComboBox;
    lblDescUnitaOperativa: TmeIWLabel;
    lblUnitaOperativa: TmeIWLabel;
    dcmbUnitaOperativa: TmeIWDBLookupComboBox;
    lblQualifica: TmeIWLabel;
    dcmbQualifica: TmeIWDBLookupComboBox;
    lblInizioRapporto: TmeIWLabel;
    dcmbInizioRapporto: TmeIWDBLookupComboBox;
    lblPartitaIva: TmeIWLabel;
    dcmbPartitaIva: TmeIWDBLookupComboBox;
    lblDescSedeServizio: TmeIWLabel;
    lblDescQualifica: TmeIWLabel;
    lblDescInizioRapporto: TmeIWLabel;
    lblDescPartitaIva: TmeIWLabel;
    lblPathFilePDFCed: TmeIWLabel;
    dedtPathFilePDFCed: TmeIWDBEdit;
    lblDichiarazioneFamiliari: TmeIWLabel;
    lblPeriodoDichiarazione: TmeIWLabel;
    dedtFamDataDa: TmeIWDBEdit;
    lblFamDataDa: TmeIWLabel;
    dedtFamDataA: TmeIWDBEdit;
    lblFamDataA: TmeIWLabel;
    dchkFamStatoCivile: TmeIWDBCheckBox;
    lblFamPathIstruzioni: TmeIWLabel;
    dedtFamPathIstruzioni: TmeIWDBEdit;
    lblFamNote: TmeIWLabel;
    dmemFamNote: TmeIWDBMemo;
    edtGennaio: TmeIWEdit;
    edtFebbraio: TmeIWEdit;
    edtMarzo: TmeIWEdit;
    edtAprile: TmeIWEdit;
    edtMaggio: TmeIWEdit;
    edtGiugno: TmeIWEdit;
    edtLuglio: TmeIWEdit;
    edtAgosto: TmeIWEdit;
    edtSettembre: TmeIWEdit;
    edtOttobre: TmeIWEdit;
    edtNovembre: TmeIWEdit;
    edtDicembre: TmeIWEdit;
    edtCodINPDAP: TmeIWEdit;
    edtCodFiscaleProdut: TmeIWEdit;
    edtCodAteco: TmeIWEdit;
    edtCodFiscaleProdut1: TmeIWEdit;
    edtCodFiscaleFirmaDMA2: TmeIWEdit;
    lblCodIBAN: TmeIWLabel;
    dedtCodIBAN: TmeIWDBEdit;
    lblNomeFilePDFCed: TmeIWLabel;
    dedtNomeFilePDFCed: TmeIWDBEdit;
    lblCodAziendaBase: TmeIWLabel;
    cmbCodAziendaBase: TMedpIWMultiColumnComboBox;
    lblDAziendaBase: TmeIWLabel;
    lblTipoFornitore: TmeIWLabel;
    dedtTipoFornitore: TmeIWDBEdit;
    lbl770TipoFornitore: TmeIWLabel;
    edt770TipoFornitore: TmeIWEdit;
    lblCodFiscaleProdut2: TmeIWLabel;
    dedtCodFiscaleProdut2: TmeIWDBEdit;
    lbl770CodFiscaleSW: TmeIWLabel;
    edt770CodFiscaleSW: TmeIWEdit;
    edtPathFilePDFCU: TmeIWEdit;
    lblPathFilePDFCU: TmeIWLabel;
    lblMatricolaInpsVF: TmeIWLabel;
    dedtMatricolaInpsVF: TmeIWDBEdit;
    lblEmailPEC: TmeIWLabel;
    dedtEmailPEC: TmeIWDBEdit;
    WP501DatiOnaosiRG: TmeIWRegion;
    dedtCodOnaosi: TmeIWDBEdit;
    lblCodOnaosi: TmeIWLabel;
    lblRespUOOnaosi: TmeIWLabel;
    lblNominRespUOOnaosi: TmeIWLabel;
    dedtNominRespUOOnaosi: TmeIWDBEdit;
    lblTelefonoRespUOOnaosi: TmeIWLabel;
    dedtTelefonoRespUOOnaosi: TmeIWDBEdit;
    lblEmailRespUOOnaosi: TmeIWLabel;
    dedtEmailRespUOOnaosi: TmeIWDBEdit;
    lblRespProcOnaosi: TmeIWLabel;
    lblNominRespProcOnaosi: TmeIWLabel;
    dedtNominRespProcOnaosi: TmeIWDBEdit;
    lblTelefonoRespProcOnaosi: TmeIWLabel;
    dedtTelefonoRespProcOnaosi: TmeIWDBEdit;
    lblEmailRespProcOnaosi: TmeIWLabel;
    dedtEmailRespProcOnaosi: TmeIWDBEdit;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dcomboAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbValutaStampaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure edtGennaioAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtFebbraioAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtMarzoAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtAprileAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtMaggioAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtGiugnoAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtLuglioAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtAgostoAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtSettembreAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtOttobreAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtNovembreAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure edtDicembreAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure dedtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbCodAziendaBaseChange(Sender: TObject; Index: Integer);
  private
    procedure AggiornaComponenti;
    procedure Componenti2DataSet;override;
    procedure DataSet2Componenti;override;
    procedure CaricaMultiColumnCombobox;Override;
  public
    { Public declarations }
    procedure AbilitazioniMultiAzienda;
  end;

implementation

uses WP501UCudSetupDM, WR102UGestTabella, WP501UCudSetup;

{$R *.dfm}

procedure TWP501FCudSetupDettFM.IWFrameRegionCreate(Sender: TObject);
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

  dcmbIndirizzoDomicilio.ListSource:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.dsrI010;
  dcmbCAPDomicilio.ListSource:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.dsrI010;
  dcmbComuneDomicilio.ListSource:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.dsrI010;
  dcmbProvinciaDomicilio.ListSource:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.dsrI010;
  dcmbSedeServizio.ListSource:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.dsrI010;
  dcmbUnitaOperativa.ListSource:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.dsrI010;
  dcmbQualifica.ListSource:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.dsrI010;
  dcmbInizioRapporto.ListSource:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.dsrI010;
  dcmbPartitaIva.ListSource:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.dsrI010;

  grdTabDetail.AggiungiTab('Azienda',WP501DatiGeneraliRG);
  grdTabDetail.AggiungiTab('CU',WP501DatiCudRG);
  grdTabDetail.AggiungiTab('770',WP501Dati770RG);
  grdTabDetail.AggiungiTab('D.M.A.',WP501DatiDMARG);
  grdTabDetail.AggiungiTab('uniEMens',WP501DatiEMensRG);
  grdTabDetail.AggiungiTab('INPGI',WP501DatiINPGIRG);
  grdTabDetail.AggiungiTab('ENPAM',WP501DatiEnpamRG);
  grdTabDetail.AggiungiTab('ONAOSI',WP501DatiOnaosiRG);
  grdTabDetail.AggiungiTab('Firmatario',WP501FirmatarioRG);
  grdTabDetail.AggiungiTab('Tesoriere',WP501DatiBancaRG);

  WP501DatiGeneraliRG.Visible:=True;
  WP501DatiCudRG.Visible:=True;
  WP501Dati770RG.Visible:=True;
  WP501DatiDMARG.Visible:=True;
  WP501DatiEMensRG.Visible:=True;
  WP501DatiINPGIRG.Visible:=True;
  WP501DatiOnaosiRG.Visible:=True;
  WP501DatiEnpamRG.Visible:=True;
  WP501FirmatarioRG.Visible:=True;
  WP501DatiBancaRG.Visible:=True;

  //grdTabDetail.AggiungiTab('Postel',WP501PostelRG);
  //WP501PostelRG.Visible:=True;

  grdTabDetail.AggiungiTab('Cedolino',WP501CedolinoRG);
  WP501CedolinoRG.Visible:=True;
  grdTabDetail.ActiveTab:=WP501DatiGeneraliRG;

  //ModPAGHEAttivato:=False;
  if Parametri.Applicazione = 'RILPRE' then
  begin
    if Not (Parent as TWP501FCudSetup).ModPAGHEAttivato then
    begin
      lblMatricolaInpsVF.Visible:=True;
      dedtMatricolaInpsVF.Visible:=True;
      for i:=0 to grdTabDetail.TabCount - 1 do
      begin
        grdTabDetail.TabByIndex(i).Visible:=grdTabDetail.TabByIndex(i).Caption = 'Azienda';
      end;
    end;
  end;

  //grdTabDetail.AggiungiTab('Familiari',WP501FamiliariRG);
end;

procedure TWP501FCudSetupDettFM.cmbCodAziendaBaseChange(Sender: TObject; Index: Integer);
begin
  (WR302DM as TWP501FCudSetupDM).SelTabella.FieldByName('COD_AZIENDA_BASE').AsString:=cmbCodAziendaBase.Text;
  lblDAziendaBase.Caption:=(WR302DM as TWP501FCudSetupDM).SelTabella.FieldByName('D_AZIENDA_BASE').AsString;
end;

procedure TWP501FCudSetupDettFM.cmbValutaStampaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWP501FCudSetupDM).SelTabella.FieldByName('COD_VALUTA').AsString:=cmbValutaStampa.Text;
  lblDescrValuta.Caption:='';
  if cmbValutaStampa.Text <> '' then
    lblDescrValuta.Caption:=VarToStr((WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.selP030.Lookup('COD_VALUTA',cmbValutaStampa.Text,'DESCRIZIONE'));
end;

procedure TWP501FCudSetupDettFM.dcomboAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  AggiornaComponenti;
end;

procedure TWP501FCudSetupDettFM.dedtAnnoAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if (WR302DM as TWP501FCudSetupDM).selTabella.FieldByName('ANNO').AsInteger <> 0 then
  begin
    (WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.CambiaAnno;
    CaricaMultiColumnCombobox;
  end;
end;

procedure TWP501FCudSetupDettFM.edtGennaioAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtGennaio.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtGennaio.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(01));
end;

procedure TWP501FCudSetupDettFM.edtFebbraioAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtFebbraio.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtFebbraio.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(02));
end;

procedure TWP501FCudSetupDettFM.edtMarzoAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtMarzo.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtMarzo.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(03));
end;

procedure TWP501FCudSetupDettFM.edtAprileAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtAprile.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtAprile.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(04));
end;

procedure TWP501FCudSetupDettFM.edtMaggioAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtMaggio.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtMaggio.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(05));
end;

procedure TWP501FCudSetupDettFM.edtGiugnoAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtGiugno.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtGiugno.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(06));
end;

procedure TWP501FCudSetupDettFM.edtLuglioAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtLuglio.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtLuglio.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(07));
end;

procedure TWP501FCudSetupDettFM.edtAgostoAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtAgosto.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtAgosto.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(08));
end;

procedure TWP501FCudSetupDettFM.edtSettembreAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtSettembre.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtSettembre.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(09));
end;

procedure TWP501FCudSetupDettFM.edtOttobreAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtOttobre.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtOttobre.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(10));
end;

procedure TWP501FCudSetupDettFM.edtNovembreAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtNovembre.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtNovembre.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(11));
end;

procedure TWP501FCudSetupDettFM.edtDicembreAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
    if (edtDicembre.Text = '__/__/____') and (selTabella.State in [dsEdit,dsInsert]) then
      edtDicembre.Text:=DateToStr(P501FCudSetupMW.MeseSuccessivo(12));
end;

procedure TWP501FCudSetupDettFM.grdTabDetailTabControlChange(Sender: TObject);
begin
  inherited;
  AggiornaComponenti;
end;

procedure TWP501FCudSetupDettFM.CaricaMultiColumnCombobox;
begin
  //Azienda
  with (WR302DM as TWP501FCudSetupDM).P501FCudSetupMW do
  begin
    cmbCodAziendaBase.Items.Clear;
    selT440.First;
    while not selT440.Eof do
    begin
      cmbCodAziendaBase.AddRow(selT440.FieldByName('CODICE').AsString + ';' + selT440.FieldByName('DESCRIZIONE').AsString);
      selT440.Next;
    end;
  end;
  cmbCodAziendaBase.Text:=(WR302DM as TWP501FCudSetupDM).SelTabella.FieldByName('COD_AZIENDA_BASE').AsString;
  lblDAziendaBase.Caption:=(WR302DM as TWP501FCudSetupDM).SelTabella.FieldByName('D_AZIENDA_BASE').AsString;
  //Valuta
  with (WR302DM as TWP501FCudSetupDM).P501FCudSetupMW do
  begin
    cmbValutaStampa.Items.Clear;
    selP030.First;
    while not selP030.Eof do
    begin
      cmbValutaStampa.AddRow(selP030.FieldByName('COD_VALUTA').AsString + ';' + selP030.FieldByName('DESCRIZIONE').AsString);
      selP030.Next;
    end;
  end;
  cmbValutaStampa.Text:=(WR302DM as TWP501FCudSetupDM).SelTabella.FieldByName('COD_VALUTA').AsString;
  lblDescrValuta.Caption:='';
  if cmbValutaStampa.Text <> '' then
    lblDescrValuta.Caption:=VarToStr((WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.selP030.Lookup('COD_VALUTA',cmbValutaStampa.Text,'DESCRIZIONE'));
end;

procedure TWP501FCudSetupDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
  begin
    selTabella.FieldByName('COD_AZIENDA_BASE').AsString:=cmbCodAziendaBase.Text;
    selTabella.FieldByName('COD_VALUTA').AsString:=cmbValutaStampa.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF01').AsString:=edtGennaio.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF02').AsString:=edtFebbraio.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF03').AsString:=edtMarzo.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF04').AsString:=edtAprile.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF05').AsString:=edtMaggio.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF06').AsString:=edtGiugno.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF07').AsString:=edtLuglio.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF08').AsString:=edtAgosto.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF09').AsString:=edtSettembre.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF10').AsString:=edtOttobre.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF11').AsString:=edtNovembre.Text;
    selTabella.FieldByName('DATA_VERS_IRPEF12').AsString:=edtDicembre.Text;
  end;
end;

procedure TWP501FCudSetupDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWP501FCudSetupDM) do
  begin
    cmbCodAziendaBase.Text:=SelTabella.FieldByName('COD_AZIENDA_BASE').AsString;
    lblDAziendaBase.Caption:=SelTabella.FieldByName('D_AZIENDA_BASE').AsString;
    cmbValutaStampa.Text:=SelTabella.FieldByName('COD_VALUTA').AsString;
    lblDescrValuta.Caption:='';
    if cmbValutaStampa.Text <> '' then
      lblDescrValuta.Caption:=VarToStr((WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.selP030.Lookup('COD_VALUTA',cmbValutaStampa.Text,'DESCRIZIONE'));
    edtGennaio.Text:=selTabella.FieldByName('DATA_VERS_IRPEF01').AsString;
    edtFebbraio.Text:=selTabella.FieldByName('DATA_VERS_IRPEF02').AsString;
    edtMarzo.Text:=selTabella.FieldByName('DATA_VERS_IRPEF03').AsString;
    edtAprile.Text:=selTabella.FieldByName('DATA_VERS_IRPEF04').AsString;
    edtMaggio.Text:=selTabella.FieldByName('DATA_VERS_IRPEF05').AsString;
    edtGiugno.Text:=selTabella.FieldByName('DATA_VERS_IRPEF06').AsString;
    edtLuglio.Text:=selTabella.FieldByName('DATA_VERS_IRPEF07').AsString;
    edtAgosto.Text:=selTabella.FieldByName('DATA_VERS_IRPEF08').AsString;
    edtSettembre.Text:=selTabella.FieldByName('DATA_VERS_IRPEF09').AsString;
    edtOttobre.Text:=selTabella.FieldByName('DATA_VERS_IRPEF10').AsString;
    edtNovembre.Text:=selTabella.FieldByName('DATA_VERS_IRPEF11').AsString;
    edtDicembre.Text:=selTabella.FieldByName('DATA_VERS_IRPEF12').AsString;
  end;
  AggiornaComponenti;
end;

procedure TWP501FCudSetupDettFM.AggiornaComponenti;
begin
  with (WR302DM as TWP501FCudSetupDM) do
  begin
    edtCodINPDAP.Text:=selTabella.FieldByName('CODICE_INPDAP_DMA').AsString;
    edtCodFiscaleProdut.Text:=selTabella.FieldByName('COD_FISCALE_SW_DMA').AsString;
    edtCodAteco.Text:=selTabella.FieldByName('CODICE_ATECO_DMA').AsString;
    edtCodFiscaleProdut1.Text:=selTabella.FieldByName('COD_FISCALE_SW_DMA').AsString;
    edtCodFiscaleFirmaDMA2.Text:=selTabella.FieldByName('COD_FISCALE_FIRMA').AsString;
    edt770TipoFornitore.Text:=selTabella.FieldByName('TIPO_FORNITORE').AsString;
    edt770CodFiscaleSW.Text:=selTabella.FieldByName('COD_FISCALE_SW_DMA').AsString;
    edtPathFilePDFCU.Text:=selTabella.FieldByName('PATH_FILEPDF_CED').AsString;
    lblDescIndirizzoDomicilio.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',SelTabella.FieldByName('IND_DOM_POSTEL').AsString,'NOME_LOGICO'));
    lblDescCAPDomicilio.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',SelTabella.FieldByName('CAP_DOM_POSTEL').AsString,'NOME_LOGICO'));
    lblDescComuneDomicilio.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',SelTabella.FieldByName('COM_DOM_POSTEL').AsString,'NOME_LOGICO'));
    lblDescProvinciaDomicilio.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',SelTabella.FieldByName('PRV_DOM_POSTEL').AsString,'NOME_LOGICO'));
    lblDescSedeServizio.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',SelTabella.FieldByName('SEDE_SERVIZIO_CED').AsString,'NOME_LOGICO'));
    lblDescUnitaOperativa.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',SelTabella.FieldByName('UNITA_OP_CED').AsString,'NOME_LOGICO'));
    lblDescQualifica.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',SelTabella.FieldByName('QUALIFICA_CED').AsString,'NOME_LOGICO'));
    lblDescInizioRapporto.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',SelTabella.FieldByName('DATA_INIZIO_CED').AsString,'NOME_LOGICO'));
    lblDescPartitaIva.Caption:=VarToStr(P501FCudSetupMW.selI010.Lookup('NOME_CAMPO',SelTabella.FieldByName('PIVA_CED').AsString,'NOME_LOGICO'));
  end;
end;

procedure TWP501FCudSetupDettFM.AbilitazioniMultiAzienda;
var AziendaBaseBASE:Boolean;
begin
  AziendaBaseBASE:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.selP500.FieldByName('COD_AZIENDA_BASE').AsString = T440AZIENDA_BASE;
  //Azienda
  cmbCodAziendaBase.Visible:=(WR302DM as TWP501FCudSetupDM).P501FCudSetupMW.selT440.RecordCount > 1;
  lblCodAziendaBase.Visible:=cmbCodAziendaBase.Visible;
  lblDAziendaBase.Visible:=cmbCodAziendaBase.Visible;
  //Tab CU: Valuta
  cmbValutaStampa.Visible:=AziendaBaseBASE;
  lblCodValuta.Visible:=cmbValutaStampa.Visible;
  lblDescrValuta.Visible:=cmbValutaStampa.Visible;
  //Tab CU: Stampa da web: Abilitata
  chkWEBStampa.Visible:=AziendaBaseBASE;
  //Tab CU: Stampa da web: Data firma
  dedtWebDataStampa.Visible:=AziendaBaseBASE;
  lblWEBDataStampa.Visible:=dedtWebDataStampa.Visible;
  //Tab CU: Stampa da web: Nome file allegato istruzioni
  dedtWEBPathIstruzioni.Visible:=AziendaBaseBASE;
  lblWebPathIstruzioni.Visible:=dedtWEBPathIstruzioni.Visible;
  (*abilitazione prevista per un'eventuale riutilizzo futuro
  //Tab Postel
  grdTabDetail.Tabs[WP501PostelRG].LinkVisible:=AziendaBaseBASE;*)
  //Tab Cedolino
  grdTabDetail.Tabs[WP501CedolinoRG].LinkVisible:=AziendaBaseBASE and ((Parametri.Applicazione = 'PAGHE') or (Parent as TWP501FCudSetup).ModPAGHEAttivato);
  (*abilitazione prevista per un'eventuale riutilizzo futuro
  //Tab Familiari
  grdTabDetail.Tabs[WP501FamiliariRG].LinkVisible:=AziendaBaseBASE;*)
end;

end.
