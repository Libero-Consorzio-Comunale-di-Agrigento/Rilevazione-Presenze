unit C600USelezioneAnagrafe;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, checklst, ExtCtrls, ComCtrls, DBCtrls, Db, A000UCostanti, A000UInterfaccia, A000USessione,
  Buttons, Menus,C180FunzioniGenerali,QueryStorico, Oracle, ActnList, ImgList,
  ToolWin, OracleData, Grids, DBGrids, Variants, C600USelezioneAnagrafeDtM,
  System.Actions, System.UITypes, System.ImageList;

const C600TuttiCampi = 'T030.*,T480.CITTA,T480.PROVINCIA,V430.*';
      C600CampiBase = 'T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE';

type
  PSelezione = ^TSelezione;

  TSelezione = record
    DaValore,AValore:String;
    TotValori,SelValori:TStringList;
    Esistente:Boolean;
    EscludiValori:Boolean;
    CaseInsensitive:Boolean;
  end;

  TC600SelAnagrafeBridge = record
    SQLCreato:String;
    Progressivo:Integer;
    SelezionePeriodica,SoloPersonaleInterno:Boolean;
  end;

  TC600FSelezioneAnagrafe = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    CBValori: TCheckListBox;
    TVAzienda: TTreeView;
    CBDaValore: TComboBox;
    CBAValore: TComboBox;
    Label3: TLabel;
    Panel4: TPanel;
    BitBtn2: TBitBtn;
    Panel5: TPanel;
    LBOrdinamento: TListBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Escieconferma1: TMenuItem;
    Escieannulla1: TMenuItem;
    Selezione1: TMenuItem;
    GeneraSQL1: TMenuItem;
    ModificaSQL1: TMenuItem;
    Annullaselezione1: TMenuItem;
    Aggiornaselezione1: TMenuItem;
    StatusBar1: TStatusBar;
    chkCessati: TCheckBox;
    ToolBar1: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actConferma: TAction;
    actAnnulla: TAction;
    actSalvaSelezione: TAction;
    actApriSelezione: TAction;
    actEliminaSelezione: TAction;
    actAnteprimaSelezione: TAction;
    actModificaSelezione: TAction;
    actAnnullaSelezione: TAction;
    ToolButton12: TToolButton;
    ToolButton14: TToolButton;
    N1: TMenuItem;
    Apriselezione1: TMenuItem;
    Salvaselezione1: TMenuItem;
    Eliminaselezione1: TMenuItem;
    cmbSelezione: TComboBox;
    ToolButton15: TToolButton;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    dgrdAnteprima: TDBGrid;
    PopupMenu1: TPopupMenu;
    Singolodipendente1: TMenuItem;
    PopupMenu2: TPopupMenu;
    mnuRicercaCompleta: TMenuItem;
    Splitter1: TSplitter;
    Label4: TLabel;
    PopupMenu3: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    grpSelezionePeriodica: TRadioGroup;
    chkEsterni: TCheckBox;
    NRicercaTesto: TMenuItem;
    Ricercatestocontenuto1: TMenuItem;
    Successivo1: TMenuItem;
    chkCaseInsensitive: TCheckBox;
    chkEscludiValori: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TVAziendaDblClick(Sender: TObject);
    procedure TVAziendaChange(Sender: TObject; Node: TTreeNode);
    procedure LBOrdinamentoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LBOrdinamentoDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure LBOrdinamentoDblClick(Sender: TObject);
    procedure TVAziendaExit(Sender: TObject);
    procedure actGenerazioneSelezioneExecute(Sender: TObject);
    procedure actModificaSelezioneExecute(Sender: TObject);
    procedure Panel1Exit(Sender: TObject);
    procedure actAnnullaSelezioneExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure CBAValoreEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actApriSelezioneExecute(Sender: TObject);
    procedure actEliminaSelezioneExecute(Sender: TObject);
    procedure actSalvaSelezioneExecute(Sender: TObject);
    procedure cmbSelezioneDblClick(Sender: TObject);
    procedure TVAziendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TVAziendaEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure TVAziendaEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Singolodipendente1Click(Sender: TObject);
    procedure mnuRicercaCompletaClick(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure Ricercatestocontenuto1Click(Sender: TObject);
    procedure Successivo1Click(Sender: TObject);
  private
    { Private declarations }
    VecchioNodo:Integer;
    TreeNodeOrig,TVAziendaSearch:String;
    procedure GetCheck(Source:TStringList);
    procedure PutCheck(Dest:TStringList);
    procedure GestioneVecchioNodo;
    procedure AggiornaSelezione;
    //function FormatoValore(Campo:String; Valore:String; Tipo:TFieldType):String;
    //function ValoriSelezionati(Campo:String; Lista:TStringList; Tipo:TFieldType):String;
    //function FormatoCampo(Campo: String): String;
    function FormatoCampo(Campo:String; CaseInsensitive:Boolean; Tipo:String):String;
    function FormatoValore(Valore:String; CaseInsensitive:Boolean; Tipo:String):String;
    function ValoriSelezionati(Campo:String; Lista:TStringList; EscludiValori:Boolean; Tipo:String):String;
  public
    { Public declarations }
    DataLavoro,DataDal:TDateTime;
    OrderString,SelectString,C600Nome,C600Badge:String;
    DataBase:TOracleSession;
    ListSQL,ListSQLPeriodico,SQLCreato,CorpoSQL:TStringList;
    Componenti:TList;
    PulisciVecchiaSelezione,OpenC600SelAnagrafe:Boolean;
    WhereSql:String;
    //ex-Globali
    C600DatiSelezionati:String;
    C600FSelezioneAnagrafeDtM:TC600FSelezioneAnagrafeDtM;
    procedure PulisciListe;
    function IsCampoCaseInsensitive(Campo: String): Boolean;
    function PrefissoTabella(Campo:String):String;
    //ex-Private
    procedure QueryDinamica(Modo:Byte);
    //ex C600DtM
    procedure CaricaTVAzienda(Completa:Boolean);
  end;

implementation

uses C700USQL;

{$R *.DFM}

function TC600FSelezioneAnagrafe.IsCampoCaseInsensitive(Campo: String): Boolean;
{ Determina se un campo deve essere trattato in modo
  da non considerare differenza fra maiuscole e minuscole. }
{
var
  NomeCampo: String;
  i: Integer;
}
  begin
  // gestione commentata per il momento
  {
  i:=Pos('.',Campo);
  NomeCampo:=Copy(Campo,i + 1,Length(Campo) - i);
  Result:=(NomeCampo = 'COGNOME');
  }
  Result:=False;
end;

procedure TC600FSelezioneAnagrafe.FormCreate(Sender: TObject);
begin
  Componenti:=TList.Create;
  ListSQL:=TStringList.Create;
  ListSQLPeriodico:=TStringList.Create;
  SQLCreato:=TStringList.Create;
  CorpoSQL:=TStringList.Create;
  VecchioNodo:=0;
  actEliminaSelezione.Enabled:=Parametri.C700_SalvaSelezioni = 'S';
  actSalvaSelezione.Enabled:=Parametri.C700_SalvaSelezioni <> 'N';
end;

procedure TC600FSelezioneAnagrafe.PulisciListe;
var i:Integer;
begin
  for i:=Componenti.Count - 1 downto 0 do
    begin
    PSelezione(Componenti.Items[i]).TotValori.Free;
    PSelezione(Componenti.Items[i]).SelValori.Free;
    Dispose(PSelezione(Componenti.Items[i]));
    Componenti.Delete(i);
    end;
  CBDaValore.Items.Clear;
  CBAValore.Items.Clear;
  CBValori.Items.Clear;
end;

procedure TC600FSelezioneAnagrafe.TVAziendaChange(Sender: TObject;
  Node: TTreeNode);
{Carico i dati dalla List Box se sono già registrati in memoria}
var I:Integer;
begin
  GestioneVecchioNodo;
  I:=Node.Index;
  VecchioNodo:=i;
  CBValori.Items.Clear;
  chkCaseInsensitive.Checked:=False;
  chkEscludiValori.Checked:=False;
  //Da Valore e A Valore li carico comunque poichè li posso inserire manualmente
  CBDaValore.Text:=PSelezione(Componenti.Items[I]).DaValore;
  CBAValore.Text:=PSelezione(Componenti.Items[I]).AValore;
  if (CBDaValore.Text <> '') or (CBAValore.Text <> '')then
    chkCaseInsensitive.Checked:=PSelezione(Componenti.Items[I]).CaseInsensitive;
  if PSelezione(Componenti.Items[I]).SelValori.Count > 0 then
    chkEscludiValori.Checked:=PSelezione(Componenti.Items[I]).EscludiValori;
  //Carico i dati del nuovo nodo
  if PSelezione(Componenti.Items[I]).Esistente then
  begin
    CBValori.Items.Assign(PSelezione(Componenti.Items[I]).TotValori);
    CBDaValore.Items.Assign(PSelezione(Componenti.Items[I]).TotValori);
    CBAValore.Items.Assign(PSelezione(Componenti.Items[I]).TotValori);
    GetCheck(PSelezione(Componenti.Items[I]).SelValori);
  end;
  CBValori.Enabled:=PSelezione(Componenti.Items[I]).Esistente;
end;

procedure TC600FSelezioneAnagrafe.GestioneVecchioNodo;
{Memorizzo le selezioni del vecchio nodo e gestisco l'ordinamento per questa colonna}
var Old_Da,Old_A,Old_In:String;
    Old_EscludiValori,Old_CaseInsensitive:Boolean;
begin
  if (VecchioNodo < 0) or (VecchioNodo >= TVAzienda.Items.Count) then exit;
  Old_Da:=PSelezione(Componenti.Items[VecchioNodo]).DaValore;
  Old_A:=PSelezione(Componenti.Items[VecchioNodo]).AValore;
  Old_In:=PSelezione(Componenti.Items[VecchioNodo]).SelValori.Text;
  Old_CaseInsensitive:=PSelezione(Componenti.Items[VecchioNodo]).CaseInsensitive;
  Old_EscludiValori:=PSelezione(Componenti.Items[VecchioNodo]).EscludiValori;
  //Memorizzo i dati del nodo precedente
  PSelezione(Componenti.Items[VecchioNodo]).DaValore:=CBDaValore.Text;
  PSelezione(Componenti.Items[VecchioNodo]).AValore:=CBAValore.Text;
  PSelezione(Componenti.Items[VecchioNodo]).CaseInsensitive:=False;
  if (CBDaValore.Text <> '') or (CBAValore.Text <> '') then
    PSelezione(Componenti.Items[VecchioNodo]).CaseInsensitive:=chkCaseInsensitive.Checked;
  //CheckListBox
  if PSelezione(Componenti.Items[VecchioNodo]).Esistente then
    PutCheck(PSelezione(Componenti.Items[VecchioNodo]).SelValori);
  PSelezione(Componenti.Items[VecchioNodo]).EscludiValori:=False;
  if PSelezione(Componenti.Items[VecchioNodo]).SelValori.Count > 0 then
    PSelezione(Componenti.Items[VecchioNodo]).EscludiValori:=chkEscludiValori.Checked;
  //Verifico se ci sono dei cambiamenti nella selezione per annullare eventualmente quella manuale
  if (Old_Da <> CBDaValore.Text) or
     (Old_A <> CBAValore.Text) or
     (Old_CaseInsensitive <> PSelezione(Componenti.Items[VecchioNodo]).CaseInsensitive) or
     (Old_In <> PSelezione(Componenti.Items[VecchioNodo]).SelValori.Text) or
     (Old_EscludiValori <> PSelezione(Componenti.Items[VecchioNodo]).EscludiValori)
  then
  begin
    SQLCreato.Clear;
    cmbSelezione.Text:='';  //Alberto 14/06/2006
  end;
  if (Trim(CBDaValore.Text) <> '') or (Trim(CBAValore.Text) <> '') or
     (PSelezione(Componenti.Items[VecchioNodo]).SelValori.Count > 0) then
  begin
    //Se sono specificati dei dati significativi annullo la selezione manuale e
    //riporto il dato in ordinamento
    if LBOrdinamento.Items.IndexOf(TVAzienda.Items[VecchioNodo].Text) = -1 then
       LBOrdinamento.Items.Add(TVAzienda.Items[VecchioNodo].Text);
  end;
end;

procedure TC600FSelezioneAnagrafe.TVAziendaDblClick(Sender: TObject);
{Selezione di una colonna}
var I:Integer;
begin
  if TVAzienda.Selected = nil then exit;
  I:=TVAzienda.Selected.Index;
  VecchioNodo:=I;
  if not PSelezione(Componenti.Items[i]).Esistente then
    //Costruisco la query per estrarre la colonna richiesta
    with C600FSelezioneAnagrafeDtM.selDistinct do
    begin
      Screen.Cursor:=crHourGlass;
      CBDaValore.Text:='';
      CBAValore.Text:='';
      Close;
      QueryDinamica(0);
      try
        Open;
      except
        actGenerazioneSelezioneExecute(nil);
        QueryDinamica(0);
        Open;
      end;
      //Riempo la lista con i dati della tabella
      PSelezione(Componenti.Items[I]).TotValori.Clear;
      PSelezione(Componenti.Items[I]).TotValori.BeginUpdate;
      while not Eof do
      begin
        PSelezione(Componenti.Items[I]).TotValori.Add(Fields[0].AsString);
        Next;
      end;
      PSelezione(Componenti.Items[I]).TotValori.EndUpdate;
      CBValori.Items.Assign(PSelezione(Componenti.Items[I]).TotValori);
      CBDaValore.Items.Assign(CBValori.Items);
      CBAValore.Items.Assign(CBValori.Items);
      PSelezione(Componenti.Items[i]).Esistente:=True;
      CBDaValore.Text:=PSelezione(Componenti.Items[I]).DaValore;
      CBAValore.Text:=PSelezione(Componenti.Items[I]).AValore;
      chkCaseInsensitive.Checked:=False;
      if (CBDaValore.Text <> '') or (CBAValore.Text <> '') then
        chkCaseInsensitive.Checked:=PSelezione(Componenti.Items[I]).CaseInsensitive;
      chkEscludiValori.Checked:=False;
      GetCheck(PSelezione(Componenti.Items[I]).SelValori);
      if PSelezione(Componenti.Items[I]).SelValori.Count > 0 then
        chkEscludiValori.Checked:=PSelezione(Componenti.Items[I]).EscludiValori;
      CBDaValore.Enabled:=True;
      CBAValore.Enabled:=True;
      CBValori.Enabled:=True;
      Screen.Cursor:=crDefault;
   end;
end;

procedure TC600FSelezioneAnagrafe.QueryDinamica(Modo:Byte);
var i:Integer;
    S,Filtro,OrderBy:String;
    Q:TOracleDataSet;
  function GetHintT030V430:String;
  begin
    Result:=IfThen(chkCessati.Checked,Parametri.CampiRiferimento.C26_HintT030V430,Parametri.CampiRiferimento.C26_HintT030V430_NC);
  end;
  function GetHintT030V430NoTag:String;
  begin
    Result:=StringReplace(StringReplace(GetHintT030V430,'/*+','',[]),'*/','',[]);
  end;
begin
  Q:=C600FSelezioneAnagrafeDtM.selDistinct;
  CorpoSQL.Clear;
  //Colonne restituite dalla select
  case Modo of
    0:begin
        S:='DISTINCT ' + Parametri.ColonneStruttura.Values[TVAzienda.Selected.Text];  //Selezione di una colonna specifica
        Q:=C600FSelezioneAnagrafeDtM.selDistinct;
      end;
    1:begin
        S:=C600CampiBase;//'MATRICOLA,COGNOME,NOME,T430BADGE,T430INIZIO,T430FINE,PROGRESSIVO';//Dati anagrafici di base
        Q:=C600FSelezioneAnagrafeDtM.selAnagrafe;
      end;
    2:begin
        S:=C600DatiSelezionati;    //Dati anagrafici richiesti
        Q:=C600FSelezioneAnagrafeDtM.selAnagrafe;
      end;
  end;
  with Q do
  begin
    CloseAll;
    //Gestione Query periodica
    if grpSelezionePeriodica.Enabled and (grpSelezionePeriodica.ItemIndex = 1) then
    begin
      SQL.Assign(ListSQLPeriodico);
      SQL.Delete(0);
      SQL.Insert(0,Format('SELECT %s %s FROM',[GetHintT030V430,S]));
      SQL.Text:=StringReplace(SQL.Text,'HintT030V430',GetHintT030V430NoTag,[rfIgnoreCase,rfReplaceAll]);
      CorpoSQL.Assign(ListSQLPeriodico);
      CorpoSQL.Delete(0);
      CorpoSQL.Text:=StringReplace(CorpoSQL.Text,'HintT030V430',GetHintT030V430NoTag,[rfIgnoreCase,rfReplaceAll]);
      Filtro:='';
      OrderBy:='';
      //Filtro sui soli dipendenti in servizio
      if not chkCessati.Checked then
        Filtro:=Filtro + 'AND :DATALAVORO >= T430INIZIO AND :C700DATADAL <= NVL(T430FINE,:DATALAVORO)' + #13#10;
      //Gestione del filtro sui soli dipendenti in servizio ereditato dalla selezione principale
      //commutazione dalla gestione non periodica a quella periodica
      S:=Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]);
      if Pos(S,CorpoSQL.Text) > 0 then
      begin
        SQL.Text:=SQL.Text.Replace(S,Format(QDipInServizioPeriodica,[IntToStr(Parametri.ValiditaCessati)]));
        CorpoSQL.Text:=CorpoSQL.Text.Replace(S,Format(QDipInServizioPeriodica,[IntToStr(Parametri.ValiditaCessati)]));
      end;
      //Alberto: solo personale interno
      if (not chkEsterni.Visible) or (not chkEsterni.Checked) then
        Filtro:=Filtro + 'AND T030.TIPO_PERSONALE = ''I''' + #13#10;
      if Singolodipendente1.Checked then
        Filtro:=Filtro + 'AND T030.PROGRESSIVO = ' + IntToStr(C600FSelezioneAnagrafeDtM.C600Progressivo) + #13#10;
      with SQLCreato do
        for i:=0 to Count - 1 do
          if Pos('ORDER BY',Strings[i]) = 0 then
          begin
            if i = 0 then
              Filtro:=Filtro + 'AND' + #13#10;
            Filtro:=Filtro + Strings[i] + #13#10;
          end
          else if Modo > 0 then
            OrderBy:=OrderBy + Strings[i] + #13#10
          else Break;
      if OrderBy <> '' then
        SQL.Add(OrderBy);
      DeleteVariables;
      DeclareVariable('DATALAVORO',otDate);
      DeclareVariable('C700DATADAL',otDate);
      DeclareVariable('C700FILTRO',otSubst);
      SetVariable('DATALAVORO',DataLavoro);
      SetVariable('C700DATADAL',DataDal);
      SetVariable('C700FILTRO',Filtro);
      exit;
    end;
    SQL.Assign(ListSQL);
    SQL.Delete(0);
    SQL.Insert(0,Format('SELECT %s %s FROM',[IfThen(chkCessati.Checked,Parametri.CampiRiferimento.C26_HintT030V430,Parametri.CampiRiferimento.C26_HintT030V430_NC),S]));
    CorpoSQL.Assign(ListSQL);
    CorpoSQL.Delete(0);
    //Filtro sui soli dipendenti in servizio
    if not chkCessati.Checked then
    begin
      S:='AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)';
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    //Gestione del filtro sui soli dipendenti in servizio ereditato dalla selezione principale
    //commutazione dalla gestione periodica a quella non periodica
    S:=Format(QDipInServizioPeriodica,[IntToStr(Parametri.ValiditaCessati)]);
    if Pos(S,CorpoSQL.Text) > 0 then
    begin
      SQL.Text:=SQL.Text.Replace(S,Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]));
      CorpoSQL.Text:=CorpoSQL.Text.Replace(S,Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]));
    end;
    //Alberto: solo personale interno
    if (not chkEsterni.Visible) or (not chkEsterni.Checked) then
    begin
      S:='AND T030.TIPO_PERSONALE = ''I''';
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    if Singolodipendente1.Checked then
    begin
      S:='AND T030.PROGRESSIVO = ' + IntToStr(C600FSelezioneAnagrafeDtM.C600Progressivo);
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    with SQLCreato do
      for i:=0 to Count - 1 do
        if Pos('ORDER BY',UpperCase(Trim(Strings[i]))) <> 1 then
        begin
          if i = 0 then
          begin
            SQL.Add('AND');
            CorpoSQL.Add('AND');
          end;
          SQL.Add(Strings[i]);
          CorpoSQL.Add(Strings[i]);
        end
        else if Modo > 0 then SQL.Add(Strings[i])
        else Break;
    if Modo = 0 then
      SQL.Add('ORDER BY ' + Parametri.ColonneStruttura.Values[TVAzienda.Selected.Text]);
    DeleteVariables;
    DeclareVariable('DATALAVORO',otDate);
    SetVariable('DATALAVORO',DataLavoro);
  end;
end;

procedure TC600FSelezioneAnagrafe.Ricercatestocontenuto1Click(Sender: TObject);
var TN:TTreeNode;
begin
  if TVAzienda.Selected = nil then
    exit;
  TVAziendaSearch:=Trim(InputBox('Ricerca per testo contenuto','Nome dato',TVAziendaSearch));
  TN:=TVAzienda.Items[0];
  while TN <> nil do
  begin
    TN:=TN.getNextSibling;
    if (TN <> nil) and (Pos(UpperCase(TVAziendaSearch),UpperCase(TN.Text)) > 0 ) then
    begin
      TVAzienda.Select(TN,[]);
      Break;
    end;
  end;
end;

procedure TC600FSelezioneAnagrafe.Successivo1Click(Sender: TObject);
var TN:TTreeNode;
begin
  if TVAzienda.Selected = nil then
    exit;
  if TVAziendaSearch = '' then
  begin
    Ricercatestocontenuto1Click(nil);
    exit;
  end;
  TN:=TVAzienda.Selected;
  while TN <> nil do
  begin
    TN:=TN.getNextSibling;
    if (TN <> nil) and (Pos(UpperCase(TVAziendaSearch),UpperCase(TN.Text)) > 0 ) then
    begin
      TVAzienda.Select(TN,[]);
      Break;
    end;
  end;
end;

procedure TC600FSelezioneAnagrafe.GetCheck(Source:TStringList);
{Leggo gli Items di Source e li Checko in CBValori}
var i,j:Integer;
begin
  for i:=0 to Source.Count - 1 do
  begin
    j:=CBValori.Items.IndexOf(Source[i]);
    if j > -1 then
      CBValori.Checked[j]:=True;
  end;
end;

procedure TC600FSelezioneAnagrafe.PutCheck(Dest:TStringList);
{Salvo gli Items Checkati in SelValori}
var i:Integer;
begin
  Dest.Clear;
  for i:=0 to CBValori.Items.Count - 1 do
    if CBValori.Checked[i] then
      Dest.Add(CBValori.Items[i]);
end;

procedure TC600FSelezioneAnagrafe.TVAziendaExit(Sender: TObject);
{Gestione dati selezionati in uscita dal TreeView}
begin
  BitBtn1.Default:=True;
  BitBtn3.Cancel:=True;
  GestioneVecchioNodo;
end;

procedure TC600FSelezioneAnagrafe.LBOrdinamentoDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source = TVAzienda then
    //Drag&Drop da TreeView
    Accept:=LBOrdinamento.Items.IndexOf((Source as TTreeView).Selected.Text) = -1
  else
    if Source = Sender then
      //Drag&Drop da sè stesso per spostamento Items
      Accept:=True;
end;

procedure TC600FSelezioneAnagrafe.LBOrdinamentoDragDrop(Sender, Source: TObject;
  X, Y: Integer);
{Inserimento Campo di ordinamento}
var i:Integer;
    Punto:TPoint;
begin
  Punto.X:=X;
  Punto.Y:=Y;
  i:=LBOrdinamento.ItemAtPos(Punto,True);
  if Source = TVAzienda then
    //Inserimento da TVAzienda
    begin
    if i = -1 then
      LBOrdinamento.Items.Add((Source as TTreeView).Selected.Text)
    else
      LBOrdinamento.Items.Insert(i,(Source as TTreeView).Selected.Text)
    end
  else
    if (Source = Sender) and (i > -1) then
      //Spostamento Campo di ordinamento
      LBOrdinamento.Items.Move(LBOrdinamento.itemIndex,i);
  //Alberto 14/06/2006
  SQLCreato.Clear;
  cmbSelezione.Text:='';
end;

procedure TC600FSelezioneAnagrafe.LBOrdinamentoDblClick(Sender: TObject);
{Cancellazione Campo di ordinamento}
begin
  LBOrdinamento.Items.Delete(LBOrdinamento.ItemIndex);
  //Alberto 14/06/2006
  SQLCreato.Clear;
  cmbSelezione.Text:='';
end;

procedure TC600FSelezioneAnagrafe.actGenerazioneSelezioneExecute(Sender: TObject);
{Generazione SQL}
var i,P:Integer;
    Da,A,Oppure,Ordina,VecchioMemo,Campo1,Valore1,Valore2:String;
begin
  GestioneVecchioNodo;
  //Memorizzo la vecchia selezione e tolgo la parte ORDER BY
  VecchioMemo:=SQLCreato.Text;
  i:=Pos('ORDER BY',VecchioMemo);
  if i > 0 then
    VecchioMemo:=Copy(VecchioMemo,1,i - 1);
  SQLCreato.Clear;
  for i:=0 to TVAzienda.Items.Count - 1 do
    begin
    //Costruzione CAMPO1 >= ... AND CAMPO1 <= ...
    Da:='';
    A:='';
    Oppure:='';
    //Imposto il prefisso della tabella prima del campo
    Campo1:=PrefissoTabella(Parametri.ColonneStruttura.Values[TVAzienda.Items[i].Text]);
    Valore1:=PSelezione(Componenti.Items[i]).DaValore;
    Valore2:=PSelezione(Componenti.Items[i]).AValore;
    P:=Parametri.ColonneStruttura.IndexOfName(TVAzienda.Items[i].Text);
    if (Valore1 <> '') and (Valore2 <> '') then
    begin
      if Valore1 = Valore2 then
      begin
        if Pos('%',Valore1) = 0 then
          Da:=FormatoCampo(Campo1,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P]) + ' = ' + FormatoValore(Valore1,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P])
        else
          Da:=FormatoCampo(Campo1,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P]) + ' LIKE ' +  FormatoValore(Valore1,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P]);
      end
      else
        Da:=Format('%s BETWEEN %s AND %s',[FormatoCampo(Campo1,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P]),
                                           FormatoValore(Valore1,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P]),
                                           FormatoValore(Valore2,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P])])
    end
    else
    begin
      if Valore1 <> '' then
        Da:=FormatoCampo(Campo1,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P]) + ' >= ' + FormatoValore(Valore1,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P]);
      if Valore2 <> '' then
        A:=FormatoCampo(Campo1,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P]) + ' <= ' + FormatoValore(Valore2,PSelezione(Componenti.Items[i]).CaseInsensitive,Parametri.TipiStruttura[P]);
      if (Da <> '') and (A <> '') then
        Da:=Da + ' AND ';
      Da:=Da + A;
    end;
    if Da <> '' then Da:='(' + Da + ')';
    //Costruzione CAMPO1 IN (...)
    Oppure:=ValoriSelezionati(Campo1,PSelezione(Componenti.Items[i]).SelValori,PSelezione(Componenti.Items[i]).EscludiValori,Parametri.TipiStruttura[P]);
    //if Oppure <> '' then Oppure:='(' + Oppure + ')';
    if (Da <> '') and (Oppure <> '') then
      Da:=Da + ' OR ';
    Da:=Da + Oppure;
    if Da <> '' then
      begin
      Da:='(' + Da + ')';
      if SQLCreato.Count > 0 then
        Da:=' AND ' + Da;
      SQLCreato.Add(Da);
      end;
    end;
  //Se è cambiata la selezione reimposto Esistente = False
  //per tutti i dati
  if VecchioMemo <> SQLCreato.Text then
    AggiornaSelezione;
  Ordina:='';
  for i:=0 to LBOrdinamento.Items.Count - 1 do
    Ordina:=Ordina + ', ' + PrefissoTabella(Parametri.ColonneStruttura.Values[LBOrdinamento.Items[i]]);
  if LBOrdinamento.Items.IndexOf('COGNOME') = -1 then
    Ordina:=Ordina + ', ' + PrefissoTabella('COGNOME');
  if LBOrdinamento.Items.IndexOf('NOME') = -1 then
    Ordina:=Ordina + ', ' + PrefissoTabella('NOME');
  if LBOrdinamento.Items.IndexOf('MATRICOLA') = -1 then
    Ordina:=Ordina + ', ' + PrefissoTabella('MATRICOLA');
  if Ordina <> '' then
    SQLCreato.Add('ORDER BY ' + Copy(Ordina,3,Length(Ordina)));
  // split a 2000 caratteri per ogni riga di codice sql
  R180SplitLines(SQLCreato);    
end;

function TC600FSelezioneAnagrafe.PrefissoTabella(Campo:String):String;
{Cerca la tabella di cui fa parte Campo tra T030,T480,V430}
begin
  Result:=AliasTabella(Campo) + '.' + Campo;
end;

function TC600FSelezioneAnagrafe.FormatoCampo(Campo:String; CaseInsensitive:Boolean; Tipo:String):String;
{ se il campo rientra nella lista di quelli da trattare come "case insensitive"
  utilizza il formato "UPPER(CAMPO)"
  altrimenti lascia il campo inalterato }
begin
  Result:=Campo;
  if (TFieldType(StrToInt(Tipo)) = ftString) and CaseInsensitive then
    Result:='UPPER(' + Result + ')';
end;

function TC600FSelezioneAnagrafe.FormatoValore(Valore:String; CaseInsensitive:Boolean; Tipo:String):String;
{Formatta il valore inserendo gli apici se stringa,
 e trasformando la data in dd/mm/yyyy
 Inoltre valuta se considerare il campo case insensitive, utilizzando il formato
 "UPPER(campo)" (ha senso solo per i campi di tipo string) }
begin
  if Valore = '' then
    Result:=''''''
  else
  case TFieldType(StrToInt(Tipo)) of
    ftString:
    begin
      Result:='''' + AggiungiApice(Valore) + '''';
      if CaseInsensitive then
        Result:='UPPER(' + Result + ')';
    end;
    ftTime:
      Result:='''' + AggiungiApice(Valore) + '''';
    ftDate,ftDateTime:
      Result:='''' + FormatDateTime('dd/mm/yyyy',StrToDate(Valore)) + '''';
    else
      Result:=Valore;
  end;
end;

function TC600FSelezioneAnagrafe.ValoriSelezionati(Campo:String; Lista:TStringList; EscludiValori:Boolean; Tipo:String):String;
{ Gestione della lista con i valori per la costruzione
  della sintassi CAMPO1 IN (VALORE1, VALORE2,...) OR CAMPO1 IS NULL }
var i:Integer;
    Nullo:Boolean;
begin
  Result:='';
  Nullo:=False;

  // gestione della lista di valori
  for i:=0 to Lista.Count - 1 do
  begin
    if FormatoValore(Lista[i],False,Tipo) = '''''' then
      Nullo:=True
    else
    begin
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + FormatoValore(Lista[i],False,Tipo);
    end;
  end;
  if Result <> '' then
    Result:=FormatoCampo(Campo,False,Tipo) + IfThen(EscludiValori,' NOT') + ' IN (' + Result + ')';

  // gestione del valore null
  if Nullo then
  begin
    if Result <> '' then
    begin
      if EscludiValori then
        Result:='(' + Result + ' AND ' + Campo + ' IS NOT NULL' + ')'
      else
        Result:='(' + Result + ' OR ' + Campo + ' IS NULL' + ')';
    end
    else
      Result:=Campo + ' IS' + IfThen(EscludiValori,' NOT') + ' NULL';
  end;
end;

procedure TC600FSelezioneAnagrafe.actModificaSelezioneExecute(Sender: TObject);
{Modifica istruzione SQL}
begin
  if SQLCreato.Count = 0 then
    actGenerazioneSelezioneExecute(nil);
  C700FSQL.Memo1.Lines.Assign(SQLCreato);
  if C700FSQL.ShowModal = mrOK then
  begin
    // split a 2000 caratteri per ogni riga di codice sql
    R180SplitLines(C700FSQL.Memo1.Lines);
    SQLCreato.Assign(C700FSQL.Memo1.Lines);
    actConfermaExecute(nil);
  end;
end;

procedure TC600FSelezioneAnagrafe.Panel1Exit(Sender: TObject);
begin
  GestioneVecchioNodo;
end;

procedure TC600FSelezioneAnagrafe.actAnnullaSelezioneExecute(Sender: TObject);
{Annullo tutti i parametri di selezione}
var i:Integer;
begin
  SQLCreato.Clear;
  if Sender = actAnnullaSelezione then
    cmbSelezione.Text:='';
  LBOrdinamento.Items.Clear;
  CBDaValore.Text:='';
  CBAValore.Text:='';
  for i:=0 to TVazienda.Items.Count - 1 do
  begin
    //se era stata generata un'istruzione, resetto il parametro...
    //...Esistente in modo da ripetere la Query
    PSelezione(Componenti.Items[i]).Esistente:=False;
    PSelezione(Componenti.Items[i]).DaValore:='';
    PSelezione(Componenti.Items[i]).AValore:='';
    PSelezione(Componenti.Items[i]).SelValori.Clear;
    PSelezione(Componenti.Items[i]).CaseInsensitive:=False;
    PSelezione(Componenti.Items[i]).EscludiValori:=False;
  end;
  if TVAzienda.Items.Count > 0 then
    TVAziendaChange(TVAzienda,TVAzienda.Items[TVAzienda.Selected.Index]);
  if Sender = actAnnullaSelezione then
    actConfermaExecute(actAnnullaSelezione);
end;

procedure TC600FSelezioneAnagrafe.AggiornaSelezione;
{Resetto Esistente = False per forzare la rigenerazione della Query}
var i:Integer;
begin
  for i:=0 to TVAzienda.Items.Count - 1 do
    PSelezione(Componenti.Items[i]).Esistente:=False;
  if TVAzienda.Items.Count > 0 then
    TVAziendaChange(TVAzienda,TVAzienda.Items[TVAzienda.Selected.Index]);
end;

procedure TC600FSelezioneAnagrafe.actConfermaExecute(Sender: TObject);
{Conferma della selezione e ritorno al chiamante}
var Modo:Byte;
    ProgressivoSelezionato:Integer;
    S:String;
begin
  ProgressivoSelezionato:=C600FSelezioneAnagrafeDtM.C600Progressivo;
  if Visible then
    cmbSelezione.SetFocus;
  //Imposto il flag  in modo da restituire le colonne volute
  if Sender = actConferma then
    Modo:=2  //Restituisco i campi specificati dal chiamante
  else
    Modo:=1;  //Restituisco C700CampiBase
  if (SQLCreato.Count = 0) (*or (Sender = actGenerazioneSelezione)*) then
    actGenerazioneSelezioneExecute(nil);
  QueryDinamica(Modo);
  try
    with TOracleQuery.Create(nil) do
    try
      Session:=C600FSelezioneAnagrafeDtM.selAnagrafe.Session;
      begin
        Variables.Assign(C600FSelezioneAnagrafeDtM.selAnagrafe.Variables);
        SQL.Assign(C600FSelezioneAnagrafeDtM.selAnagrafe.SQL);
      end;
      Describe;
    finally
      Free;
    end;
  except
    SQLCreato.Clear;
    actGenerazioneSelezioneExecute(nil);
  end;
  //Alberto 16/06/2006: se si preme 'Annulla selezione' si esegue l'anteprima vuota
  if Sender = actAnnullaSelezione then
  begin
    S:=C600FSelezioneAnagrafeDtM.selAnagrafe.SQL.Text;
    if Pos('ORDER BY',UpperCase(S)) > 0 then
    begin
      Insert(' AND T030.PROGRESSIVO = 0 ',S,Pos('ORDER BY',UpperCase(S)));
      C600FSelezioneAnagrafeDtM.selAnagrafe.SQL.Text:=S;
    end;
  end;
  if (Modo = 1) or OpenC600SelAnagrafe then
    try
      Screen.Cursor:=crHourGlass;
      C600FSelezioneAnagrafeDtM.selAnagrafe.Open
    finally
      Screen.Cursor:=crDefault;
    end
  else
  begin
    ModalResult:=mrOK;
    exit;
  end;
  if Sender = actConferma then
  begin
    //Esco dalla Form
    C600FSelezioneAnagrafeDtM.selAnagrafe.SearchRecord('Progressivo',ProgressivoSelezionato,[srFromBeginning]);
    ModalResult:=mrOK;
  end
  else
  with C600FSelezioneAnagrafeDtM.selAnagrafe do
  begin
    try FieldByName('T430BADGE').DisplayLabel:='BADGE'; except end;
    try FieldByName('T430INIZIO').DisplayLabel:='INIZIO'; except end;
    try FieldByName('T430FINE').DisplayLabel:='FINE'; except end;
    try FieldByName('COGNOME').DisplayWidth:=15; except end;
    try FieldByName('NOME').DisplayWidth:=15; except end;
    try FieldByName('T430INIZIO').DisplayWidth:=10; except end;
    try FieldByName('T430FINE').DisplayWidth:=10; except end;
    try FieldByName('T430AZIENDA_BASE').Visible:=False; except end;
    try FieldByName('T430D_AZIENDA_BASE').Visible:=False; except end;
    StatusBar1.Panels[0].Text:=Format('%d Anagrafiche selezionate',[RecordCount]);
  end;
end;

procedure TC600FSelezioneAnagrafe.FormDestroy(Sender: TObject);
begin
  PulisciListe;
  Componenti.Free;
  ListSQL.Free;
  ListSQLPeriodico.Free;
  CorpoSQL.Free;
  //caratto 16/01/2015 memory leak fin dalle origini
  SqlCreato.Free;
  C600FSelezioneAnagrafeDtM.Free;
  C600FSelezioneAnagrafeDtM:=nil;
end;

procedure TC600FSelezioneAnagrafe.FormDeactivate(Sender: TObject);
begin
  WhereSql:=SQLCreato.Text;
end;

procedure TC600FSelezioneAnagrafe.CBAValoreEnter(Sender: TObject);
begin
  if CBAValore.Text = '' then
    CBAValore.Text:=CBDaValore.Text;
end;

procedure TC600FSelezioneAnagrafe.FormShow(Sender: TObject);
begin
  TVAzienda.OnChange:=TVAziendaChange;
  with C600FSelezioneAnagrafeDtM.selAnagrafe do
  begin
    if not Active then
    begin
      Screen.Cursor:=crHourGlass;
      try
        Open;
      finally
        Screen.Cursor:=crDefault;
      end;
      StatusBar1.Panels[0].Text:=Format('%d Anagrafiche selezionate',[RecordCount]);
    end;
    if RecordCount = 0 then
      PulisciVecchiaSelezione:=True;
    try FieldByName('T430BADGE').DisplayLabel:='BADGE'; except end;
    try FieldByName('T430INIZIO').DisplayLabel:='INIZIO'; except end;
    try FieldByName('T430FINE').DisplayLabel:='FINE'; except end;
    try FieldByName('COGNOME').DisplayWidth:=15; except end;
    try FieldByName('NOME').DisplayWidth:=15; except end;
    try FieldByName('T430INIZIO').DisplayWidth:=10; except end;
    try FieldByName('T430FINE').DisplayWidth:=10; except end;
    try FieldByName('T430AZIENDA_BASE').Visible:=False; except end;
    try FieldByName('T430D_AZIENDA_BASE').Visible:=False; except end;
  end;
  grpSelezionePeriodica.Items[0]:='al ' + FormatDateTime('dd/mm/yyyy',DataLavoro);
  grpSelezionePeriodica.Items[1]:='dal ' + FormatDateTime('dd/mm/yyyy',DataDal) + ' al ' + FormatDateTime('dd/mm/yyyy',DataLavoro);
  C700FSQL:=TC700FSQL.Create(nil);
  dgrdAnteprima.DataSource:=C600FSelezioneAnagrafeDtM.dscAnagrafe;
  if PulisciVecchiaSelezione then
    actAnnullaSelezioneExecute(nil);
end;

procedure TC600FSelezioneAnagrafe.actAnnullaExecute(Sender: TObject);
begin
  ModalResult:=mrAbort;
end;

procedure TC600FSelezioneAnagrafe.actApriSelezioneExecute(Sender: TObject);
begin
  if cmbSelezione.Items.IndexOf(cmbSelezione.Text) < 0 then
    raise Exception.Create('Specificare il nome della selezione');
  actAnnullaSelezioneExecute(nil);
  with C600FSelezioneAnagrafeDtM.selT003 do
  begin
    Close;
    SetVariable('Nome',cmbSelezione.Text);
    Open;
    if RecordCount = 0 then exit;
    SQLCreato.Clear;
    while not Eof do
    begin
      SQLCreato.Add(FieldByName('Riga').AsString);
      Next;
    end;
  end;
  actConfermaExecute(Sender);
end;

procedure TC600FSelezioneAnagrafe.actEliminaSelezioneExecute(Sender: TObject);
begin
  if cmbSelezione.Items.IndexOf(cmbSelezione.Text) < 0 then
    exit;
  if MessageDlg(Format('Eliminare la selezione ''%s''?',[cmbSelezione.Text]),mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  with C600FSelezioneAnagrafeDtM.delT003 do
  begin
    SetVariable('Nome',cmbSelezione.Text);
    Execute;
    DataBase.Commit;
  end;
  A000AggiornaFiltroDizionario('SELEZIONI ANAGRAFICHE',cmbSelezione.Text,'');
  cmbSelezione.Text:='';
  C600FSelezioneAnagrafeDtM.GetNomeSelezioni;
end;

procedure TC600FSelezioneAnagrafe.actSalvaSelezioneExecute(Sender: TObject);
var i:Integer;
    Trovato:Boolean;
begin
  if Trim(cmbSelezione.Text) = '' then
    raise Exception.Create('Specificare il nome della selezione');
  if SQLCreato.Count = 0 then
    actGenerazioneSelezioneExecute(nil);
  //Verifico esistenza della selezione da salvare direttamente sul dataset senza filtro per annullare eventuale filtro dizionario.
  with C600FSelezioneAnagrafeDtM.selT003Nome do
  try
    Filtered:=False;
    Open;
    Trovato:=SearchRecord('NOME',cmbSelezione.Text,[srFromBeginning]);
  finally
    Filtered:=True;
    Close;
  end;
  if Trovato then
    //non posso sovrascrivere, oppure la selezione non è visibile nel mio filtro dizionario
    if (Parametri.C700_SalvaSelezioni <> 'S') or (cmbSelezione.Items.IndexOf(cmbSelezione.Text) < 0) then
      raise Exception.Create(Format('Selezione ''%s'' già esistente: impossibile sovrascrivere!',[cmbSelezione.Text]))
    else if MessageDlg(Format('Selezione ''%s'' già esistente: sovrascrivere?',[cmbSelezione.Text]),mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      exit;
  with C600FSelezioneAnagrafeDtM.delT003 do
  begin
    SetVariable('Nome',cmbSelezione.Text);
    Execute;
  end;
  with C600FSelezioneAnagrafeDtM.insT003 do
  begin
    SetVariable('Nome',cmbSelezione.Text);
    for i:=0 to SQLCreato.Count - 1 do
      if Trim(SQLCreato[i]) <> '' then
      begin
        SetVariable('Posizione',i);
        SetVariable('Riga',Trim(SQLCreato[i]));
        Execute;
      end;
    DataBase.Commit;
    A000AggiornaFiltroDizionario('SELEZIONI ANAGRAFICHE','',cmbSelezione.Text);
  end;
  C600FSelezioneAnagrafeDtM.GetNomeSelezioni;
end;

procedure TC600FSelezioneAnagrafe.cmbSelezioneDblClick(Sender: TObject);
begin
  actApriSelezioneExecute(nil);
end;

procedure TC600FSelezioneAnagrafe.TVAziendaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    BitBtn1.Default:=True;
    BitBtn3.Cancel:=True;
  end;
  if Key = VK_F2 then
    TVAzienda.Selected.EditText;
end;

procedure TC600FSelezioneAnagrafe.TVAziendaEdited(Sender: TObject;
  Node: TTreeNode; var S: String);
{Ricerca dei dipendenti sul TreeView}
begin
  inherited;
  CBDaValore.Text:=S;
  CBAValore.Text:=S;
  S:=TreeNodeOrig;
  BitBtn1.Default:=True;
  BitBtn3.Cancel:=True;
  CBDaValore.SetFocus;
end;

procedure TC600FSelezioneAnagrafe.TVAziendaEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
  actAnnullaSelezioneExecute(nil);
  TreeNodeOrig:=Node.Text;
  BitBtn1.Default:=False;
  BitBtn3.Cancel:=False;
end;

procedure TC600FSelezioneAnagrafe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  C700FSQL.Free;
end;

procedure TC600FSelezioneAnagrafe.Singolodipendente1Click(Sender: TObject);
begin
  Singolodipendente1.Checked:=not Singolodipendente1.Checked;
  actConfermaExecute(nil);
end;

procedure TC600FSelezioneAnagrafe.mnuRicercaCompletaClick(Sender: TObject);
begin
  mnuRicercaCompleta.Checked:=not mnuRicercaCompleta.Checked;
  (*C700FSelezioneAnagrafeDtM.*)CaricaTVAzienda(mnuRicercaCompleta.Checked);
end;

procedure TC600FSelezioneAnagrafe.Splitter1Moved(Sender: TObject);
begin
  CBDaValore.Width:=Panel2.Width - 32;
  CBAValore.Width:=Panel2.Width - 32;
end;

procedure TC600FSelezioneAnagrafe.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to CBValori.Items.Count - 1 do
    CBValori.Checked[i]:=Sender = Selezionatutto1;
end;

procedure TC600FSelezioneAnagrafe.CaricaTVAzienda(Completa:Boolean);
var j:Integer;
    P:PSelezione;
    S:String;
begin
  with C600FSelezioneAnagrafeDtM do
  begin
    PulisciListe;
    TVAzienda.OnChange:=nil;
    TVAzienda.Items.BeginUpdate;
    TVAzienda.Items.Clear;
    QCols.SetVariable('APPLICAZIONE',Parametri.Applicazione);
    QCols.Open;
    QCols.First;
    while not QCols.Eof do
    begin
      if Completa or ((not QCols.FieldByName('RICERCA').IsNull) and (QCols.FieldByName('RICERCA').AsInteger >= 0)) then
      begin
        S:=QCols.FieldByName('NOME_CAMPO').AsString;
        if Copy(S,1,6) = 'T430D_' then
          S:=Copy(S,7,Length(S))
        else if Copy(S,1,4) = 'T430' then
          S:=Copy(S,5,Length(S));
        if (Copy(S,1,4) = 'P430') or (S = 'PROGRESSIVO') or
           ((selbT033.RecordCount = 0) or
            (selbT033.SearchRecord('CAMPODB',VarArrayOf([S]),[srFromBeginning]))) then
        begin
          TVAzienda.Items.Add(nil,QCols.FieldByName('NOME_LOGICO').AsString);
          New(P);
          j:=Componenti.Add(P);
          PSelezione(Componenti.Items[j]).DaValore:='';
          PSelezione(Componenti.Items[j]).AValore:='';
          PSelezione(Componenti.Items[j]).TotValori:=TStringList.Create;
          PSelezione(Componenti.Items[j]).SelValori:=TStringList.Create;
          PSelezione(Componenti.Items[j]).Esistente:=False;
          PSelezione(Componenti.Items[j]).EscludiValori:=False;
          PSelezione(Componenti.Items[j]).CaseInsensitive:=False;
        end;
      end;
      QCols.Next;
    end;
    TVAzienda.Items.EndUpdate;
    TVAzienda.OnChange:=TVAziendaChange;
    if TVAzienda.Items.Count > 0 then
      TVAzienda.Selected:=TVAzienda.Items[0];
    QCols.Close;
  end;
end;

end.
