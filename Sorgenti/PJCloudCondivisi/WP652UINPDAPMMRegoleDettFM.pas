unit WP652UINPDAPMMRegoleDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, A000UCostanti,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  meIWLabel, IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWCompListbox,
  meIWDBLookupComboBox, WP652UINPDAPMMRegoleDM, IWCompButton, meIWButton,
  WC013UCheckListFM, meIWDBLabel, medpIWMultiColumnComboBox, IWCompCheckbox,
  meIWDBCheckBox,DB, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, Vcl.Menus,
  IWCompMemo, meIWDBMemo, meIWImageFile, medpIWImageButton, medpIWMessageDlg,
  A000UInterfaccia, A000UMessaggi, WR100UBase;

type
  TWP652FINPDAPMMRegoleDettFM = class(TWR205FDettTabellaFM)
    InpdapRGTemplate: TIWTemplateProcessorHTML;
    FluperRGTemplate: TIWTemplateProcessorHTML;
    WP652FluperRG: TmeIWRegion;
    WP652InpdapRG: TmeIWRegion;
    lblParteFluper: TmeIWLabel;
    dedtParteFluper: TmeIWDBEdit;
    lblNumeroFluper: TmeIWLabel;
    dedtNumeroFluper: TmeIWDBEdit;
    lblDescrizioneFluper: TmeIWLabel;
    dedtDescrizioneFluper: TmeIWDBEdit;
    dcmbNomeDatoFluper: TmeIWDBLookupComboBox;
    lblNomeDatoFluper: TmeIWLabel;
    lblCausaliFluper: TmeIWLabel;
    dedtCausaliFluper: TmeIWDBEdit;
    btnCausaliFluper: TmeIWButton;
    lblNumeroTredicesimaFluper: TmeIWLabel;
    lblNumeroTredPrecFluper: TmeIWLabel;
    cmbNumeroTredicesimaFluper: TMedpIWMultiColumnComboBox;
    dlblDescNumeroTredicesimaFluper: TmeIWDBLabel;
    cmbNumeroTredprecFluper: TMedpIWMultiColumnComboBox;
    dlblDescNumeroTredPrecFluper: TmeIWDBLabel;
    lblNumeroArretratiACFluper: TmeIWLabel;
    lblNumeroArretratiAPFluper: TmeIWLabel;
    cmbNumeroArretratiACFluper: TMedpIWMultiColumnComboBox;
    dlblDescNumeroArretratiACFluper: TmeIWDBLabel;
    cmbNumeroArretratiAPFluper: TMedpIWMultiColumnComboBox;
    dlblDescNumeroArretratiAPFluper: TmeIWDBLabel;
    lblTipoRecordFluper: TmeIWLabel;
    dedtTipoRecordFluper: TmeIWDBEdit;
    lblSezioneFileFluper: TmeIWLabel;
    dedtSezioneFileFluper: TmeIWDBEdit;
    lblEsportazioneFileFluper: TmeIWLabel;
    dedtNumeroFileFluper: TmeIWDBEdit;
    lblNumeroFileFluper: TmeIWLabel;
    dedtFormatoFileFluper: TmeIWDBEdit;
    lblFormatoFileFluper: TmeIWLabel;
    dEdtLunghezzaFluper: TmeIWDBEdit;
    lblLunghezzaFluper: TmeIWLabel;
    dchkNumericoFluper: TmeIWDBCheckBox;
    cmbCodArrotondamentoFluper: TMedpIWMultiColumnComboBox;
    lblCodArrotondamentoFluper: TmeIWLabel;
    dedtFormatoFluper: TmeIWDBEdit;
    lblFormatoFluper: TmeIWLabel;
    dchkRegolaModificabileFluper: TmeIWDBCheckBox;
    drgpTipoDatoFLUPER: TmeIWDBRadioGroup;
    lblTipoDatoFluper: TmeIWLabel;
    dmemCommento: TmeIWDBMemo;
    MainMenu1: TMainMenu;
    lblCommento: TmeIWLabel;
    dmemRegolaCalcoloManuale: TmeIWDBMemo;
    lblRegolaCalcoloManuale: TmeIWLabel;
    btnRipristinaAutomaticaFLUPER: TmedpIWImageButton;
    btnFiltroVociFLUPER: TmedpIWImageButton;
    btnRipristinaAutomatica: TmedpIWImageButton;
    btnFiltroVoci: TmedpIWImageButton;
    lblParteCUD: TmeIWLabel;
    dedtParteCUD: TmeIWDBEdit;
    lblNumeroCUD: TmeIWLabel;
    dedtNumeroCUD: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblEsportazioneFile: TmeIWLabel;
    lblTipoRecord: TmeIWLabel;
    dedtTipoRecord: TmeIWDBEdit;
    lblSezioneFile: TmeIWLabel;
    dedtSezioneFile: TmeIWDBEdit;
    lblNumeroFile: TmeIWLabel;
    dedtNumeroFile: TmeIWDBEdit;
    lblFormatoFile: TmeIWLabel;
    dedtFormatoFile: TmeIWDBEdit;
    dchkFormatoAnnoMese: TmeIWDBCheckBox;
    dchkNumerico: TmeIWDBCheckBox;
    lblCodArrotondamento: TmeIWLabel;
    cmbCodArrotondamento: TMedpIWMultiColumnComboBox;
    lblFormato: TmeIWLabel;
    dedtFormato: TmeIWDBEdit;
    dchkOmettiVuoto: TmeIWDBCheckBox;
    dchkRegolaModificabile: TmeIWDBCheckBox;
    lblIdCausaleF24: TmeIWLabel;
    dedtIdCausaleF24: TmeIWDBEdit;
    drgpTipoDato: TmeIWDBRadioGroup;
    lblTipoDato: TmeIWLabel;
    dmemRegolaCalcoloEccezioni: TmeIWDBMemo;
    lblRegolaCalcoloEccezioni: TmeIWLabel;
    btnRelazioniTabelle: TmedpIWImageButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnCausaliFluperClick(Sender: TObject);
    procedure cmbNumeroTredicesimaFluperAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbNumeroTredprecFluperAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbNumeroArretratiACFluperAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbNumeroArretratiAPFluperAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure btnRipristinaAutomaticaFLUPERClick(Sender: TObject);
    procedure dmemRegolaCalcoloManualeAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure btnFiltroVociFLUPERClick(Sender: TObject);
    procedure btnRelazioniTabelleClick(Sender: TObject);
  private
    procedure CausaliFluperResult(Sender: TObject; Result: Boolean);
    procedure ResultRipristino(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure AbilitaFiltro;
    procedure FiltroVociResult(Sender: TObject; Result: Boolean);
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation
uses
  WP652UINPDAPMMRegole;

{$R *.dfm}

procedure TWP652FINPDAPMMRegoleDettFM.IWFrameRegionCreate(Sender: TObject);
var
  NomeFlusso: String;
begin
  inherited;
  NomeFlusso:=(Self.Owner as TWP652FINPDAPMMRegole).NomeFlusso;
  if NomeFlusso = FLUSSO_INPDAP then
  begin
    WP652InpdapRG.Visible:=True;
    WP652FluperRG.Visible:=False;
  end
  else if NomeFlusso = FLUSSO_FLUPER then
  begin
    WP652InpdapRG.Visible:=False;
    WP652FluperRG.Visible:=True;
  end
  else if NomeFlusso = FLUSSO_CREDITI then
  begin
    WP652InpdapRG.Visible:=False;
    WP652FluperRG.Visible:=True;
  end;
  dcmbNomeDatoFluper.ListSource:=(WR302DM as TWP652FINPDAPMMRegoleDM).P652FINPDAPMMRegoleMW.dsrV430;
end;

procedure TWP652FINPDAPMMRegoleDettFM.btnCausaliFluperClick(Sender: TObject);
var
  WC013: TWC013FCheckListFM;
  ElencoValoriChecklist: TElencoValoriChecklist;
  LstSel,LstDesc,LstCod: TStringList;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  LstSel:=TStringList.Create;
  LstDesc:=TStringList.Create;
  LstCod:=TStringList.Create;
  try
    lstDesc.add('*** Presenza');
    lstCod.add('');
    ElencoValoriChecklist:=(WR302DM as TWP652FINPDAPMMRegoleDM).P652FINPDAPMMRegoleMW.getListPresenze;
    lstDesc.addStrings(ElencoValoriChecklist.lstDescrizione);
    lstCod.addStrings(ElencoValoriChecklist.lstCodice);
    FreeAndNil(ElencoValoriChecklist);
    lstDesc.add('*** Assenza');
    lstCod.add('');
    ElencoValoriChecklist:=(WR302DM as TWP652FINPDAPMMRegoleDM).P652FINPDAPMMRegoleMW.getListAssenze;
    lstDesc.addStrings(ElencoValoriChecklist.lstDescrizione);
    lstCod.addStrings(ElencoValoriChecklist.lstCodice);
    FreeAndNil(ElencoValoriChecklist);

    LstSel.CommaText:=WR302DM.selTabella.FieldByName('CODICI_CAUSALI').AsString;
    WC013.CaricaLista(lstDesc, lstCod);

    WC013.ImpostaValoriSelezionati(LstSel);
    WC013.ResultEvent:=CausaliFluperResult;
    WC013.Visualizza(0,0,'<WC013> Causali');
  finally
    if ElencoValoriChecklist <> nil then
      FreeAndNil(ElencoValoriChecklist);
    FreeAndNil(LstSel);
    FreeAndNil(LstDesc);
    FreeAndNil(LstCod);
  end;
end;

procedure TWP652FINPDAPMMRegoleDettFM.btnFiltroVociFLUPERClick(Sender: TObject);
var
  lstVoci: TStringList;
  sEsisteContratto, S: String;
  lenCodice: Integer;
  lstCodici: TStringList;
  WC013: TWC013FCheckListFM;
  lstVociSelezionate: TStringList;
begin
  try
    lstVoci:=TStringList.Create;
    sEsisteContratto:=(WR302DM AS TWP652FINPDAPMMRegoleDM).P652FINPDAPMMRegoleMW.FiltroVoci(0, lstVoci);
    if lstVoci.count = 0 then
      Exit;

    if sEsisteContratto = 'XX' then
      lenCodice:=17
    else
      lenCodice:=11;
    lstCodici:=TStringList.Create;
    for S in lstVoci do
      lstCodici.Add(Trim(Copy(S,1,lenCodice)));

    WC013:=TWC013FCheckListFM.Create(Self.Owner);
    WC013.CaricaLista(lstVoci, lstCodici);
    FreeAndNil(lstCodici);

    lstVociSelezionate:=TStringList.Create;
    lstVociSelezionate.StrictDelimiter:=True;
    lstVociSelezionate.CommaText:=(WR302DM AS TWP652FINPDAPMMRegoleDM).P652FINPDAPMMRegoleMW.VociSelezionate;
    WC013.ImpostaValoriSelezionati(lstVociSelezionate);
    FreeAndNil(lstVociSelezionate);

    WC013.ResultEvent:=FiltroVociResult;
    WC013.Visualizza(0,0,'<WC013> Filtro voci');
  finally
    if lstVoci <> nil then
      FreeAndNil(lstVoci);

    if lstVociSelezionate <> nil then
      FreeAndNil(lstVociSelezionate);
  end;
end;

procedure TWP652FINPDAPMMRegoleDettFM.FiltroVociResult(Sender: TObject; Result: Boolean);
var lst: TStringList;
begin
  if Result then
  begin
    lst:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      (WR302DM AS TWP652FINPDAPMMRegoleDM).P652FINPDAPMMRegoleMW.ImpostaVociFiltro(lst);
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TWP652FINPDAPMMRegoleDettFM.btnRelazioniTabelleClick(Sender: TObject);
begin
  inherited;
  with WR302DM do
  begin
    if (selTabella.FieldByName('NUMERO').AsString = '008') or (selTabella.FieldByName('NUMERO').AsString = '009') or (selTabella.FieldByName('NUMERO').AsString = '092') then
      (Self.Owner as TWR100FBase).AccediForm(299,'TIPOFLUSSO=FL' + ParamDelimiter + 'FLUSSO=FLUPER_STR')
    else if (selTabella.FieldByName('NUMERO').AsString = '010') or (selTabella.FieldByName('NUMERO').AsString = '011') or (selTabella.FieldByName('NUMERO').AsString = '012') or (selTabella.FieldByName('NUMERO').AsString = '013') then
      (Self.Owner as TWR100FBase).AccediForm(299,'TIPOFLUSSO=FL' + ParamDelimiter + 'FLUSSO=FLUPER_DIP')
    else
      (Self.Owner as TWR100FBase).AccediForm(299,'TIPOFLUSSO=FL' + ParamDelimiter + 'FLUSSO=FLUPER_UO');
  end;
end;

procedure TWP652FINPDAPMMRegoleDettFM.btnRipristinaAutomaticaFLUPERClick(
  Sender: TObject);
begin
  inherited;
  MsgBox.WebMessageDlg(A000MSG_P652_DLG_RIPRISTINO_REGOLA,mtConfirmation,[mbYes,mbNo],ResultRipristino,'');
end;

procedure TWP652FINPDAPMMRegoleDettFM.ResultRipristino(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    If WR302DM.selTabella.FieldByName('REGOLA_CALCOLO_AUTOMATICA').AsString = '' then
      MsgBox.WebMessageDlg(A000MSG_P652_MSG_NO_REGOLA,mtInformation,[mbYes,mbNo],nil,'')
    else
      WR302DM.selTabella.FieldByName('REGOLA_CALCOLO_MANUALE').AsString:=WR302DM.selTabella.FieldByName('REGOLA_CALCOLO_AUTOMATICA').AsString;
  end;
end;

procedure TWP652FINPDAPMMRegoleDettFM.CaricaMultiColumnCombobox;
var
  sTmp: String;
begin
  inherited;
  cmbNumeroTredicesimaFluper.Items.Clear;
  cmbNumeroTredprecFluper.items.Clear;
  with (WR302DM as TWP652FINPDAPMMRegoleDM).P652FINPDAPMMRegoleMW do
  begin
    P660B.First;
    while not P660B.Eof do
    begin
      sTmp:=Format('%s;%s',[P660B.FieldByName('NUMERO').AsString,P660B.FieldByName('DESCRIZIONE').AsString]);
      cmbNumeroTredicesimaFluper.AddRow(sTmp);
      cmbNumeroTredprecFluper.AddRow(sTmp);
      cmbNumeroArretratiACFluper.AddRow(sTmp);
      cmbNumeroArretratiAPFluper.AddRow(sTmp);
      P660B.Next;
    end;
  end;
end;

procedure TWP652FINPDAPMMRegoleDettFM.CausaliFluperResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      WR302DM.selTabella.FieldByName('CODICI_CAUSALI').AsString:=lstTmp.CommaText;
    finally
      FreeAndNil(lstTmp);
    end;
  end;
end;

procedure TWP652FINPDAPMMRegoleDettFM.cmbNumeroArretratiACFluperAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  //Aggiorno campo db in modo che si aggiornino campi lookup
  WR302DM.selTabella.FieldByName('FL_NUMERO_ARRCORR').AsString:=cmbNumeroArretratiACFluper.Text;
end;

procedure TWP652FINPDAPMMRegoleDettFM.cmbNumeroArretratiAPFluperAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  //Aggiorno campo db in modo che si aggiornino campi lookup
  WR302DM.selTabella.FieldByName('FL_NUMERO_ARRPREC').AsString:=cmbNumeroArretratiAPFluper.Text;
end;

procedure TWP652FINPDAPMMRegoleDettFM.cmbNumeroTredicesimaFluperAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  //Aggiorno campo db in modo che si aggiornino campi lookup
  WR302DM.selTabella.FieldByName('FL_NUMERO_TREDICESIMA').AsString:=cmbNumeroTredicesimaFluper.Text;
end;

procedure TWP652FINPDAPMMRegoleDettFM.cmbNumeroTredprecFluperAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  //Aggiorno campo db in modo che si aggiornino campi lookup
  WR302DM.selTabella.FieldByName('FL_NUMERO_TREDPREC').AsString:=cmbNumeroTredprecFluper.Text;
end;

procedure TWP652FINPDAPMMRegoleDettFM.DataSet2Componenti;
begin
  with WR302DM do
  begin
    if (Self.Owner as TWP652FINPDAPMMRegole).NomeFlusso <> FLUSSO_INPDAP then
    begin
      cmbNumeroTredicesimaFluper.Text:=selTabella.FieldByName('FL_NUMERO_TREDICESIMA').AsString;
      cmbNumeroTredprecFluper.Text:=selTabella.FieldByName('FL_NUMERO_TREDPREC').AsString;
      cmbNumeroArretratiACFluper.Text:=selTabella.FieldByName('FL_NUMERO_ARRCORR').AsString;
      cmbNumeroArretratiAPFluper.Text:=selTabella.FieldByName('FL_NUMERO_ARRPREC').AsString;
    end;

    cmbCodArrotondamentoFluper.Text:=selTabella.FieldByName('COD_ARROTONDAMENTO').AsString;
    cmbCodArrotondamento.Text:=selTabella.FieldByName('COD_ARROTONDAMENTO').AsString;
  end;
  btnRelazioniTabelle.Enabled:=(WR302DM as TWP652FINPDAPMMRegoleDM).P652FINPDAPMMRegoleMW.CanRelazioniTabelle;
end;

procedure TWP652FINPDAPMMRegoleDettFM.dmemRegolaCalcoloManualeAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaFiltro;
end;

procedure TWP652FINPDAPMMRegoleDettFM.Componenti2DataSet;
begin
  inherited;
  with WR302DM do
  begin
    if (Self.Owner as TWP652FINPDAPMMRegole).NomeFlusso <> FLUSSO_INPDAP then
    begin
      selTabella.FieldByName('FL_NUMERO_TREDICESIMA').AsString:=cmbNumeroTredicesimaFluper.Text;
      selTabella.FieldByName('FL_NUMERO_TREDPREC').AsString:=cmbNumeroTredprecFluper.Text;
      selTabella.FieldByName('FL_NUMERO_ARRCORR').AsString:=cmbNumeroArretratiACFluper.Text;
      selTabella.FieldByName('FL_NUMERO_ARRPREC').AsString:=cmbNumeroArretratiAPFluper.Text;
    end;
  end;
end;

procedure TWP652FINPDAPMMRegoleDettFM.AbilitaFiltro;
begin
  with (WR302DM as TWP652FINPDAPMMRegoleDM).P652FINPDAPMMRegoleMW do
  begin
    btnRipristinaAutomatica.Enabled:= CanRipristinaAutomatica;
    btnRipristinaAutomaticaFLUPER.Enabled:=btnRipristinaAutomatica.Enabled;

    btnFiltroVoci.Enabled:=CanFiltroVoci;
    btnFiltroVociFLUPER.Enabled:=btnFiltroVoci.Enabled;
  end;
end;

procedure TWP652FINPDAPMMRegoleDettFM.AbilitaComponenti;
var
  bEdit: Boolean;
begin
  inherited;
  bEdit:=WR302DM.selTabella.State in [dsEdit, dsInsert];

  if bEdit then
  begin
    //Campi non editabili
    dedtParteFluper.Enabled:=False;
    dedtNumeroFluper.Enabled:=False;
    dedtDescrizioneFluper.Enabled:=False;
    dedtTipoRecordFluper.Enabled:=False;
    dedtSezioneFileFluper.Enabled:=False;
    dedtNumeroFileFluper.Enabled:=False;
    dedtFormatoFileFluper.Enabled:=False;
    dEdtLunghezzaFluper.Enabled:=False;
    dchkNumericoFluper.Enabled:=False;
    dchkRegolaModificabileFluper.Enabled:=False;
    dedtFormatoFluper.Enabled:=False;
    cmbCodArrotondamentoFluper.Enabled:=False;
    drgpTipoDatoFLUPER.Enabled:=False;

    dedtParteCUD.Enabled:=False;
    dedtNumeroCUD.Enabled:=False;
    dedtDescrizione.Enabled:=False;
    dedtTipoRecord.Enabled:=False;
    dedtSezioneFile.Enabled:=False;
    dedtNumeroFile.Enabled:=False;
    dedtFormatoFile.Enabled:=False;
    dchkFormatoAnnoMese.Enabled:=False;
    dchkNumerico.Enabled:=False;
    dchkOmettiVuoto.Enabled:=False;
    dedtFormato.Enabled:=False;
    cmbCodArrotondamento.Enabled:=False;
    dedtIdCausaleF24.Enabled:=False;
    drgpTipoDato.Enabled:=False;
    dmemRegolaCalcoloEccezioni.Enabled:=False;

    //Modificabile solo tramite elenco WC013
    BtnCausaliFLUPER.Enabled:=not ((WR302DM.selTabella.FieldByName('NOME_FLUSSO').AsString = 'FLUPER') and (WR302DM.selTabella.FieldByName('PARTE').AsString = 'A') and (WR302DM.selTabella.FieldByName('NUMERO').AsString = '005'));
    dEdtCausaliFLUPER.ReadOnly:=not ((WR302DM.selTabella.FieldByName('NOME_FLUSSO').AsString = 'FLUPER') and (WR302DM.selTabella.FieldByName('PARTE').AsString = 'A') and (WR302DM.selTabella.FieldByName('NUMERO').AsString = '005'));
    AbilitaFiltro;
  end;
end;

end.
