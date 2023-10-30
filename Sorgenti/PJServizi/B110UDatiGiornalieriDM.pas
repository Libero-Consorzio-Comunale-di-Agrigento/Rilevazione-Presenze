unit B110UDatiGiornalieriDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  B110USharedTypes,
  B110UUtils,
  C018UIterAutDM,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  Rp502Pro,
  W010URichiestaAssenzeDM,
  System.SysUtils,
  System.StrUtils,
  System.Classes;

type
  TB110FDatiGiornalieriDM = class(TR015FDatasnapRestDM)
    procedure DataModuleCreate(Sender: TObject);
  private
    FProgressivo: Integer;
    FData: TDateTime;
    R502DtM: TR502ProDtM1;
    procedure SetProgressivo(Value: Integer);
    procedure SetData(Value: TDateTime);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property Progressivo: Integer write SetProgressivo;
    property Data: TDateTime write SetData;
  end;

implementation

{$R *.dfm}

procedure TB110FDatiGiornalieriDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FProgressivo:=0;
  FData:=DATE_NULL;
end;

procedure TB110FDatiGiornalieriDM.SetProgressivo(Value: Integer);
begin
  FProgressivo:=Value;
end;

procedure TB110FDatiGiornalieriDM.SetData(Value: TDateTime);
begin
  FData:=Value;
end;

function TB110FDatiGiornalieriDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=True;
  Result.Messaggio:='';
end;

procedure TB110FDatiGiornalieriDM.Esegui(var RRisultato: TRisultato);
var
  i:Integer;
  S:string;
  D:TDateTime;
  LRes: TOutputDatiGiornalieri;
begin
  FProgressivo:=Parametri.ProgressivoOper;
  if FProgressivo <= 0 then
  begin
    raise Exception.Create('Anagrafico non valido: progressivo = 0');
  end;

  // conteggi giornalieri
  R502DtM:=TR502ProDtM1.Create(SIW.SessioneOracle);
  try
    // prepara risultato servizio
    RRisultato.Output:=TOutputDatiGiornalieri.Create;
    LRes:=TOutputDatiGiornalieri(RRisultato.Output);
    LRes.Clear;

    LRes.Data:=FData;

    R502DtM.QProgressivo:= -1;
    R502DtM.ConsideraRichiesteWeb:=True;
    R502DtM.GiustDistFamiliari:=False;
    R502DtM.PeriodoConteggi(FData - 6,FData);

    D:=FData;
    while D >= FData - 6 do
    begin
      R502DtM.Conteggi('Cartolina',FProgressivo,D);
      //Dati del giorno
      if D = FData then
      begin
        LRes.DebitoGG:=TFunzioniGenerali.MinutiOre(R502DtM.DebitoGG);
        LRes.ResoGG:=TFunzioniGenerali.Minutiore(TFunzioniGenerali.SommaArray(R502DtM.tminlav));
        LRes.SaldoGG:=TFunzioniGenerali.MinutiOre(TFunzioniGenerali.SommaArray(R502DtM.tminlav) - R502DtM.DebitoGG);
        LRes.OreEscluseGG:=TFunzioniGenerali.MinutiOre(R502DtM.minlavesc + R502DtM.mintipoAesc);

        //Timbrature Nominali:
          //giorno non lavorativo
          //[Rp]
          //[M] E07.00 U14.12
          //E08.00 U13.18
        if R502DtM.gglav = 'no' then
          LRes.TimbNominali:='giorno non lavorativo'
        else
        begin
          if R502DtM.s_turno1 <> '' then
            LRes.TimbNominali:=Format('[%s]',[R502DtM.s_turno1]);
          if R502DtM.EntrataTeorica > -1 then
            LRes.TimbNominali:=LRes.TimbNominali + Format(' E%s',[TFunzioniGenerali.MinutiOre(R502DtM.EntrataTeorica)]);
          if R502DtM.UscitaTeorica > -1 then
          begin
            if R502DtM.UscitaTeorica <= 1440 then
              LRes.TimbNominali:=LRes.TimbNominali + Format(' U%s',[TFunzioniGenerali.MinutiOre(R502DtM.UscitaTeorica)])
            else
              LRes.TimbNominali:=LRes.TimbNominali + Format(' U%s',[TFunzioniGenerali.MinutiOre(R502DtM.UscitaTeorica - 1440)]);
          end;
        end;
        LRes.TimbNominali:=LRes.TimbNominali.Trim;

        //Timbrature
        for i:=0 to High(R502DtM.TimbratureOriginali) do
        begin
          //Vhh.mm(causale)
          S:=Format('E%s%s U%s%s',[IfThen(R502DtM.TimbratureOriginali[i].esiste_e,TFunzioniGenerali.MinutiOre(R502DtM.TimbratureOriginali[i].e),'--.--'),
                                   IfThen(R502DtM.TimbratureOriginali[i].caus_e <> '',Format('(%s)',[R502DtM.TimbratureOriginali[i].caus_e])),
                                   IfThen(R502DtM.TimbratureOriginali[i].esiste_u,TFunzioniGenerali.MinutiOre(R502DtM.TimbratureOriginali[i].u),'--.--'),
                                   IfThen(R502DtM.TimbratureOriginali[i].caus_u <> '',Format('(%s)',[R502DtM.TimbratureOriginali[i].caus_u]))
                                   ]);
          LRes.Timbrature:=LRes.Timbrature + IfThen(LRes.Timbrature <> '',' ') + S;
          //Vhh.mm(causale)@rilevatore
          S:=Format('E%s%s%s U%s%s%s',[IfThen(R502DtM.TimbratureOriginali[i].esiste_e,TFunzioniGenerali.MinutiOre(R502DtM.TimbratureOriginali[i].e),'--.--'),
                                   IfThen(R502DtM.TimbratureOriginali[i].caus_e <> '',Format('(%s)',[R502DtM.TimbratureOriginali[i].caus_e])),
                                   IfThen(R502DtM.TimbratureOriginali[i].ril_e <> '',Format('@%s',[R502DtM.TimbratureOriginali[i].ril_e])),
                                   IfThen(R502DtM.TimbratureOriginali[i].esiste_u,TFunzioniGenerali.MinutiOre(R502DtM.TimbratureOriginali[i].u),'--.--'),
                                   IfThen(R502DtM.TimbratureOriginali[i].caus_u <> '',Format('(%s)',[R502DtM.TimbratureOriginali[i].caus_u])),
                                   IfThen(R502DtM.TimbratureOriginali[i].ril_u <> '',Format('@%s',[R502DtM.TimbratureOriginali[i].ril_u]))
                                   ]);
          SetLength(LRes.lstTimbrature,Length(LRes.lstTimbrature) + 1);
          LRes.lstTimbrature[High(LRes.lstTimbrature)]:=S;
        end;

        //Giustificativi
        for i:=0 to High(R502DtM.GiustificativiDelGiorno) do
        begin
          //non visualizzo i giustificativi se non appartenenti al filtro dizionario
          if not A000FiltroDizionario('CAUSALI SUL CARTELLINO',R502DtM.GiustificativiDelGiorno[i].tcausgius) then
            Continue;
          S:=R502DtM.GiustificativiDelGiorno[i].tcausgius;
          if R502DtM.GiustificativiDelGiorno[i].ttipogius = 'I' then
            S:=S + '(GG)'
          else if R502DtM.GiustificativiDelGiorno[i].ttipogius = 'M' then
            S:=S + '(MG)'
          else if R502DtM.GiustificativiDelGiorno[i].ttipogius = 'N' then
            S:=S + Format('(%s)',[TFunzioniGenerali.MinutiOre(R502DtM.GiustificativiDelGiorno[i].tdallegius)])
          else if R502DtM.GiustificativiDelGiorno[i].ttipogius = 'D' then
            S:=S + Format('(%s-%s)',[TFunzioniGenerali.MinutiOre(R502DtM.GiustificativiDelGiorno[i].tdallegius),TFunzioniGenerali.MinutiOre(R502DtM.GiustificativiDelGiorno[i].tallegius)]);
          LRes.Giustificativi:=LRes.Giustificativi + IfThen(LRes.Giustificativi <> '',' ') + S;
          SetLength(LRes.lstGiustificativi,Length(LRes.lstGiustificativi) + 1);
          LRes.lstGiustificativi[High(LRes.lstGiustificativi)]:=S;
        end;

        //Turni reperibilità e guardia
        LRes.TurniReperibilita:=Trim(R502DtM.TurniExtraPianificatiDalleAlle['C'] + ' ' + R502DtM.TurniExtraPianificatiDalleAlle['D']);
      end;

      //Anomalie bloccanti e gg.vuoto degli ultimi 7 gg
      for i:=0 to R502DtM.lstAnomalieGG.Count - 1 do
      begin
        if (R502DtM.lstAnomalieGG[i].Livello = 1) or
           ((R502DtM.lstAnomalieGG[i].Livello = 2) and (R502DtM.lstAnomalieGG[i].Num in [31,54])) then
        begin
          SetLength(LRes.lstAnomalie,Length(LRes.lstAnomalie) + 1);
          LRes.lstAnomalie[High(LRes.lstAnomalie)].Item:=DateToStr(D);
          LRes.lstAnomalie[High(LRes.lstAnomalie)].Value:=R502DtM.lstAnomalieGG[i].Descrizione;
        end;
      end;
      D:=D - 1;
    end;
  finally
    FreeAndNil(R502DtM);
  end;
end;

end.
