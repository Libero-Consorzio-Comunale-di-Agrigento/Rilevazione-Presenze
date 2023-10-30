unit A106UDistanzeTrasferta;

interface

uses
  C015UElencoValori, C019UDistanziometro,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, Grids, DBGrids, StdCtrls, ExtCtrls, Mask, DBCtrls,
  ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  A000UCostanti, A000USessione, A000UInterfaccia, L001Call, C180FunzioniGenerali,
  System.Actions, OracleData, Vcl.Buttons;

type
  TA106FDistanzeTrasferta = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblCodice1: TLabel;
    lblCap1: TLabel;
    lblProv1: TLabel;
    lBlCodice2: TLabel;
    lblCap2: TLabel;
    lblProv2: TLabel;
    dCmbLocalita1: TDBLookupComboBox;
    dCmbLocalita2: TDBLookupComboBox;
    dEdtCodice1: TDBEdit;
    dEdtCap1: TDBEdit;
    dEdtProv1: TDBEdit;
    dEdtCodice2: TDBEdit;
    dEdtCap2: TDBEdit;
    dEdtProv2: TDBEdit;
    dRgpTipo1: TDBRadioGroup;
    dRgpTipo2: TDBRadioGroup;
    dCmbComune1: TDBLookupComboBox;
    dCmbComune2: TDBLookupComboBox;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    PnlDistanze: TPanel;
    dGrdDistanze: TDBGrid;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    btnCalcolaDistanze: TButton;
    actCalcolaDistanze: TAction;
    pmnSelezione: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    btnConfermaKMAuto: TBitBtn;
    actConfermaCalcolaDistanze: TAction;
    actAnnullaCalcolaDistanze: TAction;
    btnAnnullaKMAuto: TBitBtn;
    N4: TMenuItem;
    mnuCopiaExcel: TMenuItem;
    dedtCitta1: TDBEdit;
    dedtCitta2: TDBEdit;
    lblCitta1: TLabel;
    lblCitta2: TLabel;
    procedure dGrdDistanzeTitleClick(Column: TColumn);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dRgpTipo2Change(Sender: TObject);
    procedure dRgpTipo1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actCalcolaDistanzeExecute(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure actConfermaCalcolaDistanzeExecute(Sender: TObject);
    procedure actAnnullaCalcolaDistanzeExecute(Sender: TObject);
    procedure mnuCopiaExcelClick(Sender: TObject);
  private
    procedure SetModalitaCalcoloKm(const PAttiva: Boolean);
  end;

var
  A106FDistanzeTrasferta: TA106FDistanzeTrasferta;
  procedure OpenA106DistanzeTrasferta;

implementation

uses A106UDistanzeTrasfertaDTM;

{$R *.dfm}

procedure OpenA106DistanzeTrasferta;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA106DistanzeTrasferta') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A106FDistanzeTrasferta:=TA106FDistanzeTrasferta.Create(nil);
  A106FDistanzeTrasfertaDtM:=TA106FDistanzeTrasfertaDTM.Create(nil);
  try
    A106FDistanzeTrasferta.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A106FDistanzeTrasferta.Free;
    A106FDistanzeTrasfertaDtM.Free;
  end;
end;

procedure TA106FDistanzeTrasferta.dRgpTipo1Change(Sender: TObject);
begin
  with A106FDistanzeTrasfertaDTM do
  begin
    //Ripulisco tutti i campi
    if DButton.state in [dsInsert,dsEdit] then
    begin
      dCmbLocalita1.KeyValue:='';
      dEdtCodice1.Field.Clear;
    end;
    if dRgpTipo1.Value='C' then
    begin
      dCmbLocalita1.DataSource:=nil;
      dCmbLocalita1.Visible:=False;
      dCmbComune1.DataSource:=DButton;
      dCmbComune1.Visible:=True;
      dEdtCap1.Visible:=True;
      lblCap1.Visible:=True;
      dEdtProv1.Visible:=True;
      lblProv1.Visible:=True;
      lBlCodice1.Caption:='Codice Istat';
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
      lblCitta1.Visible:=False;
      dedtCitta1.Visible:=False;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
    end
    else if dRgpTipo1.Value='P' then
    begin
      dCmbComune1.DataSource:=nil;
      dCmbComune1.Visible:=False;
      dCmbLocalita1.DataSource:=DButton;
      dCmbLocalita1.Visible:=True;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
      {
      dEdtCap1.Visible:=False;
      lblCap1.Visible:=False;
      dEdtProv1.Visible:=False;
      lblProv1.Visible:=False;
      }
      dEdtCap1.Visible:=True;
      lblCap1.Visible:=True;
      dEdtProv1.Visible:=True;
      lblProv1.Visible:=True;
      lblCitta1.Visible:=True;
      dedtCitta1.Visible:=True;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
      lBlCodice1.Caption:='Codice';
    end;
  end;
end;

procedure TA106FDistanzeTrasferta.dRgpTipo2Change(Sender: TObject);
begin
  inherited;
  with A106FDistanzeTrasfertaDTM do
  begin
    //Ripulisco tutti i campi
    if DButton.state in [dsInsert,dsEdit] then
    begin
      dCmbLocalita2.KeyValue:='';
      dEdtCodice2.Field.Clear;
    end;
    if dRgpTipo2.Value='C' then
    begin
      dCmbLocalita2.DataSource:=nil;
      dCmbLocalita2.Visible:=False;
      dCmbComune2.DataSource:=DButton;
      dCmbComune2.Visible:=True;
      dEdtCap2.Visible:=True;
      lblCap2.Visible:=True;
      dEdtProv2.Visible:=True;
      lblProv2.Visible:=True;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
      lblCitta2.Visible:=False;
      dedtCitta2.Visible:=False;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
      lBlCodice2.Caption:='Codice Istat';
    end
    else if dRgpTipo2.Value='P' then
    begin
      dCmbComune2.DataSource:=nil;
      dCmbComune2.Visible:=False;
      dCmbLocalita2.DataSource:=DButton;
      dCmbLocalita2.Visible:=True;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
      {
      dEdtCap2.Visible:=False;
      lblCap2.Visible:=False;
      dEdtProv2.Visible:=False;
      lblProv2.Visible:=False;
      }
      dEdtCap2.Visible:=True;
      lblCap2.Visible:=True;
      dEdtProv2.Visible:=True;
      lblProv2.Visible:=True;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
      lblCitta2.Visible:=True;
      dedtCitta2.Visible:=True;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
      lBlCodice2.Caption:='Codice';
    end;
  end;
end;

procedure TA106FDistanzeTrasferta.FormActivate(Sender: TObject);
begin
  inherited;
  dCmbComune1.Top:=dCmbLocalita1.Top;
  dCmbComune2.Top:=dCmbLocalita2.Top;
  DButton.DataSet:=A106FDistanzeTrasfertaDTM.SelM041;
end;

procedure TA106FDistanzeTrasferta.FormShow(Sender: TObject);
begin
  inherited;
  // nasconde inizialmente la colonna km proposti
  dGrdDistanze.Columns[7].Visible:=False;

  with A106FDistanzeTrasfertaDTM.A106FDistanzeTrasfertaMW do
  begin
    dCmbComune1.ListSource:=dsrSelT480;
    dCmbComune2.ListSource:=dsrSelT480;
    dCmbLocalita1.ListSource:=dsrSelM042;
    dCmbLocalita2.ListSource:=dsrSelM042;

    actCalcolaDistanze.Visible:=EseguiCalcoloDistanze;
    actConfermaCalcolaDistanze.Visible:=EseguiCalcoloDistanze;
    actAnnullaCalcolaDistanze.Visible:=EseguiCalcoloDistanze;
    btnCalcolaDistanze.Visible:=EseguiCalcoloDistanze;
  end;
end;

procedure TA106FDistanzeTrasferta.mnuCopiaExcelClick(Sender: TObject);
var
  BM: TBookmark;
begin
  dGrdDistanze.DataSource.DataSet.AfterScroll:=nil;
  BM:=dGrdDistanze.DataSource.DataSet.GetBookmark;
  try
    R180DBGridCopyToClipboard(dGrdDistanze,True);
    if dGrdDistanze.DataSource.DataSet.BookmarkValid(BM) then
      dGrdDistanze.DataSource.DataSet.GotoBookmark(BM);
  finally
    dGrdDistanze.DataSource.DataSet.AfterScroll:=A106FDistanzeTrasfertaDTM.SelM041BAfterScroll;
    dGrdDistanze.DataSource.DataSet.FreeBookmark(BM);
  end;
end;

procedure TA106FDistanzeTrasferta.SetModalitaCalcoloKm(const PAttiva: Boolean);
begin
  // disabilita pulsanti di conferma / annulla
  actCalcolaDistanze.Enabled:=not PAttiva;
  actConfermaCalcolaDistanze.Enabled:=PAttiva;
  actAnnullaCalcolaDistanze.Enabled:=PAttiva;

  // visualizza / nasconde colonna km proposti
  dGrdDistanze.Columns[7].Visible:=PAttiva;
  //dGrdDistanze.ReadOnly:=PAttiva;

  // imposta il readonly del dataset
  (DButton.DataSet as TOracleDataSet).ReadOnly:=PAttiva;

  // abilita / disabilita interfaccia di gestione singolo record
  Panel1.Enabled:=not PAttiva;
end;

procedure TA106FDistanzeTrasferta.DButtonStateChange(Sender: TObject);
begin
  inherited;
  PnlDistanze.Enabled:=DButton.State = dsBrowse;
  actCalcolaDistanze.Enabled:=DButton.State = dsBrowse;
  if actCalcolaDistanze.Enabled then
  begin
    actConfermaCalcolaDistanze.Enabled:=False;
    actAnnullaCalcolaDistanze.Enabled:=False;
  end;
end;

// AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
procedure TA106FDistanzeTrasferta.Nuovoelemento1Click(Sender: TObject);
var
{
  Griglia:TInserisciDLL;
  i:integer;
}
  vCodice: Variant;
begin
  {
  with A106FDistanzeTrasfertaDTM.A106FDistanzeTrasfertaMW.SelM042 do
  begin
    Griglia.NomeTabella:='M042_LOCALITA';
    Griglia.Titolo:='Località trasferta';
    for i:=0 to FieldCount - 1 do
    begin
      Griglia.Display[i]:=Fields[i].DisplayLabel;
      Griglia.Size[i]:=Fields[i].DisplayWidth;
    end;
    Inserisci(Griglia,dcmbLocalita1.Text);
    Refresh;
  end;
  }
  vCodice:=dcmbLocalita1.KeyValue;
  OpenC015FElencoValori('M042_LOCALITA','<A106> Località personalizzate','','CODICE',vCodice,A106FDistanzeTrasfertaDTM.A106FDistanzeTrasfertaMW.selM042Edit,550,350,False);
  A106FDistanzeTrasfertaDTM.A106FDistanzeTrasfertaMW.SelM042.Refresh;
end;
// AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine

procedure TA106FDistanzeTrasferta.Selezionatutto1Click(Sender: TObject);
begin
  if pmnSelezione.PopupComponent = dgrdDistanze then
  begin
    // gestione selezione righe tabella
    dgrdDistanze.SelectedRows.Clear;
    with (dgrdDistanze.DataSource.DataSet as TOracleDataSet) do
    begin
      AfterScroll:=nil;
      DisableControls;
      First;
      try
        while not Eof do
        begin
          if Sender = SelezionaTutto1 then
            dgrdDistanze.SelectedRows.CurrentRowSelected:=True
          else if Sender = DeselezionaTutto1 then
            dgrdDistanze.SelectedRows.CurrentRowSelected:=False
          else if Sender = InvertiSelezione1 then
            dgrdDistanze.SelectedRows.CurrentRowSelected:=not dgrdDistanze.SelectedRows.CurrentRowSelected;
          Next;
        end;
      finally
        AfterScroll:=A106FDistanzeTrasfertaDTM.SelM041BAfterScroll;
        First;
        EnableControls;
      end;
    end;
  end;
end;

procedure TA106FDistanzeTrasferta.dGrdDistanzeTitleClick(Column: TColumn);
var
  sCampo, sOrder, sNewOrder, sOldOrder:string;
  i:integer;
begin
  sNewOrder:='';
  with A106FDistanzeTrasfertaDTM do
  begin
    sOldOrder:=SelM041B.GetVariable('ORDERBY');
    sCampo:=Column.FieldName;
    for i:=0 to dGrdDistanze.Columns.Count-1 do
    begin
      if dGrdDistanze.Columns[i].FieldName<>Column.FieldName then
        sNewOrder:=sNewOrder + ',' + dGrdDistanze.Columns[i].FieldName + ' ASC';
    end;
    sOrder:='ORDER BY ' + sCampo + ' ASC' + sNewOrder;
    if sOrder=sOldOrder then
      sOrder:='ORDER BY ' + sCampo + ' DESC' + sNewOrder;
    SelM041B.Close;
    SelM041B.ClearVariables;
    SelM041B.SetVariable('ORDERBY',sOrder);
    SelM041B.Open;
  end;
end;

// calcolo automatico distanze km con webservice di google.ini
procedure TA106FDistanzeTrasferta.actCalcolaDistanzeExecute(Sender: TObject);
var
  ParOrig, ParDest, Errore: String;
  i, Dist: Integer;
  BookmarkList: TBookmarkList;
  BM: TBookmark;
  DS: TOracleDataSet;
begin
  // azione non disponibile se il dataset legato alla tabella non è in browse
  if dgrdDistanze.DataSource.State <> dsBrowse then
    Exit;

  // determina numero righe selezionate e richiede conferma all'utente
  BookmarkList:=dgrdDistanze.SelectedRows;
  if R180MessageBox('Attenzione!'#13#10 +
                    'Il calcolo automatico delle distanze utilizza'#13#10 +
                    'un servizio web.'#13#10 +
                    'In funzione del numero di righe selezionate,'#13#10 +
                    'l''operazione potrebbe impiegare molto tempo.'#13#10 +
                    'Vuoi continuare?',DOMANDA) = mrNo then
  begin
    Exit;
  end;

  // avvia operazione
  Screen.Cursor:=crHourGlass;

  // ciclo sulle righe selezionate in tabella per effettuare il calcolo delle distanze km
  // attraverso un webservice esterno
  // N.B.: il ricalcolo viene effettuato solo sulle distanze per cui è possibile
  //       stabilire sia il comune di partenza che di destinazione
  DS:=A106FDistanzeTrasfertaDTM.SelM041B;

  // salva la posizione corrente
  BM:=DS.GetBookmark;
  try
    // filtra le sole righe che indicano distanze da comune a comune
    DS.DisableControls;
    DS.First;

    // scorre tutte le distanze da comune a comune per determinarne il num. di km in modo automatico
    for i:=0 to BookmarkList.Count - 1 do
    begin
      DS.GotoBookmark(BookmarkList[i]);

      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
      // se per entrambe le località è indicato il comune effettua il calcolo della distanza
      {
      if (DS.FieldByName('TIPO1').AsString = 'C') and
         (DS.FieldByName('TIPO2').AsString = 'C') then
      }
      if (DS.FieldByName('CITTA1').AsString <> '') and
         (DS.FieldByName('CITTA2').AsString <> '') then
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
      begin
        // AOSTA_REGIONE - chiamata 82052.ini
        // riconoscimento non corretto delle distanze dovuto alle ambiguità intrinseche del nome del comune
        // è stato aggiunto il cap del comune per discriminare
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
        {
        ParOrig:=TC019FDistanziometro.FormattaLocalita(DS.FieldByName('DESC_PARTENZA').AsString,
                                                       DS.FieldByName('CAP1').AsString,
                                                       DS.FieldByName('PROV1').AsString);
        ParDest:=TC019FDistanziometro.FormattaLocalita(DS.FieldByName('DESC_DESTINAZIONE').AsString,
                                                       DS.FieldByName('CAP2').AsString,
                                                       DS.FieldByName('PROV2').AsString);
        }
        ParOrig:=TC019FDistanziometro.FormattaLocalita(DS.FieldByName('CITTA1').AsString,
                                                       DS.FieldByName('CAP1').AsString,
                                                       DS.FieldByName('PROV1').AsString);
        ParDest:=TC019FDistanziometro.FormattaLocalita(DS.FieldByName('CITTA2').AsString,
                                                       DS.FieldByName('CAP2').AsString,
                                                       DS.FieldByName('PROV2').AsString);
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
        // AOSTA_REGIONE - chiamata 82052.fine

        Dist:=TC019FDistanziometro.GetDistanza(ParOrig,ParDest,Errore,Parametri.CampiRiferimento.C33_ProxyServer);
        if Dist > 0 then
        begin
          Dist:=Trunc(R180Arrotonda(Dist/1000,1,'P'));
          DS.Edit;
          //FieldByName('CHILOMETRI').AsInteger:=Dist;
          DS.FieldByName('KM_PROPOSTI').AsInteger:=Dist;
          DS.Post;
        end;
      end;
    end;
    // ritorna al record iniziale
    if DS.BookmarkValid(BM) then
      DS.GotoBookmark(BM);
  finally
    DS.FreeBookmark(BM);
    DS.EnableControls;
    SetModalitaCalcoloKm(True);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA106FDistanzeTrasferta.actConfermaCalcolaDistanzeExecute(
  Sender: TObject);
var
 BM: TBookmark;
begin
  // v. SelM041BApplyRecord su datamodule
  // l'update viene committata grazie al parametro boolean = True
  SessioneOracle.ApplyUpdates([A106FDistanzeTrasfertaDTM.selM041B],True);

  // refresh dataset 1
  A106FDistanzeTrasfertaDTM.selM041.Refresh;

  // refresh dataset 2 con riposizionamento
  with A106FDistanzeTrasfertaDTM.SelM041B do
  begin
    // salva la posizione corrente
    BM:=GetBookmark;
    try
      Refresh;
      // ritorna al record iniziale
      if BookmarkValid(BM) then
        GotoBookmark(BM);
    finally
      FreeBookmark(BM);
    end;
  end;

  // esce dalla modalità di calcolo
  SetModalitaCalcoloKm(False);
end;

procedure TA106FDistanzeTrasferta.actAnnullaCalcolaDistanzeExecute(
  Sender: TObject);
begin
  //SessioneOracle.CancelUpdates([A106FDistanzeTrasfertaDTM.selM041B]);
  A106FDistanzeTrasfertaDTM.selM041B.CancelUpdates;

  SetModalitaCalcoloKm(False);
end;
// calcolo automatico distanze km con webservice di google.fine

end.
