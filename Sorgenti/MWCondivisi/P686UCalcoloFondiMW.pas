unit P686UCalcoloFondiMW;

interface

uses
  System.SysUtils, System.Classes, Variants, R005UDataModuleMW,
  Data.DB, OracleData, Oracle, StrUtils,
  A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali;

type
  T686Dlg = procedure(msg,Chiave:String) of object;
  T686AvanzaProgressBar = procedure of object;

  TParametriElaborazione = record
    dDecorrenzaDa: TDateTime;           //StrToDate(edtDecorrenzaDa.Text)
    dDecorrenzaA: TDateTime;            //StrToDate(edtDecorrenzaA.Text)
    dDataMonit: TDateTime;              //StrToDate(edtDataMonit.Text)
    iModalitaCalcolo: Integer;          //rgpModalitaCalcolo.ItemIndex
    iStatoCedolini: Integer;            //rgpStatoCedolini.ItemIndex
    lstFondi:TStringList;               //clbFondi
  end;

  TP686FCalcoloFondiMW = class(TR005FDataModuleMW)
    selP500: TOracleDataSet;
    selP050: TOracleDataSet;
    delP690: TOracleQuery;
    selP688Conta: TOracleQuery;
    selP688: TOracleDataSet;
    selP442: TOracleDataSet;
    scrP690: TOracleQuery;
    updP684: TOracleQuery;
    updP688: TOracleQuery;
    selP684: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    evtRichiesta:T686Dlg;
    evtAvanzaProgressBar:T686AvanzaProgressBar;
    MsgErrore:String;
    ParametriElaborazione:TParametriElaborazione;
    function LetturaFondi(DecorrenzaDa,DecorrenzaA:String):Boolean;
    procedure Controlli;
    procedure Inizializzazioni;
    procedure ElaboraFondo(CodFondo:String);
  end;

var
  P686FCalcoloFondiMW: TP686FCalcoloFondiMW;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TP686FCalcoloFondiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ParametriElaborazione.lstFondi:=TStringList.Create;
end;

procedure TP686FCalcoloFondiMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(ParametriElaborazione.lstFondi);
  inherited;
end;

function TP686FCalcoloFondiMW.LetturaFondi(DecorrenzaDa,DecorrenzaA:String):Boolean;
begin
  Result:=False;
  if (Trim(DecorrenzaDa) = '') or (Trim(DecorrenzaA) = '') then
    exit;
  if (StrToDate(DecorrenzaDa) = selP684.GetVariable('INIZIO')) and
     (StrToDate(DecorrenzaA) = selP684.GetVariable('FINE')) then
    exit;
  selP684.Close;
  selP684.SetVariable('INIZIO',StrToDate(DecorrenzaDa));
  selP684.SetVariable('FINE',StrToDate(DecorrenzaA));
  selP684.Open;
  Result:=True;
end;

procedure TP686FCalcoloFondiMW.Controlli;
begin
  with ParametriElaborazione do
  begin
    //---BLOCCANTI---//
    if dDecorrenzaA < dDecorrenzaDa then
      raise exception.Create(A000MSG_ERR_DECORR_NON_SUCC_SCAD);
    if lstFondi.Count = 0 then
      raise exception.Create(A000MSG_P686_ERR_FONDI);
    //----DOMANDE----//
    if Assigned(evtRichiesta) then
      evtRichiesta(A000MSG_P686_DLG_ELAB_FONDI,'');
  end;
end;

procedure TP686FCalcoloFondiMW.Inizializzazioni;
begin
  with ParametriElaborazione do
  begin
    delP690.ClearVariables; //Forzare la cancellazione in caso di ri-esecuzione
    selP500.Close;
    selP500.SetVariable('Anno',R180Anno(dDecorrenzaA));
    selP500.Open;
    selP050.Close;
    selP050.SetVariable('CODVALUTA',selP500.FieldByName('COD_VALUTA').AsString);
    selP050.SetVariable('DECORRENZA',dDecorrenzaA);
    selP050.Open;
    selP688Conta.SetVariable('COD','''' + StringReplace(lstFondi.CommaText,',',''',''',[rfReplaceAll]) + '''');
    selP688Conta.SetVariable('INIZIO',dDecorrenzaDa);
    selP688Conta.SetVariable('FINE',dDecorrenzaA);
    selP688Conta.Execute;
  end;
end;

procedure TP686FCalcoloFondiMW.ElaboraFondo(CodFondo:String);
var TotImp:Real;
begin
  with ParametriElaborazione do
  begin
    //Ciclo su tutte le decorrenze di ogni fondo estratte da P688
    selP688.Close;
    selP688.SetVariable('COD',CodFondo);
    selP688.SetVariable('INIZIO',dDecorrenzaDa);
    selP688.SetVariable('FINE',dDecorrenzaA);
    selP688.Open;
    while not selP688.Eof do
    begin
      if Assigned(evtAvanzaProgressBar) then
        evtAvanzaProgressBar;
      TotImp:=0;
      if (VarToStr(delP690.GetVariable('COD')) <> selP688.FieldByName('COD_FONDO').AsString) or
         (VarToStr(delP690.GetVariable('DEC')) <> selP688.FieldByName('DECORRENZA_DA').AsString) then
      begin
        //Cancello i dati registrati in precedenza
        delP690.SetVariable('COD',selP688.FieldByName('COD_FONDO').AsString);
        delP690.SetVariable('DEC',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
        delP690.Execute;
      end;
      //Recupero lo speso dalle voci
      selP442.Close;
      selP442.SetVariable('DATACALCOLO',IfThen(iModalitaCalcolo = 0,'P442.DATA_COMPETENZA_A','P441.DATA_CEDOLINO'));
      selP442.SetVariable('DATAINIZIOCOMPETENZA',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
      selP442.SetVariable('DATAFINECOMPETENZA',selP688.FieldByName('DECORRENZA_A').AsDateTime);
      if Trim(selP688.FieldByName('FILTRO_DIPENDENTI').AsString) <> '' then
        selP442.SetVariable('FILTRODIPENDENTI',selP688.FieldByName('FILTRO_DIPENDENTI').AsString)
      else if Trim(selP688.FieldByName('FILTROP684').AsString) <> '' then
        selP442.SetVariable('FILTRODIPENDENTI',selP688.FieldByName('FILTROP684').AsString)
      else //Forzo condizione sempre vera
        selP442.SetVariable('FILTRODIPENDENTI','1 = 1');
      selP442.SetVariable('ACCORPAMENTI',selP688.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString);
      case iStatoCedolini of
        0:selP442.SetVariable('STATOCEDOLINI','''S''');
        1:selP442.SetVariable('STATOCEDOLINI','''S'',''N''');
        2:selP442.SetVariable('STATOCEDOLINI','''N''');
      end;
      selP442.Open;
      while not selP442.Eof do
      begin
        //Inserisco i dati aggiornati
        scrP690.SetVariable('PROGRESSIVO',selP442.FieldByName('PROGRESSIVO').AsInteger);
        scrP690.SetVariable('COD_FONDO',selP688.FieldByName('COD_FONDO').AsString);
        scrP690.SetVariable('DECORRENZA_DA',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
        scrP690.SetVariable('CLASS_VOCE','D');
        scrP690.SetVariable('COD_VOCE_GEN',selP688.FieldByName('COD_VOCE_GEN').AsString);
        scrP690.SetVariable('COD_VOCE_DET',selP688.FieldByName('COD_VOCE_DET').AsString);
        scrP690.SetVariable('DATA_RETRIBUZIONE',selP442.FieldByName('DATA_RETRIBUZIONE').AsDateTime);
        scrP690.SetVariable('COD_CONTRATTO',selP442.FieldByName('COD_CONTRATTO').AsString);
        scrP690.SetVariable('COD_VOCE',selP442.FieldByName('COD_VOCE').AsString);
        scrP690.SetVariable('IMPORTO',selP442.FieldByName('IMPORTO').AsFloat);
        scrP690.Execute;
        TotImp:=TotImp + selP442.FieldByName('IMPORTO').AsFloat;
        selP442.Next;
      end;
      //Aggiorno la data del monitoraggio del fondo
      updP684.SetVariable('DTMONIT',dDataMonit);
      updP684.SetVariable('COD',selP688.FieldByName('COD_FONDO').AsString);
      updP684.SetVariable('DEC',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
      updP684.Execute;
      //Aggiorno il totale della destinazione dettagliata
      if selP688.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
      begin
        if selP050.SearchRecord('Cod_Arrotondamento',selP688.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
          (TotImp <> 0) then
          TotImp:=R180Arrotonda(TotImp,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
      end;
      updP688.SetVariable('IMP',TotImp);
      updP688.SetVariable('COD',selP688.FieldByName('COD_FONDO').AsString);
      updP688.SetVariable('DEC',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
      updP688.SetVariable('CODGEN',selP688.FieldByName('COD_VOCE_GEN').AsString);
      updP688.SetVariable('CODDET',selP688.FieldByName('COD_VOCE_DET').AsString);
      updP688.Execute;
      SessioneOracle.Commit;
      selP688.Next;
    end;
  end;
end;

end.
