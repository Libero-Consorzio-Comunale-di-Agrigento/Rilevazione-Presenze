unit WP684UGrigliaDettDefinizioneFondi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, Oracle, Data.DB,
  System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit,
  meIWEdit, IWCompGrids, meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  P684UDefinizioneFondiMW, A000UMessaggi, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, IWCompCheckbox, meIWCheckBox;

type
  TWP684FGrigliaDettDefinizioneFondi = class(TWR102FGestTabella)
    TemplateAreaIntestazioneRG: TIWTemplateProcessorHTML;
    WP684FGrigliaDettDefinizioneFondiAreaIntestazioneRG: TmeIWRegion;
    WP684FGrigliaDettDefinizioneFondiAreaPiedeRG: TmeIWRegion;
    lblCodFondo: TmeIWLabel;
    edtCodFondo: TmeIWEdit;
    lblDecorrenza: TmeIWLabel;
    edtDecorrenza: TmeIWEdit;
    lblDescFondo: TmeIWLabel;
    lblCodVoceGen: TmeIWLabel;
    edtCodVoceGen: TmeIWEdit;
    lblDescVoceGen: TmeIWLabel;
    lblCodVoceDet: TmeIWLabel;
    edtCodVoceDet: TmeIWEdit;
    lblDescVoceDet: TmeIWLabel;
    TemplateAreaPiedeRG: TIWTemplateProcessorHTML;
    lblTipoAccorpamento: TmeIWLabel;
    chkDipendente: TmeIWCheckBox;
    chkMese: TmeIWCheckBox;
    chkVoce: TmeIWCheckBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure chkMeseClick(Sender: TObject);
    procedure chkDipendenteClick(Sender: TObject);
    procedure chkVoceClick(Sender: TObject);
  private
    procedure AbilitazioniComponenti;
  public
    P684GrigliaDettMW: TP684FDefinizioneFondiMW;
    procedure selP690AAfterOpen;
    constructor Create(AOwner: TComponent;
                       const PAddToHistory: Boolean;
                       P684GrigliaDettMW:TP684FDefinizioneFondiMW);
  end;

implementation

uses WP684UGrigliaDettDefinizioneFondiDM, WP684UGrigliaDettDefinizioneFondiBrowseFM;

{$R *.dfm}

constructor TWP684FGrigliaDettDefinizioneFondi.Create(AOwner: TComponent;
                                                      const PAddToHistory: Boolean;
                                                      P684GrigliaDettMW:TP684FDefinizioneFondiMW);
begin
  Self.P684GrigliaDettMW:=P684GrigliaDettMW;
  inherited Create(AOwner,PAddToHistory);
end;

procedure TWP684FGrigliaDettDefinizioneFondi.IWAppFormCreate(Sender: TObject);
begin
  P684GrigliaDettMW.evtselP690AAfterOpen:=selP690AAfterOpen;
  actCopiaSu.Visible:=False;
  actNuovo.Visible:=False;
  inherited;
  WR100LinkWC700:=False;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWP684FGrigliaDettDefinizioneFondiDM.Create(Self);

  WBrowseFM:=TWP684FGrigliaDettDefinizioneFondiBrowseFM.Create(Self);
  CreaTabDefault;

  AbilitazioniComponenti;

  with P684GrigliaDettMW do
  begin
    edtCodFondo.Text:=FondoElabGrigliaDett;
    edtDecorrenza.Text:=DateToStr(DataElabGrigliaDett);
    edtCodVoceGen.Text:=CodGenElabGrigliaDett;
    edtCodVoceDet.Text:=CodDetElabGrigliaDett;
    lblCodVoceGen.Visible:=Trim(CodGenElabGrigliaDett) <> '';
    edtCodVoceGen.Visible:=lblCodVoceGen.Visible;
    lblCodVoceDet.Visible:=Trim(CodDetElabGrigliaDett) <> '';
    edtCodVoceDet.Visible:=lblCodVoceDet.Visible;
    lblDescFondo.Caption:=VarToStr(selP684.Lookup('DECORRENZA_DA;COD_FONDO',
                               VarArrayOf([DataElabGrigliaDett,FondoElabGrigliaDett]),'DESCRIZIONE'));
    if Trim(CodGenElabGrigliaDett) <> '' then
      lblDescVoceGen.Caption:=VarToStr(selP686D.Lookup('DECORRENZA_DA;COD_FONDO;CLASS_VOCE;COD_VOCE_GEN',
                                   VarArrayOf([DataElabGrigliaDett,FondoElabGrigliaDett,'D',CodGenElabGrigliaDett]),'DESCRIZIONE'))
    else
      lblDescVoceGen.Caption:='';
    if Trim(CodDetElabGrigliaDett) <> '' then
      lblDescVoceDet.Caption:=VarToStr(selP688D.Lookup('DECORRENZA_DA;COD_FONDO;COD_VOCE_GEN;COD_VOCE_DET',
                                   VarArrayOf([DataElabGrigliaDett,FondoElabGrigliaDett,CodGenElabGrigliaDett,CodDetElabGrigliaDett]),'DESCRIZIONE'))
    else
      lblDescVoceDet.Caption:='';
  end;
end;

procedure TWP684FGrigliaDettDefinizioneFondi.chkDipendenteClick(Sender: TObject);
begin
  inherited;
  if (not chkMese.Checked) and (not chkVoce.Checked) and (not chkDipendente.Checked) then
  begin
    chkDipendente.Checked:=True;
    raise Exception.Create(A000MSG_P684_ERR_TIPO_ACCORPAMENTO);
  end;
  AbilitazioniComponenti;
end;

procedure TWP684FGrigliaDettDefinizioneFondi.chkMeseClick(Sender: TObject);
begin
  inherited;
  if (not chkMese.Checked) and (not chkVoce.Checked) and (not chkDipendente.Checked) then
  begin
    chkMese.Checked:=True;
    raise Exception.Create(A000MSG_P684_ERR_TIPO_ACCORPAMENTO);
  end;
  AbilitazioniComponenti;
end;

procedure TWP684FGrigliaDettDefinizioneFondi.chkVoceClick(Sender: TObject);
begin
  inherited;
  if (not chkMese.Checked) and (not chkVoce.Checked) and (not chkDipendente.Checked) then
  begin
    chkVoce.Checked:=True;
    raise Exception.Create(A000MSG_P684_ERR_TIPO_ACCORPAMENTO);
  end;
  AbilitazioniComponenti;
end;

procedure TWP684FGrigliaDettDefinizioneFondi.AbilitazioniComponenti;
var AbilitaModifiche:Boolean;
begin
  AbilitaModifiche:=chkMese.Checked and chkVoce.Checked and chkDipendente.Checked;
  with (WR302DM as TWP684FGrigliaDettDefinizioneFondiDM) do
  begin
    P684GrigliaDettMW.LeggoSelP690;
    if AbilitaModifiche then
      dsrTabella.DataSet:=selTabella
    else
    begin
      P684GrigliaDettMW.LeggoSelP690A(chkDipendente.Checked,chkMese.Checked,chkVoce.Checked);
      dsrTabella.DataSet:=P684GrigliaDettMW.selP690A;
    end;
  end;
  with (WBrowseFM as TWP684FGrigliaDettDefinizioneFondiBrowseFM) do
  begin
    grdTabella.medpCancellaRigaWR102;
    if AbilitaModifiche then
      grdtabella.medpAttivaGrid((WR302DM as TWP684FGrigliaDettDefinizioneFondiDM).selTabella,False,False)
    else
      grdtabella.medpAttivaGrid(P684GrigliaDettMW.selP690A,False,False);
    PreparaComponenti(AbilitaModifiche);
    grdTabella.medpCaricaCDS;
  end;

  if (Trim(P684GrigliaDettMW.CodGenElabGrigliaDett) = '') or (P684GrigliaDettMW.selP690.Eof) or (not AbilitaModifiche) then
  begin
    actModifica.Enabled:=False;
    actElimina.Enabled:=False;
  end;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWP684FGrigliaDettDefinizioneFondi.selP690AAfterOpen;
begin
  with P684GrigliaDettMW do
  begin
    if chkDipendente.Checked then
    begin
      selP690A.FieldByName('MATRICOLA').DisplayLabel:='Matricola';
      selP690A.FieldByName('MATRICOLA').Index:=0;
      selP690A.FieldByName('COGNOME').DisplayLabel:='Cognome';
      selP690A.FieldByName('NOME').DisplayLabel:='Nome';
      selP690A.FieldByName('COD_POSIZIONE_ECONOMICA').DisplayLabel:='Posiz. economica';
    end;
    if chkMese.Checked then
    begin
      selP690A.FieldByName('DATA_RETRIBUZIONE').DisplayLabel:='Mese retribuzione';
      selP690A.FieldByName('DATA_RETRIBUZIONE').Alignment:=taCenter;
      TDateTimeField(selP690A.FieldByName('DATA_RETRIBUZIONE')).DisplayFormat:='mm/yyyy';
    end;
    if chkVoce.Checked then
    begin
      selP690A.FieldByName('COD_CONTRATTO').DisplayLabel:='Contratto voci';
      selP690A.FieldByName('COD_VOCE').DisplayLabel:='Codice voce';
      selP690A.FieldByName('Descrizione').DisplayLabel:='Descrizione';
    end;
    selP690A.FieldByName('Importo').DisplayLabel:='Importo';
    TFloatField(selP690A.FieldByName('IMPORTO')).DisplayFormat:='###,###,###,##0.00';
  end;
end;

end.
