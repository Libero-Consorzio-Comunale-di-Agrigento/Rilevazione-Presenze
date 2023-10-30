unit A004UCaricaAssRich;

interface

uses
  A004UGiustifAssPresMW,
  A004UGiustifAssPres, A083UMsgElaborazioni,
  A000UCostanti, A000USessione, A000UInterfaccia,
  C012UVisualizzaTesto, C023UInfoDati, C180FunzioniGenerali, C700USelezioneAnagrafe,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, DBGrids, StdCtrls, Buttons,
  ExtCtrls, ActnList, ImgList, DB, ComCtrls, ToolWin,
  OracleData, Oracle, Math, StrUtils,
  R001UGESTTAB, Mask, System.Actions, Vcl.DBCtrls, System.ImageList, InputPeriodo;

type
  TA004FCaricaAssRich = class(TR001FGestTab)
    Panel2: TPanel;
    btnImporta: TBitBtn;
    chkAnomalie: TCheckBox;
    btnVisualizzaLog: TBitBtn;
    dGrdAssenze: TDBGrid;
    PopupMenu1: TPopupMenu;
    Importaassenzacorrente1: TMenuItem;
    ProgressBar1: TProgressBar;
    grpPeriodo: TGroupBox;
    rgpModalita: TRadioGroup;
    Infoiter1: TMenuItem;
    rgpAllegato: TRadioGroup;
    dCmbFiltroCausale: TDBLookupComboBox;
    lblFiltroCausale: TLabel;
    rgpCondizAllegato: TRadioGroup;
    frmInputPeriodoIntersezione: TfrmInputPeriodo;
    frmInputPeriodoInizio: TfrmInputPeriodo;
    frmInputPeriodoFine: TfrmInputPeriodo;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure btnVisualizzaLogClick(Sender: TObject);
    procedure dGrdAssenzeEditButtonClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure rgpModalitaClick(Sender: TObject);
    procedure rgpAllegatoClick(Sender: TObject);
    procedure Infoiter1Click(Sender: TObject);
    procedure dCmbFiltroCausaleCloseUp(Sender: TObject);
    procedure dCmbFiltroCausaleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rgpCondizAllegatoClick(Sender: TObject);
  private
    procedure AggiornaFiltroPeriodo;

    { Metodi Property }
    function _GetPeriodoI: TDateTime;
    procedure _PutPeriodoI(const Value: TDateTime);
    function _GetPeriodoF: TDateTime;
    procedure _PutPeriodoF(const Value: TDateTime);
    function _GetInizioI: TDateTime;
    procedure _PutInizioI(const Value: TDateTime);
    function _GetInizioF: TDateTime;
    procedure _PutInizioF(const Value: TDateTime);
    function _GetFineI: TDateTime;
    procedure _PutFineI(const Value: TDateTime);
    function _GetFineF: TDateTime;
    procedure _PutFineF(const Value: TDateTime);

  public
    A004MW: TA004FGiustifAssPresMW;
    procedure AggiornaProgresso;

    { Property }
    property PeriodoI:TDateTime read _GetPeriodoI write _PutPeriodoI;
    property PeriodoF:TDateTime read _GetPeriodoF write _PutPeriodoF;
    property InizioI:TDateTime read _GetInizioI write _PutInizioI;
    property InizioF:TDateTime read _GetInizioF write _PutInizioF;
    property FineI:TDateTime read _GetFineI write _PutFineI;
    property FineF:TDateTime read _GetFineF write _PutFineF;

  end;

var
  A004FCaricaAssRich: TA004FCaricaAssRich;
  procedure OpenA004CaricaAssRich(PA004MW: TA004FGiustifAssPresMW);

implementation

{$R *.dfm}

procedure OpenA004CaricaAssRich(PA004MW: TA004FGiustifAssPresMW);
begin
  if not Assigned(PA004MW) then
    raise Exception.Create('Indicare il datamodulo middleware per l''elaborazione!');

  try
    A004FCaricaAssRich:=TA004FCaricaAssRich.Create(nil);
    A004FCaricaAssRich.A004MW:=PA004MW; //***
    A004FCaricaAssRich.chkAnomalie.Checked:=A004FCaricaAssRich.A004MW.AnomalieInterattive;
    A004FCaricaAssRich.ShowModal;
    A004FCaricaAssRich.A004MW.AnomalieInterattive:=A004FCaricaAssRich.chkAnomalie.Checked;
  finally
    FreeAndNil(A004FCaricaAssRich);
  end;
end;

procedure TA004FCaricaAssRich.FormShow(Sender: TObject);
begin
  inherited;

  //Spostato dal Create
  // disattiva filtro dizionario su dataset per controlli assenze - 11.07.2011
  DButton.DataSet:=A004MW.selT050;

  A004MW.Q265.OnFilterRecord:=nil;
  A004MW.Q275.OnFilterRecord:=nil;
  if A004MW.Q265.Active then
    A004MW.Q265.Refresh;
  if A004MW.Q275.Active then
    A004MW.Q275.Refresh;

  C700MergeSelAnagrafe(A004MW.selT050,False);
  C700MergeSettaPeriodo(A004MW.selT050,Parametri.DataLavoro,Parametri.DataLavoro);
  A004MW.selT050.SetVariable('AZIENDA',Parametri.Azienda);
  A004MW.selT050.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
  rgpModalitaClick(nil);
  A004MW.selT050.Close;
  A004MW.selT050.Open;
  AggiornaProgresso; // selT050_AfterOpen
end;

procedure TA004FCaricaAssRich.Infoiter1Click(Sender: TObject);
var
  C023FInfoDati:TC023FInfoDati;
begin
  inherited;
  C023FInfoDati:=TC023FInfoDati.Create(nil);
  try
    C023FInfoDati.MostraInfoRichiesta(A004MW.selT050.FieldByName('ID').AsInteger);
  finally
    FreeAndNil(C023FInfoDati);
  end;
end;

procedure TA004FCaricaAssRich.FormDestroy(Sender: TObject);
begin
  // disattiva filtro dizionario su dataset per controlli assenze - 11.07.2011
  A004MW.Q265.OnFilterRecord:=A004MW.FiltroDizionario;
  A004MW.Q275.OnFilterRecord:=A004MW.FiltroDizionario;
  A004MW.selT050.Close;
  inherited;
end;

procedure TA004FCaricaAssRich.rgpAllegatoClick(Sender: TObject);
begin
  inherited;
  A004MW.selT050FiltroAllegati(rgpAllegato.Items[rgpAllegato.ItemIndex].ToLower);
end;

procedure TA004FCaricaAssRich.rgpCondizAllegatoClick(Sender: TObject);
begin
  inherited;
  A004MW.selT050FiltroFiltroCondizAllegati(rgpCondizAllegato.Items[rgpCondizAllegato.ItemIndex].ToLower);
end;

procedure TA004FCaricaAssRich.rgpModalitaClick(Sender: TObject);
var
  Elab: String;
begin
  if rgpModalita.ItemIndex = 0 then
  begin
    // richieste nuove: cancella periodo intersezione
    PeriodoI:= 0;
    PeriodoF:= 0;
  end
  else
  begin
    // richieste già elaborate: imposta default per periodo di intersezione
    if PeriodoI <= 0 then
      PeriodoI := Date;
    if PeriodoF <= 0 then
      PeriodoF := Date;
  end;

  // pulisce periodo inizio - fine
  InizioI:= 0;
  InizioF:= 0;
  FineI:= 0;
  FineF:= 0;

  Elab:=IfThen(rgpModalita.ItemIndex = 0,'N','E');
  R180SetVariable(A004MW.selT050,'FILTRO_MODALITA',Format('and t050.elaborato = ''%s''',[Elab]));
  AggiornaFiltroPeriodo;
  A004MW.selT050.Open;
  AggiornaProgresso; // selT050_AfterOpen
end;

procedure TA004FCaricaAssRich.actRefreshExecute(Sender: TObject);
var
  ID: String;
begin
  AggiornaFiltroPeriodo;

  if A004MW.selT050.Active then
    inherited
  else
  begin
    ID:=A004MW.selT050.RowID;
    A004MW.selT050.Open;
    AggiornaProgresso; // selT050_AfterOpen
     if ID <> '' then
       A004MW.selT050.Locate('RowID',ID,[]);
  end;
end;

procedure TA004FCaricaAssRich.AggiornaFiltroPeriodo;
var
  IntersezPeriodo,InizioPeriodo,FinePeriodo,Periodo: String;
  {function IsDataNulla(const PData: String): Boolean;
  begin
    Result:=(Trim(PData) = '') or (PData = '  /  /    ');
  end;}
begin
  // periodo 1/3: intersezione dal - al
  if (PeriodoI <= 0) and (PeriodoF <= 0) then
  begin
    // periodo vuoto
    IntersezPeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if PeriodoI <= 0 then
      raise Exception.Create('Data inizio del periodo di intersezione non valida!');
    if PeriodoF <= 0 then
      raise Exception.Create('Data fine del periodo di intersezione non valida!');
    if PeriodoI > PeriodoF then
      raise Exception.Create('Il periodo di intersezione indicato non è valido!');
    IntersezPeriodo:=Format('and t050.al >= to_date(''%s'',''dd/mm/yyyy'') and t050.dal <= to_date(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',PeriodoI),FormatDateTime('dd/mm/yyyy',PeriodoF)]);
  end;

  // periodo 2/3: inizio richieste
  if (InizioI <= 0) and (InizioF <= 0) then
  begin
    // periodo vuoto
    InizioPeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if InizioI <= 0 then
      raise Exception.Create('Data di "Inizio dal" non valida!');
    if InizioF <= 0 then
      raise Exception.Create('Data di "Inizio al" non valida!');
    if InizioI > InizioF then
      raise Exception.Create('Il periodo di inizio indicato non è valido!');
    InizioPeriodo:=Format('and t050.dal between to_date(''%s'',''dd/mm/yyyy'') and to_date(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',InizioI),FormatDateTime('dd/mm/yyyy',InizioF)]);
  end;

  // periodo 3/3: fine richieste
  if (FineI <= 0) and (FineF <= 0) then
  begin
    // periodo vuoto
    FinePeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if FineI <= 0 then
      raise Exception.Create('Data di "Fine dal" non valida!');
    if FineF <= 0 then
      raise Exception.Create('Data di "Fine al" non valida!');
    if FineI > FineF then
      raise Exception.Create('Il periodo di fine indicato non è valido!');
    FinePeriodo:=Format('and t050.al between to_date(''%s'',''dd/mm/yyyy'') and to_date(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',FineI),FormatDateTime('dd/mm/yyyy',FineF)]);
  end;

  // compone il filtro periodo complessivo
  Periodo:=Trim(IntersezPeriodo + ' ' + InizioPeriodo + ' ' + FinePeriodo);

  // la modalità rielaborazione richiede che sia specificato almeno un filtro
  if (rgpModalita.ItemIndex = 1) and (Periodo = '') then
    raise Exception.Create('E'' necessario specificare almeno un filtro sul periodo per la rielaborazione delle richieste');

  R180SetVariable(A004MW.selT050,'FILTRO_PERIODO',Periodo);
end;

procedure TA004FCaricaAssRich.AggiornaProgresso;
begin
  NumRecords;
  Self.Repaint;
end;

procedure TA004FCaricaAssRich.btnImportaClick(Sender: TObject);
var
  Singola,Ok: Boolean;
  Errore,Msg: String;
  NumScartate: Integer;
begin
  if A004MW.selT050.RecordCount = 0 then
  begin
    R180MessageBox('Nessuna richiesta da importare',INFORMA);
    Exit;
  end;

  // determina se l'importazione è singola oppure massiva
  Singola:=Sender <> btnImporta;
  if not Singola then
  begin
    // importazione completa
    if R180MessageBox('Confermi l''importazione di tutte le richieste visualizzate?',DOMANDA) <> mrYes then
      Exit;
  end;

  // avvio elaborazione
  Screen.Cursor:=crHourGlass;

  // per richiesta singola la progressbar non ha senso
  {
  if not Singola then
    A004FGiustifAssPresDtM1.ProgressBar:=ProgressBar1;
  }

  // acquisizione delle richieste di giustificativo su cartellino
  Errore:='';
  Ok:=A004MW.AcquisizioneRichiesteWeb(Singola,chkAnomalie.Checked,Errore,NumScartate,rgpModalita.ItemIndex = 0);

  // riapre il dataset delle richieste
  A004MW.selT050.Close;
  A004MW.selT050.Open;
  AggiornaProgresso; // selT050_AfterOpen

  // fine elaborazione
  Screen.Cursor:=crDefault;

  // messaggio di fine elaborazione
  if Ok then
  begin
    // elaborazione ok / warning
    if Errore = '' then
      Msg:='Elaborazione terminata correttamente'
    else
      Msg:='Elaborazione terminata con avvertimenti:'#13#10 + Errore;

    if NumScartate > 0 then
    begin
      Msg:=Msg + CRLF +
           'Alcune richieste non sono state considerate' + CRLF +
           'perché sono state già importate in precedenza';
    end;
    R180MessageBox(Msg,INFORMA);
  end
  else
  begin
    // anomalie durante elaborazione
    if R180MessageBox('Elaborazione terminata con errori.'#13#10'Si desidera visualizzarli?',DOMANDA) = mrYes then
      btnVisualizzaLogClick(nil);
  end;
end;

procedure TA004FCaricaAssRich.btnVisualizzaLogClick(Sender: TObject);
begin
  inherited;
  A004FGiustifAssPres.frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A004','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(A004MW.SessioneOracleA004);
  A004FGiustifAssPres.frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TA004FCaricaAssRich.dCmbFiltroCausaleCloseUp(Sender: TObject);
begin
  inherited;
  A004MW.selT050FiltroCausale(VarToStr(dCmbFiltroCausale.KeyValue));
end;

procedure TA004FCaricaAssRich.dCmbFiltroCausaleKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  A004MW.selT050FiltroCausale(VarToStr(dCmbFiltroCausale.KeyValue));
end;

procedure TA004FCaricaAssRich.dGrdAssenzeEditButtonClick(Sender: TObject);
var s:TStringList;
begin
  inherited;
  s:=TStringList.Create;
  try
    if dGrdAssenze.SelectedIndex = 12 then
    begin
      s.Text:=A004MW.GetNoteRichiesta(A004MW.selT050.FieldByName('ID').AsInteger);
      OpenC012VisualizzaTesto('Visualizzazione Note della Richiesta','',s);
    end;
  finally
    FreeAndNil(s);
  end;
end;

{ PeriodoI }
function TA004FCaricaAssRich._GetPeriodoI: TDateTime;
begin
  Result := frmInputPeriodoIntersezione.DataInizio;
end;
procedure TA004FCaricaAssRich._PutPeriodoI(const Value: TDateTime);
begin
  frmInputPeriodoIntersezione.DataInizio := Value;
end;
{ PeriodoI---- }
{ PeriodoF }
function TA004FCaricaAssRich._GetPeriodoF: TDateTime;
begin
  Result := frmInputPeriodoIntersezione.DataFine;
end;
procedure TA004FCaricaAssRich._PutPeriodoF(const Value: TDateTime);
begin
  frmInputPeriodoIntersezione.DataFine := Value;
end;
{ PeriodoF---- }



{ FineI }
function TA004FCaricaAssRich._GetFineI: TDateTime;
begin
  Result := frmInputPeriodoFine.DataInizio;
end;
procedure TA004FCaricaAssRich._PutFineI(const Value: TDateTime);
begin
  frmInputPeriodoFine.DataInizio := Value;
end;
{ FineI---- }
{ FineF }
function TA004FCaricaAssRich._GetFineF: TDateTime;
begin
  Result := frmInputPeriodoFine.DataFine;
end;
procedure TA004FCaricaAssRich._PutFineF(const Value: TDateTime);
begin
  frmInputPeriodoFine.DataFine := Value;
end;
{ FineF---- }


{ InizioI }
function TA004FCaricaAssRich._GetInizioI: TDateTime;
begin
  Result := frmInputPeriodoInizio.DataInizio;
end;
procedure TA004FCaricaAssRich._PutInizioI(const Value: TDateTime);
begin
  frmInputPeriodoInizio.DataInizio := Value;
end;
{ InizioI---- }
{ InizioF }
function TA004FCaricaAssRich._GetInizioF: TDateTime;
begin
  Result := frmInputPeriodoInizio.DataFine;
end;
procedure TA004FCaricaAssRich._PutInizioF(const Value: TDateTime);
begin
  frmInputPeriodoInizio.DataFine := Value;
end;
{ InizioF---- }

end.
