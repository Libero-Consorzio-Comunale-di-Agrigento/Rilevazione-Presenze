unit P555UContoAnnuale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Menus, Buttons,
  ExtCtrls, ComCtrls, StdCtrls, DBCtrls,  Mask, ImgList, ToolWin, ActnList,
  C180FUNZIONIGENERALI, C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia, A002UInterfacciaSt,
  C001UFiltroTabelle, C001UFiltroTabelleDtM, C001UScegliCampi, A003UDataLavoroBis,
  C005UDatiAnagrafici, Grids, DBGrids, OracleData, Db, SelAnagrafe, Variants,C013UCheckList,
  Spin, Oracle, Printers, ToolbarFiglio, C015UElencoValori, System.Actions, A000UMessaggi,
  System.ImageList;

type
  TP555FContoAnnuale = class(TR001FGestTab)
    pnlTestata: TPanel;
    dchkChiuso: TDBCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    lblDataChiusura: TLabel;
    dedtDataChiusura: TDBEdit;
    lblIdINPDAPMM: TLabel;
    dedtIdContoAnn: TDBEdit;
    pnlDettaglio: TPanel;
    dgrdContoAnn: TDBGrid;
    pnlIntestazioneGriglia: TPanel;
    pnlVisualizzazioneVoci: TPanel;
    btnFiltroColonna: TBitBtn;
    btnFiltroRiga: TBitBtn;
    rgpTipoDati: TRadioGroup;
    cmbRicerca: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    dedtAnno: TDBEdit;
    DBText1: TDBText;
    mnuCopia: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem2: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    pnlPulsanti: TPanel;
    BChiudi: TBitBtn;
    BSalva: TBitBtn;
    SaveDialog1: TSaveDialog;
    PrinterSetupDialog2: TPrinterSetupDialog;
    dgrdRiepTab: TDBGrid;
    mnuVisDip: TPopupMenu;
    Visualizzadipendenti1: TMenuItem;
    frmToolbarFiglio: TfrmToolbarFiglio;
    procedure Visualizzadipendenti1Click(Sender: TObject);
    procedure BStampanteClick(Sender: TObject);
    procedure BSalvaClick(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure cmbRicercaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbRicercaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbRicercaCloseUp(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure dgrdContoAnnEditButtonClick(Sender: TObject);
    procedure btnFiltroColonnaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFiltroRigaClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure rgpTipoDatiClick(Sender: TObject);
    procedure frmToolbarFiglioactTFCopiaSuExecute(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    SalvaIndex:Integer;
    procedure CambiaProgressivo;
  public
    { Public declarations }
    procedure AggiornaRiepTabellari;
    procedure AbilitazioniComponenti;
  end;

var
  P555FContoAnnuale: TP555FContoAnnuale;

procedure OpenP555FContoAnnuale(Prog:LongInt);

implementation

uses P555UContoAnnualeDtM, P555UElencoDipendenti;

{$R *.DFM}

procedure OpenP555FContoAnnuale(Prog:LongInt);
begin
  (* 25/06/2015 Obsoleto. Impostato DI:True su L021
  if Prog <= 0 then
  begin
    R180MessageBox('Nessun dipendente selezionato!',INFORMA);
    exit;
  end;
  *)
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP555FContoAnnuale') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TP555FContoAnnuale, P555FContoAnnuale);
  C700Progressivo:=Prog;
  Application.CreateForm(TP555FContoAnnualeDtM, P555FContoAnnualeDtM);
  try
    Screen.Cursor:=crDefault;
    P555FContoAnnuale.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P555FContoAnnuale.Free;
    P555FContoAnnualeDtM.Free;
  end;
end;

procedure TP555FContoAnnuale.FormShow(Sender: TObject);
begin
  inherited;
  dgrdContoAnn.DataSource:=P555FContoAnnualeDtM.P555FContoAnnualeMW.dsrP555;
  dgrdRiepTab.DataSource:=P555FContoAnnualeDtM.P555FContoAnnualeMW.dsrQuery;
  cmbRicerca.ListSource:=P555FContoAnnualeDtM.P555FContoAnnualeMW.dsrP552;
  DbText1.DataSource:=P555FContoAnnualeDtM.P555FContoAnnualeMW.dsrP552;
  frmToolbarFiglio.TFDButton:=P555FContoAnnualeDtM.P555FContoAnnualeMW.dsrP555;
  frmToolbarFiglio.TFDBGrid:=dgrdContoAnn;
  frmToolbarFiglio.RefreshDopoPost:=True;
  SetLength(frmToolbarFiglio.lstLock,6);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglio.lstLock[4]:=pnlTestata;
  frmToolbarFiglio.lstLock[5]:=pnlVisualizzazioneVoci;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  A000SettaVariabiliAmbiente;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(P555FContoAnnualeDtM.P555FContoAnnualeMW,SessioneOracle, StatusBar,2,True);
  DButton.DataSet:=P555FContoAnnualeDtM.selP554;
  actInserisci.Visible:=False;
  actModifica.Visible:=False;
  actConferma.Visible:=False;
  actAnnulla.Visible:=False;
  actGomma.Visible:=False;
  rgpTipoDati.ItemIndex:=0;
  P555FContoAnnuale.WindowState:=wsMaximized;
end;

procedure TP555FContoAnnuale.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  try
    C700DataLavoro:=R180FineMese(StrToDate('31/12/'+dedtAnno.Text));
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  if C700DataLavoro = 0 then
    C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TP555FContoAnnuale.frmToolbarFiglioactTFCopiaSuExecute(
  Sender: TObject);
var RigaOrig,ColonnaOrig:Integer;
  ValoreOrig:Real;
begin
  with P555FContoAnnualeDtM.P555FContoAnnualeMW.selP555 do
  begin
    RigaOrig:=FieldByName('RIGA').AsInteger;
    ColonnaOrig:=FieldByName('COLONNA').AsInteger;
    ValoreOrig:=FieldByName('VALORE').AsFloat;
    frmToolbarFiglio.actTFInserisciExecute(frmToolbarFiglio.actTFInserisci);
    FieldByName('RIGA').AsInteger:=RigaOrig;
    FieldByName('COLONNA').AsInteger:=ColonnaOrig;
    FieldByName('VALORE').AsFloat:=ValoreOrig;
  end;
end;

procedure TP555FContoAnnuale.CambiaProgressivo;
begin
  C700Progressivo:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  P555FContoAnnualeDtM.selP554.SearchRecord('ANNO;COD_TABELLA',
    VarArrayOf([P555FContoAnnualeDtM.selP554.FieldByName('ANNO').AsInteger,VarToStr(cmbRicerca.KeyValue)]),[srFromBeginning]);
end;

procedure TP555FContoAnnuale.cmbRicercaCloseUp(Sender: TObject);
begin
  inherited;
  P555FContoAnnualeDtM.selP554.SearchRecord('ANNO;COD_TABELLA',
    VarArrayOf([P555FContoAnnualeDtM.selP554.FieldByName('ANNO').AsInteger,VarToStr(cmbRicerca.KeyValue)]),[srFromBeginning]);
end;

procedure TP555FContoAnnuale.cmbRicercaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  cmbRicercaCloseUp(nil);
end;


procedure TP555FContoAnnuale.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP555FContoAnnuale.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT');
  QueryStampa.Add('T2.anno,');
  QueryStampa.Add('T2.cod_tabella,');
  QueryStampa.Add('T2.id_contoann,');
  QueryStampa.Add('T2.chiuso,');
  QueryStampa.Add('T2.data_chiusura,');
  QueryStampa.Add('T1.progressivo,');
  QueryStampa.Add('T1.riga,');
  QueryStampa.Add('T1.colonna,');
  QueryStampa.Add('T1.valore');
  QueryStampa.Add('FROM P555_CONTOANNDATIINDIVIDUALI T1, P554_CONTOANNTESTATE T2');
  QueryStampa.Add('WHERE T1.ID_CONTOANN=T2.ID_CONTOANN');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T2.anno');
  NomiCampiR001.Add('T2.cod_tabella');
  NomiCampiR001.Add('T2.id_contoann');
  NomiCampiR001.Add('T2.chiuso');
  NomiCampiR001.Add('T2.data_chiusura');
  NomiCampiR001.Add('T1.progressivo');
  NomiCampiR001.Add('T1.riga');
  NomiCampiR001.Add('T1.colonna');
  NomiCampiR001.Add('T1.valore');
  inherited;
end;

procedure TP555FContoAnnuale.AbilitazioniComponenti;
var Abilita: Boolean;
begin
  if frmToolbarFiglio.TFDButton = nil then
    Exit;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  Abilita:=(P555FContoAnnualeDtM.P555FContoAnnualeMW.selP555.ReadOnly) and (not SolaLettura) and (P555FContoAnnualeDtM.selP554.FieldByName('CHIUSO').AsString <> 'S') and (rgpTipoDati.ItemIndex = 0);
  actCancella.Enabled:=Abilita;
  frmToolbarFiglio.actTFCopiaSu.Enabled:=Abilita;
  frmToolbarFiglio.actTFInserisci.Enabled:=Abilita;
  frmToolbarFiglio.actTFModifica.Enabled:=Abilita;
  frmToolbarFiglio.actTFCancella.Enabled:=Abilita;
  frmToolbarFiglio.Visible:=rgpTipoDati.ItemIndex < 2;
  pnlVisualizzazioneVoci.Visible:=rgpTipoDati.ItemIndex < 2;
  dgrdContoAnn.Visible:=rgpTipoDati.ItemIndex < 2;
  dgrdRiepTab.Visible:=rgpTipoDati.ItemIndex = 2;
  pnlPulsanti.Visible:=rgpTipoDati.ItemIndex = 2;
  Visualizzadipendenti1.Enabled:=rgpTipoDati.ItemIndex = 1;
  frmSelAnagrafe.Visible:=rgpTipoDati.ItemIndex = 0;
end;

procedure TP555FContoAnnuale.dgrdContoAnnEditButtonClick(Sender: TObject);
var vCodice:Variant;
begin
  with P555FContoAnnualeDtM do
  begin
    if P555FContoAnnualeMW.selP555.ReadOnly then
      exit;
    case dgrdContoAnn.SelectedIndex of
      0: begin          //Numero dato da elenco
           if Trim(P555FContoAnnualeMW.selP555.FieldByName('RIGA').AsString) <> '' then
             vCodice:=VarArrayOf([P555FContoAnnualeMW.AnnoRegole,P555FContoAnnualeMW.selP555.FieldByName('RIGA').AsString])
           else
             vCodice:=VarArrayOf([P555FContoAnnualeMW.AnnoRegole,1]);
           OpenC015FElencoValori('P552_CONTOANNREGOLE','<P555> Elenco dati',P555FContoAnnualeMW.selP552Riga.SQL.Text,'ANNO;RIGA',vCodice,P555FContoAnnualeMW.selP552Riga,500,300);
           if not VarIsClear(vCodice) then
           begin
             P555FContoAnnualeMW.selP555.FieldByName('RIGA').AsString:=VarToStr(vCodice[1]);
             P555FContoAnnualeMW.selP555.FieldByName('DESC_RIGA').AsString:=VarToStr(P555FContoAnnualeMW.selP552Riga.Lookup('ANNO;RIGA',VarArrayOf([P555FContoAnnualeMW.AnnoRegole,vCodice[1]]),'DESCRIZIONE'));
           end;
         end;
      3: begin        //Numero dato da elenco
           if Trim(P555FContoAnnualeMW.selP555.FieldByName('COLONNA').AsString) <> '' then
             vCodice:=VarArrayOf([P555FContoAnnualeMW.AnnoRegole,P555FContoAnnualeMW.selP555.FieldByName('COLONNA').AsString])
           else
             vCodice:=VarArrayOf([P555FContoAnnualeMW.AnnoRegole,1]);
           OpenC015FElencoValori('P552_CONTOANNREGOLE','<P555> Elenco dati',P555FContoAnnualeMW.selP552Col.SQL.Text,'ANNO;COLONNA',vCodice,P555FContoAnnualeMW.selP552Col,500,300);
           if not VarIsClear(vCodice) then
           begin
             P555FContoAnnualeMW.selP555.FieldByName('COLONNA').AsString:=VarToStr(vCodice[1]);
             P555FContoAnnualeMW.selP555.FieldByName('DESC_COLONNA').AsString:=VarToStr(P555FContoAnnualeMW.selP552Col.Lookup('ANNO;COLONNA',VarArrayOf([P555FContoAnnualeMW.AnnoRegole,vCodice[1]]),'DESCRIZIONE'));
           end;
         end;
    end;
  end;
end;

procedure TP555FContoAnnuale.btnFiltroRigaClick(Sender: TObject);
var C013FCheckListRiga:TC013FCheckList;
  ListRighe: TElencoValoriChecklist;
begin
  with P555FContoAnnualeDtM do
  begin
    C013FCheckListRiga:=TC013FCheckList.Create(nil);
    try
      C013FCheckListRiga.Caption:='<P555> Filtro Riga';
      C013FCheckListRiga.clbListaDati.Clear;

      ListRighe:=P555FContoAnnualeMW.ListRighe;
      try
        C013FCheckListRiga.clbListaDati.Items.Assign(ListRighe.lstDescrizione);
      finally
        FreeAndNil(ListRighe);
      end;

      R180PutCheckList(P555FContoAnnualeMW.RigSel, 3, C013FCheckListRiga.clbListaDati);
      if C013FCheckListRiga.ShowModal = mrOK then
      begin
        //Modifico la query aggiungendo il filtro sulle voci selezionate
        P555FContoAnnualeMW.RigSel:=R180GetCheckList(3,C013FCheckListRiga.clbListaDati);
        P555FContoAnnualeMW.FiltroRigheColonne;
      end;
    finally
    //except //22/06/2015 distruggeva oggetto solo se vi era eccezione. Creava memory leak, non ha mai funzionato
      FreeAndNil(C013FCheckListRiga);
    end;
  end;
end;

procedure TP555FContoAnnuale.btnFiltroColonnaClick(Sender: TObject);
var C013FCheckListCol:TC013FCheckList;
  s:String;
  ListColonne: TElencoValoriChecklist;
begin
  with P555FContoAnnualeDtM do
  begin
    C013FCheckListCol:=TC013FCheckList.Create(nil);
    try
      C013FCheckListCol.Caption:='<P555> Filtro Colonna';
      C013FCheckListCol.clbListaDati.Clear;
      ListColonne:=P555FContoAnnualeMW.ListColonne;
      try
        C013FCheckListCol.clbListaDati.Items.Assign(ListColonne.lstDescrizione);
      finally
        FreeAndNil(ListColonne);
      end;

      R180PutCheckList(P555FContoAnnualeMW.ColSel, 3, C013FCheckListCol.clbListaDati);
      if C013FCheckListCol.ShowModal = mrOK then
      begin
        P555FContoAnnualeMW.ColSel:=R180GetCheckList(3,C013FCheckListCol.clbListaDati);
        //Modifico la query aggiungendo il filtro sulle voci selezionate
        P555FContoAnnualeMW.FiltroRigheColonne;
      end;
    finally
      //except //22/06/2015 distruggeva oggetto solo se vi era eccezione. Creava memory leak, non ha mai funzionato
      FreeAndNil(C013FCheckListCol);
    end;
  end;
end;

procedure TP555FContoAnnuale.TCancClick(Sender: TObject);
var
  sInputConf:String;
begin
  with P555FContoAnnualeDtM do
  begin
    if (R180MessageBox(P555FContoAnnualeMW.MessaggioCancellazione,DOMANDA) = mrNo) then
      exit;
    sInputConf:= InputBox('Cancellazione di ' + P555FContoAnnualeMW.selP555canc.FieldByName('NUMDIP').AsString + ' dip.' ,'Inserire il numero di dipendenti che verranno cancellati:', '0');
    if (sInputConf = '0') or (sInputConf <> P555FContoAnnualeMW.selP555canc.FieldByName('NUMDIP').AsString) then
    begin
      R180MessageBox(A000MSG_B023_MSG_ELAB_ABORT,INFORMA);
      exit;
    end;
  end;
  inherited;
end;

procedure TP555FContoAnnuale.rgpTipoDatiClick(Sender: TObject);
begin
  P555FContoAnnualeDtM.P555FContoAnnualeMW.bSelAnagrafe:=rgpTipoDati.ItemIndex = 0;
  if rgpTipoDati.ItemIndex < 2 then
    SalvaIndex:=rgpTipoDati.ItemIndex;
  P555FContoAnnualeDtM.selP554.SearchRecord('ANNO;COD_TABELLA',
    VarArrayOf([P555FContoAnnualeDtM.selP554.FieldByName('ANNO').AsInteger,VarToStr(cmbRicerca.KeyValue)]),[srFromBeginning]);
end;

procedure TP555FContoAnnuale.AggiornaRiepTabellari;
var
  sMsg: String;
begin
  sMsg:=P555FContoAnnualeDtM.P555FContoAnnualeMW.VerificaCalcoloManuale(VarToStr(cmbRicerca.KeyValue));
  if sMsg <> '' then
  begin
    R180MessageBox(sMsg, 'ERRORE');
    rgpTipoDati.ItemIndex:=SalvaIndex;
    Exit;
  end;

  P555FContoAnnualeDtM.P555FContoAnnualeMW.ImpostaSelQuery(VarToStr(cmbRicerca.KeyValue));
  if P555FContoAnnualeDtM.P555FContoAnnualeMW.selQuery.RecordCount > 0 then
    BSalva.Enabled:=True
  else
    BSalva.Enabled:=False;
end;

procedure TP555FContoAnnuale.Selezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdRiepTab,'S');
end;

procedure TP555FContoAnnuale.Deselezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdRiepTab,'N');
end;

procedure TP555FContoAnnuale.Invertiselezione1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdRiepTab,'C');
end;

procedure TP555FContoAnnuale.CopiaInExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdRiepTab,Sender = CopiaInExcel);
end;

procedure TP555FContoAnnuale.BSalvaClick(Sender: TObject);
var Intestazione:Boolean;
    lst:TStringList;
begin
  Intestazione:=False;
  if R180MessageBox(A000MSG_P555_DLG_INTESTAZIONE,'DOMANDA') = mrYes then
    Intestazione:=True;
  if not SaveDialog1.Execute then exit;
  lst:=TStringList.Create;
  try
    P555FContoAnnualeDtM.P555FContoAnnualeMW.SalvaRiepilogo(Intestazione,lst);
    lst.SaveToFile(SaveDialog1.FileName);
  finally
    FreeAndNil(lst);
  end;
end;

procedure TP555FContoAnnuale.BStampanteClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TP555FContoAnnuale.cmbRicercaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
    (Sender as TDBLookupComboBox).KeyValue:=P555FContoAnnualeDtM.P555FContoAnnualeMW.selP552.FieldByName('COD_TABELLA').AsString;
end;

procedure TP555FContoAnnuale.Visualizzadipendenti1Click(Sender: TObject);
begin
  inherited;
  with P555FContoAnnualeDtM.P555FContoAnnualeMW.selP555 do
    OpenP555ElencoDipendenti(StrToIntDef(dedtAnno.Text,0),FieldByName('COLONNA').AsInteger,FieldByName('RIGA').AsInteger,VarToStr(cmbRicerca.KeyValue));
end;

end.

