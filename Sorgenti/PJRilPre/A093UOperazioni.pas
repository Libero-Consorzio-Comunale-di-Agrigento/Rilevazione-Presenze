unit A093UOperazioni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin, ComCtrls, DB, A003UDataLavoroBis, Menus, Math,
  checklst, C001StampaLib, C700USelezioneAnagrafe,RegistrazioneLog, ExtCtrls,
  Oracle, SelAnagrafe, A000UCostanti, A000UMessaggi, A000USessione,
  A000UInterfaccia, C005UDatiAnagrafici, L021Call, Variants, InputPeriodo;

type
  TCampi=TStringList;
  TA093FOperazioni = class(TForm)
    StatusBar: TStatusBar;
    gbxDettaglio: TGroupBox;
    Panel1: TPanel;
    BtnClose: TBitBtn;
    BtnStampa: TBitBtn;
    BitVideo: TBitBtn;
    BtnPrinterSetUp: TBitBtn;
    BtnPreView: TBitBtn;
    pnlDettaglio: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtValoreVecchio: TEdit;
    edtValoreNuovo: TEdit;
    cmbColonna: TComboBox;
    cmbOper1: TComboBox;
    cmbOper2: TComboBox;
    cmbOper3: TComboBox;
    chkValoriModificati: TCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnlPeriodo: TPanel;
    pnlOperatoriOperazioni: TPanel;
    CLBOperatori: TCheckListBox;
    CLBOperazioni: TCheckListBox;
    Label4: TLabel;
    pnlFunzioniOrdinamento: TPanel;
    CLBFunzioni: TCheckListBox;
    Label3: TLabel;
    LBOrdine: TCheckListBox;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    Splitter1: TSplitter;
    pnlTabelleOpzioni: TPanel;
    CLBTabelle: TCheckListBox;
    GroupBox1: TGroupBox;
    chkVisualizzaDettaglio: TCheckBox;
    chkSaltoPagina: TCheckBox;
    Splitter2: TSplitter;
    pnlEtichettaOperatori: TPanel;
    Label5: TLabel;
    pnlEtichettaFunzioni: TPanel;
    pnlEtichettaTabelle: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Splitter3: TSplitter;
    btnElinimaRegistrazioni: TBitBtn;
    chkDettaglioFiltrato: TCheckBox;
    chkDettaglio: TCheckBox;
    chkDipendentiSelezionati: TCheckBox;
    chkRicercaDipendenti: TCheckBox;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure BtnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure LBOrdineMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LBOrdineMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkDettaglioClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnElinimaRegistrazioniClick(Sender: TObject);
    procedure chkDipendentiSelezionatiClick(Sender: TObject);
  Private
    { Private declarations }
    ItemSort,iLargMinPannelli:Integer;
    procedure AbilitaPannelloDettaglio(const PAbilita: Boolean);
    procedure ControllaPeriodo;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  Public
    { Public declarations }
    FlagStatus: Boolean;
    CdFnz:TStringList;
    CdOpz:String;
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
end;

var
  A093FOperazioni: TA093FOperazioni;

procedure OpenA093Operazioni;

implementation

uses A093UOperazioniDtM1, A093UStampa, A093UVideo;

{$R *.DFM}

procedure OpenA093Operazioni;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA093Operazioni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A093FOperazioni:=TA093FOperazioni.Create(nil);
  A093FOperazioniDtM1:=TA093FOperazioniDtM1.Create(nil);
  A093FOperazioni.btnElinimaRegistrazioni.Enabled:=Not(SolaLettura);
  with A093FOperazioni do
    try
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
      A093FOperazioniDtM1.Free;
    end;
end;

procedure TA093FOperazioni.FormCreate(Sender: TObject);
begin
  CdFnz:=TStringList.Create;
  CdOpz:='CIM'; // se si inseriscono nuove operazioni aggiornare questa lista
  A093FStampa:=TA093FStampa.Create(nil);
  AbilitaPannelloDettaglio(False);
  cmbColonna.Items.Clear;
  cmbOper1.ItemIndex:=0;
  cmbOper2.ItemIndex:=0;
  cmbOper3.ItemIndex:=0;
  iLargMinPannelli:=Min(Min(pnlOperatoriOperazioni.Width,pnlFunzioniOrdinamento.Width),pnlTabelleOpzioni.Width);
end;

procedure TA093FOperazioni.FormShow(Sender: TObject);
var i,j:integer;
begin
  FlagStatus:=False;
  ItemSort:=-1;
  DataF:=Parametri.DataLavoro;
  DataI:=Parametri.DataLavoro;
  CLBOperatori.Items.Clear;
  CLBTabelle.Items.Clear;
  CLBFunzioni.Clear;
  with A093FOperazioniDtM1 do
  begin
    Q000_Operatori.First;
    while not(Q000_Operatori.Eof) do
    begin
      CLBOperatori.Items.Add(Q000_OperatoriOPERATORE.AsString);
      Q000_Operatori.Next;
    end;

    CLBFunzioni.Sorted:=False;
    for i:=1 to High(FunzioniDisponibili) do
    begin
      if (L021GetMaschera(i) <> 'XXXX') and (FunzioniDisponibili[i].T <> 47) and L021VerificaApplicazione(Parametri.Applicazione,i) then
      begin
        CLBFunzioni.Items.Add(FunzioniDisponibili[i].G + ': ' + FunzioniDisponibili[i].N + ' (' + L021GetMaschera(i) + ')');
        if (L021GetMaschera(i) <> FunzioniDisponibili[i].SW) and (FunzioniDisponibili[i].SW <> '') then
          //aggiungo la funzione web
          CLBFunzioni.Items.Add(FunzioniDisponibili[i].G + ': ' + FunzioniDisponibili[i].N + ' (' + FunzioniDisponibili[i].SW + ')');
      end;
    end;
    CLBFunzioni.Sorted:=True;
    CdFnz.Clear;
    for i:=0 to CLBFunzioni.Items.Count - 1 do
      for j:=1 to High(FunzioniDisponibili) do
      begin
        if (L021GetMaschera(j) <> 'XXXX') and (FunzioniDisponibili[j].T <> 47) and //Alberto 28/11/2005: escludo l'inserimento collettivo giustificativi, che ha la stessa sigla di A004
           L021VerificaApplicazione(Parametri.Applicazione,j) then
          if CLBFunzioni.Items[i] = FunzioniDisponibili[j].G + ': ' + FunzioniDisponibili[j].N + ' (' + L021GetMaschera(j) + ')' then
          begin
            CdFnz.Add(L021GetMaschera(j));
            Break;
          end
          else if CLBFunzioni.Items[i] = FunzioniDisponibili[j].G + ': ' + FunzioniDisponibili[j].N + ' (' + FunzioniDisponibili[j].SW + ')' then
          begin
            CdFnz.Add(FunzioniDisponibili[j].SW);
            Break;
          end;
      end;

    Q000_Tabelle.First;
    while not(Q000_Tabelle.Eof) do
    begin
      CLBTabelle.Items.Add(Q000_TabelleTABELLA.AsString);
      Q000_Tabelle.Next;
    end;
  end;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,True);
end;

procedure TA093FOperazioni.BtnStampaClick(Sender: TObject);
var i:Integer;
    S,SAnd:String;
    TuttiOperatori,TutteOperazioni: Boolean;
begin
  ControllaPeriodo;
  if (FlagStatus) and (Sender <> BitVideo) then
    raise exception.Create('Stampa o Anteprima di stampa in corso');

  Screen.Cursor:=crHourGlass;
  with A093FOperazioniDtM1.Q001 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT COLONNA,VALORE_OLD,VALORE_NEW FROM I001_LOGDATI WHERE ID = :ID');
    if chkDettaglioFiltrato.Checked then
    begin
      if cmbColonna.Text <> '' then
        SQL.Add('AND COLONNA ' + cmbOper1.Text + ' ''' + cmbColonna.Text + '''');
      if edtValoreVecchio.Text <> '' then
        SQL.Add('AND VALORE_OLD ' + cmbOper2.Text + ' ''' + edtValoreVecchio.Text + '''');
      if edtValoreNuovo.Text <> '' then
        SQL.Add('AND VALORE_NEW ' + cmbOper3.Text + ' ''' + edtValoreNuovo.Text + '''');
      if chkValoriModificati.checked then
        SQL.Add('AND VALORE_OLD <> VALORE_NEW');
    end;
    SQL.Add('ORDER BY COLONNA');
  end;

  // prepara il dataset Q000
  with A093FOperazioniDtM1.Q000 do
  begin
    Close;
    Filtered:=False;
    SQL.Clear;
    if chkDettaglio.Checked then
      SQL.Add('SELECT * FROM I000_LOGINFO T1,I001_LOGDATI T2 WHERE T1.ID = T2.ID AND DATA >= :DADATA AND DATA < :ADATA + 1')
    else
      SQL.Add('SELECT * FROM I000_LOGINFO T1 WHERE DATA >= :DADATA AND DATA < :ADATA + 1');

    // operatori
    TuttiOperatori:=True;
    S:='';
    for i:=0 to CLBOperatori.Items.Count - 1 do
    begin
      if CLBOperatori.Checked[i] then
      begin
        if S <> '' then
          S:=S + ',';
        S:=S + '''' + CLBOperatori.Items[i] + '''';
      end
      else
        TuttiOperatori:=False;
    end;
    if (S <> '') and (not TuttiOperatori) then
    begin
      if Pos(',',S) = 0 then
        SQL.Add('and OPERATORE = ' + S)
      else
        SQL.Add('and OPERATORE in (' + S + ')');
    end;

    // maschere
    S:='';
    for i:=0 to CLBFunzioni.Items.Count - 1 do
    begin
      if CLBFunzioni.Checked[i] then
      begin
        if S <> '' then
          S:=S + ',';
        S:=S + '''' + CdFnz[i] + '''';
      end;
    end;
    if S <> '' then
    begin
      if Pos(',',S) = 0 then
        SQL.Add('and MASCHERA = ' + S)
      else
        SQL.Add('and MASCHERA in (' + S + ')');
    end;

    // tabelle
    S:='';
    for i:=0 to CLBTabelle.Items.Count - 1 do
    begin
      if CLBTabelle.Checked[i] then
      begin
        if S <> '' then
          S:=S + ',';
        S:=S + '''' + CLBTabelle.Items[i] + '''';
      end;
    end;
    if S <> '' then
    begin
      if Pos(',',S) = 0 then
        SQL.Add('and TABELLA = ' + S)
      else
        SQL.Add('and TABELLA in (' + S + ')');
    end;

    // operazioni
    TutteOperazioni:=True;
    S:='';
    for i:=0 to CLBOperazioni.Items.Count - 1 do
    begin
      if CLBOperazioni.Checked[i] then
      begin
        if S <> '' then
          S:=S + ',';
        case i of
          0: S:=S + '''A''';
          1: S:=S + '''C''';
          2: S:=S + '''I''';
          3: S:=S + '''M''';
        end;
      end
      else
        TutteOperazioni:=False;
    end;
    if (S <> '') and (not TutteOperazioni) then
    begin
      if Pos(',',S) = 0 then
        SQL.Add('and OPERAZIONE = ' + S)
      else
        SQL.Add('and OPERAZIONE in (' + S + ')');
    end;

    // filtra i record per i dipendenti nella selezione anagrafica
    if chkDipendentiSelezionati.Checked then
    begin
      // determina il filtro anagrafe per filtrare i progressivi
      S:=Copy(C700SelAnagrafe.SQL.Text,Pos(' FROM',C700SelAnagrafe.SQL.Text),Length(C700SelAnagrafe.SQL.Text));
      if Pos('ORDER BY ',S) > 0 then
        S:=Copy(S,1,Pos('ORDER BY ',S) - 1);
      SQL.Add(Format('AND PROGRESSIVO IN (SELECT DISTINCT PROGRESSIVO %s)',[S]));
    end;

    // ricerca per dipendenti
    // (� legata al dipendente correntemente selezionato in C700)
    if chkRicercaDipendenti.Checked then
    begin
      SQL.Add('AND PROGRESSIVO = :PROGRESSIVO');
    end;

    // selezioni su dettaglio
    if chkDettaglio.Checked then
    begin
      if cmbColonna.Text <> '' then
        SQL.Add('AND COLONNA ' + cmbOper1.Text + ' ''' + cmbColonna.Text + '''');
      if edtValoreVecchio.Text <> '' then
        SQL.Add('AND VALORE_OLD ' + cmbOper2.Text + ' ''' + edtValoreVecchio.Text + '''');
      if edtValoreNuovo.Text <> '' then
        SQL.Add('AND VALORE_NEW ' + cmbOper3.Text + ' ''' + edtValoreNuovo.Text + '''');
      if chkValoriModificati.checked then
        SQL.Add('AND VALORE_OLD <> VALORE_NEW');
    end;

    // ordinamento
    S:='';
    for i:=0 to LBOrdine.Items.Count - 1 do
    begin
      if LBOrdine.Checked[i] then
      begin
        if S <> '' then
          S:=S + ',';
        if UpperCase(LBOrdine.Items[i]) = 'FUNZIONE' then
          S:=S + 'MASCHERA'
        else
          S:=S + LBOrdine.Items[i];
      end;
    end;
    if S = '' then
      S:='order by T1.ID'
    else
      S:='order by ' + S + ',T1.ID';
    SQL.Add(S);

    // dichiarazione variabili
    DeleteVariables;
    DeclareVariable('DaData',otDate);
    DeclareVariable('AData',otDate);
    SetVariable('DaData',DataI);
    SetVariable('AData',DataF);
    if chkRicercaDipendenti.Checked then
    begin
      DeclareVariable('Progressivo',otString);
      SetVariable('Progressivo',0);
    end;
    if Pos(':DATALAVORO',UpperCase(SQL.Text)) > 0 then
    begin
      DeclareVariable('DataLavoro',otDate);
      SetVariable('DataLavoro',C700SelAnagrafe.GetVariable('DataLavoro'));
    end;
    //Definizione campi
    FieldDefs.Update;
    //Elimino i campi persistenti se ci sono
    for i:=FieldCount -1 downto 0 do
      Fields[i].Free;
    //Creo i campi persistenti e scrivo la descrizione della fascia
    //nell'intestazione di colonna
    for i:=0 to FieldDefs.Count - 1 do
      FieldDefs[i].CreateField(A093FOperazioniDtM1.Q000);
    FieldByName('Maschera').Visible:=False;
    //Creo il Campo calcolato 'Funzione'
    with TStringField.Create(Self) do
    begin
      FieldName:='Funzione';
      Name:='Q000Funzione';
      DisplayLabel:='Funzione';
      Size:=50;
      DisplayWidth:=45;
      Calculated:=True;
      DataSet:=A093FOperazioniDtM1.Q000;
    end;
    //Impostazione ordine di visualizzazione
    for i:=0 to LBOrdine.Items.Count - 1 do
      FieldByName(LBOrdine.Items[i]).Index:=i;
    C700SelAnagrafe.AfterScroll:=nil;
    if chkDettaglio.Checked or chkVisualizzaDettaglio.Checked then
      AfterScroll:=A093FOperazioniDtM1.Q000AfterScroll
    else
      AfterScroll:=nil;
    Open;
    if (RecordCount = 0) and Assigned(AfterScroll) then
      A093FOperazioniDtM1.Q000AfterScroll(A093FOperazioniDtM1.Q000);
  end;

  if chkRicercaDipendenti.Checked then
  begin
    C700SelAnagrafe.AfterScroll:=A093FOperazioniDtM1.QAnagraAfterScroll;
    C700SelAnagrafe.First;
  end
  else
    C700SelAnagrafe.AfterScroll:=nil;

  Screen.Cursor:=crDefault;

  if Sender = BitVideo then
  begin
    A093FVideo:=TA093FVideo.Create(nil);
    try
      A093FVideo.grdAnagra.DataSource:=C700SrcAnagrafe;
//      A093FVideo.grdAnagra.Visible:=chkDettaglio.Checked and chkRicercaDipendenti.Checked;
      A093FVideo.grdAnagra.Visible:=chkRicercaDipendenti.Checked;
      A093FVideo.grdDettaglio.Visible:=chkVisualizzaDettaglio.Checked;
      A093FVideo.ShowModal;
    finally
      A093FVideo.Release;
    end;
  end
  else
    A093FStampa.CreaReport(Sender = BtnPreView);
end;

procedure TA093FOperazioni.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A093FStampa.RepR);
end;

procedure TA093FOperazioni.LBOrdineMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemSort:=LBOrdine.ItemIndex;
end;

procedure TA093FOperazioni.LBOrdineMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var c:boolean;
begin
  if (ItemSort <> -1) and (ItemSort <> LBOrdine.ItemIndex) then
    begin
    c:=LBOrdine.Checked[ItemSort];
    LBOrdine.Items.Move(ItemSort,LBOrdine.ItemIndex);
    if ItemSort>LBOrdine.ItemIndex then
       LBOrdine.Checked[LBOrdine.ItemIndex-1]:=c
    else
       LBOrdine.Checked[LBOrdine.ItemIndex+1]:=c;
    end;
  ItemSort:=- 1;
end;

procedure TA093FOperazioni.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to TCheckListBox(PopupMenu1.PopupComponent).Items.Count - 1 do
    TCheckListBox(PopupMenu1.PopupComponent).Checked[i]:=True;
end;
procedure TA093FOperazioni.Annullatutto1Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to TCheckListBox(PopupMenu1.PopupComponent).Items.Count - 1 do
    TCheckListBox(PopupMenu1.PopupComponent).Checked[i]:=False;
end;

procedure TA093FOperazioni.AbilitaPannelloDettaglio(const PAbilita: Boolean);
var
  i: Integer;
begin
  pnlDettaglio.Enabled:=PAbilita;
  for i:=0 to pnlDettaglio.ControlCount - 1 do
  begin
    pnlDettaglio.Controls[i].Enabled:=PAbilita;
  end;
end;

procedure TA093FOperazioni.chkDettaglioClick(Sender: TObject);
var
  LAbilitaDett: Boolean;
begin
  LAbilitaDett:=(chkDettaglio.Checked or chkDettaglioFiltrato.Checked);
  AbilitaPannelloDettaglio(LAbilitaDett);

  // estrae l'elenco delle colonne da I001 per le selezioni su dettaglio
  if (LAbilitaDett) and
     (cmbColonna.Items.Count = 0) then
  begin
    Screen.Cursor:=crHourGlass;
    try
      cmbColonna.Items.BeginUpdate;
      A093FOperazioniDtM1.selCols.Open;
      while not A093FOperazioniDtM1.selCols.Eof do
      begin
        cmbColonna.Items.Add(A093FOperazioniDtM1.selCols.FieldByName('COLONNA').AsString);
        A093FOperazioniDtM1.selCols.Next;
      end;
      A093FOperazioniDtM1.selCols.Close;
    finally
      cmbColonna.Items.EndUpdate;
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TA093FOperazioni.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=DataF;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA093FOperazioni.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataLavoro:=DataF;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA093FOperazioni.FormDestroy(Sender: TObject);
begin
  A093FStampa.Release;
  CdFnz.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA093FOperazioni.FormResize(Sender: TObject);
begin
  if (A093FOperazioni.WindowState = wsMaximized) and ((pnlOperatoriOperazioni.Width < iLargMinPannelli) or
   (pnlFunzioniOrdinamento.Width < iLargMinPannelli) or (pnlTabelleOpzioni.Width < iLargMinPannelli)) then
  begin
    pnlOperatoriOperazioni.Width:=iLargMinPannelli;
    pnlFunzioniOrdinamento.Width:=iLargMinPannelli;
    pnlTabelleOpzioni.Width:=iLargMinPannelli;
    A093FOperazioni.Paint;
  end;
end;

procedure TA093FOperazioni.btnElinimaRegistrazioniClick(Sender: TObject);
begin
  if MessageDlg('Eliminare le registrazioni effettuate dal ' + DateToStr(DataI) + ' al ' + DateToStr(DataF) + '?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    with A093FOperazioniDtM1.delI000 do
    begin
      SetVariable('DAL',DataI);
      SetVariable('AL',DataF);
      try
        Screen.Cursor:=crHourGlass;
        Execute;
      finally
        Screen.Cursor:=crDefault;
      end;
      SessioneOracle.Commit;
    end;
end;

procedure TA093FOperazioni.chkDipendentiSelezionatiClick(Sender: TObject);
begin
  if (Sender = chkDipendentiSelezionati) and chkDipendentiSelezionati.Checked then
    chkRicercaDipendenti.Checked:=False;
  if (Sender = chkRicercaDipendenti) and chkRicercaDipendenti.Checked then
    chkDipendentiSelezionati.Checked:=False;
end;

procedure TA093FOperazioni.ControllaPeriodo;
begin
  if DataI <= 0 then
  begin
    frmInputPeriodo.edtInizio.SetFocus;
    Raise Exception.Create(A000MSG_ERR_DATA_VALIDA);
  end;
  if DataF <= 0 then
  begin
    frmInputPeriodo.edtFine.SetFocus;
    Raise Exception.Create(A000MSG_ERR_DATA_VALIDA);
  end;

  if DataI > DataF then
  begin
    frmInputPeriodo.edtFine.SetFocus;
    Raise Exception.Create(A000MSG_ERR_PERIODO_ERRATO);
  end;
end;

{ DataF }
function TA093FOperazioni._GetDataF: TDateTime;
begin
  Result:=frmInputPeriodo.DataFine;
end;
procedure TA093FOperazioni._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine:=Value;
end;
{ ----DataF }
{ DataI }
function TA093FOperazioni._GetDataI: TDateTime;
begin
  Result:=frmInputPeriodo.DataInizio;
end;
procedure TA093FOperazioni._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio:=Value;
end;
{ ----DataI }

end.

