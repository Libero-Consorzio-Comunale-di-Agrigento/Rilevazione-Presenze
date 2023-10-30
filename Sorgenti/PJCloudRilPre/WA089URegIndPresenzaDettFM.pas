unit WA089URegIndPresenzaDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent, Db,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBComboBox,
  C180FunzioniGenerali, meIWEdit, IWCompCheckbox, meIWDBCheckBox, meIWLabel,
  IWCompButton, meIWButton, meIWCheckBox, StrUtils, Math, IWAppForm, WC013UCheckListFM,
  IWDBGrids, medpIWDBGrid, C190FunzioniGeneraliWeb,
  IWCompGrids, IWCompExtCtrls, IWCompJQueryWidget, meIWImageFile,
  IWCompRectangle, IWHTMLControls, meIWLink, medpIWMultiColumnComboBox;

type
  TWA089FRegIndPresenzaDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    dedtDescrizione: TmeIWDBEdit;
    lblPriorita: TmeIWLabel;
    dedtPriorita: TmeIWDBEdit;
    lblIncompatibile: TmeIWLabel;
    dedtIncompatibile: TmeIWDBEdit;
    btnIncompatibile: TmeIWButton;
    lblTipoMaturazione: TmeIWLabel;
    lblImporto: TmeIWLabel;
    dedtImporto: TmeIWDBEdit;
    lblVocePaghe: TmeIWLabel;
    dedtVocePaghe: TmeIWDBEdit;
    lblAssenzeCheMaturano: TmeIWLabel;
    dedtAssenzeCheMaturano: TmeIWDBEdit;
    btnAssenzeCheMaturano: TmeIWButton;
    lblAssenzeEscluse: TmeIWLabel;
    dedtAssenzeEscluse: TmeIWDBEdit;
    lblDescCausaleRiepilogo: TmeIWLabel;
    drgpPeriodoEquilibrioTurni: TmeIWDBRadioGroup;
    lblPeriodoEquilibrioTurni: TmeIWLabel;
    lblCoeffIndennita: TmeIWLabel;
    dedtCoeffIndennita: TmeIWDBEdit;
    lblCoeffRiposiComp: TmeIWLabel;
    dedtCoeffRiposiComp: TmeIWDBEdit;
    lblPercCoeffRiposiComp: TmeIWLabel;
    lblNumMaxTurniPrestati: TmeIWLabel;
    dedtNumMaxTurniPrestati: TmeIWDBEdit;
    dchkIndennitaSupplementare: TmeIWDBCheckBox;
    lblTurno: TmeIWLabel;
    lblTipo: TmeIWLabel;
    dcmbTipo: TmeIWDBComboBox;
    lblNumMax: TmeIWLabel;
    dedtNumMax: TmeIWDBEdit;
    drgpGGRiferimento: TmeIWDBRadioGroup;
    lblGGRiferimento: TmeIWLabel;
    lblTurniMinimi: TmeIWLabel;
    dedtTurniMinimi: TmeIWDBEdit;
    lblTurniRichiesti: TmeIWLabel;
    chkPrimoTurno: TmeIWCheckBox;
    chkSecondoTurno: TmeIWCheckBox;
    chkTerzoTurno: TmeIWCheckBox;
    chkQuartoTurno: TmeIWCheckBox;
    dedtPrimoTurno: TmeIWDBEdit;
    lblPercPrimoTurno: TmeIWLabel;
    dedtSecondoTurno: TmeIWDBEdit;
    lblPercSecondoTurno: TmeIWLabel;
    dedtTerzoTurno: TmeIWDBEdit;
    lblPercTerzoTurno: TmeIWLabel;
    dedtQuartoTurno: TmeIWDBEdit;
    lblPercQuartoTurno: TmeIWLabel;
    chkTurniInMinoranza: TmeIWCheckBox;
    lblArrotondamento: TmeIWLabel;
    dcmbArrotondamento: TmeIWDBComboBox;
    lblIndennitaAlternativa: TmeIWLabel;
    btnAssenzeEscluse: TmeIWButton;
    dcmbTipoMaturazione: TmeIWDBComboBox;
    lblPrimoTurno: TmeIWLabel;
    lblSecondoTurno: TmeIWLabel;
    lblTerzoTurno: TmeIWLabel;
    lblQuartoTurno: TmeIWLabel;
    lnkCausaleRiepilogo: TmeIWLink;
    dchkesclfestivi: TmeIWDBCheckBox;
    lblMaturaSabato: TmeIWLabel;
    dCmbMaturaSabato: TmeIWDBComboBox;
    lblOffsetGGPrec: TmeIWLabel;
    lblOffSetMetaDebito: TmeIWLabel;
    dedtOffsetGGPrec: TmeIWDBEdit;
    dEdtOffSetMetaDebito: TmeIWDBEdit;
    lblMinTPrioritari: TmeIWLabel;
    lblMinTurniSec: TmeIWLabel;
    dEdtMinTPrioritari: TmeIWDBEdit;
    dEdtMinTurniSec: TmeIWDBEdit;
    dChkPianifNOOP: TmeIWDBCheckBox;
    lnkSoglieGiornaliere: TmeIWLink;
    lblDescRegIndennita: TmeIWLabel;
    cmbCausaleRiepilogo: TMedpIWMultiColumnComboBox;
    cmbIndennitaAlternativa: TMedpIWMultiColumnComboBox;
    dchkMaturazPropDebitoGG: TmeIWDBCheckBox;
    dchkMaturazPropIgnoraScostNeg: TmeIWDBCheckBox;
    dchkConguaglioTurni: TmeIWDBCheckBox;    // gc: 11/09/19
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dcmbTipoMaturazioneChange(Sender: TObject);
    procedure cmbCausaleRiepilogoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure btnIncompatibileClick(Sender: TObject);
    procedure btnAssenzeAbilitateClick(Sender: TObject);
    procedure btnAssenzeEscluseClick(Sender: TObject);
    procedure cmbIndennitaAlternativaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dchkConguaglioTurniAsyncChange(Sender: TObject; EventParams: TStringList);
    //procedure grdRegoleMaturazioneRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
    //procedure grdRegoleMaturazioneDataSet2Componenti(Row: Integer);
    //procedure grdRegoleMaturazioneComponenti2DataSet(Row: Integer);
  private
    WC013:TWC013FCheckListFM;
    btnSender: TObject;
    procedure Abilitadgpbnmesi_equiturni(Tipo : String);
  public
    procedure DataSet2Componenti; override;
    procedure AbilitaComponenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure ImpostaComponentiVisible(Tipo : String);
    //procedure VisualizzaGroupBox(Nome:String;Visualizza:Boolean);
    procedure ckIncompatibileResult(Sender: TObject; Result:Boolean);
    procedure ckAssenzeCheMaturanoResult(Sender: TObject; Result:Boolean);
    procedure ckAssenzeEscluseResult(Sender: TObject; Result:Boolean);
  end;

implementation

{$R *.dfm}

uses WA089URegIndPresenzaDM, WA089URegIndPresenza;


procedure TWA089FRegIndPresenzaDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  dcmbTipoMaturazione.Items.Values['Turni minimi']:='A';
  dcmbTipoMaturazione.Items.Values['Turni minimi in percentuale']:='P';
  dcmbTipoMaturazione.Items.Values['Turni minimi con ind.oraria']:='I';
  dcmbTipoMaturazione.Items.Values['Proporzione minima']:='B';
  dcmbTipoMaturazione.Items.Values['Assenze']:='C';
  dcmbTipoMaturazione.Items.Values['Ore causalizzate']:='G';
  dcmbTipoMaturazione.Items.Values['Proporzione fissa']:='D';
  dcmbTipoMaturazione.Items.Values['Turni per coeff. di calcolo']:='E';
  dcmbTipoMaturazione.Items.Values['Con domeniche del mese']:='F';
  dcmbTipoMaturazione.Items.Values['Unitaria mensile']:='V';
  dcmbTipoMaturazione.Items.Values['GG retribuiti mensili']:='H';
  dcmbTipoMaturazione.Items.Values['Nessun equilibrio']:='Z';

  dcmbArrotondamento.Items.Values['Nessuno']:='N';
  dcmbArrotondamento.Items.Values['Puro']:='P';
  dcmbArrotondamento.Items.Values['Difetto']:='D';
  dcmbArrotondamento.Items.Values['Eccesso']:='E';

  dcmbTipo.Items.Values['Primo turno']:='1';
  dcmbTipo.Items.Values['Secondo turno']:='2';
  dcmbTipo.Items.Values['Terzo turno']:='3';
  dcmbTipo.Items.Values['Quarto turno']:='4';
  dcmbTipo.Items.Values['Turno in minoranza']:='<';

  dcmbMaturaSabato.Items.Values['Si']:='S';
  dcmbMaturaSabato.Items.Values['No']:='N';
  dcmbMaturaSabato.Items.Values['Aggiungi fuori equilibrio']:='A';

 inherited;


  (*
  grdRegoleMaturazione.medpPaginazione:=False;
  grdRegoleMaturazione.medpAttivaGrid(TWA089FRegIndPresenzaDM(TWA089FRegIndPresenza(Self.Parent).WR302DM).selT171,False,False);

  grdRegoleMaturazione.medpPreparaComponenteGenerico('WR102',grdRegoleMaturazione.medpIndexColonna('GIORNI')+1,0,DBG_EDT,'10','','','','S');
  grdRegoleMaturazione.medpPreparaComponenteGenerico('WR102',grdRegoleMaturazione.medpIndexColonna('ESPRESSIONE')+1,0,DBG_EDT,'50','','','S','');
  *)

end;

procedure TWA089FRegIndPresenzaDettFM.ImpostaComponentiVisible(Tipo : String );
begin
  if Tipo = 'I' then
    lblAssenzeCheMaturano.Caption:='Assenze tollerate'
  else
    lblAssenzeCheMaturano.Caption:='Assenze che maturano';

  lblAssenzeEscluse.Visible:=(Tipo = 'C') or (Tipo = 'F') or (Tipo = 'G') or (Tipo = 'H') or (Tipo = 'I');
  dedtAssenzeEscluse.Visible:=lblAssenzeEscluse.Visible;
  btnAssenzeEscluse.Visible:=lblAssenzeEscluse.Visible;
  if Tipo = 'C' then
    lblAssenzeEscluse.Caption:='Assenze escluse'
  else if (Tipo = 'F') or (Tipo = 'H') then
    lblAssenzeEscluse.Caption:='Assenze che non abbattono'
  else if Tipo = 'G' then
    lblAssenzeEscluse.Caption:='Causali da considerare'
  else if Tipo = 'I' then
    lblAssenzeEscluse.Caption:='Assenze da conteggiare';

  lblCoeffIndennita.Visible:=(Tipo = 'E') or (Tipo = 'F');
  dedtCoeffIndennita.Visible:=(Tipo = 'E') or (Tipo = 'F');
  dedtCoeffRiposiComp.Visible:=(Tipo = 'E');
  lblCoeffRiposiComp.Visible:=(Tipo = 'E');
  lblPercCoeffRiposiComp.Visible:=(Tipo = 'E');
  lblNumMaxTurniPrestati.Visible:=(Tipo = 'E');
  dedtNumMaxTurniPrestati.Visible:=(Tipo = 'E');
  C190VisualizzaElemento(JQuery,'grpTurnoDaConsiderare',(Tipo = 'E'));

  lnkCausaleRiepilogo.Visible:=(Tipo = 'I');
  cmbCausaleRiepilogo.Visible:=(Tipo = 'I');
  lblDescCausaleRiepilogo.Visible:=(Tipo = 'I');

  //PRiferimento.Visible:=(Tipo = 'H');
  C190VisualizzaElemento(JQuery,'grpGGRiferimento',(Tipo = 'H'));
  //PTMinIndOra.Visible:=Tipo = 'I';
  C190VisualizzaElemento(JQuery,'grpTminIndOra',(Tipo = 'I'));

  //dgpbnmesi_equiturni.Visible:=((Tipo = 'A') or (Tipo = 'B') or (Tipo = 'P')) and (cmbIndennitaAlternativa.Text = '');
  //C190VisualizzaElemento(JQuery,'grpPeriodoTurni',((Tipo = 'A') or (Tipo = 'B') or (Tipo = 'P')) and (cmbIndennitaAlternativa.Text = ''));
  Abilitadgpbnmesi_equiturni(Tipo);
  dchkMaturazPropDebitoGG.Visible:=Tipo = 'Z';
  dchkMaturazPropIgnoraScostNeg.Visible:=Tipo = 'Z';  // gc: 11/09/19
  C190VisualizzaElemento(JQuery,'grpTurni',(Tipo= 'A') or (Tipo = 'B') or (Tipo = 'D') or (Tipo = 'P'));
  //GPTurni.Visible:=(Tipo= 'A') or (Tipo = 'B') or (Tipo = 'D') or (Tipo = 'P');

  if Tipo = 'A' then
    lblTurniMinimi.Caption:='Turni minimi'
  else if Tipo = 'B' then
    lblTurniMinimi.Caption:='Turni minimi(%)'
  else if Tipo = 'D' then
    lblTurniMinimi.Caption:='Proporzione'
  else if Tipo = 'V' then
    lblTurniMinimi.Caption:='Giorni minimi di presenza';

  lblTurniMinimi.Visible:=(Tipo = 'A') or (Tipo = 'B') or (Tipo = 'D') or (Tipo = 'V');
  dedtTurniMinimi.Visible:=(Tipo = 'A') or (Tipo = 'B') or (Tipo = 'D') or (Tipo = 'V');
  chkPrimoTurno.Visible:=(Tipo = 'A') or (Tipo = 'B') or (Tipo = 'D') or (Tipo = 'V');
  chkSecondoTurno.Visible:=(Tipo = 'A') or (Tipo = 'B') or (Tipo = 'D');
  chkTerzoTurno.Visible:=(Tipo = 'A') or (Tipo = 'B') or (Tipo = 'D');
  chkQuartoTurno.Visible:=(Tipo = 'A') or (Tipo = 'B') or (Tipo = 'D');
  lblPrimoTurno.Visible:=Tipo = 'P';
  lblSecondoTurno.Visible:=Tipo = 'P';
  lblTerzoTurno.Visible:=Tipo = 'P';
  lblQuartoTurno.Visible:=Tipo = 'P';
  chkTurniInMinoranza.Visible:=(Tipo = 'A') or (Tipo = 'B');
  lblPercPrimoTurno.Visible:=Tipo = 'P';
  lblPercSecondoTurno.Visible:=Tipo = 'P';
  lblPercTerzoTurno.Visible:=Tipo = 'P';
  lblPercQuartoTurno.Visible:=Tipo = 'P';
  dcmbArrotondamento.Visible:=(Tipo = 'P') or (Tipo = 'B');
  lblArrotondamento.Visible:=(Tipo = 'P') or (Tipo = 'B');

  lblIndennitaAlternativa.Visible:=(Tipo = 'A') or (Tipo = 'B') or (Tipo = 'C') or (Tipo = 'D') or (Tipo = 'P') or (Tipo = 'E');
  cmbIndennitaAlternativa.Visible:=(Tipo = 'A') or (Tipo = 'B') or (Tipo = 'C') or (Tipo = 'D') or (Tipo = 'P') or (Tipo = 'E');
  //Panel Regole di maturazione
  //grdRegoleMaturazione.Visible:=(Tipo = 'C');
  C190VisualizzaElemento(JQuery,'grpMaturazione',(Tipo = 'C'));

  AbilitaComponenti;
end;

procedure TWA089FRegIndPresenzaDettFM.DataSet2Componenti;
var
  Tipo:String;
begin
  with TWA089FRegIndPresenzaDM(WR302DM) do
  begin
    Tipo:=seltabella.FieldByName('TIPO').AsString;

    //ImpostaComponentiVisible(Tipo);

    chkTurniInMinoranza.Checked:=selTabella.FieldByName('TURNI').AsString = '<';
    chkPrimoTurno.Checked:=Pos('1',selTabella.FieldByName('TURNI').AsString) > 0;
    chkSecondoTurno.Checked:=Pos('2',selTabella.FieldByName('TURNI').AsString) > 0;
    chkTerzoTurno.Checked:=Pos('3',selTabella.FieldByName('TURNI').AsString) > 0;
    chkQuartoTurno.Checked:=Pos('4',selTabella.FieldByName('TURNI').AsString) > 0;

    cmbCausaleRiepilogo.ItemIndex:=-1;
    cmbCausaleRiepilogo.Text:=selTabella.FieldByName('CAUPRES_RIEPORE').AsString;
    lblDescCausaleRiepilogo.Caption:=VarToStr(selT275Escluse.LookUp('CODICE', selTabella.FieldByName('CAUPRES_RIEPORE').AsString, 'DESCRIZIONE'));

    cmbIndennitaAlternativa.ItemIndex:=-1;
    cmbIndennitaAlternativa.Text:=selTabella.FieldByName('CODICE2').AsString;
    lblDescRegIndennita.Caption:=VarToStr(selT275Escluse.LookUp('CODICE', selTabella.FieldByName('CODICE2').AsString, 'DESCRIZIONE'));

    ImpostaComponentiVisible(Tipo);
    //grdRegoleMaturazione.medpAttivaGrid(selT171,False,False);
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.Componenti2DataSet;
var
  S,Tipo:String;
begin
  with TWA089FRegIndPresenzaDM(WR302DM) do
  begin
    Tipo:=seltabella.FieldByName('TIPO').AsString;

    selTabella.FieldByName('CODICE2').AsString:=cmbIndennitaAlternativa.Text;

    if (Tipo <> 'E') then
    begin
      S:='';
      if chkTurniInMinoranza.Checked then
        S:='<'
      else
      begin
        if chkPrimoTurno.Checked then
          S:=S + '1';
        if chkSecondoTurno.Checked then
          S:=S + '2';
        if chkTerzoTurno.Checked then
          S:=S + '3';
        if chkQuartoTurno.Checked then
          S:=S + '4';
      end;
      selTabella.FieldByName('TURNI').AsString:=S;
    end;

    selTabella.FieldByName('CAUPRES_RIEPORE').AsString:=cmbCausaleRiepilogo.Text;
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.AbilitaComponenti;
var
  Tipo:String;
begin
  with TWA089FRegIndPresenzaDM(WR302DM) do
  begin
    if selTabella.State in [dsInsert,dsEdit] then
    begin
      Tipo:=seltabella.FieldByName('TIPO').AsString;

      lblAssenzeCheMaturano.Enabled:=(Tipo <> 'C') and (Tipo <> 'G') and (Tipo <> 'V') and (Tipo <> 'H');
      btnAssenzeCheMaturano.Enabled:=lblAssenzeCheMaturano.Enabled;

      if (Tipo = 'P') or (Tipo = 'F') then
      begin
        TWA089FRegIndPresenzaDM(WR302DM).selTabellaTURNO1.MaxValue:=100;
        TWA089FRegIndPresenzaDM(WR302DM).selTabellaTURNO2.MaxValue:=100;
        TWA089FRegIndPresenzaDM(WR302DM).selTabellaTURNO3.MaxValue:=100;
        TWA089FRegIndPresenzaDM(WR302DM).selTabellaTURNO4.MaxValue:=100;
      end
      else
      begin
        TWA089FRegIndPresenzaDM(WR302DM).selTabellaTURNO1.MaxValue:=30;
        TWA089FRegIndPresenzaDM(WR302DM).selTabellaTURNO2.MaxValue:=30;
        TWA089FRegIndPresenzaDM(WR302DM).selTabellaTURNO3.MaxValue:=30;
        TWA089FRegIndPresenzaDM(WR302DM).selTabellaTURNO4.MaxValue:=30;
      end;
    end;
    //grdRegoleMaturazione.medpAttivaGrid(selT171,selTabella.State in [dsEdit,dsInsert],selTabella.State in [dsEdit,dsInsert]);
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.Abilitadgpbnmesi_equiturni(Tipo : String);
var bVisibile: Boolean;
begin
  bVisibile:=(((Tipo = 'A') or (Tipo = 'B')) and (cmbIndennitaAlternativa.Text = '')) or (Tipo = 'P');
  C190VisualizzaElemento(JQuery,'grpPeriodoTurni',bVisibile);
  C190AbilitaComponente(drgpPeriodoEquilibrioTurni, bVisibile and ((TWA089FRegIndPresenzaDM(WR302DM).selTabella.FieldByName('CONGUAGLIO_EQUITURNI').AsString = 'S') or (cmbIndennitaAlternativa.Text = '')));
end;

procedure TWA089FRegIndPresenzaDettFM.btnAssenzeAbilitateClick(Sender: TObject);
var SF:String;
begin
  inherited;
  btnSender:=Sender;
  SF:=dedtAssenzeCheMaturano.Text;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    TWA089FRegIndPresenzaDM(WR302DM).Q265.Open;
    while not TWA089FRegIndPresenzaDM(WR302DM).Q265.Eof do
    begin
      ckList.Items.Add(Format('%-5s %s',[TWA089FRegIndPresenzaDM(WR302DM).Q265.FieldByName('CODICE').AsString,TWA089FRegIndPresenzaDM(WR302DM).Q265.FieldByName('DESCRIZIONE').AsString]));
      ckList.Values.Add(Trim(TWA089FRegIndPresenzaDM(WR302DM).Q265.FieldByName('CODICE').AsString));
      TWA089FRegIndPresenzaDM(WR302DM).Q265.Next;
    end;
    TWA089FRegIndPresenzaDM(WR302DM).Q265.Close;
    ResultEvent:=ckAssenzeCheMaturanoResult;
    C190PutCheckList(SF,30,ckList);
    WC013.Visualizza;
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.ckAssenzeCheMaturanoResult(Sender: TObject; Result:Boolean);
begin
  if Result then
  begin
    WR302DM.selTabella.FieldByName(dedtAssenzeCheMaturano.DataField).AsString:=StringReplace(StringReplace(C190GetCheckList(5,WC013.ckList),'*** A','',[]),'*** P','',[])
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.btnAssenzeEscluseClick(Sender: TObject);
procedure CaricaAssenze;
begin
  TWA089FRegIndPresenzaDM(WR302DM).Q265.Open;
    while not TWA089FRegIndPresenzaDM(WR302DM).Q265.Eof do
    begin
      WC013.ckList.Items.Add(Format('%-5s %s',[TWA089FRegIndPresenzaDM(WR302DM).Q265.FieldByName('CODICE').AsString,TWA089FRegIndPresenzaDM(WR302DM).Q265.FieldByName('DESCRIZIONE').AsString]));
      WC013.ckList.Values.Add(Trim(TWA089FRegIndPresenzaDM(WR302DM).Q265.FieldByName('CODICE').AsString));
      TWA089FRegIndPresenzaDM(WR302DM).Q265.Next;
    end;
    TWA089FRegIndPresenzaDM(WR302DM).Q265.Close;
end;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    if dcmbTipoMaturazione.Items.ValueFromIndex[dcmbTipoMaturazione.ItemIndex] = 'G' then
    begin
      WC013.ckList.Items.Add('*** Presenza');
      WC013.ckList.Values.Add('*** P');

      TWA089FRegIndPresenzaDM(WR302DM).selT275.Open;
      while not TWA089FRegIndPresenzaDM(WR302DM).selT275.Eof do
      begin
        ckList.Items.Add(Format('%-5s %s',[TWA089FRegIndPresenzaDM(WR302DM).selT275.FieldByName('CODICE').AsString,TWA089FRegIndPresenzaDM(WR302DM).selT275.FieldByName('DESCRIZIONE').AsString]));
        ckList.Values.Add(Trim(TWA089FRegIndPresenzaDM(WR302DM).selT275.FieldByName('CODICE').AsString));
        TWA089FRegIndPresenzaDM(WR302DM).selT275.Next;
      end;
      TWA089FRegIndPresenzaDM(WR302DM).selT275.Close;

      WC013.ckList.Items.Add('*** Assenza');
      WC013.ckList.Values.Add('*** A');

      CaricaAssenze;
    end
    else
      CaricaAssenze;

    ResultEvent:=ckAssenzeEscluseResult;
    C190PutCheckList(dedtAssenzeEscluse.Text,30,ckList);
    WC013.Visualizza;
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.ckAssenzeEscluseResult(Sender: TObject; Result:Boolean);
begin
  if Result then
  begin
    WR302DM.selTabella.FieldByName(dedtAssenzeEscluse.DataField).AsString:=StringReplace(StringReplace(C190GetCheckList(5,WC013.ckList),'*** A','',[]),'*** P','',[]);
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.btnIncompatibileClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    TWA089FRegIndPresenzaDM(WR302DM).selT162Incomp.Close;
    TWA089FRegIndPresenzaDM(WR302DM).selT162Incomp.SetVariable('CODICE',TWA089FRegIndPresenzaDM(WR302DM).selTabella.FieldByName('CODICE').AsString);
    TWA089FRegIndPresenzaDM(WR302DM).selT162Incomp.Open;
    while not TWA089FRegIndPresenzaDM(WR302DM).selT162Incomp.Eof do
    begin
      ckList.Items.Add(Format('%-5s %s',[TWA089FRegIndPresenzaDM(WR302DM).selT162Incomp.FieldByName('CODICE').AsString,TWA089FRegIndPresenzaDM(WR302DM).selT162Incomp.FieldByName('DESCRIZIONE').AsString]));
      ckList.Values.Add(Trim(TWA089FRegIndPresenzaDM(WR302DM).selT162Incomp.FieldByName('CODICE').AsString));
      TWA089FRegIndPresenzaDM(WR302DM).selT162Incomp.Next;
    end;
    ResultEvent:=ckIncompatibileResult;
    C190PutCheckList(dedtIncompatibile.Text,30,ckList);
    WC013.Visualizza;
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with TWA089FRegIndPresenzaDM(WR302DM).selT275Escluse do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbCausaleRiepilogo.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;

  with TWA089FRegIndPresenzaDM(WR302DM).Look162 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbIndennitaAlternativa.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.ckIncompatibileResult(Sender: TObject; Result:Boolean);
begin
  if Result then
  begin
    WR302DM.selTabella.FieldByName(dedtIncompatibile.DataField).AsString:=C190GetCheckList(5,WC013.ckList);
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.cmbCausaleRiepilogoAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with TWA089FRegIndPresenzaDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabellaCAUPRES_RIEPORE.AsString:=cmbCausaleRiepilogo.Text; //nel caso si lanci l'accedi
      lblDescCausaleRiepilogo.Caption:=cmbCausaleRiepilogo.Items[Index].RowData[1];
    end
    else
    begin
      selTabellaCAUPRES_RIEPORE.AsString:='';
      lblDescCausaleRiepilogo.Caption:='';
    end;
  end;
end;

procedure TWA089FRegIndPresenzaDettFM.cmbIndennitaAlternativaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;

  with TWA089FRegIndPresenzaDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      lblDescRegIndennita.Caption:=cmbIndennitaAlternativa.Items[Index].RowData[1];
    end
    else
    begin
      lblDescRegIndennita.Caption:='';
    end;
  end;

  Abilitadgpbnmesi_equiturni(dcmbTipoMaturazione.Items.ValueFromIndex[dcmbTipoMaturazione.ItemIndex]);
end;

procedure TWA089FRegIndPresenzaDettFM.dchkConguaglioTurniAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  Abilitadgpbnmesi_equiturni(dcmbTipoMaturazione.Items.ValueFromIndex[dcmbTipoMaturazione.ItemIndex]);
end;

procedure TWA089FRegIndPresenzaDettFM.dcmbTipoMaturazioneChange(
  Sender: TObject);
begin
  ImpostaComponentiVisible(dcmbTipoMaturazione.Items.ValueFromIndex[dcmbTipoMaturazione.ItemIndex]);
end;

(*
procedure TWA089FRegIndPresenzaDettFM.grdRegoleMaturazioneDataSet2Componenti(
  Row: Integer);
begin
  inherited;
  TmeIWEdit(grdRegoleMaturazione.medpCompCella(Row,grdRegoleMaturazione.medpIndexColonna('GIORNI'),0)).Text:=grdRegoleMaturazione.medpValoreColonna(Row, 'GIORNI');
  TmeIWEdit(grdRegoleMaturazione.medpCompCella(Row,grdRegoleMaturazione.medpIndexColonna('ESPRESSIONE'),0)).Text:=grdRegoleMaturazione.medpValoreColonna(Row, 'ESPRESSIONE');
end;
*)
(*
procedure TWA089FRegIndPresenzaDettFM.grdRegoleMaturazioneComponenti2DataSet(
  Row: Integer);
begin
  inherited;
  grdRegoleMaturazione.medpDataSet.FieldByName('GIORNI').AsString:=TmeIWEdit(grdRegoleMaturazione.medpCompCella(Row,grdRegoleMaturazione.medpIndexColonna('GIORNI'),0)).Text;
  grdRegoleMaturazione.medpDataSet.FieldByName('ESPRESSIONE').AsString:=TmeIWEdit(grdRegoleMaturazione.medpCompCella(Row,grdRegoleMaturazione.medpIndexColonna('ESPRESSIONE'),0)).Text;
end;
*)
(*
procedure TWA089FRegIndPresenzaDettFM.grdRegoleMaturazioneRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdRegoleMaturazione.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdRegoleMaturazione.medpCompGriglia) + 1) and (grdRegoleMaturazione.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRegoleMaturazione.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;
 *)
 (*
procedure TWA089FRegIndPresenzaDettFM.VisualizzaGroupBox(Nome:String;Visualizza:Boolean);
begin
  if Visualizza then
    JQuery.OnReady.Add('$(''#' + Nome + ''').show(); ')
  else
    JQuery.OnReady.Add('$(''#' + Nome + ''').hide(); ');
end;
*)
end.
