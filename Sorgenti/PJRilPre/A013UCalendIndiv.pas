unit A013UCalendIndiv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TABELLE99, StdCtrls, Buttons, Mask, ExtCtrls, Menus, ComCtrls, C700USelezioneAnagrafe,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, C005UDatiAnagrafici, SelAnagrafe, Variants, InputPeriodo;

type
  TA013FCalendIndiv = class(TFrmTabelle99)
    ScrollBox1: TScrollBox;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    ELunedi: TCheckBox;
    EMartedi: TCheckBox;
    EMercoledi: TCheckBox;
    EGiovedi: TCheckBox;
    EVenerdi: TCheckBox;
    ESabato: TCheckBox;
    EDomenica: TCheckBox;
    GroupBox2: TGroupBox;
    Genera: TBitBtn;
    Visualizza: TBitBtn;
    EPatrono: TMaskEdit;
    ProgressBar1: TProgressBar;
    Cancella: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure GeneraClick(Sender: TObject);
    procedure VisualizzaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    {private declaration}
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    {public declaration}
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A013FCalendIndiv: TA013FCalendIndiv;

procedure OpenA013CalendIndiv(Progressivo:LongInt);

implementation

uses A013UCalendIndivDtM1,A013USviluppoIndiv;

{$R *.DFM}

procedure OpenA013CalendIndiv(Progressivo:LongInt);
begin
  if Progressivo <= 0 then
  begin
    ShowMessage(A000MSG_ERR_NO_DIP);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA013CalendIndiv') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A013FCalendIndiv:=TA013FCalendIndiv.Create(nil);
  try
    C700Progressivo:=Progressivo;
    A013FCalendIndivDtM1:=TA013FCalendIndivDtM1.Create(nil);
    A013FCalendIndiv.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A013FCalendIndivDtM1.Free;
    A013FCalendIndiv.Free;
  end;
end;

procedure TA013FCalendIndiv.FormCreate(Sender: TObject);
begin
  inherited;
  Genera.Enabled:=not SolaLettura;
  Cancella.Enabled:=not SolaLettura;
end;

procedure TA013FCalendIndiv.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A013FCalendIndivDtM1.A013MW,SessioneOracle,StatusBar,1,True);
end;

procedure TA013FCalendIndiv.GeneraClick(Sender: TObject);
var DaGiorno,AGiorno,Patrono:TDateTime;
    Messaggio:String;
{Genero il calendario del dipendente da data a data}
begin
  DaGiorno:= DataI;
  AGiorno:= DataF;
  if DaGiorno <= 0 then
  begin
    ShowMessage(A000MSG_ERR_DATA_ERRATA);
    exit;
  end;
  if AGiorno <= 0 then
  begin
    ShowMessage(A000MSG_ERR_DATA_ERRATA);
    exit;
  end;
  if DaGiorno > AGiorno then
  begin
    ShowMessage(A000MSG_ERR_DATE_INVERTITE);
    exit;
  end;
  if Sender = Cancella then
    Messaggio:='cancellare'
  else
    Messaggio:='generare';
  if MessageDlg(Format(A000MSG_A013_DLG_FMT_CONFERMA_AZIONE,[Messaggio, frmInputPeriodo.edtInizio.Text, frmInputPeriodo.edtFine.Text]),
                mtInformation, [mbYes, mbNo], 0) = mrNo then exit;
  //Cancellazione Calendario
  if Sender = Cancella then
  begin
    A013FCalendIndivDtM1.A013MW.CancellaCalendario(DaGiorno,AGiorno);
    ShowMessage(A000MSG_MSG_ELABORAZIONE_TERMINATA);
    exit;
  end;
  //Generazione Calendario
  if (StringReplace(EPatrono.Text,' ','',[rfReplaceAll]) <> '//') and (not A013FCalendIndivDtM1.A013MW.ConvData(EPatrono.Text,Patrono)) then
  begin
    ShowMessage(A000MSG_A013_ERR_DATA_PATRONO);
    exit;
  end;
  {Carico nel vettore LAVORATIVO i giorni lavorativi}
  with A013FCalendIndivDtM1.A013MW do
  begin
    if (Trim(EPatrono.Text) = '') or (StringReplace(EPatrono.Text,' ','',[rfReplaceAll]) = '//') then
      DataPatrono:=0
    else
      DataPatrono:=StrToDate(EPatrono.Text);
    Lavorativo[1]:=ELunedi.Checked;
    Lavorativo[2]:=EMartedi.Checked;
    Lavorativo[3]:=EMercoledi.Checked;
    Lavorativo[4]:=EGiovedi.Checked;
    Lavorativo[5]:=EVenerdi.Checked;
    Lavorativo[6]:=ESabato.Checked;
    Lavorativo[7]:=EDomenica.Checked;
    Screen.Cursor:=crHourGlass;
    GeneraCalendario(DaGiorno,AGiorno);
    Screen.Cursor:=crDefault;
    ShowMessage(A000MSG_MSG_ELABORAZIONE_TERMINATA);
  end;
end;

procedure TA013FCalendIndiv.VisualizzaClick(Sender: TObject);
{Visualizzo il calendario del dipendente da data a data}
var AnnoF,MeseF,GiornoF,AnnoL,MeseL,GiornoL:Word;
    Range:Boolean;
    DiffAnni:Integer;
    Msg:String;
begin
  with A013FCalendIndivDtM1.A013MW do
  begin
    Range:=True;
    DaData:= DataI;
    AData:= DataF;
    //Controllo se e' impostato un range valido
    if DaData < 1 then
    begin
      Range:=False;
      DaData:=EncodeDate(1900,1,1);
    end;
    if AData < 1 then
    begin
      Range:=False;
      AData:=EncodeDate(3999,12,31);
    end;
    if (Range) and (DaData > AData) then
    begin
      ShowMessage(A000MSG_ERR_DATE_INVERTITE);
      exit;
    end;
    Msg:=ValidaCalendario;
    if(Msg <> '') then
    begin
      ShowMessage(Msg);
      exit;
    end;
    DecodeDate(DaData,AnnoF,MeseF,GiornoF);
    DecodeDate(AData,AnnoL,MeseL,GiornoL);
  end;
  A013FSviluppoIndiv:=TA013FSviluppoIndiv.Create(nil);
  try
    A013FSviluppoIndiv.DaData:=EncodeDate(AnnoF,MeseF,GiornoF);
    A013FSviluppoIndiv.AData:=EncodeDate(AnnoL,MeseL,GiornoL);
    if A013FSviluppoIndiv.DaData > A013FSviluppoIndiv.AData then
    begin
      A013FSviluppoIndiv.DaData:=EncodeDate(AnnoL,MeseL,GiornoL);
      A013FSviluppoIndiv.AData:=EncodeDate(AnnoF,MeseF,GiornoF);
      DecodeDate(A013FSviluppoIndiv.DaData,AnnoF,MeseF,GiornoF);
      DecodeDate(A013FSviluppoIndiv.AData,AnnoL,MeseL,GiornoL);
    end;
    DiffAnni:=AnnoL - AnnoF;
    if DiffAnni = 0 then
      A013FSviluppoIndiv.NumMesi:=MeseL - MeseF + 1
    else
      A013FSviluppoIndiv.NumMesi:=12*(DiffAnni - 1) + MeseL + 13 - MeseF;
    A013FSviluppoIndiv.Calendario.RowCount:=A013FSviluppoIndiv.NumMesi + 1;
    A013FSviluppoIndiv.Anno:=AnnoF;
    A013FSviluppoIndiv.Mese:=MeseF;
    A013FSviluppoIndiv.ShowModal;
    finally
    A013FSviluppoIndiv.Release;
  end;
end;

procedure TA013FCalendIndiv.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:= DataI;
  except
    try
      C005DataVisualizzazione:= DataF;
    except
      C005DataVisualizzazione:=Parametri.DataLavoro;
    end;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA013FCalendIndiv.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  try
    C700Datalavoro:= DataI;
  except
    try
      C700Datalavoro:= DataF;
    except
      C700Datalavoro:=Parametri.DataLavoro;
    end;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA013FCalendIndiv.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

{ DataF }
function TA013FCalendIndiv._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TA013FCalendIndiv._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ----DataF }
{ DataI }
function TA013FCalendIndiv._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TA013FCalendIndiv._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ----DataI }

end.
