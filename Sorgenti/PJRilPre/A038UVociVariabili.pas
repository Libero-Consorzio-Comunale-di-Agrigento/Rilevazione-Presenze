unit A038UVociVariabili;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask, ExtCtrls, A000UCostanti, A000UMessaggi, A000USessione,A000UInterfaccia,
  C700USelezioneAnagrafe, DBCtrls,C180FunzioniGenerali,Spin,A003UDataLavoroBis,
  Grids, DBGrids, checklst, Menus, Oracle, SelAnagrafe, C005UDatiAnagrafici, Variants, Data.DB, InputPeriodo;

type
  TA038FVociVariabili = class(TForm)
    StatusBar: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Stampa1: TMenuItem;
    N1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    PageControl1: TPageControl;
    tabFiltro: TTabSheet;
    tabVoci: TTabSheet;
    Panel1: TPanel;
    CheckListBox1: TCheckListBox;
    CheckListBox2: TCheckListBox;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    chkTuttiDipendenti: TCheckBox;
    Panel2: TPanel;
    Label3: TLabel;
    chkVoci: TCheckBox;
    Label4: TLabel;
    chkCodici: TCheckBox;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    chkMeseCassa: TCheckBox;
    cmbMeseCassa: TComboBox;
    rgpTipoElenco: TRadioGroup;
    chkTipoVoci: TGroupBox;
    chkUMNumero: TCheckBox;
    chkUMOre: TCheckBox;
    chkUMValuta: TCheckBox;
    N2: TMenuItem;
    Esci1: TMenuItem;
    Decodificavoci1: TMenuItem;
    PopupMenu2: TPopupMenu;
    CopiaInExcel: TMenuItem;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure PageControl1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkTuttiDipendentiClick(Sender: TObject);
    procedure AttivaFiltroClick(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure cmbMeseCassaChange(Sender: TObject);
    procedure rgpTipoElencoClick(Sender: TObject);
    procedure Esci1Click(Sender: TObject);
    procedure Decodificavoci1Click(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodobtnDataInizioClick(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure frmInputPeriodobtnDataFineClick(Sender: TObject);
    procedure frmInputPeriodobtnIndietroClick(Sender: TObject);
    procedure frmInputPeriodobtnAvantiClick(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
   public
    { Public declarations }
    DataCassa:TDateTime;
    Q195Modificata:Boolean;
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A038FVociVariabili: TA038FVociVariabili;

procedure OpenA038VociVariabili(Prog:LongInt);

implementation

uses A038UVociVariabiliDtM1, A038UDialogStampa, A038UDecodificaVoci;

{$R *.DFM}

procedure OpenA038VociVariabili(Prog:LongInt);
{Gestione voci variabili già scaricate alle paghe}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA038VociVariabili') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A038FVociVariabili:=TA038FVociVariabili.Create(nil);
  with A038FVociVariabili do
    try
      C700Progressivo:=Prog;
      A038FVociVariabiliDtM1:=TA038FVociVariabiliDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A038FVociVariabiliDtM1.Free;
      Free;
    end;
end;

procedure TA038FVociVariabili.FormCreate(Sender: TObject);
var A,M,G:Word;
begin
  frmInputPeriodo.FormatoData:=fdMese;
  if Parametri.DataLavoro <> 0 then
    DataI:=Parametri.DataLavoro
  else
    DataI:=Date;
  DecodeDate(DataI,A,M,G);
  DataI:=EncodeDate(A,M,1);
  DataF:=R180FineMese(DataI);
  Q195Modificata:=False;
  StatusBar.Panels[0].Text:='--- Records';

  frmInputPeriodo.CaptionDataOutI:='Inizio periodo';
  frmInputPeriodo.CaptionDataOutF:='Fine periodo';
end;

procedure TA038FVociVariabili.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
    A038FVociVariabiliDtM1.SettaQuery('PROGRESSIVO');
end;

procedure TA038FVociVariabili.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA038FVociVariabili.FormShow(Sender: TObject);
var
  i:Integer;
begin
  PageControl1.ActivePage:=tabFiltro;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A038FVociVariabiliDtM1.A038FVociVariabiliMW,SessioneOracle,StatusBar,1,True);
  C700SelAnagrafe.OnFilterRecord:=A038FVociVariabiliDtM1.Q195FilterRecord;
  with A038FVociVariabiliDtM1.A038FVociVariabiliMW.VociPaghe do
  begin
    Open;
    while not Eof do
    begin
      CheckListBox1.Items.Add(FieldByName('VocePaghe').AsString);
      Next;
    end;
    Close;
  end;
  if SolaLettura then
  begin
    A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195.ReadOnly:=True;
    DecodificaVoci1.Enabled:=False;
  end;
  for i:=1 to High(VettConst) do
    CheckListBox2.Items.Add(Format('%-4s %s',[VettConst[i].CodInt,VettConst[i].Descrizione]));
  with A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195Cassa do
  begin
    Open;
    while not Eof do
    begin
      cmbMeseCassa.Items.Add(FieldByName('Data_Cassa').AsString);
      Next;
    end;
    Close;
  end;
  if cmbMeseCassa.Items.Count > 0 then
    cmbMeseCassa.ItemIndex:=0;
  try
    DataCassa:=StrToDate(cmbMeseCassa.Items[cmbMeseCassa.ItemIndex]);
  except
    DataCassa:=0;
  end;
end;

procedure TA038FVociVariabili.chkTuttiDipendentiClick(Sender: TObject);
begin
  A038FVociVariabiliDtM1.SettaQuery('T');
end;

procedure TA038FVociVariabili.AttivaFiltroClick(Sender: TObject);
begin
  with A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195 do
  begin
    Filtered:=False;
    Filtered:=chkVoci.Checked or chkCodici.Checked or chkMeseCassa.Checked or (not chkUMNumero.Checked) or (not chkUMOre.Checked) or (not chkUMValuta.Checked);
    if Active then
    begin
      First;
      StatusBar.Panels[0].Text:=Format('%d Records',[RecordCount]);
    end;
  end;
end;

procedure TA038FVociVariabili.CheckListBox1ClickCheck(Sender: TObject);
begin
  if chkVoci.Checked or chkCodici.Checked then
    with A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195 do
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
      if Active then
        StatusBar.Panels[0].Text:=Format('%d Records',[RecordCount]);
    end;
end;

procedure TA038FVociVariabili.Stampa1Click(Sender: TObject);
var S,S1:String;
    L:TStringList;
    P,P1:Word;
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  L:=TStringList.Create;
  try
    S:=EliminaRitornoACapo(C700SelAnagrafe.SQL.Text);
    P:=Pos('FROM',S);
    P1:=Pos('WHERE',S);
    S1:=Copy(S,1,P - 1);
    S1:=TrimRight(S1) + ',T195.DATARIF,T195.VOCEPAGHE,T195.DESCRIZIONE_VOCE,T195.VALORE,T195.IMPORTO,T195.UM,T195.DAL,T195.AL,T195.OPERAZIONE,T195.COD_INTERNO,T195.DATA_CASSA';
    L.Add(S1);
    S1:=Copy(S,P,P1 - 1 - P);
    if rgpTipoElenco.ItemIndex = 0 then
    begin
      S1:=S1 + ',(select T.*, T193F_GETDESCRIZIONE(null, T.PROGRESSIVO, T.VOCEPAGHE, T.DATARIF) DESCRIZIONE_VOCE from T195_VOCIVARIABILI T) T195';
    end
    else
    begin
      S1:=S1 + ',(SELECT PROGRESSIVO,DATARIF,VOCEPAGHE,T193F_GETDESCRIZIONE(null, PROGRESSIVO, VOCEPAGHE, DATARIF) DESCRIZIONE_VOCE, SUM(VALORE) VALORE,SUM(IMPORTO) IMPORTO,UM,DAL,AL,OPERAZIONE,COD_INTERNO,MAX(DATA_CASSA) DATA_CASSA ' +
                'FROM T195_VOCIVARIABILI '+
                'GROUP BY PROGRESSIVO,DATARIF,VOCEPAGHE,UM,DAL,AL,OPERAZIONE,COD_INTERNO) T195';
    end;
    L.Add(S1);
    L.Add('WHERE T195.PROGRESSIVO = T030.PROGRESSIVO AND T195.DATARIF BETWEEN :DATA1 AND :DATA2 AND');
    L.Add(Copy(S,P1 + 6,Length(S)));
    with C700SelAnagrafe do
      begin
      CloseAll;
      SQL.Clear;
      SQL.Assign(L);
      DeleteVariables;
      DeclareVariable('DATALAVORO',otDate);
      DeclareVariable('DATA1',otDate);
      DeclareVariable('DATA2',otDate);
      SetVariable('DATALAVORO',DataF);
      SetVariable('DATA1',DataI);
      SetVariable('DATA2',DataF);
      Filtered:=A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195.Filtered;
      Open;
      end;
    A038FDialogStampa:=TA038FDialogStampa.Create(nil);
    A038FDialogStampa.ShowModal;
  finally
    L.Free;
    A038FDialogStampa.Free;
    C700SelAnagrafe.DeleteVariables;
    C700SelAnagrafe.DeclareVariable('DATALAVORO',otDate);
    C700SelAnagrafe.SetVariable('DATALAVORO',DataF);
    C700SelAnagrafe.Filtered:=False;
    frmSelAnagrafe.RipristinaC00SelAnagrafe(A038FVociVariabiliDtM1.A038FVociVariabiliMW);
  end;
end;

procedure TA038FVociVariabili.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=DataF;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA038FVociVariabili.frmInputPeriodobtnAvantiClick(Sender: TObject);
begin
  frmInputPeriodo.btnAvantiClick(Sender);
  if (DataI > 0) and (DataF > 0) then
  begin
    A038FVociVariabiliDtM1.SettaQuery('DATA1');
    A038FVociVariabiliDtM1.SettaQuery('DATA2');
  end;
end;

procedure TA038FVociVariabili.frmInputPeriodobtnDataFineClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataFineClick(Sender);
    A038FVociVariabiliDtM1.SettaQuery('DATA2');
end;

procedure TA038FVociVariabili.frmInputPeriodobtnDataInizioClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataInizioClick(Sender);
  A038FVociVariabiliDtM1.SettaQuery('DATA1');
end;

procedure TA038FVociVariabili.frmInputPeriodobtnIndietroClick(Sender: TObject);
begin
  frmInputPeriodo.btnIndietroClick(Sender);
  if (DataI > 0) and (DataF > 0) then
  begin
    A038FVociVariabiliDtM1.SettaQuery('DATA1');
    A038FVociVariabiliDtM1.SettaQuery('DATA2');
  end;
end;

procedure TA038FVociVariabili.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  if DataF > 0 then A038FVociVariabiliDtM1.SettaQuery('DATA2')
  else
  begin
    frmInputPeriodo.edtFine.SetFocus;
    raise Exception.Create(A000MSG_ERR_DATA_VALIDA);
  end;
end;

procedure TA038FVociVariabili.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  frmInputPeriodo.edtInizioExit(Sender);
  if DataI > 0 then A038FVociVariabiliDtM1.SettaQuery('DATA1')
  else
  begin
    frmInputPeriodo.edtInizio.SetFocus;
    raise Exception.Create(A000MSG_ERR_DATA_VALIDA);
  end;
end;

procedure TA038FVociVariabili.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataLavoro:=DataF;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA038FVociVariabili.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  with TCheckListBox(PopupMenu1.PopupComponent) do
    for i:=0 to Items.Count - 1 do
      Checked[i]:=Sender = Selezionatutto1;
  CheckListBox1ClickCheck(nil);
end;

procedure TA038FVociVariabili.cmbMeseCassaChange(Sender: TObject);
begin
  DataCassa:=StrToDate(cmbMeseCassa.Items[cmbMeseCassa.ItemIndex]);
  with A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195 do
  begin
    DisableControls;
    Filtered:=False;
    Filtered:=True;
    EnableControls;
    if Active then
      StatusBar.Panels[0].Text:=Format('%d Records',[RecordCount]);
  end;
end;

procedure TA038FVociVariabili.CopiaInExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(DBGrid1, True , False);
end;

procedure TA038FVociVariabili.rgpTipoElencoClick(Sender: TObject);
begin
  A038FVociVariabiliDtM1.SettaQuery('TIPO_ELENCO');
end;

procedure TA038FVociVariabili.Esci1Click(Sender: TObject);
begin
  Close;
end;

procedure TA038FVociVariabili.Decodificavoci1Click(Sender: TObject);
begin
  A038FDecodificaVoci:=TA038FDecodificaVoci.Create(nil);
  with A038FDecodificaVoci do
  try
    ShowModal;
  finally
    Release;
  end;
end;

procedure TA038FVociVariabili.PageControl1Change(Sender: TObject);
begin
  if (PageControl1.ActivePage = tabVoci) and (Q195Modificata or (not A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195.Active)) then
  begin
    Screen.Cursor:=crHourGlass;
    A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195.Close;
    A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195.Open;
    StatusBar.Panels[0].Text:=Format('%d Records',[A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195.RecordCount]);
    Screen.Cursor:=crDefault;
    Q195Modificata:=False;
  end;
end;

{ DataF }
function TA038FVociVariabili._GetDataF: TDateTime;
begin
  Result:=frmInputPeriodo.DataFine;
end;
procedure TA038FVociVariabili._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine:=Value;
end;
{ ----DataF }
{ DataI }
function TA038FVociVariabili._GetDataI: TDateTime;
begin
  Result:=frmInputPeriodo.DataInizio;
end;
procedure TA038FVociVariabili._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio:=Value;
end;
{ ----DataI }

end.
