unit WA179UProfiliIterAut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, medpIWMultiColumnComboBox, DB, OracleData,
  medpIWMessageDlg, WR200UBaseFM;

type
  TNuovoProfilo = (npNuovoProfiloIter, npCopiaSuProfiloIter);

  TWA179FProfiliIterAut = class(TWR102FGestTabella)
    cmbAzienda: TMedpIWMultiColumnComboBox;
    lblAzienda: TmeIWLabel;
    procedure actNuovoExecute(Sender: TObject); override;
    procedure actModificaExecute(Sender: TObject); override;
    procedure actEliminaExecute(Sender: TObject); override;
    procedure actAnnullaExecute(Sender: TObject); override;
    procedure actConfermaExecute(Sender: TObject); override;
    procedure IWAppFormCreate(Sender: TObject);
    procedure cmbAziendaChange(Sender: TObject; Index: Integer);
  private
    { Private declarations }
    WA179FNuovoProfilo:TWR200FBaseFM;
    procedure CancellaProfiloIter(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure AbilitaComponenti(const MainDts:TOracleDataSet);
  public
    { Public declarations }
    Operazione:String;
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses
  WA179UProfiliIterAutDM, WA179UProfiliIterAutBrowseFM,
  WA179UProfiliIterAutDettFM, C180FunzioniGenerali, A000UInterfaccia,
  A000UCostanti, medpIWDBGrid, WA179UNuovoProfiloIterFM;

{$R *.dfm}

procedure TWA179FProfiliIterAut.AbilitaComponenti(const MainDts:TOracleDataSet);
begin
  cmbAzienda.Enabled:=(MainDts.State in [dsBrowse]);
  (WDettaglioFM as  TWA179FProfiliIterAutDettFM).cmbCodiceIter.ReadOnly:=(MainDts.State in [dsInsert,dsEdit]);
  //Abilitazione della navbar(in base allo stato del dataset)
  selTabellaStateChange(MainDts);
end;

procedure TWA179FProfiliIterAut.cmbAziendaChange(Sender: TObject;
  Index: Integer);
var
  Cmb:TMedpIWMultiColumnComboBox;
  CodPrevIter, DescPrevIter:string;
begin
  inherited;
  //Salvo i valori della cmbCodiceIter prima che vengano cancellati, per poi risettarli successivamente
  Cmb:=(WDettaglioFM as TWA179FProfiliIterAutDettFM).cmbCodiceIter;
  CodPrevIter:=Cmb.Items[Cmb.ItemIndex].RowData[0];
  DescPrevIter:=Cmb.Items[Cmb.ItemIndex].RowData[1];
  //============================================================================
  (WR302DM AS TWA179FProfiliIterAutDM).selTabella.Close;
  (WR302DM AS TWA179FProfiliIterAutDM).selTabella.SetVariable('AZIENDA', cmbAzienda.Text);
  (WR302DM AS TWA179FProfiliIterAutDM).selTabella.Open;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  //Ricarico la cmbCodiceIter dopo essere stata pulita
  (WDettaglioFM AS TWA179FProfiliIterAutDettFM).CaricaMultiColumnCombobox;
  //Mi riposiziono sul valore precedente
  Cmb.Text:=DescPrevIter;
  //============================================================================
  //Riapro il dataset sel I075 in base alla nuova azienda e al vecchio codice iter
  (WR302DM AS TWA179FProfiliIterAutDM).OpenSelI075(cmbAzienda.Text, CodPrevIter);
  (WDettaglioFM AS TWA179FProfiliIterAutDettFM).grdIterAutorizzativi.medpAggiornaCDS(True);
end;

function TWA179FProfiliIterAut.InizializzaAccesso:Boolean;
begin
  //Inizializzazione
  (WR302DM as TWA179FProfiliIterAutDM).AziendaMain:=GetParam('AZIENDA');
  if (WR302DM as TWA179FProfiliIterAutDM).AziendaMain.IsEmpty then
  begin
    (WR302DM as TWA179FProfiliIterAutDM).AziendaMain:=Parametri.Azienda;
  end;
  Result:=True;
end;

procedure TWA179FProfiliIterAut.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.CopiaSuTabella:='MONDOEDP.I075_ITER_AUTORIZZATIVI';
  InterfacciaWR102.CopiaSuChiave:='AZIENDA,PROFILO';
  InterfacciaWR102.CopiaSuChiaveInput:='PROFILO';
  InterfacciaWR102.CopiaSuCampi:='AZIENDA,PROFILO,ITER,COD_ITER,LIVELLO,ACCESSO';

  WR302DM:=TWA179FProfiliIterAutDM.Create(Self);
  WBrowseFM:=TWA179FProfiliIterAutBrowseFM.Create(Self);
  WDettaglioFM:=TWA179FProfiliIterAutDettFM.Create(Self);

  //Carico CmbAziende
  cmbAzienda.Items.Clear;
  (WR302DM as TWA179FProfiliIterAutDM).QI090.First;
  while Not (WR302DM as TWA179FProfiliIterAutDM).QI090.Eof do
  begin
    cmbAzienda.AddRow((WR302DM as TWA179FProfiliIterAutDM).QI090.FieldByName('AZIENDA').AsString);
    (WR302DM as TWA179FProfiliIterAutDM).QI090.Next;
  end;
  cmbAzienda.Text:=Parametri.Azienda;
  cmbAzienda.Enabled:=Parametri.Azienda = 'AZIN';
  (WDettaglioFM as TWA179FProfiliIterAutDettFM).edtProfilo.Enabled:=True;
  (WDettaglioFM as TWA179FProfiliIterAutDettFM).edtProfilo.Text:=(WR302DM as TWA179FProfiliIterAutDM).selTabella.FieldByName('PROFILO').AsString;

  CreaTabDefault;

end;

procedure TWA179FProfiliIterAut.actNuovoExecute(Sender: TObject);
begin
  //Nuovo profilo
  WA179FNuovoProfilo:=TWA179FNuovoProfiloIterFM.Create(Self);
  (WA179FNuovoProfilo as TWA179FNuovoProfiloIterFM).Azienda:=cmbAzienda.Items[cmbAzienda.ItemIndex].RowData[0];
  (WA179FNuovoProfilo as TWA179FNuovoProfiloIterFM).Iter:=(WDettaglioFM as TWA179FProfiliIterAutDettFM).cmbCodiceIter.Items[(WDettaglioFM as TWA179FProfiliIterAutDettFM).cmbCodiceIter.ItemIndex].RowData[0];
  (WA179FNuovoProfilo as TWA179FNuovoProfiloIterFM).Visualizza;
end;

procedure TWA179FProfiliIterAut.CancellaProfiloIter(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  (WR302DM as TWA179FProfiliIterAutDM).delI075.SetVariable('AZIENDA',cmbAzienda.Items[cmbAzienda.ItemIndex].RowData[0]);
  (WR302DM as TWA179FProfiliIterAutDM).delI075.SetVariable('PROFILO',(WR302DM as TWA179FProfiliIterAutDM).selTabella.FieldByName('PROFILO').AsString);
  (WR302DM as TWA179FProfiliIterAutDM).delI075.Execute;
  (WR302DM as TWA179FProfiliIterAutDM).delI075.Session.Commit;
  WBrowseFM.grdTabella.medpDataSet.Refresh;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
end;

procedure TWA179FProfiliIterAut.actEliminaExecute(Sender: TObject);
begin
  //Cancellazione profilo(CancellaProfiloIter)
  MsgBox.WebMessageDlg('Cancellare il profilo selezionato?',mtConfirmation,[mbYes,mbNo],CancellaProfiloIter,'');
end;

procedure TWA179FProfiliIterAut.actModificaExecute(Sender: TObject);
begin
  //Modifica Profilo
  grdTabControl.ActiveTab:=WDettaglioFM;
  cmbAzienda.Enabled:=False;
  (WDettaglioFM as TWA179FProfiliIterAutDettFM).edtProfilo.ReadOnly:=True;
  (WDettaglioFM as TWA179FProfiliIterAutDettFM).grdIterAutorizzativi.medpModifica(True);
  AbilitaComponenti((WR302DM as TWA179FProfiliIterAutDM).selI075);
end;

procedure TWA179FProfiliIterAut.actAnnullaExecute(Sender: TObject);
begin
  //Annulla profilo
  (WR302DM as TWA179FProfiliIterAutDM).selI075.Cancel;
  AbilitaComponenti((WR302DM as TWA179FProfiliIterAutDM).selI075);
  cmbAzienda.Enabled:=True;
  (WDettaglioFM as TWA179FProfiliIterAutDettFM).cmbCodiceIter.Enabled:=True;
  (WDettaglioFM as TWA179FProfiliIterAutDettFM).grdIterAutorizzativi.medpAggiornaCDS(True);
end;

procedure TWA179FProfiliIterAut.actConfermaExecute(Sender: TObject);
var
  NuovoProfilo:String;
begin
  //Conferma profilo
  (WDettaglioFM as TWA179FProfiliIterAutDettFM).ConfermaGridIter;
  SessioneOracle.ApplyUpdates([(WR302DM as TWA179FProfiliIterAutDM).selI075],True);
  (WDettaglioFM as TWA179FProfiliIterAutDettFM).grdIterAutorizzativi.Visible:=True;
  (WDettaglioFM as TWA179FProfiliIterAutDettFM).grdIterAutorizzativi.medpAggiornaCDS(True);
  AbilitaComponenti((WR302DM as TWA179FProfiliIterAutDM).selI075);
end;

end.
