unit A092UStampaStorico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin ,C001StampaLib, C180FunzioniGenerali,A000UCostanti, A000USessione,A000UInterfaccia,
  Grids, DBGrids, ExtCtrls,DB,ComCtrls, checklst, Menus, StrUtils,
  A003UDataLavoroBis, C004UParamForm, QueryStorico,
  SelAnagrafe, C700USelezioneAnagrafe, C005UDatiAnagrafici, Variants, A000UMessaggi, InputPeriodo;

type
  TA092FStampaStorico = class(TForm)
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnlEsporta: TPanel;
    splMain: TSplitter;
    pnlMain: TPanel;
    Label1: TLabel;
    ListaAnagra: TCheckListBox;
    chkSaltoPagina: TCheckBox;
    rgpOrdinamento: TRadioGroup;
    chkVariazioni: TCheckBox;
    PrinterSetupDialog1: TPrinterSetupDialog;
    pnlBottoni: TPanel;
    BtnPrinterSetUp: TBitBtn;
    BtnPreView: TBitBtn;
    BtnClose: TBitBtn;
    BtnStampa: TBitBtn;
    btnEsporta: TBitBtn;
    dgrdEsporta: TDBGrid;
    pmnEsporta: TPopupMenu;
    CopiainExcel: TMenuItem;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnPreViewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListaAnagraMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListaAnagraMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnEsportaClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure CopiainExcelClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  Private
    ItemSort:Integer;
    procedure ScorriQueryAnagrafica;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure  ControllaPeriodo;
    procedure PreView(Sender: TObject);
    function  ControlliValidità:boolean;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    FlagStatus:Boolean;
    Stipendi:Boolean;
    DocumentoPDF,TipoModulo: string;
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A092FStampaStorico: TA092FStampaStorico;

procedure OpenA092StampaStorico(Prog:LongInt);

implementation

uses A092UStampa, UInputTime, A092UStampaStoricoDtM1;

{$R *.DFM}

procedure OpenA092StampaStorico(Prog:LongInt);
{Stampa movimentazione storica dei dati specificati}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA092StampaStorico') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
  end;
  A092FStampaStorico:=TA092FStampaStorico.Create(nil);
  with A092FStampaStorico do
    try
      C700Progressivo:=Prog;
      A092FStampaStoricoDtM1:=TA092FStampaStoricoDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A092FStampaStoricoDtM1.Free;
      Free;
    end;
end;

procedure TA092FStampaStorico.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  A092FStampa:=TA092FStampa.Create(nil);
  FlagStatus:=False;
  //ClientHeight:=430;
end;

procedure TA092FStampaStorico.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A092',Parametri.ProgOper);
  DataI:=Date;
  DataF:=Date;
  ItemSort:=-1;
  ListaAnagra.Items.Clear;

  with A092FStampaStoricoDtM1.A092MW.Q010S do
  begin
    First;
    while not Eof do
      begin
      if (FieldByName('COLUMN_NAME').AsString <> 'PROGRESSIVO') and
         (FieldByName('COLUMN_NAME').AsString <> 'DATADECORRENZA') and
         (FieldByName('COLUMN_NAME').AsString <> 'DATAFINE') and
         (FieldByName('COLUMN_NAME').AsString <> 'DECORRENZA') and
         (FieldByName('COLUMN_NAME').AsString <> 'DECORRENZA_FINE') then
        ListaAnagra.Items.Add(FieldByName('NOME_LOGICO').AsString);
      Next;
      end;
  end;
  A092FStampa.RepR.PrinterSettings.UseStandardPrinter:=(TipoModulo = 'COM') and Parametri.UseStandardPrinter;
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataDal:=Parametri.DataLavoro;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  dgrdEsporta.DataSource:=A092FStampaStoricoDtM1.A092MW.dsrTabellaStampa;
  StatusBar.Panels[1].Text:='Nessun record'
end;

procedure TA092FStampaStorico.ScorriQueryAnagrafica;
var i:Integer;
begin
  with A092FStampaStoricoDtM1 do
  begin
    // Carico StringList usata per centralizzare scrittura del record
    A092MW.FParametriInterfaccia.ListaAnagra.Clear;
    for i:=0 to ListaAnagra.Items.Count - 1 do
      if ListaAnagra.Checked[i] then
        A092MW.FParametriInterfaccia.ListaAnagra.Add(ListaAnagra.Items[i]);
    A092MW.SetFiltriDatiAnagrafe;
    A092MW.FParametriInterfaccia.DaData:=Self.DataI;
    A092MW.FParametriInterfaccia.AData:=Self.DataF;
    A092MW.FParametriInterfaccia.chkVariazioni:=chkVariazioni.Checked;
    A092MW.FParametriInterfaccia.IsApplicazionePaghe:=Stipendi;

    A092MW.TabellaStampa.DisableControls;
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
    while not C700SelAnagrafe.Eof do
      begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.StepBy(1);

      // Carico parametri per centralizzare scrittura del record
      A092MW.FParametriInterfaccia.Progressivo:=C700SelAnagrafe.FieldByName('PROGRESSIVO').Value;
      A092MW.FParametriInterfaccia.Nominativo:=C700SelAnagrafe.FieldByName('Cognome').AsString+' '+C700SelAnagrafe.FieldByName('Nome').AsString;
      A092MW.FParametriInterfaccia.Matricola:=C700SelAnagrafe.FieldByName('Matricola').AsString;

      // Richiamo metodo del Middleware per scrittura Dataset "TabellaStampa"
      A092MW.ElaborazioneElemento;

      C700SelAnagrafe.Next;
    end;
    finally
      A092MW.TabellaStampa.First;
      A092MW.TabellaStampa.EnableControls;
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Self.Enabled:=True;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.Position:=0;
    end;
  end;
end;

procedure TA092FStampaStorico.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A092FStampa.RepR);
end;

procedure TA092FStampaStorico.btnEsportaClick(Sender: TObject);
begin
  PreView(btnEsporta);
end;

procedure TA092FStampaStorico.CopiainExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdEsporta,True,False,True,False);
end;

procedure TA092FStampaStorico.BtnPreViewClick(Sender: TObject);
begin
  PreView(BtnPreView);
end;

procedure TA092FStampaStorico.BtnStampaClick(Sender: TObject);
begin
  PreView(BtnStampa);
end;

procedure TA092FStampaStorico.PreView(Sender: TObject);
var i:integer;
    ok:boolean;
    IndexName: String;
begin
  ControllaPeriodo;
  if ControlliValidità then
  begin
    StatusBar.Panels[1].Text:='Estrazione in corso';
    if rgpOrdinamento.ItemIndex = 1 then
      IndexName:='Primary'
    else
      IndexName:='IdxData';

    if FlagStatus then
      raise exception.Create('Stampa o Anteprima di stampa in corso');

    A092FStampaStoricoDtM1.A092MW.CreaTabellaStampa(IndexName);
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI,DataF) then
      C700SelAnagrafe.Close;
    C700SelAnagrafe.Open;
    frmSelAnagrafe.NumRecords;
    ScorriQueryAnagrafica;
    A092FStampaStoricoDtM1.A092MW.TabellaStampa.First;
    if A092FStampaStoricoDtM1.A092MW.TabellaStampa.RecordCount = 0 then
      StatusBar.Panels[1].Text:='Nessun record estratto'
    else
      StatusBar.Panels[1].Text:=Format('Record estratti: %d',[A092FStampaStoricoDtM1.A092MW.TabellaStampa.RecordCount]);
    if Sender <> btnEsporta then
      A092FStampa.CreaReport(Sender = BtnPreView);
    self.Repaint;
  end;
end;

function TA092FStampaStorico.ControlliValidità: boolean;
var i:Integer;
    ok:boolean;
begin
  Result:=True;
  C700SelAnagrafe.Open;
  if C700SelAnagrafe.RecordCount = 0 then
  begin
    Result:=False;
    if TipoModulo = 'COM' then
      raise Exception.Create(A000MSG_A092_ERR_ANAGRAFE)
    else
    begin
      R180MessageBox(A000MSG_A092_ERR_ANAGRAFE,ERRORE);
      exit;
    end;
  end;

  ok:=False;
  for i:=0 to ListaAnagra.Items.Count - 1 do
    if ListaAnagra.Checked[i] then
    begin
      ok:=True;
      Break;
      end;
  if not Ok then
  begin
    Result:=False;
    if TipoModulo = 'COM' then
      raise Exception.Create(A000MSG_A092_ERR_DATO_ANAGRAFE)
    else
    begin
      R180MessageBox(A000MSG_A092_ERR_DATO_ANAGRAFE,ERRORE);
      exit;
    end;
  end;
end;

procedure TA092FStampaStorico.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to ListaAnagra.Items.Count - 1 do
    ListaAnagra.Checked[i]:=True;
end;

procedure TA092FStampaStorico.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to ListaAnagra.Items.Count - 1 do
    ListaAnagra.Checked[i]:=False;
end;

procedure TA092FStampaStorico.GetParametriFunzione;
{Leggo i parametri della form}
var x,i:integer;
    svalore, snome, selemento:string;
begin
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  chkVariazioni.Checked:=C004FParamForm.GetParametro('SOLOVARIAZIONI','N') = 'S';
  rgpOrdinamento.ItemIndex:=StrToInt(C004FParamForm.GetParametro('ORDINAMENTO','0'));
  x:=0;
  snome:='LISTAANAGRA';
  while VarToStr(C004FParamForm.GetParametro(snome + IntToStr(x),'')) <> '' do
  begin
    svalore:=C004FParamForm.GetParametro(snome + IntToStr(x),'');
    svalore:=svalore + IfThen(svalore = '','',',');
    while Pos(',',svalore) > 0 do
    begin
      selemento:=Trim(Copy(svalore,1,Pos(',',svalore) - 1));
      svalore:=Trim(Copy(svalore,Pos(',',svalore) + 1));
      for i:=0 to ListaAnagra.Items.Count - 1 do
      begin
        if VarToStr(A092FStampaStoricoDtM1.A092MW.Q010S.Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME')) = selemento then
          ListaAnagra.Checked[i]:=true;
      end;
    end;
    inc(x);
  end;
end;

procedure TA092FStampaStorico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA092FStampaStorico.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y:integer;
    svalore,snome:string;
begin
  C004FParamForm.Cancella001;
  if chkSaltoPagina.Checked then
    C004FParamForm.PutParametro('SALTOPAGINA','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINA','N');
  if chkVariazioni.Checked then
    C004FParamForm.PutParametro('SOLOVARIAZIONI','S')
  else
    C004FParamForm.PutParametro('SOLOVARIAZIONI','N');
  C004FParamForm.PutParametro('ORDINAMENTO',IntToStr(rgpOrdinamento.ItemIndex));
  // salvo l'elenco dei campi di anagrafe selezionate
  x:=0; //contatore parametri causali
  y:=0; //contatore elementi per parametro
  svalore:='';
  snome:='LISTAANAGRA';
  For i:=0 to ListaAnagra.Items.Count - 1 do
  begin
    if ListaAnagra.Checked[i] then
    begin
      svalore:=svalore + IfThen(svalore = '','',',');
      svalore:=svalore + Trim(Format('%-30s',[VarToStr(A092FStampaStoricoDtM1.A092MW.Q010S.Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME'))]));
      inc(y);
      if y = 3 then
      begin
        C004FParamForm.PutParametro(snome + IntToStr(x),svalore);
        inc(x);
        y:=0;
        svalore:='';
      end;
    end;
  end;
  C004FParamForm.PutParametro(snome + IntToStr(x),svalore);
  try SessioneOracle.Commit; except end;
end;

procedure TA092FStampaStorico.ListaAnagraMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemSort:=ListaAnagra.ItemIndex;
end;

procedure TA092FStampaStorico.ListaAnagraMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (ItemSort <> -1) and (ItemSort <> ListaAnagra.ItemIndex) then
    begin
    C1:=ListaAnagra.Checked[ItemSort];
    C2:=ListaAnagra.Checked[ListaAnagra.ItemIndex];
    ListaAnagra.Items.Exchange(ItemSort,ListaAnagra.ItemIndex);
    ListaAnagra.Checked[ItemSort]:=C2;
    ListaAnagra.Checked[ListaAnagra.ItemIndex]:=C1;
    end;
  ItemSort:=- 1;
end;

procedure TA092FStampaStorico.ControllaPeriodo;
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

procedure TA092FStampaStorico.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=DataF;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA092FStampaStorico.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataDal:=DataI;
  C700DataLavoro:=DataF;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA092FStampaStorico.FormDestroy(Sender: TObject);
begin
  A092FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA092FStampaStorico.FormResize(Sender: TObject);
begin
  if WindowState=wsNormal then
    pnlMain.Constraints.MaxHeight:=450
  else
    pnlMain.Constraints.MaxHeight:=0;
end;

{ DataF }
function TA092FStampaStorico._GetDataF: TDateTime;
begin
  Result:=frmInputPeriodo.DataFine;
end;
procedure TA092FStampaStorico._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine:=Value;
end;
{ ----DataF }
{ DataI }
function TA092FStampaStorico._GetDataI: TDateTime;
begin
  Result:=frmInputPeriodo.DataInizio;
end;
procedure TA092FStampaStorico._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio:=Value;
end;
{ ----DataI }

end.
