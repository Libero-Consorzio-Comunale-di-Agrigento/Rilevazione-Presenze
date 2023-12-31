unit P552URegoleContoAnnuale;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, ExtCtrls, DBCtrls, Mask, Spin, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, Oracle, OracleData, Grids, DBGrids, Buttons,
  C600USelAnagrafe, System.Actions, A000UMessaggi,P552URegoleContoAnnualeMW,
  System.ImageList;

type
  TP552FRegoleContoAnnuale = class(TR001FGestTab)
    PageControl1: TPageControl;
    tabGenerale: TTabSheet;
    tabRighe: TTabSheet;
    tabColonne: TTabSheet;
    pnlRicerca: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtAnno: TSpinEdit;
    cmbRicerca: TDBLookupComboBox;
    dgrdRighe: TDBGrid;
    dgrdColonne: TDBGrid;
    dTxtTabella: TDBText;
    PopupMenu1: TPopupMenu;
    Accedi1: TMenuItem;
    dmemRegolaManuale: TDBMemo;
    Panel2: TPanel;
    Label3: TLabel;
    dedtAnno: TDBEdit;
    Label5: TLabel;
    dedtCodTabella: TDBEdit;
    Label4: TLabel;
    dmemDescrizione: TDBMemo;
    drdgTipologia: TDBRadioGroup;
    lblDatoLibero: TLabel;
    dcmbDatoLibero: TDBLookupComboBox;
    Label7: TLabel;
    dmemFiltroDipendenti: TDBMemo;
    Label6: TLabel;
    dchkRegolaModif: TDBCheckBox;
    btnRipristina: TBitBtn;
    TabEsportazione: TTabSheet;
    dgrdEsportazione: TDBGrid;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    lblFunzioneOracle: TLabel;
    dmemFunzioneOracle: TDBMemo;
    tabScriptIniziale: TTabSheet;
    dmemScriptIniziale: TDBMemo;
    procedure dchkRegolaModifClick(Sender: TObject);
    procedure btnRipristinaClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure dcmbDatoLiberoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TRegisClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure TCercaClick(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure TPrimoClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure cmbRicercaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbRicercaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbRicercaCloseUp(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure drdgTipologiaClick(Sender: TObject);
    procedure edtAnnoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
  private
    { Private declarations }
    procedure Aggiorna;
  public
    { Public declarations }
  end;

var
  P552FRegoleContoAnnuale: TP552FRegoleContoAnnuale;

  procedure OpenP552RegoleContoAnnuale;

implementation

uses P552URegoleContoAnnualeDtM, P552UDettaglioRegoleContoAnn,
  P552UEsportazioneFile;

{$R *.dfm}

procedure OpenP552RegoleContoAnnuale;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP552RegoleContoAnnuale') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP552FRegoleContoAnnuale,P552FRegoleContoAnnuale);
  with P552FRegoleContoAnnuale do
    try
      P552FRegoleContoAnnualeDtM:=TP552FRegoleContoAnnualeDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      P552FRegoleContoAnnualeDtM.Free;
      Free;
    end;
end;

procedure TP552FRegoleContoAnnuale.FormDestroy(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP552FRegoleContoAnnuale.FormShow(Sender: TObject);
begin
  inherited;
  dcmbDatoLibero.ListSource:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.dsrI010;
  dgrdRighe.DataSource:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.dsrP552Righe;
  dgrdColonne.DataSource:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.dsrP552Colonne;
  dgrdEsportazione.DataSource:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.dsrP551;
  PageControl1.ActivePage:=tabGenerale;
  with P552FRegoleContoAnnualeDtM do
  begin
    DButton.Dataset:=selP552;
    edtAnno.Text:=IntToStr(P552FRegoleContoAnnualeMW.GetMaxAnno);
  end;
  edtAnnoChange(edtAnno);
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
end;

procedure TP552FRegoleContoAnnuale.edtAnnoChange(Sender: TObject);
var SalvaAnno:Integer;
begin
  inherited;
  with P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW do
  begin
    SalvaAnno:=0;
    if selP552Ricerca.Active then
      SalvaAnno:=StrToIntDef(VarToStr(selP552Ricerca.GetVariable('Anno')),1900);
    ImpostaAnnoSelP552Ricerca(StrToIntDef(edtAnno.Text,1900));

    if (selP552Ricerca.RecordCount <= 0) and (SalvaAnno <> 0) then
    begin
      edtAnno.Text:=IntToStr(SalvaAnno);
      ImpostaAnnoSelP552Ricerca(SalvaAnno);
    end;
    if Trim(cmbRicerca.Text) = '' then
      cmbRicerca.KeyValue:=selP552Ricerca.FieldByName('COD_TABELLA').AsString;
    if Sender = edtAnno then
      Aggiorna;
  end;
end;

procedure TP552FRegoleContoAnnuale.Aggiorna;
begin
  with P552FRegoleContoAnnualeDtM do
  begin
    selP552.SearchRecord('ANNO;COD_TABELLA',VarArrayOf([edtAnno.Text,cmbRicerca.Text]),[srFromBeginning]);
    if PageControl1.ActivePage = tabRighe then
    begin
      P552FRegoleContoAnnualeMW.ImpostaSelP552Righe;
    end
    else if PageControl1.ActivePage = tabColonne then
    begin
      P552FRegoleContoAnnualeMW.ImpostaSelP552Colonne;
    end
    else if PageControl1.ActivePage = tabEsportazione then
    begin
      P552FRegoleContoAnnualeMW.ImpostaSelP551;
    end;
  end;
  actInserisci.Enabled:=(PageControl1.ActivePage = tabGenerale) and not SolaLettura;
  actModifica.Enabled:=(PageControl1.ActivePage = tabGenerale) and not SolaLettura;
  actCancella.Enabled:=(PageControl1.ActivePage = tabGenerale) and not SolaLettura;
  actRicerca.Enabled:=PageControl1.ActivePage <> tabEsportazione;
  actPrimo.Enabled:=PageControl1.ActivePage <> tabEsportazione;
  actPrecedente.Enabled:=PageControl1.ActivePage <> tabEsportazione;
  actSuccessivo.Enabled:=PageControl1.ActivePage <> tabEsportazione;
  actUltimo.Enabled:=PageControl1.ActivePage <> tabEsportazione;
  actRefresh.Enabled:=PageControl1.ActivePage <> tabEsportazione;
  actStampa.Enabled:=PageControl1.ActivePage <> tabEsportazione;
end;

procedure TP552FRegoleContoAnnuale.drdgTipologiaClick(Sender: TObject);
begin
  inherited;
  lblDatoLibero.Visible:=drdgTipologia.ItemIndex = 1;
  dCmbDatoLibero.Visible:=drdgTipologia.ItemIndex = 1;
  lblFunzioneOracle.Visible:=drdgTipologia.ItemIndex = 2;
  dmemFunzioneOracle.Visible:=drdgTipologia.ItemIndex = 2;
  if (DButton.State <> dsBrowse) then
    P552FRegoleContoAnnualeDtM.selP552.FieldByName('VALORE_COSTANTE').AsString:='';
end;

procedure TP552FRegoleContoAnnuale.DButtonStateChange(Sender: TObject);
begin
  inherited;
  pnlRicerca.Enabled:=DButton.State = dsBrowse;
  C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State <> dsBrowse;
  if PageControl1.ActivePage = tabGenerale then
    dchkRegolaModifClick(nil);
end;

procedure TP552FRegoleContoAnnuale.cmbRicercaCloseUp(Sender: TObject);
begin
  inherited;
  Aggiorna;
end;

procedure TP552FRegoleContoAnnuale.cmbRicercaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbRicercaCloseUp(nil);
end;

procedure TP552FRegoleContoAnnuale.cmbRicercaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  //IL COMBO DEVE SEMPRE ESSERE VALORIZZATO
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.selP552Ricerca.FieldByName('COD_TABELLA').AsString;
(*    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;*)
  end;
end;

procedure TP552FRegoleContoAnnuale.PageControl1Change(Sender: TObject);
begin
  inherited;
  if PageControl1.ActivePage = tabGenerale then
    DButton.Dataset:=P552FRegoleContoAnnualeDtM.selP552
  else if PageControl1.ActivePage = tabScriptIniziale then
    DButton.Dataset:=P552FRegoleContoAnnualeDtM.selP552
  else if PageControl1.ActivePage = tabRighe then
    DButton.Dataset:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.selP552Righe
  else if PageControl1.ActivePage = tabColonne then
    DButton.Dataset:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.selP552Colonne;
  Aggiorna;
end;

procedure TP552FRegoleContoAnnuale.TPrimoClick(Sender: TObject);
begin
  inherited;
  if PageControl1.ActivePage = tabGenerale then
  begin
    cmbRicerca.KeyValue:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('COD_TABELLA').AsString;
    edtAnno.Text:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('ANNO').AsString;
  end;
end;

procedure TP552FRegoleContoAnnuale.Accedi1Click(Sender: TObject);
var SalvaNum:Integer;
begin
  inherited;
  if Popupmenu1.PopupComponent = dGrdRighe then
    with P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.selP552Righe do
    begin
      DButton.DataSet:=nil;
      SalvaNum:=FieldByName('RIGA').AsInteger;
      OpenP522DettaglioRegoleContoAnn(FieldByName('RIGA').AsInteger,StrToIntDef(edtAnno.Text,0),TIPO_ELAB_RIGA,cmbRicerca.Text);
      cmbRicerca.KeyValue:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.selP552Ricerca.FieldByName('COD_TABELLA').AsString;
      PageControl1Change(nil);
      SearchRecord('RIGA',SalvaNum,[srFromBeginning]);
    end;
  if Popupmenu1.PopupComponent = dGrdColonne then
    with P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.selP552Colonne do
    begin
      DButton.DataSet:=nil;
      SalvaNum:=FieldByName('COLONNA').AsInteger;
      OpenP522DettaglioRegoleContoAnn(FieldByName('COLONNA').AsInteger,StrToIntDef(edtAnno.Text,0),TIPO_ELAB_COLONNA,cmbRicerca.Text);
      cmbRicerca.KeyValue:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.selP552Ricerca.FieldByName('COD_TABELLA').AsString;
      PageControl1Change(nil);
      SearchRecord('COLONNA',SalvaNum,[srFromBeginning]);
    end;
  if Popupmenu1.PopupComponent = dGrdEsportazione then
  begin
    OpenP522EsportazioneFile(StrToIntDef(edtAnno.Text,0),P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.selP551.FieldByName('NUM_CAMPO').AsInteger,cmbRicerca.Text);
  end;
end;

procedure TP552FRegoleContoAnnuale.TCercaClick(Sender: TObject);
begin
  inherited;
  if PageControl1.ActivePage = tabGenerale then
  begin
    cmbRicerca.KeyValue:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('COD_TABELLA').AsString;
    edtAnno.Text:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('ANNO').AsString;
  end;
end;

procedure TP552FRegoleContoAnnuale.TInserClick(Sender: TObject);
begin
  inherited;
  cmbRicerca.KeyValue:=null;
  dTxtTabella.Visible:=False;
  dedtAnno.SetFocus;
end;

procedure TP552FRegoleContoAnnuale.TCancClick(Sender: TObject);
var Anno,Tabella:String;
begin
//  inherited;
  if DButton.DataSet.RecordCount > 0 then
  begin
    Anno:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('ANNO').AsString;
    Tabella:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('COD_TABELLA').AsString;
    if R180MessageBox('Confermi cancellazione ?',DOMANDA) = mrYes then
    begin
      P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.DeleteP552(Tabella,Anno);
      edtAnno.Text:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('ANNO').AsString;
      edtAnnoChange(nil);
      cmbRicerca.KeyValue:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('COD_TABELLA').AsString;
    end;
  end;
end;

procedure TP552FRegoleContoAnnuale.TRegisClick(Sender: TObject);
begin
  inherited;
  edtAnno.Text:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('ANNO').AsString;
  edtAnnoChange(nil);
  cmbRicerca.KeyValue:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('COD_TABELLA').AsString;
  P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.selP552Ricerca.SearchRecord('COD_TABELLA',cmbRicerca.Text,[srFromBeginning]);
  dTxtTabella.Visible:=True;
end;

procedure TP552FRegoleContoAnnuale.dcmbDatoLiberoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TP552FRegoleContoAnnuale.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
  cmbRicerca.KeyValue:=P552FRegoleContoAnnualeDtM.selP552.FieldByName('COD_TABELLA').AsString;
  P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.selP552Ricerca.SearchRecord('COD_TABELLA',cmbRicerca.Text,[srFromBeginning]);
  dTxtTabella.Visible:=True;
end;

procedure TP552FRegoleContoAnnuale.btnRipristinaClick(Sender: TObject);
begin
  inherited;
  if (R180MessageBox(A000MSG_P552_DLG_RIPRISTINO_REGOLA,DOMANDA) = mrYes) then
    DButton.Dataset.FieldByName('REGOLA_CALCOLO_MANUALE').AsString:=DButton.Dataset.FieldByName('REGOLA_CALCOLO_AUTOMATICA').AsString;
end;

procedure TP552FRegoleContoAnnuale.C600frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
var S:String;
begin
  inherited;
  if dedtAnno.Field.IsNull then
    C600frmSelAnagrafe.C600DataLavoro:=Date
  else
    C600frmSelAnagrafe.C600DataLavoro:=EncodeDate(dedtAnno.Field.AsInteger,12,31);
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    P552FRegoleContoAnnualeDtM.selP552.FieldByName('FILTRO_DIPENDENTI').AsString:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.TrasformaV430(S);
  end;
end;

procedure TP552FRegoleContoAnnuale.dchkRegolaModifClick(Sender: TObject);
begin
  inherited;
  if PageControl1.ActivePage = tabGenerale then
  begin
    dMemRegolaManuale.Enabled:=(DButton.State <> dsBrowse) and (dchkRegolaModif.Checked);
    btnRipristina.Enabled:=(DButton.State <> dsBrowse) and (dchkRegolaModif.Checked);
  end;
end;

end.
