unit WA022UContrattiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, A022UContrattiMW,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, A000UCostanti,
  A000USessione, C180FunzioniGenerali, medpIWMessageDlg, ControlloVociPaghe,
  A000UMessaggi;

type
  TWA022FContrattiDM = class(TWR302FGestTabellaDM)
    T201: TOracleDataSet;
    T201Codice: TStringField;
    T201Giorno: TStringField;
    T201D_Giorno: TStringField;
    T201FasciaDa1: TDateTimeField;
    T201FasciaA1: TDateTimeField;
    T201Maggior1: TStringField;
    T201FasciaDa2: TDateTimeField;
    T201FasciaA2: TDateTimeField;
    T201Maggior2: TStringField;
    T201FasciaDa3: TDateTimeField;
    T201FasciaA3: TDateTimeField;
    T201Maggior3: TStringField;
    T201FasciaDa4: TDateTimeField;
    T201FasciaA4: TDateTimeField;
    T201Maggior4: TStringField;
    D201: TDataSource;
    T210: TOracleDataSet;
    T210Codice: TStringField;
    T210Descrizione: TStringField;
    T210Maggiorazione: TFloatField;
    T210PORE_LAV: TStringField;
    T210PSTR_NEL_MESE: TStringField;
    T210PIND_TUR: TStringField;
    T210PORE_COMP: TStringField;
    D210: TDataSource;
    Q201ModificaContr: TOracleQuery;
    selTabellaCodice: TStringField;
    selTabellaDescrizione: TStringField;
    selTabellaTipo: TStringField;
    selTabellaIndTurno: TStringField;
    selTabellaReperibilita: TStringField;
    selTabellaMaxStraord: TStringField;
    selTabellaIndNotteDa: TDateTimeField;
    selTabellaIndNotteA: TDateTimeField;
    selTabellaTOLINDNOT: TFloatField;
    selTabellaARRINDNOT: TFloatField;
    selTabellaDATADECORRENZA: TDateTimeField;
    selTabellaMAXRESIDUABILE: TStringField;
    selTabellaARR_INDTURNO_PAL: TStringField;
    selTabellaORE_LAVFASCE_CONASS: TStringField;
    procedure selTabellaIndNotteDaSetText(Sender: TField; const Text: string);
    procedure selTabellaAfterEdit(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure T201BeforeDelete(DataSet: TDataSet);
    procedure T201BeforeInsert(DataSet: TDataSet);
    procedure T201CalcFields(DataSet: TDataSet);
    procedure T210BeforePost(DataSet: TDataSet);
    procedure T210BeforeDelete(DataSet: TDataSet);
    procedure T210AfterPost(DataSet: TDataSet);
    procedure T210AfterDelete(DataSet: TDataSet);
    procedure T201AfterPost(DataSet: TDataSet);
    procedure T201BeforePost(DataSet: TDataSet);
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
  private
    Inserimento,Cancellazione:Boolean;
    CodiceOld:String;
    selControlloVociPaghe:TControlloVociPaghe;
    procedure CheckBeforePost_T210(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
    A022MW: TA022FContrattiMW;
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
  end;

implementation

uses  WA022UContrattiDettFM, WA022UContratti, WR100UBase;
      //WA022UFasceMaggiorazioneFM;

{$R *.dfm}

procedure TWA022FContrattiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  T201.ReadOnly:=(Owner as TWA022FContratti).SolaLettura;
  T210.ReadOnly:=(Owner as TWA022FContratti).SolaLettura;
  T201.Open;
  T210.Open;
  selTabella.Open;
  Inserimento:=False;
  Cancellazione:=False;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');

  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
  A022MW:=TA022FContrattiMW.Create(nil);
  A022MW.T200:=selTabella;
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
end;

procedure TWA022FContrattiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
  FreeAndNil(A022MW);
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
  inherited;
end;

procedure TWA022FContrattiDM.AfterPost(DataSet: TDataSet);
var
  i:Integer;
begin
  MsgBox.ClearKeys;

  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
  A022MW.T200AfterPost;
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine

  if Inserimento then
  begin
    for i:=1 to 9 do
    begin
      T201.Append;
      T201.FieldByName('Codice').AsString:=selTabella.FieldByName('Codice').AsString;
      T201.FieldByName('Giorno').AsString:=IntToStr(i);
      T201.Post;
    end;
    Inserimento:=False;
  end;
  if T201.UpdatesPending then
    SessioneOracle.ApplyUpdates([T201],True);
  inherited;
  SessioneOracle.Commit;
  //SessioneOracle.CancelUpdates([T201]);
  T201.CancelUpdates;
end;

procedure TWA022FContrattiDM.AfterScroll(DataSet: TDataSet);
begin
  //*** verificare.ini
  {
  with T201 do
  begin
    Close;
    SetVariable('Codice',T200.FieldByname('Codice').AsString);
    Open;
    if (T200.State = dsBrowse) and (RecordCount = 0) then
    begin
      Inserimento:=True;
      T200AfterPost(T200);
      Inserimento:=False;
    end;
  end;
  }
  //*** verificare.fine

  inherited;

  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
  if A022MW <> nil then
    A022MW.T200AfterScroll;
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
end;

procedure TWA022FContrattiDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
   Cancellazione:=True;
  T201.First;
  while not T201.Eof do
    T201.Delete;
  SessioneOracle.ApplyUpdates([T201],True);
  Cancellazione:=False;
end;

procedure TWA022FContrattiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  try
    OreMinutiValidate(selTabella.FieldByName('Reperibilita').AsString);
    OreMinutiValidate(selTabella.FieldByName('MaxStraord').AsString);
    OreMinutiValidate(selTabella.FieldByName('MAXRESIDUABILE').AsString);
  except
    MsgBox.WebMessageDlg(A000MSG_ERR_ORA_NON_VALIDA,mtError,[mbOk],nil,'');
    Abort;
  end;

  if selTabella.FieldByName('ArrIndNot').AsInteger <> 0 then
    if 60 mod selTabella.FieldByName('ArrIndNot').AsInteger <> 0 then
    begin
      MsgBox.WebMessageDlg(A000MSG_ERR_MINUTI_DIVISORI,mtError,[mbOk],nil,'');
      Abort;
    end;

  try
    if not selTabella.FieldByName('ARR_INDTURNO_PAL').IsNull then
      R180OraValidate(selTabella.FieldByName('ARR_INDTURNO_PAL').AsString);
  except
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_VALORE_NON_CORRETTO,['Numero ore annuali massime di eccedenza compensabile']),mtError,[mbOk],nil,'');
    Abort;
  end;

  with selTabella do
  begin
    if (FieldByName('ArrIndNot').AsInteger <= FieldByName('TolIndNot').AsInteger) and
       ((FieldByName('ArrIndNot').AsInteger > 0) or (FieldByName('TolIndNot').AsInteger > 0)) then
      raise Exception.Create(A000MSG_A022_ERR_IND_NOTTURNA_ARROT);
  end;
  if selTabella.State = dsInsert then Inserimento:=True;
  //Aggiorno il codice contratto sulle fasce di maggiorazione
  if selTabella.State = dsEdit then
    if CodiceOld <> selTabellaCodice.AsString then
      with Q201ModificaContr do
      begin
        SetVariable('Codice',selTabellaCodice.AsString);
        SetVariable('Codice_Old',CodiceOld);
        try
          Execute;
          SessioneOracle.Commit;
        except
          SessioneOracle.Rollback;
          raise;
        end;
      end;
end;

procedure TWA022FContrattiDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  (*
  if TWA022FFasceMaggiorazioneFM(TWA022FContratti(Self.Owner).WFasceMaggiorazioneFM) <> nil then
    with TWA022FFasceMaggiorazioneFM(TWA022FContratti(Self.Owner).WFasceMaggiorazioneFM) do
      grdFasceMaggiorazione.medpAttivaGrid(T210,not (selTabella.State in [dsInsert,dsEdit]),not (selTabella.State in [dsInsert,dsEdit]));
  *)

  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
  if (A022MW <> nil) and (A022MW.selT203 <> nil) then
  begin
    A022MW.selT203.ReadOnly:=dsrTabella.State <> dsEdit;
  end;
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
end;

procedure TWA022FContrattiDM.selTabellaAfterEdit(DataSet: TDataSet);
begin
  CodiceOld:=selTabellaCodice.AsString;
end;

procedure TWA022FContrattiDM.selTabellaIndNotteDaSetText(Sender: TField;
  const Text: string);
begin
  {$I CampoOra}
end;

procedure TWA022FContrattiDM.T201AfterPost(DataSet: TDataSet);
begin
  if not Inserimento then
    RegistraLog.RegistraOperazione;
end;

procedure TWA022FContrattiDM.T201BeforeDelete(DataSet: TDataSet);
begin
  if not Cancellazione then Abort;
end;

procedure TWA022FContrattiDM.T201BeforeInsert(DataSet: TDataSet);
begin
  if not Inserimento then Abort;
end;

procedure TWA022FContrattiDM.T201BeforePost(DataSet: TDataSet);
begin
  if DataSet.State = dsEdit then
    RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,5),DataSet,True);
end;

procedure TWA022FContrattiDM.T201CalcFields(DataSet: TDataSet);
begin
  with T201.FieldByName('Giorno'),T201 do
  begin
    if AsString = '1' then FieldByName('D_Giorno').AsString:='Lunedì';
    if AsString = '2' then FieldByName('D_Giorno').AsString:='Martedì';
    if AsString = '3' then FieldByName('D_Giorno').AsString:='Mercoledì';
    if AsString = '4' then FieldByName('D_Giorno').AsString:='Giovedì';
    if AsString = '5' then FieldByName('D_Giorno').AsString:='Venerdì';
    if AsString = '6' then FieldByName('D_Giorno').AsString:='Sabato';
    if AsString = '7' then FieldByName('D_Giorno').AsString:='Domenica';
    if AsString = '8' then FieldByName('D_Giorno').AsString:='Non lav.';
    if AsString = '9' then FieldByName('D_Giorno').AsString:='Festivo';
  end;
end;

procedure TWA022FContrattiDM.T210AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TWA022FContrattiDM.T210AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TWA022FContrattiDM.T210BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,5),DataSet,True);
end;

procedure TWA022FContrattiDM.T210BeforePost(DataSet: TDataSet);
var
  VoceOld:String;
  Messaggi:String;
begin
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    Messaggi:='';
    //Controllo voci paghe
    if (DataSet.State = dsInsert) or (T210.FieldByName('PORE_LAV').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=T210.FieldByName('PORE_LAV').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T210.FieldByName('PORE_LAV').AsString) then
      Messaggi:=Messaggi + #13#10 + selControlloVociPaghe.MessaggioLog;

    if (DataSet.State = dsInsert) or (T210.FieldByName('PSTR_NEL_MESE').medpOldValue = null)  then
      VoceOld:=''
    else
      VoceOld:=T210.FieldByName('PSTR_NEL_MESE').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T210.FieldByName('PSTR_NEL_MESE').AsString) then
      Messaggi:=Messaggi + #13#10 + selControlloVociPaghe.MessaggioLog;

    if (DataSet.State = dsInsert) or (T210.FieldByName('PIND_TUR').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=T210.FieldByName('PIND_TUR').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T210.FieldByName('PIND_TUR').AsString) then

    if (DataSet.State = dsInsert) or (T210.FieldByName('PORE_COMP').medpOldValue = null)  then
      VoceOld:=''
    else
      VoceOld:=T210.FieldByName('PORE_COMP').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T210.FieldByName('PORE_COMP').AsString) then
      Messaggi:=Messaggi + #13#10 + selControlloVociPaghe.MessaggioLog;
  end;

  if Messaggi <> '' then
  begin
    MsgBox.WebMessageDlg(Messaggi,mtConfirmation,[mbYes,mbNo],CheckBeforePost_T210,'PUNTO_1');
    Abort;
  end
  else
  begin
    selControlloVociPaghe.ValutaInserimentoVocePaghe(T210.FieldByName('PORE_LAV').AsString);
    selControlloVociPaghe.ValutaInserimentoVocePaghe(T210.FieldByName('PSTR_NEL_MESE').AsString);
    selControlloVociPaghe.ValutaInserimentoVocePaghe(T210.FieldByName('PIND_TUR').AsString);
    selControlloVociPaghe.ValutaInserimentoVocePaghe(T210.FieldByName('PORE_COMP').AsString);

    MsgBox.ClearKeys;

    case DataSet.State of
      dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,5),DataSet,True);
      dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,5),DataSet,True);
    end;
  end;
end;

procedure TWA022FContrattiDM.CheckBeforePost_T210(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: T210.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

end.
