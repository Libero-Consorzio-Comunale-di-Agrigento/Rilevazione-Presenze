unit A104UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, A003UDataLavoroBis,
  StdCtrls, Buttons, ExtCtrls, Mask, SelAnagrafe, ComCtrls, C013UCheckList,
  DBCtrls, Spin ,C001StampaLib, C180FunzioniGenerali,A000UCostanti, A000USessione,A000UInterfaccia,
  Grids, DBGrids, DB, C004UParamForm, QueryStorico, Menus,
  C005UDatiAnagrafici, C700USelezioneAnagrafe, OracleData, Variants, Oracle, A000UMessaggi;

type
  TA104FDialogStampa = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    edtMeseScaricoDa: TMaskEdit;
    Label7: TLabel;
    edtMeseScaricoA: TMaskEdit;
    ChkSaltoPagina: TCheckBox;
    Panel1: TPanel;
    BtnClose: TBitBtn;
    BtnStampa: TBitBtn;
    BtnPrinterSetUp: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    EdtStato: TEdit;
    EdtTitolo: TEdit;
    Label3: TLabel;
    rgpOrdinamento: TRadioGroup;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure edtMeseScaricoDaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frmSelAnagrafebtnPrimoClick(Sender: TObject);
  private
    { Private declarations }
    //DataCassaDa, DataCassaA:TDateTime;
    //bPv_SaltoPagina: Boolean;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure PulisciMaskEdit(Sender:TObject);
    procedure ScorriQueryAnagrafica;
    procedure InserisciDipendente(Progr:Integer);
    function SetApici(Str:String):String;
  public
    DocumentoPDF, TipoModulo: string;
    StampaTXT: Boolean;
  end;

var
  A104FDialogStampa: TA104FDialogStampa;

procedure OpenA104StampaMissioni(Prog:LongInt);

implementation

uses A104UStampaMissioni, A104UStampaMissioniDtM1;

{$R *.DFM}

procedure OpenA104StampaMissioni(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA104StampaMissioni') of
    'N':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A104FDialogStampa:=TA104FDialogStampa.Create(nil);
  with A104FDialogStampa do
    try
      C700Progressivo:=Prog;
      A104FStampaMissioniDtM1:=TA104FStampaMissioniDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A104FStampaMissioniDtM1.Free;
      Free;
    end;
end;

procedure TA104FDialogStampa.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  StampaTXT:=False;
  A104FStampaMissioni:=TA104FStampaMissioni.Create(nil);
  A104FStampaMissioni.ChildBand2.Tag:=A104FStampaMissioni.ChildBand2.Height;
  A104FStampaMissioni.ChildBand3.Tag:=A104FStampaMissioni.ChildBand3.Height;
  A104FStampaMissioni.ChildBand4.Tag:=A104FStampaMissioni.ChildBand4.Height;
  A104FStampaMissioni.ChildBand5.Tag:=A104FStampaMissioni.ChildBand5.Height;
  A104FStampaMissioni.GroupHeaderBand2.Tag:=A104FStampaMissioni.GroupHeaderBand2.Height;
  A104FStampaMissioni.QRSubDetail1.Tag:=A104FStampaMissioni.QRSubDetail1.Height;
  A104FStampaMissioni.GroupFooterBand2.Tag:=A104FStampaMissioni.GroupFooterBand2.Height;
  A104FStampaMissioni.GroupHeaderBand1.Tag:=A104FStampaMissioni.GroupHeaderBand1.Height;
  A104FStampaMissioni.QRSubDetail2.Tag:=A104FStampaMissioni.QRSubDetail2.Height;
  A104FStampaMissioni.ChildBand1.Tag:=A104FStampaMissioni.ChildBand1.Height;
  A104FStampaMissioni.GroupFooterBand1.Tag:=A104FStampaMissioni.GroupFooterBand1.Height;
  A104FStampaMissioni.ChildBand6.Tag:=A104FStampaMissioni.ChildBand6.Height;
  A104FStampaMissioni.ChildBand7.Tag:=A104FStampaMissioni.ChildBand7.Height;
end;

procedure TA104FDialogStampa.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A104',Parametri.ProgOper);
  A104FStampaMissioni.PrinterSettings.UseStandardPrinter:=(TipoModulo = 'COM') and Parametri.UseStandardPrinter;
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  C700DataDal:=Parametri.DataLavoro;
end;

procedure TA104FDialogStampa.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
  begin
    C001SettaQuickReport(A104FStampaMissioni);
  end;
end;

function TA104FDialogStampa.SetApici(Str:String):String;
var Ret:String;
begin
  Str:=StringReplace(Str,'''','''''',[rfReplaceAll]);
  Ret:='''' + StringReplace(Str,',',''',''',[rfReplaceAll]) + '''';
  Result:=Ret;
end;

procedure TA104FDialogStampa.BtnStampaClick(Sender: TObject);
var FiltroMeseScarico:String;
begin
  //richiamo da B028 la C700 è chiusa
  if C700SelAnagrafe.state = dsInactive  then
    C700SelAnagrafe.Open;
  if C700SelAnagrafe.RecordCount = 0 then
  begin
    if TipoModulo = 'CS' then
    begin
      Application.MessageBox(PChar('Nessun dato corrisponde ai filtri di ricerca impostati sui dipendenti.' + chr(10) + chr(13) + 'Effettuare una nuova selezione cliccando sulla lente.'), PChar('Attenzione'), MB_OK + MB_ICONEXCLAMATION);
      Screen.Cursor:=crDefault;
      exit;
    end;
  end;

  (*Alberto 05/12/2011: consentito l'uso della stampa anche senza avere specificato C8_Sede
  if Not(A104FStampaMissioniDtM1.QSede.Active) then
    Raise Exception.Create('Parametro ''TRASFERTE: SEDE DI RIFERIMENTO'' non impostato. E'' possibile farlo da ''Gestione Aziende''.');
  *)

  C700SelAnagrafe.First;
  frmSelAnagrafe.VisualizzaDipendente;

  Screen.Cursor:=crHourGlass;

  A104FStampaMissioniDtM1.SelM040.Close;
  FiltroMeseScarico:='';
  if trim(edtMeseScaricoDa.Text) <> '/' then
    FiltroMeseScarico:=FiltroMeseScarico + ' AND M040.MESESCARICO >= TO_DATE(''01/' + edtMeseScaricoDa.Text + ''',''DD/MM/YYYY'')';
  if trim(edtMeseScaricoA.Text) <> '/' then
    FiltroMeseScarico:=FiltroMeseScarico + ' AND M040.MESESCARICO <= TO_DATE(''' + FormatDateTime('dd/mm/yyyy', R180FineMese(EncodeDate(StrtoInt(Copy(edtMeseScaricoA.Text,4,4)), StrtoInt(Copy(edtMeseScaricoA.Text,1,2)),1))) + ''',''DD/MM/YYYY'')';
  C700MergeSelAnagrafe(A104FStampaMissioniDtM1.SelM040);
  C700MergeSettaPeriodo(A104FStampaMissioniDtM1.SelM040,Parametri.DataLavoro,Parametri.DataLavoro);
  if EdtStato.Text <> '' then
    A104FStampaMissioniDtM1.SelM040.SetVariable('STATOMISSIONE','AND STATO IN (' + SetApici(EdtStato.Text) + ')')
  else
    A104FStampaMissioniDtM1.SelM040.SetVariable('STATOMISSIONE','');
  A104FStampaMissioniDtM1.SelM040.SetVariable('MESESCARICO', FiltroMeseScarico);
  A104FStampaMissioniDtM1.SelM040.Open;
  if A104FStampaMissioniDtM1.SelM040.RecordCount = 0 then
  begin
    if TipoModulo = 'CS' then
      R180MessageBox(A000MSG_A104_ERR_NO_TRASF,ESCLAMA)
    else
      Raise Exception.Create(A000MSG_A104_ERR_NO_TRASF);
    Screen.Cursor:=crDefault;
    exit;
  end;
  A104FStampaMissioniDtM1.CreaTabellaStampa;
  ScorriQueryAnagrafica;
  A104FStampaMissioni.bPv_SaltoPagina:=ChkSaltoPagina.Checked;
  A104FStampaMissioni.CreaReport;
  A104FStampaMissioniDtM1.TabellaStampa.Close;
end;

procedure TA104FDialogStampa.ScorriQueryAnagrafica;
begin
  C700SelAnagrafe.First;
  ProgressBar.Position:=0;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.Eof do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      InserisciDipendente(C700Progressivo);
      ProgressBar.StepBy(1);
      C700SelAnagrafe.Next;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar.Position:=0;
  end;
end;

procedure TA104FDialogStampa.InserisciDipendente(Progr:Integer);
Var Stato:String;
  bTrovato:boolean;
begin
  with A104FStampaMissioniDtM1 do
  begin
    bTrovato:=SelM040.SearchRecord('PROGRESSIVO',Progr,[srFromBeginning]);
    while ((bTrovato = True) and (not SelM040.Eof)) do
    begin
      TabellaStampa.Append;
      Stato:=SelM040.FieldByName('stato').AsString;
      if Stato = 'D' then
        TabellaStampa.FieldByName('stato').AsString:='Da Liq.'
      else if Stato = 'L' then
        TabellaStampa.FieldByName('stato').AsString:='Liquidata'
      else if Stato = 'P' then
        TabellaStampa.FieldByName('stato').AsString:='Parz. Liq.'
      else if Stato = 'S' then
        TabellaStampa.FieldByName('stato').AsString:='Sospesa';
      TabellaStampa.FieldByName('contatore').value:=TabellaStampa.RecordCount + 1;
      TabellaStampa.FieldByName('progressivo').value:=SelM040.FieldByName('progressivo').asInteger;
      TabellaStampa.FieldByName('matricola').value:=SelM040.FieldByName('matricola').asString;
      TabellaStampa.FieldByName('cognome').value:=SelM040.FieldByName('cognome').asString;
      TabellaStampa.FieldByName('nome').value:=SelM040.FieldByName('nome').asString;
      TabellaStampa.FieldByName('mesescarico').value:=SelM040.FieldByName('mesescarico').asDateTime;
      TabellaStampa.FieldByName('mesecompetenza').value:=SelM040.FieldByName('mesecompetenza').asDateTime;
      TabellaStampa.FieldByName('datada').value:=SelM040.FieldByName('datada').asDateTime;
      TabellaStampa.FieldByName('orada').value:=SelM040.FieldByName('orada').asString;
      TabellaStampa.FieldByName('protocollo').value:=SelM040.FieldByName('protocollo').asString;
      TabellaStampa.FieldByName('tiporegistrazione').value:=SelM040.FieldByName('tiporegistrazione').asString;
      TabellaStampa.FieldByName('dataa').value:=SelM040.FieldByName('dataa').asDateTime;
      TabellaStampa.FieldByName('oraa').value:=SelM040.FieldByName('oraa').asString;
      TabellaStampa.FieldByName('totalegg').value:=SelM040.FieldByName('totalegg').asInteger;
      TabellaStampa.FieldByName('durata').value:=SelM040.FieldByName('durata').asString;
      TabellaStampa.FieldByName('abbreviazione').value:=SelM040.FieldByName('abbreviazione').asString;
      TabellaStampa.FieldByName('tariffaindintera').value:=SelM040.FieldByName('tariffaindintera').asFloat;
      TabellaStampa.FieldByName('oreindintera').value:=SelM040.FieldByName('oreindintera').asFloat;
      TabellaStampa.FieldByName('importoindintera').value:=SelM040.FieldByName('importoindintera').asFloat;
      TabellaStampa.FieldByName('tariffaindridottah').value:=SelM040.FieldByName('tariffaindridottah').asFloat;
      TabellaStampa.FieldByName('oreindridottah').value:=SelM040.FieldByName('oreindridottah').asFloat;
      TabellaStampa.FieldByName('importoindridottah').value:=SelM040.FieldByName('importoindridottah').asFloat;
      TabellaStampa.FieldByName('tariffaindridottag').value:=SelM040.FieldByName('tariffaindridottag').asFloat;
      TabellaStampa.FieldByName('oreindridottag').value:=SelM040.FieldByName('oreindridottag').asFloat;
      TabellaStampa.FieldByName('importoindridottag').value:=SelM040.FieldByName('importoindridottag').asFloat;
      TabellaStampa.FieldByName('tariffaindridottahg').value:=SelM040.FieldByName('tariffaindridottahg').asFloat;
      TabellaStampa.FieldByName('oreindridottahg').value:=SelM040.FieldByName('oreindridottahg').asFloat;
      TabellaStampa.FieldByName('importoindridottahg').value:=SelM040.FieldByName('importoindridottahg').asFloat;
      TabellaStampa.FieldByName('flag_modificato').value:=SelM040.FieldByName('flag_modificato').asString;
      TabellaStampa.FieldByName('commessa').value:=SelM040.FieldByName('commessa').asString;
      TabellaStampa.FieldByName('desctiporegistrazione').value:=SelM040.FieldByName('desctiporegistrazione').asString;
      TabellaStampa.FieldByName('noterimborsi').value:=SelM040.FieldByName('note_rimborsi').asString;
      if QSede.SearchRecord('CODICE',SelM040.FieldByName('partenza').asString,[srFromBeginning]) then
        TabellaStampa.FieldByName('partenza').value:=SelM040.FieldByName('partenza').asString + ' - ' + QSede.FieldByName('DESCRIZIONE').AsString
      else
        TabellaStampa.FieldByName('partenza').value:=SelM040.FieldByName('partenza').asString;
      TabellaStampa.FieldByName('destinazione').value:=SelM040.FieldByName('destinazione').asString;
      TabellaStampa.Post;
      bTrovato:=SelM040.SearchRecord('PROGRESSIVO',Progr,[]);
    end;
  end;
end;

procedure TA104FDialogStampa.FormDestroy(Sender: TObject);
begin
  A104FStampaMissioni.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA104FDialogStampa.GetParametriFunzione;
{Leggo i parametri della form}
var
  sDep:string;
begin
  sDep:=C004FParamForm.GetParametro('CASSADA', FormatDateTime('mmyyyy',(R180InizioMese(Parametri.DataLavoro))));
//  MskCassaDa.Text:=FormatDateTime('mm/yyyy', EncodeDate(strtoint(Copy(sDep,5,4)),strtoint(Copy(sDep,3,2)),strtoint(Copy(sDep,1,2))));
  edtMeseScaricoDa.Text:=Copy(sDep,1,2) + '/' + Copy(sDep,3,4);
  sDep:=C004FParamForm.GetParametro('CASSAA', FormatDateTime('mmyyyy',(R180FineMese(Parametri.DataLavoro))));
  edtMeseScaricoA.Text:=Copy(sDep,1,2) + '/' + Copy(sDep,3,4);;
  ChkSaltoPagina.Checked:= C004FParamForm.GetParametro('SALTOPG', 'S') = 'S';
  rgpOrdinamento.ItemIndex:=StrToInt(C004FParamForm.GetParametro('ORDINAMENTO','0'));
  sDep:=C004FParamForm.GetParametro('STATO','');
  EdtStato.Text:=sDep;
  sDep:=C004FParamForm.GetParametro('TITOLO','RIEPILOGO LIQUIDAZIONI MENSILI');
  if sDep = '' then
    sDep:='RIEPILOGO LIQUIDAZIONI MENSILI';
  EdtTitolo.Text:=sDep;
end;

procedure TA104FDialogStampa.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('CASSADA', Copy(edtMeseScaricoDa.Text,1,2) + Copy(edtMeseScaricoDa.Text,4,4));
  C004FParamForm.PutParametro('CASSAA', Copy(edtMeseScaricoA.Text,1,2) + Copy(edtMeseScaricoA.Text,4,4));
  C004FParamForm.PutParametro('STATO',EdtStato.Text);
  C004FParamForm.PutParametro('TITOLO',EdtTitolo.Text);
  if chkSaltoPagina.Checked then
    C004FParamForm.PutParametro('SALTOPG', 'S')
  else
    C004FParamForm.PutParametro('SALTOPG', 'N');
  C004FParamForm.PutParametro('ORDINAMENTO',rgpOrdinamento.ItemIndex.ToString);
  try SessioneOracle.Commit; except end;
end;

procedure TA104FDialogStampa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA104FDialogStampa.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA104FDialogStampa.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  try
    C700DataDal:=EncodeDate(StrToInt(Copy(edtMeseScaricoDa.Text,4,4)),StrToInt(Copy(edtMeseScaricoDa.Text,1,2)),1);
    if StrToInt(Copy(edtMeseScaricoA.Text,1,2))=12 then
      C700DataLavoro:=EncodeDate(StrToInt(Copy(edtMeseScaricoA.Text,4,4)),12,31)
    else
      C700DataLavoro:=EncodeDate(StrToInt(Copy(edtMeseScaricoA.Text,4,4)),StrToInt(Copy(edtMeseScaricoA.Text,1,2))+1,1)-1;
  except
    C700DataDal:=Parametri.DataLavoro;
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA104FDialogStampa.PulisciMaskEdit(Sender:TObject);
var
  MskInput:TMaskEdit;
  sDep:string;
begin
  MskInput:=TMaskEdit(Sender);
  If (trim(MskInput.text)='/') or (trim(MskInput.text)='/  /') or (trim(MskInput.text)='.')then
  begin
    sDep:=MskInput.EditMask;
    MskInput.EditMask:='';
    MskInput.Clear;
    MskInput.EditMask:=sDep;
  end;
end;

procedure TA104FDialogStampa.edtMeseScaricoDaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  PulisciMaskEdit(Sender);
end;

procedure TA104FDialogStampa.frmSelAnagrafebtnPrimoClick(Sender: TObject);
begin
  frmSelAnagrafe.btnBrowseClick(Sender);

end;

procedure TA104FDialogStampa.Button1Click(Sender: TObject);
var SDate:String;
begin
  SDate:=DateToStr(DataOut(Parametri.DataLavoro,'Mese Scarico Da','M'));
  edtMeseScaricoDa.Text:=Copy(SDate,4,length(SDate));
end;

procedure TA104FDialogStampa.Button2Click(Sender: TObject);
var Sdate:String;
begin
  Sdate:=DateToStr(DataOut(Parametri.DataLavoro,'Mese Scarico A','M'));
  edtMeseScaricoA.Text:=Copy(SDate,4,Length(SDate));
end;

procedure TA104FDialogStampa.Button3Click(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    C013FCheckList.clbListaDati.Items.Add(Format('%-16s %s',[COD_MISSIONE_DA_LIQUIDARE,DESC_MISSIONE_DA_LIQUIDARE]));
    C013FCheckList.clbListaDati.Items.Add(Format('%-16s %s',[COD_MISSIONE_LIQUIDATA,DESC_MISSIONE_LIQUIDATA]));
    C013FCheckList.clbListaDati.Items.Add(Format('%-16s %s',[COD_MISSIONE_PARZ_LIQUIDATA,DESC_MISSIONE_PARZ_LIQUIDATA]));
    C013FCheckList.clbListaDati.Items.Add(Format('%-16s %s',[COD_MISSIONE_SOSPESA,DESC_MISSIONE_SOSPESA]));
    R180PutCheckList(EdtStato.Text,15,C013FCheckList.clbListaDati);
    C013FCheckList.ShowModal;
  finally
    EdtStato.Text:=Trim(R180GetCheckList(15, C013FCheckList.clbListaDati));
    FreeAndNil(C013FCheckList);
  end;
end;

end.
