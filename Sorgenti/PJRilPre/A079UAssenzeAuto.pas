unit A079UAssenzeAuto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, C001StampaLib, C180FunzioniGenerali, Math,
  A000UCostanti, A000USessione, A000UInterfaccia,
  ExtCtrls,DB,checklst, ComCtrls, C700USelezioneAnagrafe,
  Mask, SelAnagrafe, Menus, A003UDataLavoroBis, C005UDatiAnagrafici, Variants,
  A079UAssenzeAutoMW, A000UMessaggi, InputPeriodo;

type
  TA079FAssenzeAuto = class(TForm)
    BtnEsegui: TBitBtn;
    BtnClose: TBitBtn;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnEseguiClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    A079MW:TA079FAssenzeAutoMW;
    procedure ScorriQueryAnagrafica;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    { Public declarations }
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A079FAssenzeAuto: TA079FAssenzeAuto;

procedure OpenA079AssenzeAuto(Prog:LongInt);

implementation

{$R *.DFM}

procedure OpenA079AssenzeAuto(Prog:LongInt);
{Gestione inserimento automatico assenze}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA079AssenzeAuto') of
    'N','R':begin
              ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
              Exit;
            end;
  end;
  A079FAssenzeAuto:=TA079FAssenzeAuto.Create(nil);
  with A079FAssenzeAuto do
    try
      C700Progressivo:=Prog;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA079FAssenzeAuto.FormCreate(Sender: TObject);
begin
  A079MW:=TA079FAssenzeAutoMW.Create(Self);
  inherited;
end;

procedure TA079FAssenzeAuto.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A079MW,SessioneOracle,StatusBar,0,False);
end;

procedure TA079FAssenzeAuto.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA079FAssenzeAuto.BtnEseguiClick(Sender: TObject);
begin
  A079MW.ControllaDate(DataI, DataF);
  ScorriQueryAnagrafica;
end;

procedure TA079FAssenzeAuto.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:= IfThen(DataI > 0, DataI, Parametri.DataLavoro);

  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA079FAssenzeAuto.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:= IfThen(DataF > 0, DataF, Parametri.DataLavoro);

  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA079FAssenzeAuto.ScorriQueryAnagrafica;
begin
  R180SetVariable(C700SelAnagrafe,'DATALAVORO',A079MW.AData);
  C700SelAnagrafe.Open;
  frmSelAnagrafe.NumRecords;
  C700SelAnagrafe.First;
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.EOF do
    begin
      try
        A079MW.InserimentoAutomaticoAssenze;
        C700SelAnagrafe.Next;
      except
      end;
      ProgressBar1.StepBy(1);
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar1.Position:=0;
  end;
  ShowMessage(A000MSG_MSG_ELABORAZIONE_TERMINATA);
end;

{ DataF }
function TA079FAssenzeAuto._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TA079FAssenzeAuto._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ----DataF }
{ DataI }
function TA079FAssenzeAuto._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TA079FAssenzeAuto._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ----DataI }

end.
