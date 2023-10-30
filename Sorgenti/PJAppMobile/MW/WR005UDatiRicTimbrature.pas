unit WR005UDatiRicTimbrature;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Sensors, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB, WM000UMemTableMW, MedpUnimPanelBase,
  System.Variants, WR002URichiesteMW;

type

  TStatoRichieste = (DaAutorizzare, Autorizzate, Negate);

  TWR005FDatiRicTimbratureMW = class(TObject)
    private
      FDMemTable: TFDMemTable;

      function GetTimbratura: String;
      function GetTimbraturaOrig: String;
      function GetData: String;
      function GetDataRichiesta: String;
      function GetOperazione: String;
      function GetOperazioneEstesa: String;
      function GetMotivazionePresente: Boolean;
      function GetMotivazione: String;
      function GetRevocabile: String;
    public
      constructor Create(PFDMemTable: TFDMemTable);
      destructor Destroy; override;

      // TIMBRATURA
      //--------------------------------------------------------------------
      property Timbratura: String read GetTimbratura;
      property TimbraturaOrig: String read GetTimbraturaOrig;
      property Data: String read GetData;
      property DataRichiesta: String read GetDataRichiesta;
      property Operazione: String read GetOperazione;
      property OperazioneEstesa: String read GetOperazioneEstesa;
      property MotivazionePresente: Boolean read GetMotivazionePresente;
      property Motivazione: String read GetMotivazione;
      property Revocabile: String read GetRevocabile;
      //--------------------------------------------------------------------
end;

implementation

{ TWR005FDatiRicTimbrature }

constructor TWR005FDatiRicTimbratureMW.Create(PFDMemTable: TFDMemTable);
begin
  inherited Create;
  FDMemTable:=PFDMemTable;
end;

destructor TWR005FDatiRicTimbratureMW.Destroy;
begin
  //
  inherited;
end;

// TIMBRATURA
//--------------------------------------------------------------------------------------------------------------
function TWR005FDatiRicTimbratureMW.GetTimbratura: String;
var
    LOra: String;
    LOperazione: String;
    LVerso: String;
    LRilevatore: String;
    LCausale: String;
    LVersoFmt: string;
    LCausaleFmt: string;
    LRilevatoreFmt: string;
    LIsVersoModif: Boolean;
    LIsCausaleModif: Boolean;
    LIsRilevatoreModif: Boolean;
    LVersoOrig: String;
    LRilevatoreOrig: String;
    LCausaleOrig: String;
begin
  if FDMemTable.Active then
  begin
    LOperazione:=FDMemTable.FieldByName('OPERAZIONE').AsString;
    LVerso:=FDMemTable.FieldByName('VERSO').AsString;
    LVersoOrig:=FDMemTable.FieldByName('VERSO_ORIG').AsString;
    LIsVersoModif:=LVerso <> LVersoOrig;
    LOra:=FDMemTable.FieldByName('ORA').AsString;
    LCausale:=FDMemTable.FieldByName('CAUSALE').AsString;
    LCausaleOrig:=FDMemTable.FieldByName('CAUSALE_ORIG').AsString;
    LIsCausaleModif:=LCausale <> LCausaleOrig;
    LRilevatore:=FDMemTable.FieldByName('RILEVATORE_RICH').AsString;
    LRilevatoreOrig:=FDMemTable.FieldByName('RILEVATORE_ORIG').AsString;
    LIsRilevatoreModif:=LRilevatore <> LRilevatoreOrig;

    LVersoFmt:=IfThen((LOperazione = 'M') and (LIsVersoModif),PREFIX_MODIF) + LVerso;
    LRilevatoreFmt:=IfThen((LOperazione = 'M') and (LIsRilevatoreModif),PREFIX_MODIF) + LRilevatore;
    LCausaleFmt:=IfThen((LOperazione = 'M') and (LIsCausaleModif),PREFIX_MODIF) + LCausale;

    Result:=Format('%s %s %s %s',[LOra,LVersoFmt,LRilevatoreFmt,LCausaleFmt]);
  end
  else
    Result:='';
end;

function TWR005FDatiRicTimbratureMW.GetTimbraturaOrig: String;
var LOra: String;
    LVersoOrig: String;
    LRilevatoreOrig: String;
    LCausaleOrig: String;
begin
  if FDMemTable.Active then
  begin
    LVersoOrig:=FDMemTable.FieldByName('VERSO_ORIG').AsString;
    LOra:=FDMemTable.FieldByName('ORA').AsString;
    LCausaleOrig:=FDMemTable.FieldByName('CAUSALE_ORIG').AsString;
    LRilevatoreOrig:=FDMemTable.FieldByName('RILEVATORE_ORIG').AsString;

    Result:=Format('%s %s %s %s',[LOra,LVersoOrig,LRilevatoreOrig,LCausaleOrig]);
  end
  else
    Result:='';
end;

function TWR005FDatiRicTimbratureMW.GetData: String;
var LData: TDateTime;
begin
  if FDMemTable.Active then
  begin
    LData:=FDMemTable.FieldByName('DATA').AsDateTime;
    Result:=FormatDateTime('dd/mm/yyyy',LData);
  end
  else
    Result:='';
end;

function TWR005FDatiRicTimbratureMW.GetDataRichiesta: String;
var LDataRichiesta: TDateTime;
begin
  if FDMemTable.Active then
  begin
    LDataRichiesta:=FDMemTable.FieldByName('DATA_RICHIESTA').AsDateTime;
    Result:=FormatDateTime('dd/mm/yyyy hh:mm',LDataRichiesta);
  end
  else
    Result:='';
end;

function TWR005FDatiRicTimbratureMW.GetOperazione: String;
var LOperazione: String;
begin
  if FDMemTable.Active then
  begin
    LOperazione:=FDMemTable.FieldByName('OPERAZIONE').AsString;

    if LOperazione = 'I' then
      Result:='INS'
    else if LOperazione = 'M' then
      Result:='MOD'
    else if LOperazione = 'C' then
      Result:='CANC'
    else
      Result:=LOperazione;
  end
  else
    Result:='';
end;

function TWR005FDatiRicTimbratureMW.GetOperazioneEstesa: String;
var LOperazione: String;
    LRilevatore: String;
    LRilevatoreOrig: String;
    LCausale: String;
    LCausaleOrig: String;
    LVerso: String;
    LVersoOrig: String;
    LIsVersoModif: Boolean;
    LIsCausaleModif: Boolean;
    LIsRilevatoreModif: Boolean;
begin
  LOperazione:=FDMemTable.FieldByName('OPERAZIONE').AsString;
  LVerso:=FDMemTable.FieldByName('VERSO').AsString;
  LVersoOrig:=FDMemTable.FieldByName('VERSO_ORIG').AsString;
  LIsVersoModif:=LVerso <> LVersoOrig;
  LCausale:=FDMemTable.FieldByName('CAUSALE').AsString;
  LCausaleOrig:=FDMemTable.FieldByName('CAUSALE_ORIG').AsString;
  LIsCausaleModif:=LCausale <> LCausaleOrig;
  LRilevatore:=FDMemTable.FieldByName('RILEVATORE_RICH').AsString;
  LRilevatoreOrig:=FDMemTable.FieldByName('RILEVATORE_ORIG').AsString;
  LIsRilevatoreModif:=LRilevatore <> LRilevatoreOrig;

  if LOperazione = 'I' then
    Result:='Inserimento'
  else if LOperazione = 'M' then
  begin
    Result:='Modifica';

    if LIsVersoModif then
      Result:=Result + #13#10 + Format('- cambio verso: %s -> %s',[LVersoOrig,LVerso]);

    if LIsCausaleModif then
    begin
      if LCausaleOrig = '' then
        Result:=Result + #13#10 + Format('- impostazione causale %s',[LCausale])
      else if LCausale = '' then
        Result:=Result + #13#10 + Format('- rimozione causale %s',[LCausaleOrig])
      else
        Result:=Result + #13#10 + Format('- modifica causale: %s -> %s',[LCausaleOrig,LCausale]);
    end;

    if LIsRilevatoreModif then
    begin
      if LRilevatoreOrig = '' then
        Result:=Result + #13#10 + Format('- impostazione rilevatore %s',[LRilevatore])
      else if LRilevatore = '' then
        Result:=Result + #13#10 + Format('- rimozione rilevatore %s',[LRilevatoreOrig])
      else
        Result:=Result + #13#10 + Format('- modifica rilevatore: %s -> %s',[LRilevatoreOrig,LRilevatore]);
    end;
  end
  else if LOperazione = 'C' then
    Result:='Cancellazione';
end;

function TWR005FDatiRicTimbratureMW.GetMotivazionePresente: Boolean;
begin
  Result:=(FDMemTable.FindField('MOTIVAZIONE') <> nil) and (FDMemTable.FindField('D_MOTIVAZIONE') <> nil);
end;

function TWR005FDatiRicTimbratureMW.GetMotivazione: String;
begin
  if (FDMemTable.FindField('MOTIVAZIONE') <> nil) and (FDMemTable.FindField('D_MOTIVAZIONE') <> nil) then
    Result:=FDMemTable.FieldByName('D_MOTIVAZIONE').AsString
  else
    Result:='';
end;

function TWR005FDatiRicTimbratureMW.GetRevocabile: String;
begin
  if FDMemTable.Active then
    Result:=FDMemTable.FieldByName('REVOCABILE').AsString
  else
    Result:='';
end;

end.
