unit WA171UXMLVisiteFiscaliDettFM;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWDBStdCtrls, meIWDBEdit, medpIWMultiColumnComboBox, C190FunzioniGeneraliWeb,
  IWCompCheckbox, meIWDBCheckBox, IWAdvRadioGroup, meTIWAdvRadioGroup,
  IWDBAdvRadioGroup, meTIWDBAdvRadioGroup, IWCompExtCtrls, meIWImageFile,
  medpIWImageButton, medpIWMessageDlg, A000UInterfaccia, DB,
  Winapi.Windows, WR102UGestTabella, C180FunzioniGenerali;

type
  TWA171FXMLVisiteFiscaliDettFM = class(TWR205FDettTabellaFM)
    grpReperibilita: TmeIWLabel;
    lblRepComune: TmeIWLabel;
    lblRepCAP: TmeIWLabel;
    lblRepIndirizzo: TmeIWLabel;
    lblRepCognome: TmeIWLabel;
    dEdtRepCAP: TmeIWDBEdit;
    dEdtRepIndirizzo: TmeIWDBEdit;
    dEdtRepCognome: TmeIWDBEdit;
    dCmbRepComune: TMedpIWMultiColumnComboBox;
    dEdtDataRichiesta: TmeIWDBEdit;
    dEdtOraRichiesta: TmeIWDBEdit;
    lblDataRichiesta: TmeIWLabel;
    lblOraRichiesta: TmeIWLabel;
    dChkConfermaAmb: TmeIWDBCheckBox;
    dChkAccettaAttiMed: TmeIWDBCheckBox;
    lblDataVisita: TmeIWLabel;
    dEdtDataVisita: TmeIWDBEdit;
    dRgpTipoAmbDom: TmeTIWAdvRadioGroup;
    dRgpOrarioVisita: TmeTIWAdvRadioGroup;
    dRgpObbligoOrario: TmeTIWAdvRadioGroup;
    dChkMalattiaFerie: TmeIWDBCheckBox;
    dChkElaborato: TmeIWDBCheckBox;
    dEdtInizioMal: TmeIWDBEdit;
    dEdtFineMal: TmeIWDBEdit;
    lblInizioMal: TmeIWLabel;
    lblFineMal: TmeIWLabel;
    lblNominativo: TmeIWLabel;
    btnCopiaConfig: TmedpIWImageButton;
    grpDettaglioVisita: TmeIWLabel;
    dedtDettagliIndirizzo: TmeIWDBEdit;
    dedtTelefono: TmeIWDBEdit;
    grpDettAgg: TmeIWLabel;
    lblTelefono: TmeIWLabel;
    lblDettagliIndirizzo: TmeIWLabel;
    procedure dCmbRepComuneAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure btnCopiaConfigClick(Sender: TObject);
    procedure dEdtInizioMalAsyncChange(Sender: TObject;
      EventParams: TStringList);
  private
    { Private declarations }
    procedure CopiaConfigurazione(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    { Public declarations }
    procedure CaricaMultiColumnCombobox; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
  end;

implementation

uses
  WA171UXMLVisiteFiscaliDM, A171UXMLVisiteFiscaliMW, WA171UXMLVisiteFiscali;

{$R *.dfm}

procedure TWA171FXMLVisiteFiscaliDettFM.CaricaMultiColumnCombobox;
begin
  C190CaricaMepdMulticolumnComboBox(dCmbRepComune,(WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.selT480,'CODCATASTALE','CITTA');
end;

procedure TWA171FXMLVisiteFiscaliDettFM.DataSet2Componenti;
begin
  inherited;
  dCmbRepComune.Text:=(WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('DescComuneRep').AsString;
  //dRgpTipoAmbDom(TIPO_AMB_DOM)
  if (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('TIPO_AMB_DOM').AsString = 'A' then
  begin
    dRgpTipoAmbDom.ItemIndex:=0;
  end
  else if (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('TIPO_AMB_DOM').AsString = 'D' then
  begin
    dRgpTipoAmbDom.ItemIndex:=1;
  end;
  //dRgpOrarioVisita(ORARIO_VISITA)
  if (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('ORARIO_VISITA').AsString = 'A' then
  begin
    dRgpOrarioVisita.ItemIndex:=0;
  end
  else if (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('ORARIO_VISITA').AsString = 'P' then
  begin
    dRgpOrarioVisita.ItemIndex:=1;
  end
  else if (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('ORARIO_VISITA').AsString = 'N' then
  begin
    dRgpOrarioVisita.ItemIndex:=2;
  end;
  //dRgpObbligoOrario(OBBLIGO_ORARIO)
  if (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('OBBLIGO_ORARIO').AsString = 'S' then
  begin
    dRgpObbligoOrario.ItemIndex:=0;
  end
  else if (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('OBBLIGO_ORARIO').AsString = 'N' then
  begin
    dRgpObbligoOrario.ItemIndex:=1;
  end;
end;

procedure TWA171FXMLVisiteFiscaliDettFM.dCmbRepComuneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  CAPVal:string;
begin
  inherited;
  CAPVal:=VarToStr((WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.selT480.Lookup('CODCATASTALE',dCmbRepComune.Items[dCmbRepComune.ItemIndex].RowData[0] ,'CAP'));
  (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('CAP_REP').AsString:=CAPVal;
end;

procedure TWA171FXMLVisiteFiscaliDettFM.dEdtInizioMalAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWA171FXMLVisiteFiscaliDM) do
  begin
    A171MW.VerificaPeriodoMalT049(dEdtInizioMal.Text, dEdtFineMal.Text);
    //Se il dataset è in edit(modifico lo stato del check MALATTIA_FERIE)
    if selTabella.State in [dsInsert, dsEdit] then
    begin
      A171MW.T049PeriodoMalattiaDa:=selTabella.FieldByName('INIZIO_MAL').AsDateTime;
      A171MW.T049PeriodoMalattiaA:=selTabella.FieldByName('FINE_MAL').AsDateTime;
      selTabella.FieldByName('MALATTIA_FERIE').AsString:=A171MW.PeriodoMalattiaInFerie(selTabella.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;
end;

procedure TWA171FXMLVisiteFiscaliDettFM.btnCopiaConfigClick(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA171FXMLVisiteFiscaliDM) do
  begin
    A171MW.ControlliCopia;
    MsgBox.WebMessageDlg('Attenzione: i nuovi dati ' +  A171MW.updMessaggio + ' verranno estesi a tutte le visite presenti in griglia. Confermi l''operazione?',
                       mtConfirmation,[mbYes,mbNo],CopiaConfigurazione,'');
  end;
end;

procedure TWA171FXMLVisiteFiscaliDettFM.CopiaConfigurazione(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.CopiaConfigurazione;
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.Refresh;
    (Parent as TWA171FXMLVisiteFiscali).WBrowseFM.grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWA171FXMLVisiteFiscaliDettFM.Componenti2DataSet;
begin
  inherited;
  //dCmbRepComune
  if dCmbRepComune.ItemIndex >= 0 then
  begin
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('CODCATASTALE_REP').AsString:=dCmbRepComune.Items[dCmbRepComune.ItemIndex].RowData[0];
  end
  else
  begin
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('CODCATASTALE_REP').AsString:='';
  end;
  //dRgpTipoAmbDom(TIPO_AMB_DOM)
  if dRgpTipoAmbDom.ItemIndex = 0 then
  begin
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('TIPO_AMB_DOM').AsString:='A';
  end
  else if dRgpTipoAmbDom.ItemIndex = 1 then
  begin
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('TIPO_AMB_DOM').AsString:='D';
  end;
  //dRgpOrarioVisita(ORARIO_VISITA)
  if dRgpOrarioVisita.ItemIndex = 0 then
  begin
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('ORARIO_VISITA').AsString:='A';
  end
  else if dRgpOrarioVisita.ItemIndex = 1 then
  begin
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('ORARIO_VISITA').AsString:='P';
  end
  else if dRgpOrarioVisita.ItemIndex = 2 then
  begin
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('ORARIO_VISITA').AsString:='N';
  end;
  //dRgpObbligoOrario(OBBLIGO_ORARIO)
  if dRgpObbligoOrario.ItemIndex = 0 then
  begin
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('OBBLIGO_ORARIO').AsString:='S';
  end
  else if dRgpObbligoOrario.ItemIndex = 1 then
  begin
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.FieldByName('OBBLIGO_ORARIO').AsString:='N';
  end;
  btnCopiaConfig.Enabled:=False;
end;

end.
