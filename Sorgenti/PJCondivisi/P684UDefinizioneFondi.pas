unit P684UDefinizioneFondi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  A000UCostanti, A000USessione, A000UInterfaccia, ExtCtrls, DBCtrls, StdCtrls, Mask,
  C600USelAnagrafe, Buttons, Oracle, OracleData, A003UDataLavoroBis,
  P680UMacrocategorieFondi, P682URaggruppamentiFondi, Grids, DBGrids,
  C180FunzioniGenerali, C009UCopiaSu, ClipBrd, System.Actions, System.ImageList,
  A000UMessaggi;

type
  TP684FDefinizioneFondi = class(TR001FGestTab)
    pnlRicerca: TPanel;
    PageControl1: TPageControl;
    tabGenerale: TTabSheet;
    tabRisorseGen: TTabSheet;
    tabRisorseDett: TTabSheet;
    tabDestinGen: TTabSheet;
    tabDestinDett: TTabSheet;
    dedtCodFondo: TDBEdit;
    lblCodFondo: TLabel;
    dedtDecorrenza: TDBEdit;
    lblDecorrenza: TLabel;
    dedtScadenza: TDBEdit;
    lblScadenza: TLabel;
    dtxtDescrizione: TDBText;
    cmbRicerca: TDBLookupComboBox;
    lblRicerca: TLabel;
    cmbDecorrenza: TDBLookupComboBox;
    lblDecorrenzaDa: TLabel;
    btnDecorrenza: TBitBtn;
    btnScadenza: TBitBtn;
    dmemDescrizione: TDBMemo;
    lblDescrizione: TLabel;
    lblFiltroDipendenti: TLabel;
    dmemFiltroDipendenti: TDBMemo;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    btnDataCostituz: TBitBtn;
    dedtDataCostituz: TDBEdit;
    lblDataCostituz: TLabel;
    dcmbMacroCateg: TDBLookupComboBox;
    lblMacroCateg: TLabel;
    lblRaggr: TLabel;
    dcmbRaggr: TDBLookupComboBox;
    dtxtMacrocateg: TDBText;
    dtxtRaggr: TDBText;
    PopupMenu1: TPopupMenu;
    Accedi1: TMenuItem;
    dgrdRisorseGen: TDBGrid;
    dgrdDestinGen: TDBGrid;
    dgrdRisorseDett: TDBGrid;
    dgrdDestinDett: TDBGrid;
    gpbMonitoraggio: TGroupBox;
    dedtDataMonitoraggio: TDBEdit;
    lblDataMonitoraggio: TLabel;
    lblTotRisorse: TLabel;
    edtTotRisorse: TEdit;
    edtTotSpeso: TEdit;
    lblTotSpeso: TLabel;
    edtTotResiduo: TEdit;
    lblTotResiduo: TLabel;
    Rinumeraordinestampa: TMenuItem;
    N4: TMenuItem;
    Selezionatutto: TMenuItem;
    Deselezionatutto: TMenuItem;
    Invertiselezione: TMenuItem;
    N5: TMenuItem;
    Copia: TMenuItem;
    Copiainexcel: TMenuItem;
    btnVisDettaglio: TBitBtn;
    Modificacodicevoce: TMenuItem;
    lblNote: TLabel;
    dmemNote: TDBMemo;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure dcmbMacroCategKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbMacroCategKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbMacroCategCloseUp(Sender: TObject);
    procedure dcmbRaggrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbRaggrKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbRaggrCloseUp(Sender: TObject);
    procedure cmbRicercaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbRicercaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbRicercaCloseUp(Sender: TObject);
    procedure cmbDecorrenzaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbDecorrenzaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbDecorrenzaCloseUp(Sender: TObject);
    procedure dedtDecorrenzaExit(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnDecorrenzaClick(Sender: TObject);
    procedure btnScadenzaClick(Sender: TObject);
    procedure btnDataCostituzClick(Sender: TObject);
    procedure btnVisDettaglioClick(Sender: TObject);
    procedure Copiada1Click(Sender: TObject);
    procedure TCercaClick(Sender: TObject);
    procedure TPrimoClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure SelezionatuttoClick(Sender: TObject);
    procedure DeselezionatuttoClick(Sender: TObject);
    procedure InvertiselezioneClick(Sender: TObject);
    procedure CopiaClick(Sender: TObject);
    procedure ModificacodicevoceClick(Sender: TObject);
    procedure RinumeraordinestampaClick(Sender: TObject);
  private
    { Private declarations }
    procedure Aggiorna;
    procedure AggiornaDecorrenzaRicerca;
  public
    { Public declarations }
    procedure AbilitazioniComponenti;
  end;

var
  P684FDefinizioneFondi: TP684FDefinizioneFondi;

  procedure OpenP684DefinizioneFondi;

implementation

uses P684UDefinizioneFondiDtM, P684UGenerale, P684UDettaglioRisorse, P684UDettaglioDestin, P684UGrigliaDett;

{$R *.dfm}

procedure OpenP684DefinizioneFondi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP684DefinizioneFondi') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP684FDefinizioneFondi,P684FDefinizioneFondi);
  with P684FDefinizioneFondi do
    try
      P684FDefinizioneFondiDtM:=TP684FDefinizioneFondiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      P684FDefinizioneFondiDtM.Free;
      Free;
    end;
end;

procedure TP684FDefinizioneFondi.FormShow(Sender: TObject);
begin
  inherited;
  dcmbMacroCateg.ListSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP680;
  dtxtMacrocateg.DataSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP680;
  dcmbRaggr.ListSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP682;
  dtxtRaggr.DataSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP682;
  dgrdRisorseGen.DataSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP686R;
  dgrdRisorseDett.DataSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP688R;
  dgrdDestinGen.DataSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP686D;
  dgrdDestinDett.DataSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP688D;
  CopiaDa1.Visible:=True;
  CopiaDa1.Enabled:=True;
  PageControl1.ActivePage:=tabGenerale;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    DButton.Dataset:=selP684;
    selP684Dec.Open;
    if selP684Dec.RecordCount > 0 then
    begin
      selP684Dec.Last;
      cmbDecorrenza.KeyValue:=selP684Dec.FieldByName('DECORRENZA').AsDateTime;
      cmbDecorrenzaCloseUp(nil);
    end;
  end;
end;

procedure TP684FDefinizioneFondi.FormDestroy(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP684FDefinizioneFondi.PageControl1Change(Sender: TObject);
begin
  inherited;
  Aggiorna;
  AbilitazioniComponenti;
end;

procedure TP684FDefinizioneFondi.PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  AllowChange:=DButton.State = dsBrowse;
end;

procedure TP684FDefinizioneFondi.dcmbMacroCategKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
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

procedure TP684FDefinizioneFondi.dcmbMacroCategKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbMacroCategCloseUp(nil);
end;

procedure TP684FDefinizioneFondi.dcmbMacroCategCloseUp(Sender: TObject);
begin
  inherited;
  dtxtMacrocateg.Visible:=Trim(dcmbMacroCateg.Text) <> '';
end;

procedure TP684FDefinizioneFondi.dcmbRaggrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbMacroCategKeyDown(Sender,Key,Shift);
end;

procedure TP684FDefinizioneFondi.dcmbRaggrKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbRaggrCloseUp(nil);
end;

procedure TP684FDefinizioneFondi.dcmbRaggrCloseUp(Sender: TObject);
begin
  inherited;
  dtxtRaggr.Visible:=Trim(dcmbRaggr.Text) <> '';
end;

procedure TP684FDefinizioneFondi.cmbRicercaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  //IL COMBO DEVE SEMPRE ESSERE VALORIZZATO
  if Key = vk_Delete then
    (Sender as TDBLookupComboBox).KeyValue:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.selP684Ricerca.FieldByName('COD_FONDO').AsString;
end;

procedure TP684FDefinizioneFondi.cmbRicercaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbRicercaCloseUp(nil);
end;

procedure TP684FDefinizioneFondi.cmbRicercaCloseUp(Sender: TObject);
begin
  inherited;
  Aggiorna;
end;

procedure TP684FDefinizioneFondi.cmbDecorrenzaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  //IL COMBO DEVE SEMPRE ESSERE VALORIZZATO
  if Key = vk_Delete then
    (Sender as TDBLookupComboBox).KeyValue:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.selP684Dec.FieldByName('DECORRENZA').AsDateTime;
end;

procedure TP684FDefinizioneFondi.cmbDecorrenzaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbDecorrenzaCloseUp(nil);
end;

procedure TP684FDefinizioneFondi.cmbDecorrenzaCloseUp(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    LeggoSelP684Ricerca;
    cmbRicerca.KeyValue:=selP684Ricerca.FieldByName('COD_FONDO').AsString;
    cmbRicercaCloseUp(nil);
  end;
end;

procedure TP684FDefinizioneFondi.dedtDecorrenzaExit(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtm do
  begin
    if (DButton.State in [dsEdit,dsInsert]) and
      (not selP684.FieldByName('DECORRENZA_DA').IsNull) and (selP684.FieldByName('DECORRENZA_A').IsNull) then
      selP684.FieldByName('DECORRENZA_A').AsDateTime:=StrToDate('31/12/' + Copy(selP684.FieldByName('DECORRENZA_DA').AsString,7,4));
  end;
end;

procedure TP684FDefinizioneFondi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  pnlRicerca.Enabled:=DButton.State = dsBrowse;
  btnVisDettaglio.Enabled:=DButton.State = dsBrowse;
  if PageControl1.ActivePage = tabGenerale then
  begin
    btnDecorrenza.Enabled:=DButton.State in [dsEdit,dsInsert];
    btnScadenza.Enabled:=DButton.State in [dsEdit,dsInsert];
    btnDataCostituz.Enabled:=DButton.State in [dsEdit,dsInsert];
    C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsEdit,dsInsert];
  end;
end;

procedure TP684FDefinizioneFondi.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S:String;
begin
  inherited;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    if selP684.FieldByName('DECORRENZA_A').IsNull then
      C600frmSelAnagrafe.C600DataLavoro:=Date
    else
      C600frmSelAnagrafe.C600DataLavoro:=selP684.FieldByName('DECORRENZA_A').AsDateTime;
    C600frmSelAnagrafe.btnSelezioneClick(Sender);
    if C600frmSelAnagrafe.C600ModalResult = mrOK then
    begin
      S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
      if Pos('ORDER BY',UpperCase(S)) > 0 then
        S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
      selP684.FieldByName('FILTRO_DIPENDENTI').AsString:=TrasformaV430(S);
    end;
  end;
end;

procedure TP684FDefinizioneFondi.btnDecorrenzaClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    if selP684.FieldByName('DECORRENZA_DA').IsNull then
      selP684.FieldByName('DECORRENZA_DA').AsDateTime:=Parametri.DataLavoro;
    selP684.FieldByName('DECORRENZA_DA').AsDateTime:=DataOut(selP684.FieldByName('DECORRENZA_DA').AsDateTime,'Decorrenza','G');
  end;
end;

procedure TP684FDefinizioneFondi.btnScadenzaClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    if selP684.FieldByName('DECORRENZA_A').IsNull then
      selP684.FieldByName('DECORRENZA_A').AsDateTime:=Parametri.DataLavoro;
    selP684.FieldByName('DECORRENZA_A').AsDateTime:=DataOut(selP684.FieldByName('DECORRENZA_A').AsDateTime,'Scadenza','G');
  end;
end;

procedure TP684FDefinizioneFondi.btnDataCostituzClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    if selP684.FieldByName('DATA_COSTITUZ').IsNull then
      selP684.FieldByName('DATA_COSTITUZ').AsDateTime:=Parametri.DataLavoro;
    selP684.FieldByName('DATA_COSTITUZ').AsDateTime:=DataOut(selP684.FieldByName('DATA_COSTITUZ').AsDateTime,'Data costituzione','G');
  end;
end;

procedure TP684FDefinizioneFondi.btnVisDettaglioClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    OpenP684GrigliaDett(selP684.FieldByName('COD_FONDO').AsString,'',
      '',selP684.FieldByName('DECORRENZA_DA').AsDateTime);
  end;
end;

procedure TP684FDefinizioneFondi.Copiada1Click(Sender: TObject);
begin
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    if PageControl1.ActivePage = tabGenerale then
    begin
      C009FCopiaSu:=TC009FCopiaSu.Create(nil);
      with C009FCopiaSu do
      try
        SetODS([P684FDefinizioneFondiDtM.selP684]);
        ODS:=P684FDefinizioneFondiDtM.selP684;
        ShowModal;
      finally
        Free;
      end;
      AggiornaDecorrenzaRicerca;
    end
    else if PageControl1.ActivePage = tabRisorseDett then
    begin
      C009FCopiaSu:=TC009FCopiaSu.Create(nil);
      with C009FCopiaSu do
      try
        SetODS([selP688R]);
        ODS:=selP688R;
        ShowModal;
      finally
        Free;
      end;
    end;
  end;
end;

procedure TP684FDefinizioneFondi.TCercaClick(Sender: TObject);
begin
  inherited;
  AggiornaDecorrenzaRicerca;
end;

procedure TP684FDefinizioneFondi.TPrimoClick(Sender: TObject);
begin
  inherited;
  AggiornaDecorrenzaRicerca;
end;

procedure TP684FDefinizioneFondi.TInserClick(Sender: TObject);
begin
  inherited;
  cmbDecorrenza.KeyValue:=null;
  cmbRicerca.KeyValue:=null;
  dedtCodFondo.SetFocus;
end;

procedure TP684FDefinizioneFondi.TCancClick(Sender: TObject);
var Mes:String;
begin
  Mes:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.MessaggioCancellazione(cmbRicerca.Text,cmbDecorrenza.Text);
  if R180MessageBox(Mes,'DOMANDA') = mrYes  then
  begin
    DButton.DataSet.Delete;
    NumRecords;
    AggiornaDecorrenzaRicerca;
  end;
end;

procedure TP684FDefinizioneFondi.TRegisClick(Sender: TObject);
begin
  inherited;
  AggiornaDecorrenzaRicerca;
end;

procedure TP684FDefinizioneFondi.TAnnullaClick(Sender: TObject);
begin
  inherited;
  AggiornaDecorrenzaRicerca;
end;

procedure TP684FDefinizioneFondi.Accedi1Click(Sender: TObject);
begin
  inherited;
  if PopupMenu1.PopupComponent = dcmbMacroCateg then
  begin
    OpenP680MacrocategorieFondi(dcmbMacroCateg.Text);
    P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.selP680.Refresh;
    exit;
  end
  else if PopupMenu1.PopupComponent = dcmbRaggr then
  begin
    OpenP682RaggruppamentiFondi(dcmbRaggr.Text);
    P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.selP682.Refresh;
    exit;
  end;
  if (cmbRicerca.Text = '') or (cmbDecorrenza.Text = '') then
    raise exception.Create(A000MSG_P684_ERR_COD_FONDO);
  if PopupMenu1.PopupComponent = dgrdRisorseGen then
  begin
    OpenP684Generale('R',cmbRicerca.Text,StrToDate(cmbDecorrenza.Text));
    P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.selP686R.Refresh;
  end
  else if PopupMenu1.PopupComponent = dgrdDestinGen then
  begin
    OpenP684Generale('D',cmbRicerca.Text,StrToDate(cmbDecorrenza.Text));
    P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.selP686D.Refresh;
  end
  else if PopupMenu1.PopupComponent = dgrdRisorseDett then
  begin
    OpenP684DettaglioRisorse(cmbRicerca.Text,StrToDate(cmbDecorrenza.Text));
    P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.selP688R.Refresh;
  end
  else if PopupMenu1.PopupComponent = dgrdDestinDett then
  begin
    C600frmSelAnagrafe.DistruggiSelAnagrafe;
    OpenP684DettaglioDestin(cmbRicerca.Text,StrToDate(cmbDecorrenza.Text));
    C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
    C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
    P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.selP688D.Refresh;
  end;
end;

procedure TP684FDefinizioneFondi.SelezionatuttoClick(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(TDBGrid(Popupmenu1.PopupComponent),'S');
end;

procedure TP684FDefinizioneFondi.DeselezionatuttoClick(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(TDBGrid(Popupmenu1.PopupComponent),'N');
end;

procedure TP684FDefinizioneFondi.InvertiselezioneClick(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(TDBGrid(Popupmenu1.PopupComponent),'C');
end;

procedure TP684FDefinizioneFondi.CopiaClick(Sender: TObject);
var S:String;
  i:Integer;
  Griglia:TDBGrid;
begin
  inherited;
  Griglia:=nil;
  if PageControl1.ActivePage = tabRisorseGen then
    Griglia:=dgrdRisorseGen
  else if PageControl1.ActivePage = tabDestinGen then
    Griglia:=dgrdDestinGen
  else if PageControl1.ActivePage = tabRisorseDett then
    Griglia:=dgrdRisorseDett
  else if PageControl1.ActivePage = tabDestinDett then
    Griglia:=dgrdDestinDett;
  with Griglia.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;
    First;
    try
      if not EOF then
      begin
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
            S:=S + Fields[i].DisplayLabel + #9;
        S:=S + #13#10;
      end;
      while not EOF do
      begin
        if Griglia.SelectedRows.CurrentRowSelected then
        begin
          for i:=0 to FieldCount - 1 do
            if Fields[i].Visible then
              S:=S + Fields[i].AsString + #9;
          S:=S + #13#10;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;
  Clipboard.AsText:=S;
  Griglia.Repaint;
end;

procedure TP684FDefinizioneFondi.ModificacodicevoceClick(Sender: TObject);
var OldCodiceVoce,NewCodiceVoce:String;
    EsitoModificaCodiceVoce:Boolean;
begin
  inherited;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    if PageControl1.ActivePage = tabRisorseGen then
      OldCodiceVoce:=selP686R.FieldByName('COD_VOCE_GEN').AsString
    else
      OldCodiceVoce:=selP686D.FieldByName('COD_VOCE_GEN').AsString;
    NewCodiceVoce:=OldCodiceVoce;
    if InputQuery('Modifica codice voce','Codice voce:',NewCodiceVoce) then
    begin
      if NewCodiceVoce = OldCodiceVoce then
        exit;
      if PageControl1.ActivePage = tabRisorseGen then
        EsitoModificaCodiceVoce:=ModifCodiceVoce(selP686R,cmbRicerca.Text,cmbDecorrenza.Text,NewCodiceVoce)
      else
        EsitoModificaCodiceVoce:=ModifCodiceVoce(selP686D,cmbRicerca.Text,cmbDecorrenza.Text,NewCodiceVoce);
      if EsitoModificaCodiceVoce then
        R180MessageBox(A000MSG_P684_MSG_MODIFICA_COD_VOCE,'INFORMA')
      else
        R180MessageBox(Format(A000MSG_P684_ERR_FMT_MODIFICA_COD_VOCE,[ScriptSQL.Output.Text]),'ERRORE');
    end;
  end;
end;

procedure TP684FDefinizioneFondi.RinumeraordinestampaClick(Sender: TObject);
begin
  inherited;
  if R180MessageBox(A000MSG_P664_DLG_RINUM_ORDINE_STAMPA,'DOMANDA') <> mrYes then
    exit;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    if PageControl1.ActivePage = tabRisorseGen then
      RinumOrdineStampa(selP686R)
    else
      RinumOrdineStampa(selP686D);
  end;
end;

procedure TP684FDefinizioneFondi.Aggiorna;
begin
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    if PageControl1.ActivePage = tabGenerale then
      selP684.SearchRecord('DECORRENZA_DA;COD_FONDO',VarArrayOf([StrToDateTimeDef(cmbDecorrenza.Text,StrToDate('30/12/1899')),cmbRicerca.Text]),[srFromBeginning])
    else if PageControl1.ActivePage = tabRisorseGen then
      LeggoSelP686R(cmbRicerca.Text,cmbDecorrenza.Text)
    else if PageControl1.ActivePage = tabDestinGen then
      LeggoSelP686D(cmbRicerca.Text,cmbDecorrenza.Text)
    else if PageControl1.ActivePage = tabRisorseDett then
    begin
      LeggoSelP686R(cmbRicerca.Text,cmbDecorrenza.Text);
      LeggoSelP688R(cmbRicerca.Text,cmbDecorrenza.Text);
    end
    else  if PageControl1.ActivePage = tabDestinDett then
    begin
      LeggoSelP686D(cmbRicerca.Text,cmbDecorrenza.Text);
      LeggoSelP688D(cmbRicerca.Text,cmbDecorrenza.Text);
    end;
  end;
end;

procedure TP684FDefinizioneFondi.AggiornaDecorrenzaRicerca;
begin
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    selP684Dec.Refresh;
    cmbDecorrenza.KeyValue:=selP684.FieldByName('DECORRENZA_DA').AsDateTime;
    LeggoSelP684Ricerca;
    cmbRicerca.KeyValue:=selP684.FieldByName('COD_FONDO').AsString;
  end;
end;

procedure TP684FDefinizioneFondi.AbilitazioniComponenti;
//Gestisco le abilitazioni e disabilitazioni di tutti i componenti della form nelle varie circostanze
begin
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    actInserisci.Enabled:=PageControl1.ActivePage = tabGenerale;
    actModifica.Enabled:=PageControl1.ActivePage = tabGenerale;
    actCancella.Enabled:=PageControl1.ActivePage = tabGenerale;
    actRicerca.Enabled:=PageControl1.ActivePage = tabGenerale;
    actPrimo.Enabled:=PageControl1.ActivePage = tabGenerale;
    actPrecedente.Enabled:=PageControl1.ActivePage = tabGenerale;
    actSuccessivo.Enabled:=PageControl1.ActivePage = tabGenerale;
    actUltimo.Enabled:=PageControl1.ActivePage = tabGenerale;
    actRefresh.Enabled:=PageControl1.ActivePage = tabGenerale;
    actStampa.Enabled:=PageControl1.ActivePage = tabGenerale;
    actCopiaSu.Enabled:=((PageControl1.ActivePage = tabGenerale) and (selP684.RecordCount > 0)) or ((PageControl1.ActivePage = tabRisorseDett) and (selP688R.RecordCount > 0));
    Modificacodicevoce.Visible:=((PageControl1.ActivePage = tabRisorseGen) and (selP686R.RecordCount > 0)) or ((PageControl1.ActivePage = tabDestinGen) and (selP686D.RecordCount > 0));
    Rinumeraordinestampa.Visible:=((PageControl1.ActivePage = tabRisorseGen) and (selP686R.RecordCount > 0)) or ((PageControl1.ActivePage = tabDestinGen) and (selP686D.RecordCount > 0));
    SelezionaTutto.Visible:=(PageControl1.ActivePage <> tabGenerale);
    DeselezionaTutto.Visible:=(PageControl1.ActivePage <> tabGenerale);
    InvertiSelezione.Visible:=(PageControl1.ActivePage <> tabGenerale);
    Copia.Visible:=(PageControl1.ActivePage <> tabGenerale);
    Copiainexcel.Visible:=(PageControl1.ActivePage <> tabGenerale);
  end;
end;

end.
