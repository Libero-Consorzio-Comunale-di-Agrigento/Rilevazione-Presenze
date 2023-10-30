unit A060UTimbIrregolari;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Menus, Buttons, Grids, DBGrids, Printers,
  A000UCostanti, A000USessione,A000UInterfaccia,A000UMessaggi, C180FunzioniGenerali, ComCtrls, A003UDataLavoroBis, Variants,
  RegistrazioneLog, Data.DB, InputPeriodo;

type
  TA060FTimbIrregolari = class(TForm)
    ScrollBox1: TScrollBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    LAzienda: TLabel;
    Label3: TLabel;
    LBadge: TLabel;
    DBGrid1: TDBGrid;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnCancella: TBitBtn;
    StatusBar1: TStatusBar;
    cmbABadge: TComboBox;
    cmbDaBadge: TComboBox;
    lblDalBadge: TLabel;
    lblAlBadge: TLabel;
    btnRefresh: TBitBtn;
    lblDaChiave: TLabel;
    cmbDaChiave: TComboBox;
    lblAChiave: TLabel;
    cmbAChiave: TComboBox;
    lblAScarico: TLabel;
    lblDaScarico: TLabel;
    cmbDaScarico: TComboBox;
    cmbAScarico: TComboBox;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbDaBadgeChange(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbDaChiaveChange(Sender: TObject);
    procedure cmbAChiaveChange(Sender: TObject);
    procedure cmbDaScaricoChange(Sender: TObject);
    procedure cmbAScaricoChange(Sender: TObject);
    procedure AggiornaData;
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure frmInputPeriodobtnDataInizioClick(Sender: TObject);
    procedure frmInputPeriodobtnDataFineExit(Sender: TObject);
    procedure frmInputPeriodobtnIndietroClick(Sender: TObject);
    procedure frmInputPeriodobtnAvantiClick(Sender: TObject);

  private
    procedure AggiornaRisultati;
    procedure RepaintAzienda(PAzienda:String);
    procedure RepaintBadgeChiave(PBadgeChiave:String);
    procedure RepaintStatusBar(Text:String);
    procedure CaricaComboBox;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A060FTimbIrregolari: TA060FTimbIrregolari;

procedure OpenA060TimbIrregolari;

implementation

uses A060UTimbIrregolariDtM1;

{$R *.DFM}

procedure OpenA060TimbIrregolari;
{Ripristino timbrature irregolari}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA060TimbIrregolari') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A060FTimbIrregolari:=TA060FTimbIrregolari.Create(nil);
  try
    A060FTimbIrregolariDtM1:=TA060FTimbIrregolariDtM1.Create(nil);
    A060FTimbIrregolari.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A060FTimbIrregolariDtM1);
    FreeAndNil(A060FTimbIrregolari);
  end;
end;

procedure TA060FTimbIrregolari.BitBtn1Click(Sender: TObject);
{Nome file di appoggio = TIaammgg.IRR}
var Msg:String;
begin
  if DataI > DataF then
    raise Exception.Create(A000MSG_ERR_PERIODO_ERRATO);
  Screen.Cursor:=crHourGlass;
  try
    AggiornaRisultati;
    with A060FTimbIrregolariDtM1.A060MW do
    begin
      GrdRisultatiVisibile:=(DbGrid1 <> nil) and (DbGrid1.Visible);
      Msg:=Scarico;
    end;
    if Msg <> '' then
      ShowMessage(Msg);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA060FTimbIrregolari.FormCreate(Sender: TObject);
begin
  DataI:= R180InizioMese(Parametri.DataLavoro);
  DataF:= R180FineMese(Parametri.DataLavoro);
  BitBtn1.Enabled:=not SolaLettura;
  btnCancella.Enabled:=not SolaLettura;
end;

procedure TA060FTimbIrregolari.FormShow(Sender: TObject);
begin
  A060FTimbIrregolariDtM1.A060MW.RepaintAzienda:=RepaintAzienda;
  A060FTimbIrregolariDtM1.A060MW.RepaintBadge:=RepaintBadgeChiave;
  A060FTimbIrregolariDtM1.A060MW.RepaintStatusBar:=RepaintStatusBar;
end;

procedure TA060FTimbIrregolari.RepaintAzienda(PAzienda: String);
begin
  LAzienda.Caption:=PAzienda;
  LAzienda.Repaint;
end;

procedure TA060FTimbIrregolari.RepaintBadgeChiave(PBadgeChiave: String);
begin
  LBadge.Caption:=PBadgeChiave;
  LBadge.RePaint;
end;

procedure TA060FTimbIrregolari.RepaintStatusBar(Text: String);
begin
  {"(StatusBar1 <> nil)" il controllo serve nel caso in cui il progetto venga
  lanciato da Delphi}
  if StatusBar1 <> nil then
    StatusBar1.SimpleText:=Text;
end;

procedure TA060FTimbIrregolari.FormActivate(Sender: TObject);
begin
  DataI:= R180InizioMese(Parametri.DataLavoro);
  DataF:= R180FineMese(Parametri.DataLavoro);
  CaricaComboBox;
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.CaricaComboBox;
var
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
  //tmpLista:TStringList;
  tmpListaBadge,
  tmpListaChiavi,
  tmpListaScarico: TStringList;
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
begin
  try
    A060FTimbIrregolariDtM1.A060MW.DaData:=DataI;
    A060FTimbIrregolariDtM1.A060MW.AData:=DataF;
    tmpListaBadge:=A060FTimbIrregolariDtM1.A060MW.CaricaListaBadge;
    cmbDaBadge.Items:=tmpListaBadge;
    cmbABadge.Items:=tmpListaBadge;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    // i valori di badge da/a sono impostati vuoti
    {
    if cmbDaBadge.Text = '' then
      cmbDaBadge.Text:='0';
    if cmbABadge.Text = '' then
      cmbABadge.Text:='999999999999999';
    }
    // lista delle chiavi alternative al badge
    tmpListaChiavi:=A060FTimbIrregolariDtM1.A060MW.CaricaListaChiavi;
    cmbDaChiave.Items:=tmpListaChiavi;
    cmbAChiave.Items:=tmpListaChiavi;
    // lista delle parametrizzazioni di scarico
    tmpListaScarico:=A060FTimbIrregolariDtM1.A060MW.CaricaListaParamScarico;
    cmbDaScarico.Items:=tmpListaScarico;
    cmbAScarico.Items:=tmpListaScarico;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
  finally
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    {
    if tmpLista <> nil then
      FreeAndNil(tmpLista);
    }
    if tmpListaScarico <> nil then
      FreeAndNil(tmpListaScarico);
    if tmpListaScarico <> nil then
      FreeAndNil(tmpListaScarico);
    if tmpListaScarico <> nil then
      FreeAndNil(tmpListaScarico);
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
  end;
end;

procedure TA060FTimbIrregolari.btnCancellaClick(Sender: TObject);
var Msg:String;
begin
  if R180MessageBox(Format(A000MSG_A060_DLG_FMT_ELIMINA_TIMBRATURE,[DateToStr(DataI),DateToStr(DataF)]),DOMANDA) = mrYes then
  begin
    A060FTimbIrregolariDtM1.A060MW.DaData:= DataI;
    A060FTimbIrregolariDtM1.A060MW.AData:= DataF;
    A060FTimbIrregolariDtM1.A060MW.DaBadge:=cmbDaBadge.Text;
    A060FTimbIrregolariDtM1.A060MW.ABadge:=cmbABadge.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    A060FTimbIrregolariDtM1.A060MW.DaChiave:=cmbDaChiave.Text;
    A060FTimbIrregolariDtM1.A060MW.AChiave:=cmbAChiave.Text;
    A060FTimbIrregolariDtM1.A060MW.DaScarico:=cmbDaScarico.Text;
    A060FTimbIrregolariDtM1.A060MW.AScarico:=cmbAScarico.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
    Msg:=A060FTimbIrregolariDtM1.A060MW.CancellaTimbrature;
    if Msg <> '' then
      ShowMessage(Msg);
  end;
end;

procedure TA060FTimbIrregolari.cmbDaBadgeChange(Sender: TObject);
begin
  AggiornaRisultati;
end;

// AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
procedure TA060FTimbIrregolari.cmbDaChiaveChange(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.cmbAChiaveChange(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.cmbDaScaricoChange(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.cmbAScaricoChange(Sender: TObject);
begin
  AggiornaRisultati;
end;
// AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine

procedure TA060FTimbIrregolari.btnRefreshClick(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.BitBtn4Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TA060FTimbIrregolari.BitBtn5Click(Sender: TObject);
var
  H,NR:Integer;
  S:String;
  procedure Intestazione;
  begin
    Printer.Canvas.TextOut(5,H,DateToStr(Date));
    Printer.Canvas.TextOut(5,H*3,'Elenco timbrature irregolari dal ' + frmInputPeriodo.edtInizio.Text + ' al ' + frmInputPeriodo.edtFine.Text );
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // modifica intestazione per includere il dato Chiave
    //Printer.Canvas.TextOut(5,H*5,'Data       Badge           Ed. Verso Ora   Causale Rilevatore Param. scarico       Aziende');
    Printer.Canvas.TextOut(5,H*5,Format('%-10s %-15s %-3s %-20s %-5s %-5s %-7s %-6s %-20s %s',
                                        ['Data','Badge','Ed.','Chiave','Verso','Ora','Causale','Rilev.','Param. scarico','Aziende']));
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    NR:=7;
  end;
begin
  if A060FTimbIrregolariDtM1.A060MW.QI101.RecordCount = 0 then
    raise Exception.Create('Nessuna timbratura da stampare!');
  Printer.Canvas.Font.Name:='Courier New';
  Printer.Canvas.Font.Size:=8;
  H:=Printer.Canvas.TextHeight('Z');
  Printer.BeginDoc;
  Intestazione;
  with A060FTimbIrregolariDtM1.A060MW.QI101 do
    begin
    DisableControls;
    First;
    while not Eof do
    begin
      if (NR * H) >= (Printer.PageHeight - H) then
      begin
        Printer.NewPage;
        Intestazione;
      end;
      S:=FormatDateTime('dd/mm/yyyy',FieldByName('Data').AsDateTime);
      S:=Format('%s %-15s',[S,FieldByName('Badge').AsString]);
      S:=Format('%s %-3s',[S,FieldByName('EdBadge').AsString]);
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
      // espone in stampa il dato chiave
      S:=Format('%s %-20s',[S,FieldByName('Chiave').AsString]);
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
      S:=Format('%s %5s %5s',[S,FieldByName('Verso').AsString,FormatDateTime('hh.nn',FieldByName('Ora').AsDateTime)]);
      S:=Format('%s %-7s %-6s',[S,FieldByName('Causale').AsString,FieldByName('Rilev').AsString]);
      S:=Format('%s %-20s',[S,FieldByName('Scarico').AsString]);
      S:=Format('%s %s',[S,Trim(FieldByName('Aziende').AsString)]);
      Printer.Canvas.TextOut(5,H * NR,S);
      inc(NR);
      Next;
    end;
    First;
    EnableControls;
  end;
  Printer.EndDoc;
end;



procedure TA060FTimbIrregolari.AggiornaRisultati;
begin
  A060FTimbIrregolariDtM1.A060MW.DaData:=DataI;
  A060FTimbIrregolariDtM1.A060MW.AData:=DataF;
  with A060FTimbIrregolariDtM1.A060MW do
  begin
    DaBadge:=cmbDaBadge.Text;
    ABadge:=cmbABadge.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    DaChiave:=cmbDaChiave.Text;
    AChiave:=cmbAChiave.Text;
    DaScarico:=cmbDaScarico.Text;
    AScarico:=cmbAScarico.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
    CaricaTimbrature;
  end;
end;

procedure TA060FTimbIrregolari.frmInputPeriodobtnAvantiClick(Sender: TObject);
begin
  frmInputPeriodo.btnAvantiClick(Sender);
  AggiornaData;
end;

procedure TA060FTimbIrregolari.frmInputPeriodobtnDataFineExit(Sender: TObject);
begin
  AggiornaData;
end;

procedure TA060FTimbIrregolari.frmInputPeriodobtnDataInizioClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataInizioClick(Sender);
  AggiornaData;
end;

procedure TA060FTimbIrregolari.frmInputPeriodobtnIndietroClick(Sender: TObject);
begin
  frmInputPeriodo.btnIndietroClick(Sender);
  AggiornaData;
end;

procedure TA060FTimbIrregolari.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  if DataF > 0 then
  begin
    if A060FTimbIrregolariDtM1.A060MW.VariazioneDataF(DataF) then
      AggiornaData;
  end
  else
  begin
    frmInputPeriodo.edtFine.SetFocus;
    raise Exception.Create(A000MSG_ERR_DATA_VALIDA);
  end;
end;

procedure TA060FTimbIrregolari.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  frmInputPeriodo.edtInizioExit(Sender);
  if DataI > 0 then
  begin
    if A060FTimbIrregolariDtM1.A060MW.VariazioneDataI(DataI) then
      AggiornaData;
  end
  else
  begin
    frmInputPeriodo.edtInizio.SetFocus;
    raise Exception.Create(A000MSG_ERR_DATA_VALIDA);
  end;
end;

procedure TA060FTimbIrregolari.AggiornaData;
begin
  if DataI > 0 then
    R180SetVariable(A060FTimbIrregolariDtM1.A060MW.QI101,'Data1',DataI);
  if DataF > 0 then
    R180SetVariable(A060FTimbIrregolariDtM1.A060MW.QI101,'Data2',DataF);
  A060FTimbIrregolariDtM1.A060MW.QI101.Open;
  CaricaComboBox;
end;

{ DataF }
function TA060FTimbIrregolari._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TA060FTimbIrregolari._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ----DataF }
{ DataI }
function TA060FTimbIrregolari._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TA060FTimbIrregolari._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ----DataI }

end.
