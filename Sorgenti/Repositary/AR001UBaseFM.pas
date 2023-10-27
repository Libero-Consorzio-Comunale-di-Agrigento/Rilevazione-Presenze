unit AR001UBaseFM;

interface

uses
  A000UCostanti,
  AM000UConstants,
  AM000UMessageManager,
  AM000UTypes,
  AM000UUtils,
  B110USharedTypes,
  C200UWebServicesTypes,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, System.Math, FMX.Effects,
  FMX.Ani, FMX.ListView, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView.Types, System.Net.HttpClient, System.Messaging, System.StrUtils,
  Data.FireDACJSONReflect, FireDAC.Comp.Client;

type
  TAR001FBaseFM = class(TFrame)
    pnlMain: TPanel;
  private
    FAbilitazione: String;
    FTabTitle: String;
    procedure RegistraSubscribers;
    procedure RimuoviSubscribers;
  protected
    procedure ApplicaTema; virtual;
    function GetTabellaDizionarioSRV(var PDataset: TFDMemTable; const PTabella, PParam1: String; const PApplicaFiltroDizionario: Boolean): TResCtrl; inline;
  public
    FRegID: TRegID;
    constructor Create(AOwner: TComponent) ; override;
    destructor Destroy; override;
    procedure OnAggiornaUI(const Sender: TObject; const AMessage: TMessage);
    property Abilitazione: String read FAbilitazione write FAbilitazione;
    property TabTitle: String read FTabTitle write FTabTitle;
  end;

implementation

uses
  AM000UMain,
  AM000UClientModule,
  AM000UCommonInterface;

{$R *.fmx}

{ TAR001FBaseFM }

constructor TAR001FBaseFM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAbilitazione:='';
  FTabTitle:='';
  RegistraSubscribers;

  ApplicaTema;
end;

destructor TAR001FBaseFM.Destroy;
begin
  RimuoviSubscribers;
  inherited;
end;

procedure TAR001FBaseFM.RegistraSubscribers;
begin
  FRegID.AggiornaUI:=MessageManager.SubscribeToMessage(TAggiornaUIMessage,OnAggiornaUI);
end;

procedure TAR001FBaseFM.RimuoviSubscribers;
begin
  MessageManager.Unsubscribe(TAggiornaUIMessage,FRegID.AggiornaUI,False);
end;

procedure TAR001FBaseFM.OnAggiornaUI(const Sender: TObject; const AMessage: TMessage);
begin
  Exit;
  if Self.Visible then
  begin
    ApplicaTema;
  end;
end;

procedure TAR001FBaseFM.ApplicaTema;
begin
  TAM000FUtils.ImpostaTemaObject(pnlMain);
end;

function TAR001FBaseFM.GetTabellaDizionarioSRV(var PDataset: TFDMemTable; const PTabella, PParam1: String; const PApplicaFiltroDizionario: Boolean): TResCtrl;
var
  LRes: TRisultato;
  LDataSetList: TFDJSONDataSets;
begin
  // chiude il dataset dizionario
  PDataset.Close;

  // estrae il dizionario richiesto dal server
  LRes:=AM000FClientModule.B110FServerMethodsDMClient
          .Dizionario(AM000FMain.InfoClient.PrepareForServer,
                      AM000FMain.ParametriLogin.PrepareForServer,
                      PTabella,
                      PParam1,
                      PApplicaFiltroDizionario,
                      '');

  // verifica risultato
  Result:=LRes.Check(TOutputDizionario);
  if not Result.Ok then
    Exit;

  // risposta servizio ok
  try
    LDataSetList:=(LRes.Output as TOutputDizionario).JSONDatasets;
    PDataset.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  except
    on E: Exception do
    begin
      Result.Messaggio:=E.Message;
      Exit;
    end;
  end;

  // estrazione dati ok
  Result.Ok:=True;
end;

end.

