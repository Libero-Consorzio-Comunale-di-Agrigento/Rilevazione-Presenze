unit A056UTurnazIndMW;

interface

uses R005UDataModuleMW, Data.DB, Oracle, System.Classes, OracleData,
  System.SysUtils, System.Variants,
  A000UInterfaccia, A058UPianifTurniDtM1, C180FunzioniGenerali;

type
  TA056MWEvt = procedure of object;
  TA056ShowMsg = procedure (Msg: String) of object;

  TDipendente = record
    Progressivo:Integer;
    T1:String;
    Partenza:Integer;
    PinifDaCalen:String;
    VerRiposi:String;
    VerGGLav:String;
    Ciclo:String;
  end;

  TGGTurno = record
    NumTurno:Integer;
    CodTurno:String;
  end;

  TTurni = record
    NumTurni:array of TGGTurno;
  end;

  TA056FTurnazIndMW = class(TR005FDataModuleMW)
    selT021: TOracleDataSet;
    selT620: TOracleDataSet;
    selT040: TOracleDataSet;
    selT603: TOracleDataSet;
    selT606: TOracleDataSet;
    Q620Delete: TOracleQuery;
    Q620DeleteAll: TOracleQuery;
    Q620Insert: TOracleQuery;
    Q430: TOracleDataSet;
    Q611: TOracleDataSet;
    Q641: TOracleDataSet;
    D640: TDataSource;
    Q640: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure D640DataChange(Sender: TObject; Field: TField);
    procedure Q640FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    SquadraPrev, OpPrev:String;
    ListaCicli:TStringList;
    procedure SviluppoTurnazione(Turnazione: String);
    procedure SviluppoCicli;
  public
    Q620: TOracleDataSet;
    Data: TDateTime;
    Orario: TStringList;
    Turno1: TStringList;
    Turno2: TStringList;
    Causale: TStringList;
    Turnazione: String;
    PartenzaValue: Integer;
    EvtD640DataChange: TA056MWEvt;
    EvtImpostaVarMW: TA056MWEvt;
    EvtSetPartenzaMaxValue: TA056MWEvt;
    EvtInitProgressBar: TA056MWEvt;
    EvtIncProgressBar: TA056MWEvt;
    EvtShowMsg: TA056ShowMsg;
    ChkPregressoChecked: Boolean;
    ChkPianifDaCalendarioChecked: Boolean;
    ChkGGLavChecked, ChkRiposiChecked: Boolean;
    VetDipendenti:array of TDipendente;
    A056PCKT080TURNO: T080PCKTURNO;
    procedure PianifDaCalendarioValidate;
    procedure AssegnazioneAutomaticaStep1;
    procedure AssegnazioneAutomaticaStep2;
    procedure CalcolaSviluppo(Turnazione: String);
    procedure InserisciTurnazInd(Prog: Integer);
    procedure CancellaTurnazInd(Prog: Integer);
    procedure LeggiSquadraStorico;
  end;

implementation

{$R *.dfm}

procedure TA056FTurnazIndMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Data:=Parametri.DataLavoro;
  ListaCicli:=TStringList.Create;
  Turno1:=TStringList.Create;
  Turno2:=TStringList.Create;
  Orario:=TStringList.Create;
  Causale:=TStringList.Create;
  Q640.Open;
  A056PCKT080TURNO:=T080PCKTURNO.Create;
end;

procedure TA056FTurnazIndMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ListaCicli);//.Free;
  FreeAndNil(Turno1);//.Free;
  FreeAndNil(Turno2);//.Free;
  FreeAndNil(Orario);//.Free;
  FreeAndNil(Causale);//.Free;
  FreeAndNil(A056PCKT080TURNO);
end;

procedure TA056FTurnazIndMW.D640DataChange(Sender: TObject; Field: TField);
begin
  if (Q640.RecordCount > 0) and (Field = nil) then
    if Assigned(EvtD640DataChange) then
      EvtD640DataChange;
end;

procedure TA056FTurnazIndMW.PianifDaCalendarioValidate;
begin
  if (Q620.FieldByName('PIANIF_DA_CALENDARIO').AsString <> 'S') and
     (Q620.FieldByName('PIANIF_DA_CALENDARIO').AsString <> 'N') then
    Raise Exception.Create('Valori inseribili S o N!');
  if (Q620.FieldByName('VERIFICA_TURNI').AsString <> 'S') and
     (Q620.FieldByName('VERIFICA_TURNI').AsString <> 'N') then
    Raise Exception.Create('Valori inseribili S o N!');
  if (Q620.FieldByName('VERIFICA_RIPOSI').AsString <> 'S') and
     (Q620.FieldByName('VERIFICA_RIPOSI').AsString <> 'N') then
    Raise Exception.Create('Valori inseribili S o N!');
end;

procedure TA056FTurnazIndMW.Q640FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=Accept and R180InConcat(Q640.FieldByName('CODICE').AsString,selT603.FieldByName('CODICI_TURNAZIONE').AsString);
end;

procedure TA056FTurnazIndMW.AssegnazioneAutomaticaStep1;
begin
  //Massimo: questa procedure è obbligatoria assegnarla al MW perchè è necessario allineare le variabili
  EvtImpostaVarMW;
  Randomize;
  SelAnagrafe.First;
  SquadraPrev:=SelAnagrafe.FieldByName('T430SQUADRA').AsString;
  OpPrev:=SelAnagrafe.FieldByName('T430TIPOOPE').AsString;
  while Not SelAnagrafe.Eof do
  begin
    SelAnagrafe.Next;
    if (SquadraPrev <> SelAnagrafe.FieldByName('T430SQUADRA').AsString) or
       (OpPrev <> SelAnagrafe.FieldByName('T430TIPOOPE').AsString) then
      Raise Exception.Create('Non si possono pianificare automaticamente dipendenti appartenenti a due o più squadre/tipi operatore diversi!');
  end;
end;

procedure TA056FTurnazIndMW.AssegnazioneAutomaticaStep2;
var
  i,r,t:Integer;
  Max,Min,OrdTurni:Array[1..4] of Integer;
  ElencoTurni:Array[0..4] of TTurni;

  function GetNumTurno(NTurno:Integer):Integer;
  var Count:Integer;
  begin
    Result:=0;
    selT021.Close;
    selT021.SetVariable('CODICE',Orario[i]);
    selT021.SetVariable('DECORRENZA',Data);
    selT021.Open;
    selT021.First;
    Count:=1;
    while (Not selT021.Eof) and (Count <= NTurno) do
    begin
      inc(Count);
      selT021.Next;
    end;
    dec(Count);
    Result:=Count;
  end;

  procedure CaricaElencoTurni;
  var NumTurno,i:Integer;
      Turnazione:String;
  begin
    if Not ChkPregressoChecked then
      Turnazione:=Q640.FieldByName('CODICE').AsString
    else
    begin
      selT620.Close;
      selT620.SetVariable('PROG',ProgressivoC700);
      selT620.SetVariable('DATA',Data);
      selT620.Open;
      if selT620.RecordCount > 0 then
        Turnazione:=selT620.FieldByName('TURNAZIONE').AsString
      else
        Turnazione:=Q640.FieldByName('CODICE').AsString;
    end;
    //Setto il valore della turnazione
    Q620Insert.SetVariable('TURNAZIONE',Turnazione);
    CalcolaSviluppo(Turnazione);

    (*=====================
    STRUTTURA ELENCOTURNI
    =====================
    ElencoTurni[0].NumTurni = [1,3,46,32] = punti di partenza dei turni con riposi
    ElencoTurni[1].NumTurni = [12,5,21,3] = punti di partenza dei turni con 1
    ElencoTurni[2].NumTurni = [9,35,6,23] = punti di partenza dei turni con 2
    ElencoTurni[3].NumTurni = come sopra
    ElencoTurni[4].NumTurni = come sopra*)
    for i:=1 to Orario.Count - 1 do
    begin
      try
        NumTurno:=GetNumTurno(StrToInt(Turno1[i]))
      except
        NumTurno:=0;
      end;
      SetLength(ElencoTurni[NumTurno].NumTurni,Length(ElencoTurni[NumTurno].NumTurni) + 1);
      ElencoTurni[NumTurno].NumTurni[High(ElencoTurni[NumTurno].NumTurni)].NumTurno:=i;
      ElencoTurni[NumTurno].NumTurni[High(ElencoTurni[NumTurno].NumTurni)].CodTurno:=Orario[i];
    end;
  end;

  function NumTurno(T:Integer):integer;
  //Conto quanti turni T sono già stati assegnati
  var Ind:integer;
  begin
    Result:=0;
    for Ind:=0 to High(VetDipendenti) do
      if (StrToInt(VetDipendenti[Ind].T1) = T) and
         (VarToStr(selT040.Lookup('PROGRESSIVO',VetDipendenti[Ind].Progressivo,'PROGRESSIVO')) = '') then
        Inc(Result);
  end;

begin
  { Massimo: spostato in AssegnazioneAutomaticaStep1, per gestione domanda da IrisCloud
  //Massimo: questa procedure è obbligatoria assegnarla al MW perchè è necessario allineare le variabili
  EvtImpostaVarMW;
  Randomize;
  SelAnagrafe.First;
  SquadraPrev:=SelAnagrafe.FieldByName('T430SQUADRA').AsString;
  OpPrev:=SelAnagrafe.FieldByName('T430TIPOOPE').AsString;
  while Not SelAnagrafe.Eof do
  begin
    SelAnagrafe.Next;
    if (SquadraPrev <> SelAnagrafe.FieldByName('T430SQUADRA').AsString) or
       ((OpPrev <> SelAnagrafe.FieldByName('T430TIPOOPE').AsString) and (ControlloMaxMinItemIndex = 1)) then
      Raise Exception.Create('Non si possono pianificare automaticamente dipendenti appartenenti a due o più squadre/tipi operatore diversi!');
  end;
  }
  //if R180MessageBox('Per i dipendenti selezionati, verranno cancellate le assegnazioni precedenti.' + #13#10 + 'Continuare?','DOMANDA') = mrNo then
    //Exit;

  //Inizializzo variabili
  for i:=1 to 4 do
  begin
    Min[i]:=0;
    Max[i]:=0;
    OrdTurni[i]:=i; //Prelevo i min/max già in ordine di priorità (uso l'array solo per retrocompatibilità)
  end;

  //Cancello le pianificazioni precedenti x il giorno pianificato e per i dipendenti selezionati
  SelAnagrafe.First;
  while Not(SelAnagrafe.Eof) do
  begin
    Q620Delete.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    Q620Delete.SetVariable('DATA',Data);
    Q620Delete.Execute;
    SelAnagrafe.Next;
  end;
  SessioneOracle.Commit;

  //Valorizzo i massimi e i minimi
  //Max min squadra / tipo operatore
  selT606.Close;
  selT606.SetVariable('PROGRESSIVO',-1); //Non individuale
  selT606.SetVariable('COD_SQUADRA',SquadraPrev);
  selT606.SetVariable('COD_TIPOOPE',OpPrev);
  selT606.SetVariable('COD_ORARIO','*'); //Tutti gli orari
  selT606.SetVariable('COD_CONDIZIONE','00001'); //Numero teste
  selT606.SetVariable('DATA',Data);
  selT606.SetVariable('COD_GIORNO',A056PCKT080TURNO.CalcolaTipoGiorno(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data,'S')); //Giorno specifico
  selT606.Open;
  if selT606.RecordCount = 0 then
  begin
    selT606.Close;
    selT606.SetVariable('COD_GIORNO',IntToStr(DayOfWeek(Data - 1))); //Giorno della settimana
    selT606.Open;
  end;
  if selT606.RecordCount = 0 then
  begin
    selT606.Close;
    selT606.SetVariable('COD_GIORNO','*'); //Qualsiasi giorno
    selT606.Open;
  end;
  while not selT606.Eof do
  begin
    i:=selT606.RecNo;
    if i <= 4 then
    begin
      Min[i]:=selT606.fieldByName('MINIMO').AsInteger;
      Max[i]:=selT606.fieldByName('MASSIMO').AsInteger;
    end;
    selT606.Next;
  end;

  //Assenze per il giorno
  selT040.Close;
  selT040.SetVariable('DATA',Data);
  selT040.Open;

  SetLength(VetDipendenti,SelAnagrafe.RecordCount);
  i:=0;
  SelAnagrafe.First;
  while Not SelAnagrafe.Eof do
  begin
    VetDipendenti[i].Progressivo:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    if VarToStr(selT040.Lookup('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,'PROGRESSIVO')) = '' then
      VetDipendenti[i].T1:='0'
    else
      VetDipendenti[i].T1:='-99';
    if ChkPregressoChecked then
    begin
      selT620.Close;
      selT620.SetVariable('PROG',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selT620.SetVariable('DATA',Data);
      selT620.Open;
    end;
    if (ChkPregressoChecked) and (selT620.Active) and (selT620.RecordCount > 0)  then
    begin
      VetDipendenti[i].VerRiposi:=selT620.FieldByName('VERIFICA_RIPOSI').AsString;
      VetDipendenti[i].VerGGLav:=selT620.FieldByName('VERIFICA_TURNI').AsString;
      VetDipendenti[i].PinifDaCalen:=selT620.FieldByName('PIANIF_DA_CALENDARIO').AsString;
    end
    else
    begin
      if ChkPianifDaCalendarioChecked then
        VetDipendenti[i].PinifDaCalen:='S'
      else
        VetDipendenti[i].PinifDaCalen:='N';
      if ChkGGLavChecked then
        VetDipendenti[i].VerGGLav:='S'
      else
        VetDipendenti[i].VerGGLav:='N';
      if ChkRiposiChecked then
        VetDipendenti[i].VerRiposi:='S'
      else
        VetDipendenti[i].VerRiposi:='N';
    end;
    SelAnagrafe.Next;
    Inc(i);
  end;

  CaricaElencoTurni;
  if Assigned(EvtInitProgressBar) then
    EvtInitProgressBar;
  for i:=0 to High(VetDipendenti) do
  begin
    for t:=1 to 4 do
    begin
      //Pianifico il turno solo se il numero dei turnisti è minore del minimo o se
      //il turnista ha una causale d'assenza
      if (NumTurno(OrdTurni[t]) < Min[OrdTurni[t]]) or
         ((VetDipendenti[i].T1 = '-99') and (NumTurno(OrdTurni[t]) < Max[OrdTurni[t]]) and
         (NumTurno(OrdTurni[t]) >= Min[OrdTurni[t]])) then
      begin
        if High(ElencoTurni[OrdTurni[t]].NumTurni) >= 0 then
        begin
          VetDipendenti[i].T1:=IntToStr(OrdTurni[t]);
          r:=Random(Length(ElencoTurni[OrdTurni[t]].NumTurni));
          VetDipendenti[i].Partenza:=ElencoTurni[OrdTurni[t]].NumTurni[r].NumTurno;
          VetDipendenti[i].Ciclo:=ElencoTurni[OrdTurni[t]].NumTurni[r].CodTurno;
        end;
        Break;
      end;
    end;
    if ((VetDipendenti[i].T1 = '0') or (VetDipendenti[i].T1 = '-99')) and (High(ElencoTurni[0].NumTurni) >= 0) then
    begin
      VetDipendenti[i].T1:='0';
      r:=Random(Length(ElencoTurni[0].NumTurni));
      VetDipendenti[i].Partenza:=ElencoTurni[0].NumTurni[r].NumTurno;
      VetDipendenti[i].Ciclo:=ElencoTurni[0].NumTurni[r].CodTurno;
    end;
    if Assigned(EvtIncProgressBar) then
      EvtIncProgressBar;
  end;

  if Assigned(EvtInitProgressBar) then
    EvtInitProgressBar;
  for i:=0 to High(VetDipendenti) do
  begin
    Q620Insert.SetVariable('PROGRESSIVO',VetDipendenti[i].Progressivo);
    Q620Insert.SetVariable('DATA',Data);
    //il valore della turnazione viene settato nella procedure "CaricaElencoTurni".
    //Q620Insert.SetVariable('TURNAZIONE',Q640.FieldByName('CODICE').AsString);
    Q620Insert.SetVariable('PARTENZA',VetDipendenti[i].Partenza);
    Q620Insert.SetVariable('PIANIF_DA_CALENDARIO',VetDipendenti[i].PinifDaCalen);
    Q620Insert.SetVariable('VERIFICA_TURNI',VetDipendenti[i].VerGGLav);
    Q620Insert.SetVariable('VERIFICA_RIPOSI',VetDipendenti[i].VerRiposi);
    Q620Insert.Execute;
    if Assigned(EvtIncProgressBar) then
      EvtIncProgressBar;
  end;
  Q620.Refresh;
  if Assigned(EvtShowMsg) then
    EvtShowMsg('Tutti i dipendenti assegnati correttamente.');
  //ProgressBar1.Position:=0;
  if Assigned(EvtInitProgressBar) then
    EvtInitProgressBar;
  SessioneOracle.Commit;
  (*StrOut:='';
  for i:=0 to High(VetDipendenti) do
  begin
    StrOut:=StrOut + 'Progressivo: ' + IntToStr(VetDipendenti[i].Progressivo);
    StrOut:=StrOut + '         T1: ' + VetDipendenti[i].T1;
    StrOut:=StrOut + '   Partenza: ' + IntToStr(VetDipendenti[i].Partenza) + #13#10;
  end;
  ShowMessage(StrOut);*)
end;

procedure TA056FTurnazIndMW.CalcolaSviluppo(Turnazione:String);
begin
  SviluppoTurnazione(Turnazione);
  SviluppoCicli;
  if Assigned(EvtSetPartenzaMaxValue) then
    EvtSetPartenzaMaxValue;
end;

procedure TA056FTurnazIndMW.SviluppoTurnazione(Turnazione:String);
var i,j:Integer;
begin
  //Carico la sequenza dei cicli in ListaCicli
  ListaCicli.Clear;
  with Q641 do
  begin
    Close;
    SetVariable('Turnazione',Turnazione);
    Open;
    while not Eof do
    begin
      for i:=1 to FieldByName('Multiplo').AsInteger do
        //Carico i cicli n volte quanto specificato da MULTIPLO
        for j:=0 to 4 do
          //Carico i Cicli validi
          if Trim(Fields[j].AsString) <> '' then
            ListaCicli.Add(Fields[j].AsString);
      Next;
    end;
  end;
end;

procedure TA056FTurnazIndMW.SviluppoCicli;
{Sviluppo i cicli ottenuti dalla turnazione}
var i:Integer;
    CicloOld:String;
begin
  CicloOld:='';
  Turno1.Clear;
  Turno2.Clear;
  Orario.Clear;
  Causale.Clear;
  Turno1.Add('NT');
  Turno2.Add('');
  Orario.Add('');
  Causale.Add('');
  for i:=0 to ListaCicli.Count - 1 do
    //Scorro i cicli otenuti dalla turnazione
    with Q611 do
    begin
      if CicloOld <> ListaCicli[i] then
      //Aggiorno la query dei cicli giornalieri se è cambiato il codice
      begin
        Close;
        SetVariable('Ciclo',ListaCicli[i]);
        Open;
        CicloOld:=ListaCicli[i];
      end;
      First;
      while not Eof do
      begin
        Turno1.Add(FieldByName('Turno1').AsString + FieldByName('Turno1EU').AsString);
        Turno2.Add(FieldByName('Turno2').AsString + FieldByName('Turno2EU').AsString);
        Orario.Add(FieldByName('Orario').AsString);
        Causale.Add(FieldByName('Causale').AsString);
        Next;
      end;
    end;
end;

procedure TA056FTurnazIndMW.InserisciTurnazInd(Prog:LongInt);
{Inserimento della turnazione: cancello eventualmente quella già esistente}
begin
  //Massimo: questa procedure è obbligatoria assegnarla al MW perchè è necessario allineare le variabili
  EvtImpostaVarMW;
  with Q620Delete do
  begin
    SetVariable('Progressivo',Prog);
    SetVariable('Data',Data);
    try
      Execute;
    except
    end;
  end;
  with Q620Insert do
  begin
    SetVariable('Progressivo',Prog);
    SetVariable('Data',Data);
    SetVariable('Turnazione',Turnazione);
    SetVariable('Partenza',PartenzaValue);
    if ChkPianifDaCalendarioChecked then
      SetVariable('Pianif_da_calendario','S')
    else
      SetVariable('Pianif_da_calendario','N');
    if ChkGGLavChecked then
      SetVariable('VERIFICA_TURNI','S')
    else
      SetVariable('VERIFICA_TURNI','N');
    if ChkRiposiChecked then
      SetVariable('VERIFICA_RIPOSI','S')
    else
      SetVariable('VERIFICA_RIPOSI','N');
    try
      Execute;
      SessioneOracle.Commit;
      RegistraLog.SettaProprieta('I','T620_TURNAZIND',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
      RegistraLog.InserisciDato('DATA','',DateToStr(Data));
      RegistraLog.InserisciDato('TURNAZIONE','',Format('%s(%d)',[Turnazione,PartenzaValue]));
      RegistraLog.RegistraOperazione;
    except
      SessioneOracle.RollBack;
    end;
  end;
end;

procedure TA056FTurnazIndMW.LeggiSquadraStorico;
begin
  //Leggo Squadra e tipo operatore su T430_Storico
  try
    with Q430 do
    begin
      Close;
      SetVariable('Progressivo',ProgressivoC700);
      SetVariable('Data',Data);
      Open;
    end;
  except
    exit;
  end;
  with selT603 do
  begin
    Close;
    SetVariable('Squadra',Q430.FieldByName('Squadra').AsString);
    Open;
  end;
  Q640.Filtered:=False;
  Q640.Filtered:=True;
end;

procedure TA056FTurnazIndMW.CancellaTurnazInd(Prog:LongInt);
{Cancellazione della turnazione: chiave = Progressivo + Data + Turnazione + Partenza}
begin
  //Massimo: questa procedure è obbligatoria assegnarla al MW perchè è necessario allineare le variabili
  EvtImpostaVarMW;
  with Q620DeleteAll do
  begin
    Setvariable('Progressivo',Prog);
    Setvariable('Data',Data);
    Setvariable('Turnazione',Turnazione);
    try
      Execute;
      SessioneOracle.Commit;
      RegistraLog.SettaProprieta('C','T620_TURNAZIND',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Prog),'');
      RegistraLog.InserisciDato('DATA',DateToStr(Data),'');
      RegistraLog.InserisciDato('TURNAZIONE',Format('%s(%d)',[Turnazione,PartenzaValue]),'');
      RegistraLog.RegistraOperazione;
    except
    end;
  end;
end;

end.
