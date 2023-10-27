unit R012UWebAnagrafico;

interface

uses
  R010UPAGINAWEB, WC002UDatiAnagraficiFM,
  A000USessione, A000UInterfaccia, A000UMessaggi, A000UCostanti,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompLabel,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, IWVCLBaseContainer, IWContainer,
  IWCompListbox,  Oracle, OracleData, DB, IWVCLComponent,
  meIWLink, meIWComboBox, meIWLabel, IWCompButton, meIWButton, IWCompExtCtrls,
  meIWImageFile, meIWImage, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid;

type
  TR012FWebAnagrafico = class(TR010FPaginaWeb)
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    FSelezionePeriodica,
    FCambioDipendenteAsync: Boolean;
    FElencoProgressivi: String;
    FCampiV430: String;
    WC002FDatiAnagraficiFM: TWC002FDatiAnagraficiFM;
    procedure lnkDipendenteClick(Sender: TObject);
    procedure cmbDipendentidisponibiliChange(Sender: TObject); virtual;
    procedure cmbDipendentiDisponibiliAsyncChange(Sender: TObject; EventParams: TStringList);
    function  IsSelezionePeriodica: Boolean;
    procedure SetSelezionePeriodica(Val: Boolean);
    function  IsCambioDipendenteAsync: Boolean;
    procedure SetCambioDipendenteAsync(const Val: Boolean);
    procedure _GetDipendentiDisponibili(ChiudiDataset: Boolean; D1, D2: TDateTime);
    function  GetElencoProgressivi: String;
    function  GetFiltroSingoloAnagrafico:String;
    procedure SetCampiV430(Value:String);
  protected
    lnkDipendente: TmeIWLink;
    cmbDipendentiDisponibili: TmeIWComboBox;
    ElementoTuttiDip,
    ResetOffsetGrid: Boolean;
    function  GetProgressivo: Integer; override;
    function  GetRagioneSociale(Progressivo:Integer = -1):String;
    function  GetInfoFunzione: String; override;
    procedure OnCambiaProgressivo; virtual;
    function  GetTuttiDipSelezionato: Boolean; virtual;
    procedure GetDipendentiDisponibili(Data: TDateTime); overload; virtual;
    procedure GetDipendentiDisponibili(DataDal, DataAl: TDateTime); overload; virtual;
    function  FormattaInfoDipendenteCorrente: String;
    procedure VisualizzaDipendenteCorrente; virtual;
    property  SelezionePeriodica: Boolean read IsSelezionePeriodica write SetSelezionePeriodica;
    property  CambioDipendenteAsync: Boolean read IsCambioDipendenteAsync write SetCambioDipendenteAsync;
    property  ElencoProgressivi: String read GetElencoProgressivi;
    property  FiltroSingoloAnagrafico: String read GetFiltroSingoloAnagrafico;
    property  TuttiDipSelezionato: Boolean read GetTuttiDipSelezionato;
    property  CampiV430: String read FCampiV430 write SetCampiV430;
  public
    selAnagrafeW: TOracleDataSet;
  end;

implementation

uses W001UIrisWebDtM, medpIWDBGrid;

{$R *.dfm}

procedure TR012FWebAnagrafico.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  FElencoProgressivi:='';
  FCambioDipendenteAsync:=False;
  try
    if Pos('W022',Self.Name) = 0  then
      lnkIndietro.OnClick:=lnkIndietroClick;

    // link dipendente selezionato
    if lnkDipendente = nil then
      lnkDipendente:=TmeIWLink.Create(Self);
    lnkDipendente.Name:='lnkDipendente';
    lnkDipendente.Css:='intestazione';
    lnkDipendente.Hint:='scheda anagrafica';
    lnkDipendente.Parent:=Self;
    // abilitazione per la scheda anagrafica
    if A000GetInibizioni('Tag','412') <> 'N' then
      lnkDipendente.OnClick:=lnkDipendenteClick;

    // combobox dei dipendenti disponibili
    if cmbDipendentiDisponibili = nil then
      cmbDipendentiDisponibili:=TmeIWComboBox.Create(Self);
    cmbDipendentiDisponibili.Name:='cmbDipendentiDisponibili';
    cmbDipendentiDisponibili.Css:='select_perc50';
    cmbDipendentiDisponibili.Hint:='dipendente selezionato';
    cmbDipendentiDisponibili.ItemsHaveValues:=True;
    cmbDipendentiDisponibili.Parent:=Self;
    cmbDipendentiDisponibili.OnChange:=cmbDipendentidisponibiliChange;

    // dataset anagrafico
    FCampiV430:='V430.T430BADGE,V430.T430AZIENDA_BASE,V430.T430D_AZIENDA_BASE';
    if selAnagrafeW = nil then
      selAnagrafeW:=TOracleDataSet.Create(Self);
    if WR000DM.TipoUtente = 'Dipendente' then
      selAnagrafeW.ReadBuffer:=WR000DM.cdsAnagrafe.RecordCount + 1;
    selAnagrafeW.Session:=WR000DM.selAnagrafe.Session;
    SelezionePeriodica:=False;
    ResetOffsetGrid:=False;
  except
    on E:Exception do
      Log('Errore','FormCreate[R012]',E);
  end;
end;

procedure TR012FWebAnagrafico.IWAppFormDestroy(Sender: TObject);
begin
  try FreeAndNil(lnkDipendente); except end;
  try FreeAndNil(cmbDipendentiDisponibili); except end;
  try selAnagrafeW.CloseAll; except end;
  try FreeAndNil(selAnagrafeW); except end;

  inherited;
end;

function TR012FWebAnagrafico.IsSelezionePeriodica: Boolean;
begin
  Result:=FSelezionePeriodica;
end;

procedure TR012FWebAnagrafico.SetSelezionePeriodica(Val: Boolean);
// Imposta la selezione anagrafica alla data / periodica
var
  S: String;
  LHintUnnest: String;
  LFiltroInServizio: String;
begin
  // impostazione del dataset anagrafico
  if Val then
  begin
    // selezione periodica
    selAnagrafeW.SQL.Clear;
    selAnagrafeW.SQL.Text:=QVistaOracle;

    // campi t430 parametrizzati.ini
    //SQL.Insert(0,'SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.* FROM');
    selAnagrafeW.SQL.Insert(0,Format('SELECT %s T030.*,T480.CITTA,T480.PROVINCIA,:CAMPIV430 FROM',[Parametri.CampiRiferimento.C26_HintT030V430]));
    // campi t430 parametrizzati.fine

    selAnagrafeW.SQL.Add('AND T030.PROGRESSIVO IN (');
    // utilizzo hint "unnest" - daniloc. 22.11.2010
    // nota: la distinct è stata rimossa dopo alcune verifiche statistiche sui tempi di esecuzione
    // SQL.Add('  SELECT DISTINCT PROGRESSIVO FROM');
    LHintUnnest:='/*+ UNNEST */';
    if Parametri.CampiRiferimento.C26_HintT030V430 <> '' then
      LHintUnnest:='/*+ ' +
                  StringReplace(StringReplace(Parametri.CampiRiferimento.C26_HintT030V430,'/*+','',[]),'*/','',[]) +
                  ' UNNEST */';
    selAnagrafeW.SQL.Add(Format('  SELECT %s PROGRESSIVO FROM',[LHintUnnest]));
    // utilizzo hint "unnest".fine
    S:=StringReplace(QVistaOracle,':DATALAVORO BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                                  ':DATALAVORO >= T430DATADECORRENZA AND :DATADAL <= T430DATAFINE',
                                  [rfIgnoreCase]);
    if Parametri.V430 = 'P430' then
      S:=StringReplace(S,':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                         ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :DATADAL <= NVL(P430DECORRENZA_FINE,:DATADAL)',
                         [rfIgnoreCase]);
    selAnagrafeW.SQL.Add(S);
    selAnagrafeW.SQL.Add(':FILTRO)');
    selAnagrafeW.SQL.Add(WR000DM.OrdinamentoRicerca);

    // gestione variabili della query
    selAnagrafeW.DeleteVariables;
    selAnagrafeW.Variables.Assign(WR000DM.SelAnagrafe.Variables);
    selAnagrafeW.DeclareVariable('DATADAL',otDate);
    LFiltroInServizio:=WR000DM.FiltroRicerca.Replace(CONDIZIONE_IN_SERVIZIO_STANDARD,CONDIZIONE_IN_SERVIZIO_PERIODICA,[rfIgnoreCase]);
    selAnagrafeW.SetVariable('FILTRO',LFiltroInServizio);
  end
  else
  begin
    // selezione alla data
    selAnagrafeW.SQL.Assign(WR000DM.SelAnagrafe.SQL);
    // campi t430 parametrizzati.ini
    selAnagrafeW.SQL[0]:=Format('SELECT %s T030.*,T480.CITTA,T480.PROVINCIA,:CAMPIV430 FROM',[Parametri.CampiRiferimento.C26_HintT030V430]);
    // campi t430 parametrizzati.fine
    selAnagrafeW.DeleteVariables;
    selAnagrafeW.Variables.Assign(WR000DM.SelAnagrafe.Variables);
  end;

  FSelezionePeriodica:=Val;
end;

function TR012FWebAnagrafico.IsCambioDipendenteAsync: Boolean;
begin
  Result:=FCambioDipendenteAsync;
end;

procedure TR012FWebAnagrafico.SetCambioDipendenteAsync(const Val: Boolean);
begin
  if Val = FCambioDipendenteAsync then
    Exit;
  if not Assigned(cmbDipendentiDisponibili) then
    Exit;

  if Val then
  begin
    // evento asyncchange
    cmbDipendentiDisponibili.OnChange:=nil;
    cmbDipendentiDisponibili.OnAsyncChange:=cmbDipendentiDisponibiliAsyncChange;
  end
  else
  begin
    // evento change
    cmbDipendentiDisponibili.OnChange:=cmbDipendentiDisponibiliChange;
    cmbDipendentiDisponibili.OnAsyncChange:=nil;
  end;
end;

procedure TR012FWebAnagrafico.SetCampiV430(Value: String);
var lst1,lst2:TStringList;
    i:Integer;
begin
  lst1:=TStringList.Create;
  lst2:=TStringList.Create;
  try
    lst1.CommaText:='V430.T430BADGE,V430.T430AZIENDA_BASE,V430.T430D_AZIENDA_BASE';
    lst2.CommaText:=Value.ToUpper;
    for i:=0 to lst2.Count - 1 do
    begin
      if lst1.IndexOf(lst2[i]) < 0 then
        lst1.Add(lst2[i]);
    end;
    FCampiV430:=lst1.CommaText;
  finally
    lst1.Free;
    lst2.Free;
  end;
end;

procedure TR012FWebAnagrafico.lnkDipendenteClick(Sender: TObject);
begin
  WC002FDatiAnagraficiFM:=TWC002FDatiAnagraficiFM.Create(Self);
  WC002FDatiAnagraficiFM.ParMatricola:=selAnagrafeW.FieldByName('MATRICOLA').AsString;
  WC002FDatiAnagraficiFM.AllowClick:=True;
  WC002FDatiAnagraficiFM.VisualizzaScheda;
end;

procedure TR012FWebAnagrafico.OnCambiaProgressivo;
var
  M:string;
begin
  if not TuttiDipSelezionato then
  begin
    M:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
    selAnagrafeW.SearchRecord('MATRICOLA',M,[srFromBeginning]);
  end;

  ResetOffsetGrid:=True;
  VisualizzaDipendenteCorrente;
  ResetOffsetGrid:=False;
end;

procedure TR012FWebAnagrafico.cmbDipendentidisponibiliChange(Sender: TObject);
begin
  OnCambiaProgressivo;
end;

procedure TR012FWebAnagrafico.cmbDipendentiDisponibiliAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  OnCambiaProgressivo;
end;

procedure TR012FWebAnagrafico.GetDipendentiDisponibili(DataDal, DataAl: TDateTime);
// Selezione dipendenti periodica dal - al
var
  ChiudiDataset: Boolean;
begin
  ChiudiDataset:=False;

  // se necessario imposta la selezione periodica
  if not SelezionePeriodica then
  begin
    SelezionePeriodica:=True;
    ChiudiDataset:=True;
  end;
    
  _GetDipendentiDisponibili(ChiudiDataset,DataDal,DataAl);
end;

procedure TR012FWebAnagrafico.GetDipendentiDisponibili(Data: TDateTime);
// Selezione dipendenti alla data
var
  ChiudiDataset: Boolean;
begin
  ChiudiDataset:=False;

  // se necessario rimuove la selezione periodica
  if SelezionePeriodica then
  begin
    SelezionePeriodica:=False;
    ChiudiDataset:=True;
  end;

  _GetDipendentiDisponibili(ChiudiDataset,Data,0);
end;

procedure TR012FWebAnagrafico._GetDipendentiDisponibili(ChiudiDataset: Boolean; D1, D2: TDateTime);
var
  P:Integer;
  Codice,Descrizione:String;
  Trovato:Boolean;
begin
  if selAnagrafeW.Active then
    P:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger
  else
    P:=-1;

  if selAnagrafeW.VariableIndex('CAMPIV430') < 0 then
    selAnagrafeW.DeclareVariable('CAMPIV430',otSubst);

  // determina se è necessario forzare la chiusura + riapertura del dataset
  if ChiudiDataset then
  begin
    selAnagrafeW.CloseAll;
    selAnagrafeW.SetVariable('CAMPIV430',FCampiV430);
    if SelezionePeriodica then
    begin
      selAnagrafeW.SetVariable('DATADAL',D1);
      selAnagrafeW.SetVariable('DATALAVORO',D2);
    end
    else
      selAnagrafeW.SetVariable('DATALAVORO',D1);
  end
  else
  begin
    R180SetVariable(selAnagrafeW,'CAMPIV430',FCampiV430);
    if SelezionePeriodica then
    begin
      R180SetVariable(selAnagrafeW,'DATADAL',D1);
      R180SetVariable(selAnagrafeW,'DATALAVORO',D2);
    end
    else
      R180SetVariable(selAnagrafeW,'DATALAVORO',D1);
  end;

  // ciclo di popolamento combobox anagrafico
  selAnagrafeW.Open;
  selAnagrafeW.First; // necessaria quando il dataset non viene chiuso prima della open

  cmbDipendentiDisponibili.Items.Clear;
  FElencoProgressivi:='';

  // valuta l'inserimento dell'item "Tutti i dipendenti"
  if (ElementoTuttiDip) and (selAnagrafeW.RecordCount > 1) then
    cmbDipendentiDisponibili.Items.Insert(0,'<' + A000TraduzioneStringhe(A000MSG_MSG_TUTTI_I_DIP) + '>=########');

  // ciclo di inserimento
  while not selAnagrafeW.Eof do
  begin
    Codice:=selAnagrafeW.FieldByName('MATRICOLA').AsString;
    Descrizione:=Format('%-8s %s %s',
                        [selAnagrafeW.FieldByName('MATRICOLA').AsString,
                         selAnagrafeW.FieldByName('COGNOME').AsString,
                         selAnagrafeW.FieldByName('NOME').AsString]);
    cmbDipendentiDisponibili.Items.Add(Descrizione + '=' + Codice);
    FElencoProgressivi:=FElencoProgressivi + selAnagrafeW.FieldByName('PROGRESSIVO').AsString + ',';
    selAnagrafeW.Next;
  end;

  if FElencoProgressivi <> '' then
    FElencoProgressivi:=Copy(FElencoProgressivi,1,Length(FElencoProgressivi) - 1);

  // riposizionamento bookmark su selAnagrafeW
  Trovato:=selAnagrafeW.SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
  if not Trovato then
    selAnagrafeW.First;

  if not TuttiDipSelezionato then
    cmbDipendentiDisponibili.ItemIndex:=R180IndexOf(cmbDipendentiDisponibili.Items,selAnagrafeW.FieldByName('MATRICOLA').AsString,8);
  cmbDipendentiDisponibili.RequireSelection:=cmbDipendentiDisponibili.Items.Count > 0;
end;

function TR012FWebAnagrafico.GetElencoProgressivi: String;
begin
  Result:=FElencoProgressivi;
end;

function TR012FWebAnagrafico.GetFiltroSingoloAnagrafico:String;
begin
  Result:='and T030.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger.ToString;
end;

function TR012FWebAnagrafico.GetTuttiDipSelezionato;
// restituisce True se al momento è selezionato l'elemento "Tutti i dipendenti",
//             False se è selezionato un dipendente singolo
begin
  Result:=(ElementoTuttiDip) and
          (selAnagrafeW.Active) and
          (selAnagrafeW.RecordCount > 1) and
          (cmbDipendentiDisponibili.ItemIndex = 0);
end;

function TR012FWebAnagrafico.FormattaInfoDipendenteCorrente: String;
begin
  Result:='';
  if not selAnagrafeW.Active then
    Exit;
  if selAnagrafeW.RecordCount = 0 then
    Exit;

  Result:=Format('%s %s - %s %s - %s %s',
                 [selAnagrafeW.FieldByName('COGNOME').AsString,
                  selAnagrafeW.FieldByName('NOME').AsString,
                  UpperCase(A000TraduzioneStringhe(A000MSG_MSG_MATRICOLA)),
                  selAnagrafeW.FieldByName('MATRICOLA').AsString,
                  A000TraduzioneStringhe('BADGE'),
                  selAnagrafeW.FieldByName('T430BADGE').AsString]);
end;

function TR012FWebAnagrafico.GetRagioneSociale(Progressivo:Integer = -1):String;
var AziendaBase:String;
begin
  Result:=Parametri.RagioneSociale;
  if selAnagrafeW.FindField('T430AZIENDA_BASE') = nil then
    exit;

  if Progressivo <= 0 then
    AziendaBase:=selAnagrafeW.FieldByName('T430AZIENDA_BASE').AsString
  else
    AziendaBase:=VarToStr(selAnagrafeW.Lookup('PROGRESSIVO',Progressivo,'T430AZIENDA_BASE'));

  if not R180In(AziendaBase,['',T440AZIENDA_BASE]) then
  begin
    if Progressivo <= 0 then
      Result:=selAnagrafeW.FieldByName('T430D_AZIENDA_BASE').AsString
    else
      Result:=VarToStr(selAnagrafeW.Lookup('PROGRESSIVO',Progressivo,'T430D_AZIENDA_BASE'));
  end;
end;


procedure TR012FWebAnagrafico.VisualizzaDipendenteCorrente;
var
  i:Integer;
begin
  if TuttiDipSelezionato then
    lnkDipendente.Caption:=''
  else
  begin
    // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.ini
    // l'iter degli scioperi W037 comporta una gestione particolare per cui in fase di richiesta
    // il progressivo è in realta legato all'utente web e non alla selezione anagrafica
    // in quel contesto la combobox dei dipendenti viene nascosta
    if cmbDipendentiDisponibili.Visible then
    begin
    // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.fine
      cmbDipendentiDisponibili.ItemIndex:=R180IndexOf(cmbDipendentiDisponibili.Items,selAnagrafeW.FieldByName('MATRICOLA').AsString,8);
      lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
    end;
  end;

  // se necessario reimposta l'offset della paginazione sulla prima pagina per tutte le medpIWDBGrid
  if ResetOffsetGrid then
  begin
    for i:=0 to ControlCount - 1 do
    begin
      if (Controls[i] is TmedpIWDBGrid) and
         ((Controls[i] as TmedpIWDBGrid).medpPaginazione) then
        (Controls[i] as TmedpIWDBGrid).medpResetOffset;
    end;
  end;
end;

function TR012FWebAnagrafico.GetProgressivo: Integer;
// il progressivo attuale è quello di selAnagrafeW
begin
  Result:=-1;
  if selAnagrafeW <> nil then
  begin
    try
      if selAnagrafeW.Active and (selAnagrafeW.RecordCount > 0) then
        Result:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    except
    end;
  end;
end;

function TR012FWebAnagrafico.GetInfoFunzione: String;
begin
  Result:=inherited;
  if selAnagrafeW <> nil then
  begin
    try
      if GetTuttiDipSelezionato then
        Result:=A000TraduzioneStringhe(A000MSG_MSG_TUTTI_I_DIP)
      else if (selAnagrafeW.Active) and (selAnagrafeW.RecordCount > 0) then
        Result:=Format('%s: %s<br>%s: %s %s',
                       [A000TraduzioneStringhe(A000MSG_MSG_MATRICOLA),
                        selAnagrafeW.FieldByName('MATRICOLA').AsString,
                        A000TraduzioneStringhe(A000MSG_MSG_NOMINATIVO),
                        selAnagrafeW.FieldByName('COGNOME').AsString,
                        selAnagrafeW.FieldByName('NOME').AsString]);
    except
    end;
  end;
end;

end.
