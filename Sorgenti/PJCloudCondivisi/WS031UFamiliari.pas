unit WS031UFamiliari;

interface

uses
  C180FunzioniGenerali, OracleData,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, A000USessione, A000UInterfaccia,
  Dialogs, DB, System.Actions, meIWImageFile, S031UFamiliariMW, Oracle, IWCompEdit, meIWEdit;

type
  TWS031FFamiliari = class(TWR102FGestTabella)
    actCarica: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actCaricaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject); override;
  private
    procedure selTabellaStateChange(DataSet: TDataSet); Override;
    procedure imgNuovaStoricizzazioneClick(Sender: TObject); Override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
  public
    AbilitaGestioneA154: Boolean;
    function InizializzaAccesso:Boolean; override;
    procedure AggiornaAccessoEScarica(const PId: Integer; const PFilePath: String);
  end;

const
  LIMITE_CARATTERI_NOTE = 100;  // limite di caratteri per le note da visualizzare in tabella
  LIMITE_RIGHE_NOTE     =   4;  // limite di ritorni a capo per le note da visualizzare in tabella

implementation

uses WS031UFamiliariDM,WS031UFamiliariBrowseFM, WS031UFamiliariDettFM;

{$R *.dfm}

function TWS031FFamiliari.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
  DataNasFam: TDateTime;
begin
  Result:=False;
  // seleziona il progressivo corrente se indicato
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  // seleziona il familiare indicato
  DataNasFam:=StrToDateTimeDef(GetParam('DATANAS'),DATE_NULL);
  if DataNasFam <> DATE_NULL then
  begin
    (WR302DM as TWS031FFamiliariDM).selTabella.SearchRecord('DATANAS',DataNasFam,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
  Result:=True;
end;

procedure TWS031FFamiliari.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=True;
  InterfacciaWR102.GestioneStoricizzata:=true;
  WR302DM:=TWS031FFamiliariDM.Create(Self);
  AttivaGestioneC700;
  WBrowseFM:=TWS031FFamiliariBrowseFM.Create(Self);
  WDettaglioFM:=TWS031FFamiliariDettFM.Create(Self);
  (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.SelAnagrafe:=grdC700.selAnagrafe;
  CreaTabDefault;
  actVisioneCorrenteExecute(nil);

  // valuta abilitazione gestione documenti
  AbilitaGestioneA154:=A000GetInibizioni('Tag','76') <> 'N';

end;

procedure TWS031FFamiliari.actCaricaExecute(Sender: TObject);
begin
  inherited;
  (WDettaglioFM as TWS031FFamiliariDettFM).cmbParentela.ItemIndex:=GP_NESSUNO;
  (WDettaglioFM as TWS031FFamiliariDettFM).cmbMatricola.Text:=grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString;
  with (WR302DM as TWS031FFamiliariDM) do
  begin
    SelTabella.AfterScroll:=nil;
    SelTabella.BeforePost:=nil;
    SelTabella.AfterPost:=nil;
    S031FFamiliariMW.CaricaSeStesso;
    SelTabella.Refresh;
    SelTabella.BeforePost:=BeforePost;
    SelTabella.AfterPost:=AfterPost;
    SelTabella.AfterScroll:=AfterScroll;
  end;
  (WR302DM as TWS031FFamiliariDM).selTabella.SearchRecord('GRADOPAR','NS',[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS;
  actCarica.Visible:=False;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWS031FFamiliari.selTabellaStateChange(DataSet: TDataSet);
begin
  actCarica.Enabled:=DataSet.State = dsBrowse;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  if (WDettaglioFM as TWS031FFamiliariDettFM) <> nil then
    with (WDettaglioFM as TWS031FFamiliariDettFM) do
    begin
      AbilitaComponenti;
      // blocca modifica numero ordine in inserimento
      dedtNUMORD.ReadOnly:=DataSet.State = dsInsert;
      // blocca campi anagrafici fissi in fase di storicizzazione
      cmbMatricola.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
      dedtCognome.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
      dedtNome.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
      drgpSesso.Enabled:=InterfacciaWR102.StoricizzazioneInCorso;
      dedtDataNas.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
      dedtComNas.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
      edtDescComNas.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
      dedtCapNas.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
      dedtCodFiscale.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
      dedtDataMat.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
      dchkInserimentoCU.Enabled:=not InterfacciaWR102.StoricizzazioneInCorso;
    end;
  inherited;
end;

procedure TWS031FFamiliari.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  if WDettaglioFM <> nil then
  begin
    if (WR302DM as TWS031FFamiliariDM).selTabella.RecordCount = 0 then
      (WDettaglioFM as TWS031FFamiliariDettFM).Dataset2Componenti;
    (WDettaglioFM as TWS031FFamiliariDettFM).AbilitaComponenti;
  end;
end;

procedure TWS031FFamiliari.actNuovoExecute(Sender: TObject);
begin
  inherited;
  with (WDettaglioFM as TWS031FFamiliariDettFM) do
  begin
    cmbParentela.ItemIndex:=GP_FIGLIO;
    cmbParentelaChange(nil);
  end;
end;

procedure TWS031FFamiliari.AggiornaAccessoEScarica(const PId: Integer; const PFilePath: String);
begin
  (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.C021DM.AggiornaDatiAccesso(PId,Parametri.Operatore);
  actAggiornaExecute(nil);

  // effettua il download del file
  NomeFileGenerato:=PFilePath;
  InviaFileGenerato;
end;

procedure TWS031FFamiliari.imgNuovaStoricizzazioneClick(Sender: TObject);
begin
  inherited;
  with (WDettaglioFM as TWS031FFamiliariDettFM) do
  begin
    AbilitaComponenti;
    // blocca modifica numero ordine in inserimento
    dedtNUMORD.ReadOnly:=(WR302DM as TWS031FFamiliariDM).dsrTabella.State = dsInsert;
    // blocca campi anagrafici fissi in fase di storicizzazione
    cmbMatricola.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
    dedtCognome.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
    dedtNome.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
    drgpSesso.Enabled:=InterfacciaWR102.StoricizzazioneInCorso;
    dedtDataNas.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
    dedtComNas.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
    edtDescComNas.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
    dedtCapNas.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
    dedtCodFiscale.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
    dedtDataMat.ReadOnly:=InterfacciaWR102.StoricizzazioneInCorso;
    dchkInserimentoCU.Enabled:=not InterfacciaWR102.StoricizzazioneInCorso;
  end;
end;

end.
