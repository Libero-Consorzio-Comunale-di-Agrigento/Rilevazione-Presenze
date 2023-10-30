unit WA110USoglieRimborsiPastoFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR203UGestDetailFM, ActnList, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  OracleData, Db, WA110UParametriConteggioDM, IWCompListbox, meIWComboBox,
  C190FunzioniGeneraliWeb, IWCompEdit, meIWEdit, C180FunzioniGenerali,
  medpIWMessageDlg, IWCompLabel, meIWLabel, WR100UBase, A000UInterfaccia,
  System.Actions, Vcl.Menus;

const
  NUOVA_DECORRENZA = 'Nuova';       //Numero massimo di fasce nel Mese

type
  TWA110FSoglieRimborsiPastoFM = class(TWR203FGestDetailFM)
    cmbDecorrenza: TmeIWComboBox;
    edtDecorrenza: TmeIWEdit;
    lblDecorrenza: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    procedure cmbDecorrenzaChange(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    Storicizzazione: Boolean;
    procedure CaricaComboDecorrenza;
    procedure PosizionaComboDecorrenza(Val: String);
    procedure ResultIntersezione(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    procedure ImpostaDescrizione;
    procedure AggiornaScaglioni;
    { Private declarations }
  protected
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String); override;
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
    procedure AggiornaDettaglio; override;
  end;

implementation
uses WA110UParametriConteggio, WA110UParametriConteggioDettFM;

{$R *.dfm}

{ TWA110FSoglieRimborsiPastoFM }

procedure TWA110FSoglieRimborsiPastoFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpOrdinamentoColonne:=True;
end;

procedure TWA110FSoglieRimborsiPastoFM.CaricaComboDecorrenza;
var
  B1: TBookmark;
  Decorrenza: TDateTime;
  i: Integer;
begin
  //devo ricaricare la combo senza però scatenare eventi scroll
  //che reimposterebbero selM013_2.
  //SelDistM013 è sicronizzato con selTabella nel datamodulo (gestione master/detail)
  //il posizionamento su SelDistM013 scatena caricamento selM013_2
  with (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW do
  begin
    B1:=selDistM013.GetBookmark;
	  try
      Decorrenza:=selDistM013.FieldByName('DECORRENZA').AsDateTime;
      selDistM013.AfterScroll:=nil;
      selDistM013.First;
      cmbDecorrenza.Clear;
      while not selDistM013.Eof do
      begin
        i:=cmbDecorrenza.Items.Add(DateToStr(selDistM013.FieldByName('DECORRENZA').AsDateTime));
        if selDistM013.FieldByName('DECORRENZA').AsDateTime = Decorrenza then
           cmbDecorrenza.ItemIndex:=i;
        selDistM013.Next;
      end;
      if cmbDecorrenza.Items.Count = 0 then
      begin
        i:=cmbDecorrenza.Items.Add('');
        cmbDecorrenza.ItemIndex:=i;
      end;
      
      //aggiungo elemento fittizio
      i:=cmbDecorrenza.Items.Add(NUOVA_DECORRENZA);
      
      if selDistM013.BookmarkValid(B1) then
        selDistM013.GotoBookMark(B1);
	  finally
      selDistM013.FreeBookmark(B1);
	  end;
    selDistM013.AfterScroll:=selDistM013AfterScroll;
  end;
end;

procedure TWA110FSoglieRimborsiPastoFM.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  if cmbDecorrenza.Items[cmbDecorrenza.ItemIndex] = NUOVA_DECORRENZA then
  begin
   with (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW do
   begin
    //posiziono la combo sull'ultima decorrenza
    selDistM013.Last;
    PosizionaComboDecorrenza(selDistM013.FieldByName('DECORRENZA').AsString);
   end;
  end;

  //Ricarico in modo da visualizzare correttamente cmbDecorrenza e editDecorrenza
  cmbDecorrenzaChange(nil);
end;

procedure TWA110FSoglieRimborsiPastoFM.actConfermaExecute(Sender: TObject);
var Data: TDateTime;
  Msg, Decorrenza: String;
begin
  if edtDecorrenza.Visible then
    Decorrenza:=edtDecorrenza.Text
  else
    Decorrenza:=cmbDecorrenza.Text;

  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    Msg:=(WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW.ControlloDecorrenze(Decorrenza,Storicizzazione);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultIntersezione,'PUNTO_1');
      Abort;
    end;
  end;

  inherited;
  with (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW do
  begin
    AggiornaDecorrenze(StrToDate(Decorrenza),Storicizzazione);
    //mi riposiono sulla decorrenza
    //per nuova decorrenza è stata appena inserita;
    //in modifica potrebbe essere stata cambiata
    //in nuovo elemento non è cambiata
    selDistM013.Refresh;
    if edtDecorrenza.Visible then
      Data:=strToDate(edtDecorrenza.Text)
    else
      Data:=strToDate(cmbDecorrenza.Text);
    selDistM013.SearchRecord('DECORRENZA',Data,[srFromBeginning]);
    CaricaComboDecorrenza;
    //Ricarico in modo da visualizzare correttamente cmbDecorrenza e editDecorrenza
    cmbDecorrenzaChange(nil);
  end;
  MsgBox.ClearKeys;
  AggiornaScaglioni;
end;

procedure TWA110FSoglieRimborsiPastoFM.ResultIntersezione(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    actConfermaExecute(nil)
  else
    MsgBox.ClearKeys;
end;

procedure TWA110FSoglieRimborsiPastoFM.actModificaExecute(Sender: TObject);
begin
  inherited;
  Storicizzazione:=False;
  //Elemento Fittizio per nuova decorrenza
  edtDecorrenza.Visible:=True;
  cmbDecorrenza.Enabled:=False;
  edtDecorrenza.Text:=cmbDecorrenza.Text;
end;

procedure TWA110FSoglieRimborsiPastoFM.actNuovoExecute(Sender: TObject);
begin
  inherited;
  if cmbDecorrenza.Items[cmbDecorrenza.ItemIndex] = NUOVA_DECORRENZA then
    Storicizzazione:=True //creazione nuova decorrenza
  else
    Storicizzazione:=False; //inserimento elemento all'interno di una decorrenza
end;

procedure TWA110FSoglieRimborsiPastoFM.PosizionaComboDecorrenza(Val:String);
var
  I: Integer;
begin
  for I:=0 to cmbDecorrenza.Items.Count - 1 do
  begin
    if cmbDecorrenza.items[i] = Val then
    begin
      cmbDecorrenza.ItemIndex:=i;
      Break;
    end;
  end;
end;

procedure TWA110FSoglieRimborsiPastoFM.ResultDelete(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  inherited;
  with (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW do
  begin
    if selM013_2.RecordCount = 0 then
    begin
      //Ho cancellato l'ultimo elemento della decorrenza.
      //Mi posiziono sull' ultima decorrenza e ricarico la combo
      selDistM013.Refresh;
      selDistM013.Last;
      CaricaComboDecorrenza;
      CmbDecorrenzaChange(nil);
      //Allineamento decorrenze
      UpdM013Decorrenza.Execute;
      SessioneOracle.Commit;
    end;
  end;
  AggiornaScaglioni;
end;

procedure TWA110FSoglieRimborsiPastoFM.AggiornaScaglioni;
begin
  //aggiorno grid scaglioni
  with ((Self.Owner as TWA110FParametriConteggio).WDettaglioFM as TWA110FParametriConteggioDettFM) do
  begin
    grdScaglioni.medpDataSet.Refresh;
    grdScaglioni.medpAggiornaCDS(True);
  end;
end;

procedure TWA110FSoglieRimborsiPastoFM.AggiornaDettaglio;
begin
  CaricaComboDecorrenza;
  CmbDecorrenzaChange(nil);
  ImpostaDescrizione;
  inherited;
end;

procedure TWA110FSoglieRimborsiPastoFM.ImpostaDescrizione;
begin
  with (WR302DM as TWA110FParametriConteggioDM) do
    lblDescrizione.Caption:='Codice: ' + selTabella.FieldByName('CODICE').AsString + ' Tipo missione: ' +selTabella.FieldByName('TIPO_MISSIONE').AsString;
end;

procedure TWA110FSoglieRimborsiPastoFM.CaricaDettaglio(DataSet: TDataSet;
  DataSource: TDataSource);
begin
  CaricaComboDecorrenza;
  edtDecorrenza.Visible:=False;
  cmbDecorrenza.Enabled:=True;
  ImpostaDescrizione;

  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('SOGLIA_GG'),0,DBG_EDT,'input_hour_hhmm','CAMBIADATO','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('RIMBORSO_MAX'),0,DBG_EDT,'input_num_generic','CAMBIADATO','','','D');
  CmbDecorrenzaChange(nil);
end;

procedure TWA110FSoglieRimborsiPastoFM.cmbDecorrenzaChange(Sender: TObject);
var
  Data: TDateTime;
begin
  inherited;
  with (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW do
  begin
    if cmbDecorrenza.Items[cmbDecorrenza.ItemIndex] = NUOVA_DECORRENZA then
    begin
      //Elemento Fittizio per nuova decorrenza
      edtDecorrenza.Visible:=True;
      cmbDecorrenza.Enabled:=False;
      selDistM013.SearchRecord('DECORRENZA',DATE_NULL,[srFromBeginning]);
      OpenselM013_2_NuovaDecorrenza;
      grdTabella.medpAggiornaCDS(True);
      actNuovoExecute(nil);
    end
    else
    begin
      edtDecorrenza.Visible:=False;
      cmbDecorrenza.Enabled:=True;
      if cmbDecorrenza.Text = '' then //se non ci sono decorrenze blocco toolbar
      begin
        actNuovo.Enabled:=False;
        actModifica.Enabled:=False;
        actElimina.Enabled:=False;
        TWR100FBase(Self.Owner).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
      end;
      if tryStrToDate(cmbDecorrenza.Items[cmbDecorrenza.ItemIndex],Data) then
        selDistM013.SearchRecord('DECORRENZA',Data,[srFromBeginning]);
      grdTabella.medpAggiornaCDS(True);
    end;
  end;
end;

end.
