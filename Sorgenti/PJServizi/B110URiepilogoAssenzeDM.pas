unit B110URiepilogoAssenzeDM;
//http://localhost:89/datasnap/rest/TB110FServerMethodsDM/RiepilogoAssenze/AZIN/casa/c/DIPENDENTE/4/FERIE/2015-01-01

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  B110UUtils,
  B110USharedTypes,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  R600,
  System.SysUtils,
  System.StrUtils,
  Variants;

type
  TB110FRiepilogoAssenzeDM = class(TR015FDatasnapRestDM)
    procedure DataModuleCreate(Sender: TObject);
  private
    FProgressivo: Integer;
    FCausale: String;
    FData: TDateTime;
    FDataFamiliare: TDateTime;
    R600DtM: TR600DtM1;
    procedure SetProgressivo(Value: Integer);
    procedure SetCausale(Value: String);
    procedure SetData(Value: TDateTime);
    procedure SetDataFamiliare(Value: TDateTime);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property Progressivo: Integer write SetProgressivo;
    property Causale: String write SetCausale;
    property Data: TDateTime write SetData;
    property DataFamiliare: TDateTime write SetDataFamiliare;
  end;

implementation

{$R *.dfm}

{ TB110FRiepilogoAssenzeDM }

procedure TB110FRiepilogoAssenzeDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FProgressivo:=0;
  FCausale:='';
  FData:=DATE_NULL;
  FDataFamiliare:=DATE_NULL;
end;

procedure TB110FRiepilogoAssenzeDM.SetProgressivo(Value: Integer);
begin
  FProgressivo:=Value;
end;

procedure TB110FRiepilogoAssenzeDM.SetCausale(Value: String);
begin
  FCausale:=Value;
end;

procedure TB110FRiepilogoAssenzeDM.SetData(Value: TDateTime);
begin
  FData:=Value;
end;

procedure TB110FRiepilogoAssenzeDM.SetDataFamiliare(Value: TDateTime);
begin
  FDataFamiliare:=Value;
end;

function TB110FRiepilogoAssenzeDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=True;
  Result.Messaggio:='';
end;

procedure TB110FRiepilogoAssenzeDM.Esegui(var RRisultato: TRisultato);
var
  G: TGiustificativo;
  LRes: TOutputRiepilogoAssenze;
  LRiepAss: TRiepilogoAssenze;
begin
  G.Inserimento:=False;
  G.Modo:='I';
  G.Causale:=FCausale;

  // iter giustificativi
  R600DtM:=TR600Dtm1.Create(SIW.SessioneOracle);
  try
    // verifica esistenza causale
    if VarIsNull(R600DtM.Q265.Lookup('CODICE',FCausale,'CODICE')) then
    begin
      RRisultato.AddError(TErrorCode.DataNotFound,'La causale specificata non esiste!');
      Exit;
    end;

    //R600DtM.GetAssenze(FProgressivo,FData,FData,FDataFamiliare,G,False);
    if TFunzioniGenerali._In(VarToStr(R600DtM.Q265.Lookup('CODICE',FCausale,'CUMULO_FAMILIARI')),['S','D']) then
      R600DtM.RiepilogaAssenze(FProgressivo,FData,G,True,FDataFamiliare)
    else
      R600DtM.RiepilogaAssenze(FProgressivo,FData,G,False,0);

    // prepara risultato servizio
    RRisultato.Output:=TOutputRiepilogoAssenze.Create;
    LRes:=TOutputRiepilogoAssenze(RRisultato.Output);

    // data e causale
    LRes.Data:=FData;
    LRes.CausaleCod:=FCausale;
    LRes.CausaleDesc:=VarToStr(R600DtM.Q265.Lookup('CODICE',FCausale,'DESCRIZIONE'));

    // altri dati riepilogo assenza
    LRiepAss:=R600DtM.RiepilogoAssenze[High(R600DtM.RiepilogoAssenze)];
    LRes.UMisuraDesc:=IfThen(LRiepAss.ArrotOre2Giorni,'Giorni',LRiepAss.UM);
    LRes.UMisura:=IfThen(LRes.UMisuraDesc = 'Ore','O','G');
    LRes.CompPrec:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_CP,LRiepAss.CP);
    LRes.CompCorr:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_CC,LRiepAss.CC);
    LRes.CompTot:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_CT,LRiepAss.CT);
    LRes.FruitoPrec:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_FP,LRiepAss.FP);
    LRes.FruitoCorr:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_FC,LRiepAss.FC);
    LRes.FruitoTot:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_FT,LRiepAss.FT);
    LRes.FruitoRich:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_IterRich,LRiepAss.IterRich);
    LRes.FruitoAut:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_IterAut,LRiepAss.IterAut);
    LRes.ResiduoPrec:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_RP,LRiepAss.RP);
    LRes.ResiduoCorr:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_RC,LRiepAss.RC);
    LRes.Residuo:=IfThen(LRiepAss.ArrotOre2Giorni,LRiepAss.H_R,LRiepAss.R);
  finally
    FreeAndNil(R600DtM);
  end;
end;

end.
