unit A174UParPianifTurni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  A174UParPianifTurniDtm, ExtCtrls, StdCtrls, Mask, DBCtrls, C180FunzioniGenerali,
  A000USessione, A000UMessaggi , OracleData, C013UCheckList, A000UInterfaccia,
  System.Actions, Vcl.CheckLst, System.ImageList, StrUtils;

type
  TA174FParPianifTurni = class(TR001FGestTab)
    PgCtrlParametri: TPageControl;
    TSheetVisualizzazione: TTabSheet;
    TSheetStampa: TTabSheet;
    lblCodProfilo: TLabel;
    dEdtCodice: TDBEdit;
    pnlTOP: TPanel;
    lblDescProfilo: TLabel;
    dEdtDesc: TDBEdit;
    lblTitolo: TLabel;
    dEdtTitolo: TDBEdit;
    lblDesc1: TLabel;
    dEdtDesc1: TDBEdit;
    dEdtDesc2: TDBEdit;
    lblDesc2: TLabel;
    Label1: TLabel;
    dEdtNotePagina: TDBEdit;
    drgpDettStampa: TDBRadioGroup;
    drgpTipoStampa: TDBRadioGroup;
    grpDatiOpzionali: TGroupBox;
    dChkTotTurni: TDBCheckBox;
    dchkTotTurnoOpe: TDBCheckBox;
    dchkTotCopertura: TDBCheckBox;
    dChkDettOrari: TDBCheckBox;
    dChkTotLiquid: TDBCheckBox;
    dChkAssenze: TDBCheckBox;
    drgpModLavoro: TDBRadioGroup;
    grpOpzioniPianif: TGroupBox;
    dChkPianifGGFest: TDBCheckBox;
    dChkPinifSoloTurnista: TDBCheckBox;
    dChkPianifGGAss: TDBCheckBox;
    dEdtEcludiCaus: TDBEdit;
    lblCauEsclusione: TLabel;
    btnCaus: TButton;
    grpBoxProgressiva: TGroupBox;
    dchkGenera: TDBCheckBox;
    dchkIniziale: TDBCheckBox;
    dchkCorrente: TDBCheckBox;
    dChkRendiOperativa: TDBCheckBox;
    dChkGiustifOperativi: TDBCheckBox;
    grpOrd_Visualizzazione: TGroupBox;
    lstElencoOrd: TListBox;
    lstOrdinamento: TListBox;
    lblListaDati: TLabel;
    lblOrdVis: TLabel;
    grpOrd_Stampa: TGroupBox;
    lstElencoOrdStampa: TListBox;
    lstOrdinamentoStampa: TListBox;
    lblListaDatiStampa: TLabel;
    lblOrdStampa: TLabel;
    dChkRiepNote: TDBCheckBox;
    grpLayout: TGroupBox;
    lblMarginesx: TLabel;
    lblDimFont: TLabel;
    lblNumGG: TLabel;
    lblOPagina: TLabel;
    dEdtMgSx: TDBEdit;
    dEdtDimFont: TDBEdit;
    dEdtNumGG: TDBEdit;
    dCmbOPagina: TDBComboBox;
    dchkRiduciRigheDip: TDBCheckBox;
    dChkRigheNome: TDBCheckBox;
    dChkSeparatoreCol: TDBCheckBox;
    dChkSepratoreRighe: TDBCheckBox;
    dChkSaldiOre: TDBCheckBox;
    dChkToTurnitMese: TDBCheckBox;
    dChkVisOrario: TDBCheckBox;
    dChkStampaReperibilità: TDBCheckBox;
    lblDatoAnag: TLabel;
    dCmbDatoAnag: TDBLookupComboBox;
    grpRicercaSostituto: TGroupBox;
    lblSostDatiElenco: TLabel;
    dedtSostDatiElenco: TDBEdit;
    btnSostDatiElenco: TButton;
    lblSostDatiInizio: TLabel;
    dedtSostDatiInizio: TDBEdit;
    btnSostDatiInizio: TButton;
    lblSostDatiFiltro: TLabel;
    dedtSostDatiFiltro: TDBEdit;
    btnSostDatiFiltro: TButton;
    procedure dCmbOPaginaDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure drgpTipoStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dChkTotTurniClick(Sender: TObject);
    procedure btnCausClick(Sender: TObject);
    procedure drgpDettStampaClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure dchkGeneraClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure drgpModLavoroClick(Sender: TObject);
    procedure lstElencoOrdDblClick(Sender: TObject);
    procedure lstOrdinamentoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstOrdinamentoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lstOrdinamentoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lstOrdinamentoDblClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure lstElencoOrdStampaDblClick(Sender: TObject);
    procedure lstOrdinamentoStampaDblClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure btnDatiClick(Sender: TObject);
  private
    StartingPoint:TPoint;
    procedure Abilitazioni;
    procedure OrdAbilitazioni(Stato:boolean);
  public
    { Public declarations }
  end;

var
  A174FParPianifTurni: TA174FParPianifTurni;

  procedure OpenA174ParPianifTurni(Profilo:String = '');

implementation

{$R *.dfm}

procedure OpenA174ParPianifTurni(Profilo:String = '');
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA174ParPianifTurni') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A174FParPianifTurni:=TA174FParPianifTurni.Create(nil);
  try
    A174FParPianifTurniDtm:=TA174FParPianifTurniDtm.Create(nil);
    if Trim(Profilo) <> '' then
      A174FParPianifTurniDtm.selT082.SearchRecord('CODICE',Profilo,[srFromBeginning]);
    A174FParPianifTurni.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A174FParPianifTurni);
    FreeAndNil(A174FParPianifTurniDtm);
  end;
end;

procedure TA174FParPianifTurni.OrdAbilitazioni(Stato:boolean);
begin
  lstElencoOrd.Enabled:=Stato;
  lstOrdinamento.Enabled:=Stato;
  lstElencoOrdStampa.Enabled:=Stato;
  lstOrdinamentoStampa.Enabled:=Stato;
end;

procedure TA174FParPianifTurni.actRefreshExecute(Sender: TObject);
begin
  inherited;
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_VIS',A174FParPianifTurni.lstOrdinamento.Items);
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_STAMPA',A174FParPianifTurni.lstOrdinamentoStampa.Items);
end;

procedure TA174FParPianifTurni.btnCausClick(Sender: TObject);
begin
  inherited;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with TOracleDataSet.Create(Self) do
    try
      Session:=SessioneOracle;
      SQL.Add(A174FParPianifTurniDtm.A174MW.SqlCausali);
      Open;
      C013FCheckList.clbListaDati.Items.Clear;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s',[FieldByName('CODICE').AsString]) + ' ' +
                                                             FieldByName('DESCRIZIONE').AsString);
        Next;
      end;
      R180PutCheckList(A174FParPianifTurniDtm.selT082.FieldByName('CAUS_ECLUDITURNO').AsString,5,C013FCheckList.clbListaDati);
      C013FCheckList.ShowModal;
    finally
      if A174FParPianifTurniDtm.selT082.State in [dsInsert,dsEdit] then
        A174FParPianifTurniDtm.selT082.FieldByName('CAUS_ECLUDITURNO').AsString:=Trim(R180GetCheckList(5,C013FCheckList.clbListaDati));
      FreeAndNil(C013FCheckList);
      Free;
    end;
end;

procedure TA174FParPianifTurni.btnDatiClick(Sender: TObject);
var i:Integer;
    sCampiSel:String;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    sCampiSel:=IfThen(Sender = btnSostDatiElenco,A174FParPianifTurniDtm.selT082.FieldByName('SOST_DATI_ELENCO').AsString,
               IfThen(Sender = btnSostDatiInizio,A174FParPianifTurniDtm.selT082.FieldByName('SOST_DATI_INIZIO').AsString,
               IfThen(Sender = btnSostDatiFiltro,A174FParPianifTurniDtm.selT082.FieldByName('SOST_DATI_FILTRO').AsString)));
    clbListaDati.Items.Clear;
    clbListaDati.Items.Assign(A174FParPianifTurniDtm.A174MW.ListaCols);
    R180PutCheckList(sCampiSel,40,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
    begin
      //Elenco dei campi selezionati
      sCampiSel:=R180GetCheckList(40,C013FCheckList.clbListaDati);
      if Sender = btnSostDatiElenco then
        A174FParPianifTurniDtm.selT082.FieldByName('SOST_DATI_ELENCO').AsString:=sCampiSel
      else if Sender = btnSostDatiInizio then
        A174FParPianifTurniDtm.selT082.FieldByName('SOST_DATI_INIZIO').AsString:=sCampiSel
      else if Sender = btnSostDatiFiltro then
        A174FParPianifTurniDtm.selT082.FieldByName('SOST_DATI_FILTRO').AsString:=sCampiSel;
    end;
  finally
    Release;
  end;
end;

procedure TA174FParPianifTurni.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if Field = nil then
    Abilitazioni;
end;

procedure TA174FParPianifTurni.dchkGeneraClick(Sender: TObject);
begin
  inherited;
  if (DButton.State in [dsInsert,dsEdit]) and dchkGenera.Checked then
    DButton.DataSet.FieldByName('INIZIALE').AsString:='S';
end;

procedure TA174FParPianifTurni.dChkTotTurniClick(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TA174FParPianifTurni.dCmbOPaginaDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  if Control = dCmbOPagina then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A174FParPianifTurniDtm.A174MW.Orientamento[Index].Item);
end;

procedure TA174FParPianifTurni.Abilitazioni;
begin
  btnSostDatiElenco.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnSostDatiInizio.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnSostDatiFiltro.Enabled:=DButton.State in [dsEdit,dsInsert];

  dChkRendiOperativa.Visible:=drgpModLavoro.ItemIndex = 1;

  dChkRiduciRigheDip.Enabled:=not dChkRigheNome.Checked;
  if (not dChkRiduciRigheDip.Enabled) and (DButton.State in [dsEdit,dsInsert]) then
    dChkRiduciRigheDip.Field.AsString:='N';

  dChkRigheNome.Enabled:=not dChkRiduciRigheDip.Checked;
  if (not dChkRigheNome.Enabled) and (DButton.State in [dsEdit,dsInsert]) then
    dChkRigheNome.Field.AsString:='N';

  dEdtEcludiCaus.Enabled:=drgpTipoStampa.ItemIndex = 1;
  btnCaus.Enabled:=dEdtEcludiCaus.Enabled and (DButton.State in [dsEdit,dsInsert]);

  dChkVisOrario.Enabled:=drgpDettStampa.ItemIndex = 0;
  if (not dChkVisOrario.Enabled) and (DButton.State in [dsEdit,dsInsert]) then
    dChkVisOrario.Field.AsString:='N';

  dChkTotLiquid.Enabled:=drgpTipoStampa.ItemIndex = 1;
  if (not dChkTotLiquid.Enabled) and (DButton.State in [dsEdit,dsInsert]) then
    dChkTotLiquid.Field.AsString:='N';

  dchkTotTurnoOpe.Enabled:=dChkTotTurni.Checked;
  if (not dchkTotTurnoOpe.Enabled) and (DButton.State in [dsEdit,dsInsert]) then
    dchkTotTurnoOpe.Field.AsString:='N';
end;

procedure TA174FParPianifTurni.drgpTipoStampaClick(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TA174FParPianifTurni.drgpDettStampaClick(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TA174FParPianifTurni.drgpModLavoroClick(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TA174FParPianifTurni.FormActivate(Sender: TObject);
begin
  inherited;
  dCmbDatoAnag.ListSource:=A174FParPianifTurniDtm.A174MW.dsrI010;
  R180SetComboItemsValues(dCmbOPagina.Items,A174FParPianifTurniDtm.A174MW.Orientamento,'V');
end;

procedure TA174FParPianifTurni.FormShow(Sender: TObject);
begin
  inherited;
  dChkRiepNote.Visible:=False; //Nascosto per ristrutturazione pianificazione turni. Se nessuno lo reclama, eliminare
  pgctrlParametri.ActivePageIndex:=0;
  grpBoxProgressiva.Visible:=Parametri.CampiRiferimento.C11_PianifOrariProg = 'S';
  //Visualizzazione tabellone
  A174FParPianifTurniDtm.A174MW.CaricaListaDatiOrdinamento(lstElencoOrd.Items);
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_VIS',A174FParPianifTurni.lstOrdinamento.Items);
  //Stampa tabellone
  A174FParPianifTurniDtm.A174MW.CaricaListaDatiOrdinamento(lstElencoOrdStampa.Items);
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_STAMPA',A174FParPianifTurni.lstOrdinamentoStampa.Items);
  OrdAbilitazioni(False);
end;

procedure TA174FParPianifTurni.lstElencoOrdDblClick(Sender: TObject);
begin
  inherited;
  if lstOrdinamento.Items.IndexOf(lstElencoOrd.Items[lstElencoOrd.ItemIndex]) < 0 then
    lstOrdinamento.Items.Add(lstElencoOrd.Items[lstElencoOrd.ItemIndex]);
end;

procedure TA174FParPianifTurni.lstElencoOrdStampaDblClick(Sender: TObject);
begin
  inherited;
  if lstOrdinamentoStampa.Items.IndexOf(lstElencoOrdStampa.Items[lstElencoOrdStampa.ItemIndex]) < 0 then
    lstOrdinamentoStampa.Items.Add(lstElencoOrdStampa.Items[lstElencoOrdStampa.ItemIndex]);
end;

procedure TA174FParPianifTurni.lstOrdinamentoDblClick(Sender: TObject);
begin
  inherited;
  lstOrdinamento.Items.Delete(lstOrdinamento.ItemIndex);
end;

procedure TA174FParPianifTurni.lstOrdinamentoDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  DropPosition,StartPosition:Integer;
  DropPoint:TPoint;
begin
  inherited;
  DropPoint.X:=X;
  DropPoint.Y:=Y;
  with Source as TListBox do
  begin
    StartPosition:=ItemAtPos(StartingPoint,True);
    DropPosition:=ItemAtPos(DropPoint,True);
    Items.Move(StartPosition,DropPosition);
  end;
end;

procedure TA174FParPianifTurni.lstOrdinamentoDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept:=(Source = lstOrdinamento) or (Source = lstOrdinamentoStampa);
end;

procedure TA174FParPianifTurni.lstOrdinamentoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  StartingPoint.X:=X;
  StartingPoint.Y:=Y;
end;

procedure TA174FParPianifTurni.lstOrdinamentoStampaDblClick(Sender: TObject);
begin
  inherited;
  lstOrdinamentoStampa.Items.Delete(lstOrdinamentoStampa.ItemIndex);
end;

procedure TA174FParPianifTurni.TAnnullaClick(Sender: TObject);
begin
  inherited;
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_VIS',A174FParPianifTurni.lstOrdinamento.Items);
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_STAMPA',A174FParPianifTurni.lstOrdinamentoStampa.Items);
  OrdAbilitazioni(False);
end;

procedure TA174FParPianifTurni.TInserClick(Sender: TObject);
begin
  inherited;
  OrdAbilitazioni(True);
end;

procedure TA174FParPianifTurni.TModifClick(Sender: TObject);
begin
  inherited;
  OrdAbilitazioni(True);
end;

procedure TA174FParPianifTurni.TRegisClick(Sender: TObject);
begin
  inherited;
  OrdAbilitazioni(False);
end;

end.
