unit WR302UGestTabellaDM;

interface

uses
  WR300UBaseDM,
  C180FunzioniGenerali, A000UInterfaccia,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Oracle, OracleData, DBClient,
  medpIWMessageDlg, A000UMessaggi;

type
  TEventi = set of (evAfterDelete,evAfterPost,evBeforeDelete,evBeforeEdit,evBeforeInsert,
                    evBeforePost,evOnNewRecord,evOnTranslateMessage,evAfterCancel,evAfterScroll);

  TWR102OperazioniDopoCopia = procedure of object;

  TInterfacciaWR102 = class
    StoriciPrec,
    StoriciSucc: Boolean;
    LChiavePrimaria:TStringList;
    LValoriOriginali:TStringList;
    StoricizzazioneInCorso,
    FGestioneStoricizzata,
    FChiaveReadOnly,
    OttimizzaStorico,
    OttimizzaDecorrenzaFine,
    AllineaSoloDecorrenzeIntersecanti,
    GestioneDecorrenzaFine,
    ConfermaCancellazione,
    TemplateAutomatico,
    PosStoricoCorrenteSuCambioProg:Boolean;
    NomeTabella,
    AliasNomeTabella,
    CampoDecorrenza,
    CampoDecorrenzaFine,
    NomeTabellaPadre,
    StatoBeforePost,
    CopiaSuTabella,
    CopiaSuChiave,
    CopiaSuChiaveInput,
    CopiaSuCampi,
    OrdinamentoOriginale:String;
    CopiaSuOperazioniDopoCopia:TWR102OperazioniDopoCopia;
    //DataLavoro:TDateTime;
    TabelleRelazionate:array of TOracleDataSet;
    AllineaDecorrenzaFine:procedure of object;
    Eventi:TEventi;
    DettaglioFM:Boolean;
  private
    function GetGestioneStoricizzata: Boolean;
    procedure SetGestioneStoricizzata(const Val: Boolean);
    procedure SetChiaveReadOnly(const Val: Boolean);
  public
    CopiaInCorso:Boolean;
    constructor Create;
    destructor Destroy; override;
    property GestioneStoricizzata: Boolean read GetGestioneStoricizzata write SetGestioneStoricizzata;
    property ChiaveReadOnly: Boolean read FChiaveReadOnly write SetChiaveReadOnly;
  end;

  TWR302FGestTabellaDM = class(TWR300FBaseDM)
    selTabella: TOracleDataSet;
    dsrTabella: TDataSource;
    selEstrazioneDati: TOracleDataSet;
    dsrEstrazioniDati: TDataSource;
    selT900: TOracleDataSet;
    selT901: TOracleDataSet;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); virtual;
    procedure BeforeInsert(DataSet: TDataSet); virtual;
    procedure BeforeEdit(DataSet: TDataSet); virtual;
    procedure BeforePost(DataSet: TDataSet); virtual;
    procedure BeforePostNoStorico(DataSet: TDataSet); virtual;
    procedure BeforeDelete(DataSet: TDataSet); virtual;
    procedure AfterPost(DataSet: TDataSet); virtual;
    procedure AfterDelete(DataSet: TDataSet); virtual;
    procedure AfterCancel(DataSet: TDataSet); virtual;
    procedure AfterScroll(DataSet: TDataSet); virtual;
    procedure OnTranslateMessage(Sender: TOracleDataSet; ErrorCode: Integer; const ConstraintName: String; Action: Char; var Msg: String); virtual;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure dsrTabellaUpdateData(Sender: TObject);
  private
    bExecuteUpdateStorici:Boolean;
    QUpdateStorici: TOracleQuery;
    ChiaveSenzaDec,ChiaveConDec:Variant;
    NomiSenzaDec,NomiConDec:String;
    procedure CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure GetDifferenzeDaOriginale;
    procedure SettaValoriChiavePrimaria;
    function  OttimizzazioneStorico: Boolean;
    procedure AllineaDecorrenzaFine;
  protected
    { Protected declarations }
    StoricoOttimizzato: Boolean;
    NonAprireSelTabella:Boolean;
    procedure selTabellaGestioneDateSetText(Sender: TField; const Text: string);
    procedure SetTabelleRelazionate(const DS:array of TOracleDataSet);
    function InterfacciaWR102:TInterfacciaWR102;
  public
    { Public declarations }
    procedure DoAfterPost;
    procedure InizializzaDataSet(Eventi: TEventi);
    procedure ChiaveDuplicataTabellaRelazionata(ODS:TDataSet);
  end;

implementation

uses WR102UGestTabella, A000UCostanti, A000USessione;

{$R *.dfm}

constructor TInterfacciaWR102.Create;
begin
  inherited Create;
  GestioneStoricizzata:=False;
  ChiaveReadOnly:=False;
  OttimizzaStorico:=True;
  OttimizzaDecorrenzaFine:=True;
  GestioneDecorrenzaFine:=True;
  AllineaSoloDecorrenzeIntersecanti:=False;
  ConfermaCancellazione:=True;
  LValoriOriginali:=TStringList.Create;
  LChiavePrimaria:=TStringList.Create;
  StoricizzazioneInCorso:=False;
  DettaglioFM:=True;
  CopiaSuTabella:='';
  CopiaSuChiave:='';
  CopiaSuChiaveInput:='';
  CopiaSuCampi:='';
  CopiaInCorso:=False;
end;

function TInterfacciaWR102.GetGestioneStoricizzata: Boolean;
begin
  Result:=FGestioneStoricizzata;
end;

procedure TInterfacciaWR102.SetGestioneStoricizzata(const Val: Boolean);
begin
  // imposta automaticamente gli eventi
  if Val then
    Eventi:=[evBeforeEdit,evBeforeInsert,evBeforePost,evBeforeDelete,evAfterDelete,evAfterPost,evOnNewRecord,evOnTranslateMessage,evAfterCancel,evAfterScroll]
  else
    Eventi:=[evBeforePost,evBeforeDelete,evAfterDelete,evAfterPost,evAfterCancel,evAfterScroll,evOnNewRecord];
  FGestioneStoricizzata:=Val;
end;

procedure TInterfacciaWR102.SetChiaveReadOnly(const Val: Boolean);
begin
  if Val then
  begin
    //La gestione della chiave in sola lettura viene gestita da entrambi gli eventi BeforeEdit e BeforeInsert
    if not (evBeforeEdit in Eventi) then
      Eventi:=Eventi + [evBeforeEdit];
    if not (evBeforeInsert in Eventi) then
      Eventi:=Eventi + [evBeforeInsert];
  end
  else
  begin
    //Si eliminano gli eventi BeforeEdit e BeforeInsert (solo se non gestione storicizzata)
    if evBeforeEdit in Eventi then
      Eventi:=Eventi - [evBeforeEdit];
    if (not GestioneStoricizzata) and (evBeforeInsert in Eventi) then
      Eventi:=Eventi - [evBeforeInsert];
  end;
  FChiaveReadOnly:=Val;
end;

destructor TInterfacciaWR102.Destroy;
begin
  FreeAndNil(LValoriOriginali);
  FreeAndNil(LChiavePrimaria);
  inherited Destroy;
end;

procedure TWR302FGestTabellaDM.IWUserSessionBaseCreate(Sender: TObject);
var
  i: Integer;
  s: String;
begin
  inherited;
  InizializzaDataSet(InterfacciaWR102.Eventi);
  // dataset principale
  if VarIsNull(selTabella.GetVariable('ORDERBY')) then
  begin
    // se non è specificata, imposta la variabile orderby
    // in modo da ordinare i record in base alla primary key
    if InterfacciaWR102.LChiavePrimaria.Count > 0 then
    begin
      s:='';
      for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
        s:=s + InterfacciaWR102.LChiavePrimaria[i] + ',';
      s:=Copy(s,1,Length(s) - 1);
      if InterfacciaWR102.GestioneStoricizzata then
        s:=s + ','+InterfacciaWR102.CampoDecorrenza;
      selTabella.SetVariable('ORDERBY','ORDER BY ' + s);
    end;
  end;
  if selTabella.VariableIndex('ORDERBY') > -1 then
    InterfacciaWR102.OrdinamentoOriginale:=VarToStr(selTabella.getVariable('ORDERBY'));
  if not NonAprireSelTabella then
    selTabella.Open;
  QUpdateStorici:=TOracleQuery.Create(nil);

  if InterfacciaWR102.GetGestioneStoricizzata then
  begin
    //Gestione necessaria perchè campi data-aware
    if selTabella.FindField(InterfacciaWR102.CampoDecorrenza) <> nil then
      selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).OnSetText:=selTabellaGestioneDateSetText;

    if selTabella.FindField(InterfacciaWR102.CampoDecorrenzaFine) <> nil then
      selTabella.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).OnSetText:=selTabellaGestioneDateSetText;
  end;
end;

procedure TWR302FGestTabellaDM.selTabellaGestioneDateSetText(Sender: TField;
  const Text: string);
var
  D: TDateTime;
begin
  inherited;
  if Text.Trim = '' then
    Sender.Clear
  else if TryStrToDate(Text,D) then
    Sender.AsDateTime:=D
  else
  begin
    if selTabella.State = dsEdit then
      Sender.Value:=Sender.medpOldValue
    else if InterfacciaWR102.StoricizzazioneInCorso then
    begin
      if Sender.FieldName.ToUpper = InterfacciaWR102.CampoDecorrenza.ToUpper then
        Sender.AsDateTime:=StrToDate(InterfacciaWR102.LValoriOriginali.Values[InterfacciaWR102.CampoDecorrenza.ToUpper])
      else if Sender.FieldName.ToUpper = InterfacciaWR102.CampoDecorrenzaFine.ToUpper then
        Sender.AsDateTime:=StrToDate(InterfacciaWR102.LValoriOriginali.Values[InterfacciaWR102.CampoDecorrenzaFine.ToUpper]);
    end;
  end;
end;

procedure TWR302FGestTabellaDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  VarClear(ChiaveSenzaDec);
  VarClear(ChiaveConDec);
  if selEstrazioneDati.Active then
    try selEstrazioneDati.CloseAll; except end;
//  FreeAndNil(MsgBox);
  FreeAndNil(QUpdateStorici);
  inherited;
end;

function TWR302FGestTabellaDM.InterfacciaWR102:TInterfacciaWR102;
begin
  Result:=TWR102FGestTabella(Self.Owner).InterfacciaWR102;
end;

procedure TWR302FGestTabellaDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  TWR102FGestTabella(Owner).selTabellaStateChange(selTabella);
  //Caratto 26/06/2012 abilita/disabilita tutti i componenti non data-aware del dettaglio in base allo stato del dataset
  if InterfacciaWR102.DettaglioFM and (TWR102FGestTabella(Owner).WDettaglioFM <> nil) then
    //nel caso di new record l'abilitazione dei componenti viene fatta nel newrecord dopo il settaggio dei componenti
    if not (selTabella.State in [dsInsert,dsInactive]) then
      TWR102FGestTabella(Owner).WDettaglioFM.AbilitaAllComponenti(selTabella);
end;

procedure TWR302FGestTabellaDM.dsrTabellaUpdateData(Sender: TObject);
var
  i:integer;
  Modificato:Boolean;
begin
  inherited;
  if selTabella.State = dsEdit then
  begin
    Modificato:=False;
    for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
    begin
      if SelTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).OldValue <> SelTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).Value then
      begin
        Modificato:=True;
        Break;
      end;
    end;
    if Modificato and TWR102FGestTabella(Self.Owner).CheckRelazioniEsistenti(True) then
      Abort;
  end;
end;

// ******************************************************************************** //
//                            Eventi dataset principale                             //
// ******************************************************************************** //
procedure TWR302FGestTabellaDM.InizializzaDataSet(Eventi: TEventi);
begin
  // associazione eventi del dataset principale
  if evBeforeEdit in Eventi then
    selTabella.BeforeEdit:=BeforeEdit;
  if evBeforeInsert in Eventi then
    selTabella.BeforeInsert:=BeforeInsert;
  if evBeforePost in Eventi then
  begin
    if InterfacciaWR102.GestioneStoricizzata then
      selTabella.BeforePost:=BeforePost
    else
      selTabella.BeforePost:=BeforePostNoStorico;
  end;
  if evBeforeDelete in Eventi then
    selTabella.BeforeDelete:=BeforeDelete;
  if evOnNewRecord in Eventi then
    selTabella.OnNewRecord:=OnNewRecord;
  if evAfterDelete in Eventi then
    selTabella.AfterDelete:=AfterDelete;
  if evAfterCancel in Eventi then
    selTabella.AfterCancel:=AfterCancel;
  if evAfterScroll in Eventi then
    selTabella.AfterScroll:=AfterScroll;
  if evAfterPost in Eventi then
    selTabella.AfterPost:=AfterPost;
  if evOnTranslateMessage in Eventi then
    selTabella.OnTranslateMessage:=OnTranslateMessage;

  InterfacciaWR102.NomeTabella:=UpperCase(R180Query2NomeTabella(selTabella));
  //CARATTO 21/01/2014 Nel caso selTabella estragga dati da più tabelle,
  //la chiave deve essere reperita dalla tabella che viene aggiornata
  if selTabella.UpdatingTable <> '' then
    InterfacciaWR102.NomeTabella:=UpperCase(selTabella.UpdatingTable);

  if (Copy(InterfacciaWR102.AliasNomeTabella,1,1) = '<') and (Copy(InterfacciaWR102.AliasNomeTabella,Length(InterfacciaWR102.AliasNomeTabella),1) = '>') then
    InterfacciaWR102.AliasNomeTabella:=Copy(InterfacciaWR102.AliasNomeTabella,2,Length(InterfacciaWR102.AliasNomeTabella) - 2)
  else if (Pos('_',InterfacciaWR102.NomeTabella) - 1) > 0 then
    InterfacciaWR102.AliasNomeTabella:=Copy(InterfacciaWR102.NomeTabella,1,Pos('_',InterfacciaWR102.NomeTabella) - 1)
  else
    InterfacciaWR102.AliasNomeTabella:=Copy(InterfacciaWR102.NomeTabella,1,4);
  // estrae campi primary key
  A000GetChiavePrimaria(selTabella.Session,InterfacciaWR102.NomeTabella,InterfacciaWR102.LChiavePrimaria);
  // elimina riferimento a decorrenza
  //Caratto 13/11/2012 Elimina decorrenza solo se gestione storicizzata
  if (InterfacciaWR102.LChiavePrimaria.IndexOf(InterfacciaWR102.CampoDecorrenza) >= 0) and
     (InterfacciaWR102.GestioneStoricizzata) then
    InterfacciaWR102.LChiavePrimaria.Delete(InterfacciaWR102.LChiavePrimaria.IndexOf(InterfacciaWR102.CampoDecorrenza));

  // debug
  InterfacciaWR102.AllineaDecorrenzaFine:=AllineaDecorrenzaFine;
end;

procedure TWR302FGestTabellaDM.SetTabelleRelazionate(const DS:array of TOracleDataSet);
var
  i: Integer;
begin
  SetLength(InterfacciaWR102.TabelleRelazionate,Length(DS));
  for i:=0 to High(DS) do
  begin
    InterfacciaWR102.TabelleRelazionate[i]:=DS[i];
    //if not Assigned(DS[i].BeforePost) then
    //  DS[i].BeforePost:=ChiaveDuplicataTabellaRelazionata;
  end;
end;

procedure TWR302FGestTabellaDM.ChiaveDuplicataTabellaRelazionata(ODS:TDataSet);
var
  CK,VK: array of String;
  PK:TStringList;
  i: Integer;
begin
  if not (ODS is TOracleDataSet) then
    exit;
  if (ODS as TOracleDataSet).CachedUpdates then
    exit;
  PK:=TStringList.Create;
  try
    try
      A000GetChiavePrimaria(selTabella.Session,UpperCase(R180Query2NomeTabella(ODS)),PK);
    except
    end;

    SetLength(CK,PK.Count);
    SetLength(VK,PK.Count);
    if PK.Count > 0 then
    begin
      // costruisce array campi / valori per la ricerca della chiave
      for i:=0 to PK.Count - 1 do
      begin
        if ODS.FindField(PK[i]) = nil then
        begin
          SetLength(CK,0);
          SetLength(VK,0);
          Break;
        end
        else
        begin
          CK[i]:=PK[i];
          VK[i]:=ODS.FieldByName(PK[i]).AsString;
        end;
      end;
      if Length(CK) > 0 then
        // controlla chiave primaria
        if QueryPK1.EsisteChiave(UpperCase(R180Query2NomeTabella(ODS)),(ODS as TOracleDataSet).RowID,ODS.State,CK,VK) then
          raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
    end;
  finally
    SetLength(CK,0);
    SetLength(VK,0);
    FreeAndNil(PK);
  end;
end;

procedure TWR302FGestTabellaDM.BeforeEdit(DataSet: TDataSet);
// I campi chiave devono essere readonly
var
  i: Integer;
begin
  //if InterfacciaWR102.GestioneStoricizzata then
    for i:=0 to selTabella.FieldCount - 1 do
      if InterfacciaWR102.LChiavePrimaria.IndexOf(selTabella.Fields[i].FieldName) >= 0 then
        selTabella.Fields[i].ReadOnly:=True;
end;

procedure TWR302FGestTabellaDM.BeforeInsert(DataSet: TDataSet);
// I campi chiave devono essere readonly se si sta effettuando una storicizzazione
var
  i: Integer;
begin
  for i:=0 to selTabella.FieldCount - 1 do
  begin
    //6/10/2105 Cambiare attributo readOnly solo ai campi chiave. Se vi sono altri campi che sono readonly devono rimanere tali
    if (InterfacciaWR102.LChiavePrimaria.IndexOf(selTabella.Fields[i].FieldName) >= 0) then
      selTabella.Fields[i].ReadOnly:=(InterfacciaWR102.StoricizzazioneInCorso);
      (*
      selTabella.Fields[i].ReadOnly:=(InterfacciaWR102.LChiavePrimaria.IndexOf(selTabella.Fields[i].FieldName) >= 0) and
                                   (InterfacciaWR102.StoricizzazioneInCorso);
      *)
  end;
end;

procedure TWR302FGestTabellaDM.OnNewRecord(DataSet: TDataSet);
// Impostazione data di decorrenza
begin
  if InterfacciaWR102.GestioneStoricizzata then
    selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime:=EncodeDate(1900,1,1);

  //Caratto 28/06/2012 imposto i campi del dataset con i valori dei componenti non data-aware
  if InterfacciaWR102.DettaglioFM and (TWR102FGestTabella(Owner).WDettaglioFM <> nil) then
  begin
    TWR102FGestTabella(Owner).WDettaglioFM.DataSet2Componenti;
    //non viene fatto sullo state change perchè deve essere fatto dopo DataSet2Componenti
    TWR102FGestTabella(Owner).WDettaglioFM.AbilitaAllComponenti(selTabella);
  end;

end;

procedure TWR302FGestTabellaDM.BeforePostNoStorico(DataSet: TDataSet);
// Verifica duplicazione di chiave e gestione log operazione su tabella NON STORICIZZATA
var
  CK,VK: array of String;
  i: Integer;
begin
  //
  //Caratto 28/06/2012 imposto i campi del dataset con i valori dei componenti non data-aware
  if InterfacciaWR102.DettaglioFM and (TWR102FGestTabella(Owner).WDettaglioFM <> nil) then
    TWR102FGestTabella(Owner).WDettaglioFM.Componenti2DataSet;

  // 1. verifica la duplicazione di chiave primaria
  SetLength(CK,InterfacciaWR102.LChiavePrimaria.Count);
  SetLength(VK,InterfacciaWR102.LChiavePrimaria.Count);
  if InterfacciaWR102.LChiavePrimaria.Count > 0 then
  begin
    // costruisce array campi / valori per la ricerca della chiave
    for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
    begin
      if selTabella.FindField(InterfacciaWR102.LChiavePrimaria[i]) = nil then
      begin
        SetLength(CK,0);
        SetLength(VK,0);
        Break;
      end
      else
      begin
        CK[i]:=InterfacciaWR102.LChiavePrimaria[i];
        VK[i]:=selTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).AsString;
      end;
    end;
    if Length(CK) > 0 then
    try
      // controlla chiave primaria
      if QueryPK1.EsisteChiave(InterfacciaWR102.NomeTabella,selTabella.RowID,selTabella.State,CK,VK) then
        raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
    finally
      SetLength(CK,0);
      SetLength(VK,0);
    end;
  end;

  // 2. log operazione
  case selTabella.State of
    dsInsert:
    begin
      InterfacciaWR102.StatoBeforePost:='I';
      RegistraLog.SettaProprieta('I',InterfacciaWR102.NomeTabella,Copy(Name,1,5),selTabella,True);
    end;
    dsEdit:begin
      InterfacciaWR102.StatoBeforePost:='M';
      RegistraLog.SettaProprieta('M',InterfacciaWR102.NomeTabella,Copy(Name,1,5),selTabella,True);
    end;
  end;
end;

procedure TWR302FGestTabellaDM.BeforePost(DataSet: TDataSet);
// Verifica duplicazione di chiave e gestione log operazione su tabella STORICIZZATA
var
  CK,VK,CKDec,VKDec: array of String;
  i:Integer;
  ChiaveDup: Boolean;
begin
  //Caratto 28/06/2012 imposto i campi del dataset con i valori dei componenti non data-aware
  if InterfacciaWR102.DettaglioFM and (TWR102FGestTabella(Owner).WDettaglioFM <> nil) then
    TWR102FGestTabella(Owner).WDettaglioFM.Componenti2DataSet;

  SetLength(CK,InterfacciaWR102.LChiavePrimaria.Count);
  SetLength(VK,InterfacciaWR102.LChiavePrimaria.Count);
  SetLength(CKDec,InterfacciaWR102.LChiavePrimaria.Count + 1);
  SetLength(VKDec,InterfacciaWR102.LChiavePrimaria.Count + 1);
  // costruisce array campi / valori per la ricerca della chiave
  for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
  begin
    CK[i]:=InterfacciaWR102.LChiavePrimaria[i];
    VK[i]:=AggiungiApice(selTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).AsString);
    CKDec[i]:=InterfacciaWR102.LChiavePrimaria[i];
    VKDec[i]:=AggiungiApice(selTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).AsString);
  end;
  CKDec[InterfacciaWR102.LChiavePrimaria.Count]:=InterfacciaWR102.CampoDecorrenza;
  VKDec[InterfacciaWR102.LChiavePrimaria.Count]:=selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsString;
  if selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).IsNull then
    raise Exception.Create(A000MSG_ERR_DATA_DECORRENZA);

  // primo blocco di controlli
  if not MsgBox.KeyExists('NO_STORICI_SUCC') then
  begin
    // verifica storicizzazioni successive
    if ((selTabella.State = dsEdit) or (InterfacciaWR102.StoricizzazioneInCorso)) and
       (not InterfacciaWR102.StoriciPrec) and
       (not InterfacciaWR102.StoriciSucc) then
    begin
      if QueryPK1.EsisteStoricoSucc(InterfacciaWR102.NomeTabella,selTabella.Rowid,selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime,CKDec,VKDec,InterfacciaWR102.CampoDecorrenza) then
      begin
        MsgBox.WebMessageDlg(A000MSG_DLG_STORIC_SUCC,mtConfirmation,[mbYes,mbNo],CheckBeforePost,'NO_STORICI_SUCC');
        Abort;
      end;
    end;
  end;

  // secondo blocco di controlli
  if not MsgBox.KeyExists('NO_DECORRENZA_MODIF') then
  begin
    if InterfacciaWR102.GestioneDecorrenzaFine and
       InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti and
       (not selTabella.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).IsNull) and
       (selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime > selTabella.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).AsDateTime) then
      raise Exception.Create(A000MSG_ERR_DECOR_SUP_SCAD);
    if selTabella.State = dsInsert then
    begin
      // inserimento / storicizzazione
      try
        if InterfacciaWR102.StoricizzazioneInCorso then
          // nuova storicizzazione: la chiave può esistere ma con decorrenza diversa
          ChiaveDup:=QueryPK1.EsisteChiave(InterfacciaWR102.NomeTabella,selTabella.RowID,selTabella.State,CKDec,VKDec)
        else
          // nuovo record: la chiave non può esistere
          ChiaveDup:=QueryPK1.EsisteChiave(InterfacciaWR102.NomeTabella,selTabella.RowID,selTabella.State,CK,VK);
        if ChiaveDup then
          raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
      finally
        SetLength(CK,0);
        SetLength(VK,0);
        SetLength(CKDec,0);
        SetLength(VKDec,0);
      end;
    end
    else if selTabella.State = dsEdit then
    begin
      // modifica
      //if QueryPK1.EsisteChiave(InterfacciaWR102.NomeTabella,selTabella.RowID,selTabella.State,CKDec,VKDec) then
      if QueryPK1.EsisteChiave(InterfacciaWR102.NomeTabella,selTabella.RowID,selTabella.State,CKDec,VKDec) then
        raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
      if selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).Value <> selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).medpOldValue then
      begin
        MsgBox.WebMessageDlg(A000MSG_DLG_DECOR_SENZA_STORIC,mtConfirmation,[mbYes,mbNo],CheckBeforePost,'NO_DECORRENZA_MODIF');
        Abort;
      end;
    end;
  end;

  // terzo blocco di controlli
  begin
    // 2. log operazione
    case selTabella.State of
      dsInsert:
        begin
          InterfacciaWR102.StatoBeforePost:='I';
          RegistraLog.SettaProprieta('I',InterfacciaWR102.NomeTabella,Copy(Name,1,5),selTabella,True);
        end;
      dsEdit:
        begin
          InterfacciaWR102.StatoBeforePost:='M';
          RegistraLog.SettaProprieta('M',InterfacciaWR102.NomeTabella,Copy(Name,1,5),selTabella,True);
        end;
    end;

    GetDifferenzeDaOriginale;
  end;
end;

procedure TWR302FGestTabellaDM.CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    //mrYes: selTabella.Post;
    mrYes: TWR102FGestTabella(Self.Owner).actConfermaExecute(nil);
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWR302FGestTabellaDM.GetDifferenzeDaOriginale;
var
  i: Integer;
  S,NomeCampo: String;
 // Q: TOracleQuery;
  Differenza:Boolean;
begin
  bExecuteUpdateStorici:=False;
  if (InterfacciaWR102.StoriciPrec or InterfacciaWR102.StoriciSucc) and
     (InterfacciaWR102.StoricizzazioneInCorso or (selTabella.State = dsEdit)) then
  begin
    //distruggo e ricreo oggetto.
    FreeAndNil(QUpdateStorici);
    QUpdateStorici:=TOracleQuery.Create(nil);
    try
      Differenza:=False;
      QUpdateStorici.Session:=selTabella.Session;
      // costruisce stringa di update:
      //   "update TABELLA set Campo1 = 'Valore1', ..."
      QUpdateStorici.SQL.Add('UPDATE ' + InterfacciaWR102.NomeTabella + ' SET');
      for i:=0 to selTabella.FieldDefs.Count - 1 do
      begin
        NomeCampo:=selTabella.FieldDefs[i].Name;
        // Il controllo dei campi variati esclude la chiave primaria della tabella padre,
        // e non quella della tabella figlio
        if (selTabella.FindField(NomeCampo) <> nil) and
           (InterfacciaWR102.LChiavePrimaria.IndexOf(NomeCampo) = -1) and
           (UpperCase(NomeCampo) <> InterfacciaWR102.CampoDecorrenza) and
           not ((UpperCase(NomeCampo) = InterfacciaWR102.CampoDecorrenzaFine) and InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti and InterfacciaWR102.GestioneDecorrenzaFine)
        then
        try
          if (selTabella.FieldByName(NomeCampo).FieldKind = fkData) and (selTabella.FieldByName(NomeCampo).AsString <> InterfacciaWR102.LValoriOriginali.Values[NomeCampo]) then
          begin
            S:='';
            if Differenza then
              S:=',';
            S:=S + NomeCampo + ' = ''' + AggiungiApice(selTabella.FieldByName(NomeCampo).AsString) + '''';
            QUpdateStorici.SQL.Add(S);
            Differenza:=True;
          end;
        except
        end;
      end;
      // esce se nessuna differenza da applicare
      if not Differenza then
        Exit;

      // costruisce il filtro per la stringa di update:
      //   "Where CHIAVE = 'chiave' and DECORRENZA > :DECORRENZA
      QUpdateStorici.SQL.Add('WHERE');
      if InterfacciaWR102.LChiavePrimaria.Count > 0 then
      begin
        for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
        begin
          S:=InterfacciaWR102.LChiavePrimaria[i] + ' = ''' +
             AggiungiApice(selTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).AsString) + '''' +
             ' AND';
          QUpdateStorici.SQL.Add(S);
        end;
      end;
      if (InterfacciaWR102.StoriciPrec) and (InterfacciaWR102.StoriciSucc) then
        QUpdateStorici.SQL.Add(InterfacciaWR102.CampoDecorrenza +' <> :DECORRENZA')
      else if InterfacciaWR102.StoriciPrec then
        QUpdateStorici.SQL.Add(InterfacciaWR102.CampoDecorrenza+ ' < :DECORRENZA')
      else if InterfacciaWR102.StoriciSucc then
        QUpdateStorici.SQL.Add(InterfacciaWR102.CampoDecorrenza + ' > :DECORRENZA');

      QUpdateStorici.DeclareVariable('DECORRENZA',otDate);
      QUpdateStorici.SetVariable('DECORRENZA',selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime);
      bExecuteUpdateStorici:=True;
      //Q.Execute;
      //Q.Session.Commit;
    finally
    //  FreeAndNil(Q);
    end;
  end;
end;

procedure TWR302FGestTabellaDM.SettaValoriChiavePrimaria;
var i:Integer;
begin
  NomiSenzaDec:='';
  NomiConDec:='';
  ChiaveSenzaDec:=VarArrayCreate([0,InterfacciaWR102.LChiavePrimaria.Count - 1],VarVariant);
  ChiaveConDec:=VarArrayCreate([0,InterfacciaWR102.LChiavePrimaria.Count],VarVariant);
  for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
  begin
   if i > 0 then
      NomiSenzaDec:=NomiSenzaDec + ';';
    NomiSenzaDec:=NomiSenzaDec + InterfacciaWR102.LChiavePrimaria[i];
    ChiaveSenzaDec[i]:=selTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).Value;
    ChiaveConDec[i]:=selTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).Value;
  end;
end;

procedure TWR302FGestTabellaDM.DoAfterPost;
// Refresh del Dataset e riposizionamento sul record inserito o modificato
var dDataDec: TDateTime;
    S,RI,PK:String;
    V:Variant;
    evAfterScroll: TEvDataset;
begin
  if bExecuteUpdateStorici then
  begin
    QUpdateStorici.Execute;
    QUpdateStorici.Session.Commit;
  end;
  StoricoOttimizzato:=False;
  RegistraLog.RegistraOperazione;
  SettaValoriChiavePrimaria;
  if InterfacciaWR102.GestioneStoricizzata then
  begin
    dDataDec:=selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime;
    ChiaveConDec[InterfacciaWR102.LChiavePrimaria.Count]:=selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).Value;
    NomiConDec:=NomiSenzaDec;
    if NomiConDec <> '' then
      NomiConDec:=NomiConDec + ';';
    NomiConDec:=NomiConDec + InterfacciaWR102.CampoDecorrenza;
    // debug
    StoricoOttimizzato:=OttimizzazioneStorico;//(selTabella);
    if InterfacciaWR102.GestioneDecorrenzaFine then
      AllineaDecorrenzaFine;
    SessioneOracle.Commit;
    selTabella.Refresh;
    if not selTabella.Locate(NomiConDec,ChiaveConDec,[]) then
    begin
      evAfterScroll:=selTabella.AfterScroll;
      selTabella.AfterScroll:=nil;
      selTabella.Locate(NomiSenzaDec,ChiaveSenzaDec,[]);
      RI:=selTabella.RowID;
      S:=R180GetCampiConcatenati(selTabella,InterfacciaWR102.LChiavePrimaria);
      TWR102FGestTabella(Self.Owner).GetValoriChiavePrimaria(PK,V,False);
      selTabella.Locate(PK,V,[]);
      while (not selTabella.Eof) and
            (S = R180GetCampiConcatenati(selTabella,InterfacciaWR102.LChiavePrimaria)) and
            (selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime <= dDataDec) do
      begin
        RI:=selTabella.RowID;
        selTabella.Next;
      end;
      selTabella.SearchRecord('ROWID',RI,[srFromBeginning]);
      selTabella.AfterScroll:=evAfterScroll;
      //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
      selTabella.SearchRecord('ROWID',selTabella.RowId,[srFromBeginning]);
    end;
  end
  else
  begin
    SessioneOracle.Commit;
    selTabella.Refresh;
    selTabella.Locate(NomiSenzaDec,ChiaveSenzaDec,[]);
  end;

  // cancella lo stato dei controlli
  MsgBox.ClearKeys;
  //Caratto 26/06/2012 imposta tutti i componenti non data-aware del dettaglio prendendo dal dataset
  if InterfacciaWR102.DettaglioFM and (TWR102FGestTabella(Owner).WDettaglioFM <> nil) then
    TWR102FGestTabella(Owner).WDettaglioFM.DataSet2Componenti();
end;

procedure TWR302FGestTabellaDM.AfterPost(DataSet: TDataSet);
begin
  DoAfterPost;
end;

function TWR302FGestTabellaDM.OttimizzazioneStorico:Boolean;
// VERIFICARE
var
  DS,DS1:TOracleDataSet;
  S,RI:String;
  i,T:Integer;
  L:TStringList;
  DatiUguali,TabRelaz:Boolean;
  Decorrenza,DecorrenzaFine:TDateTime;
  function DecorrenzeUguali(ODS:TOracleDataSet; D1,D2:TDateTime):Boolean;
  {Costruzione dell'istruzone:
    (SELECT *(-DECORRENZA) FROM T WHERE PrimaryKey AND DECORRENZA = D1
     MINUS
     SELECT *(-DECORRENZA) FROM T WHERE PrimaryKey AND DECORRENZA = D2)
    UNION
    (SELECT *(-DECORRENZA) FROM T WHERE PrimaryKey AND DECORRENZA = D2
     MINUS
     SELECT *(-DECORRENZA) FROM T WHERE PrimaryKey AND DECORRENZA = D1)
   se non restituisce nessuna riga, il risultato è True altrimenti False}
  var i:Integer;
      Campi,Where:String;
  begin
    Campi:='';
    for i:=0 to ODS.FieldDefs.Count - 1 do
    begin
      if (ODS.FindField(ODS.FieldDefs[i].Name) <> nil) and (ODS.FieldByName(ODS.FieldDefs[i].Name).FieldKind = fkData) and (ODS.FieldDefs[i].Name <> InterfacciaWR102.CampoDecorrenza) and ((ODS.FieldDefs[i].Name <> InterfacciaWR102.CampoDecorrenzaFine) or (not InterfacciaWR102.OttimizzaDecorrenzaFine)) then
      begin
        if Campi <> '' then Campi:=Campi + ',';
        Campi:=Campi + ODS.FieldDefs[i].Name;
      end;
    end;
    Where:='';
    for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
      //Where:=Where + InterfacciaWR102.LChiavePrimaria[i] + ' = ''' + AggiungiApice(selTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).AsString) + ''' AND ';
      Where:=Where + InterfacciaWR102.LChiavePrimaria[i] + ' = ''' + AggiungiApice(VarToStr(ChiaveSenzaDec[i])) + ''' AND ';
    DS1:=TOracleDataSet.Create(nil);
    with DS1 do
    try
      Session:=DS.Session;
      SQL.Add('SELECT COUNT(*) FROM (');
      SQL.Add('(SELECT ' + Campi + ' FROM ' + UpperCase(R180EstraiNomeTabella(ODS.SQL.Text)));
      SQL.Add('WHERE ' + Where);
      SQL.Add(InterfacciaWR102.CampoDecorrenza + ' = :D1');
      SQL.Add('MINUS');
      SQL.Add('SELECT ' + Campi + ' FROM ' + UpperCase(R180EstraiNomeTabella(ODS.SQL.Text)));
      SQL.Add('WHERE ' + Where);
      SQL.Add(InterfacciaWR102.CampoDecorrenza +' = :D2)');
      SQL.Add('UNION');
      SQL.Add('(SELECT ' + Campi + ' FROM ' + UpperCase(R180EstraiNomeTabella(ODS.SQL.Text)));
      SQL.Add('WHERE ' + Where);
      SQL.Add(InterfacciaWR102.CampoDecorrenza + ' = :D2');
      SQL.Add('MINUS');
      SQL.Add('SELECT ' + Campi + ' FROM ' + UpperCase(R180EstraiNomeTabella(ODS.SQL.Text)));
      SQL.Add('WHERE ' + Where);
      SQL.Add(InterfacciaWR102.CampoDecorrenza + ' = :D1)');
      SQL.Add(')');
      DeclareVariable('D1',otDate);
      DeclareVariable('D2',otDate);
      SetVariable('D1',D1);
      SetVariable('D2',D2);
      Open;
      Result:=Fields[0].AsInteger = 0;
      Close;
    finally
      FreeAndNil(DS1);
    end;
  end;
begin
  Result:=False;
  if not InterfacciaWR102.OttimizzaStorico then
    Exit;
  TabRelaz:=True;
  if Length(InterfacciaWR102.TabelleRelazionate) = 0 then
  begin
    SetTabelleRelazionate([selTabella]);
    TabRelaz:=False;
  end;
  DS:=TOracleDataSet.Create(nil);
  L:=TStringList.Create;
  try
    // estrae le decorrenze esistenti per la chiave corrente
    DS.Session:=selTabella.Session;
    if InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti then
      DS.SQL.Add('SELECT ' + InterfacciaWR102.CampoDecorrenza + ',' + InterfacciaWR102.CampoDecorrenzaFine + ',ROWID')
    else
      DS.SQL.Add('SELECT ' + InterfacciaWR102.CampoDecorrenza + ',ROWID');
    DS.SQL.Add('FROM ' + InterfacciaWR102.NomeTabella + ' T1');
    if InterfacciaWR102.LChiavePrimaria.Count > 0 then
      DS.SQL.Add('WHERE');
    for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
    begin
      //S:=InterfacciaWR102.LChiavePrimaria[i] + ' = ''' + AggiungiApice(selTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).AsString) + '''';
      S:=InterfacciaWR102.LChiavePrimaria[i] + ' = ''' + AggiungiApice(VarToStr(ChiaveSenzaDec[i])) + '''';
      if i < InterfacciaWR102.LChiavePrimaria.Count - 1 then
        S:=S + ' AND';
      DS.SQL.Add(S);
    end;
    DS.SQL.Add('ORDER BY ' + InterfacciaWR102.CampoDecorrenza);
    DS.Open;
    Decorrenza:=DS.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime;
    DecorrenzaFine:=0;
    if InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti and (DS.FindField(InterfacciaWR102.CampoDecorrenzaFine) <> nil) then
      DecorrenzaFine:=DS.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).AsDateTime;
    RI:=DS.RowID;
    //Confronto dei dati di una decorrenza con la decorrenza successiva, considerando le eventuali Tabelle Relazionate
    DS.Next;
    while not DS.Eof do
    begin
      DatiUguali:=True;
      if InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti and (DS.FindField(InterfacciaWR102.CampoDecorrenzaFine) <> nil) then
        if DecorrenzaFine + 1 < DS.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime then
          DatiUguali:=False;
      if DatiUguali then
        for T:=0 to High(InterfacciaWR102.TabelleRelazionate) do
        begin
          if not DecorrenzeUguali(InterfacciaWR102.TabelleRelazionate[T],Decorrenza,DS.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime) then
          begin
            DatiUguali:=False;
            Break;
          end;
        end;
      (*Se sto lavorando su un record diverso dal corrente e tutte le tabelle risultano uguali,
        posso cancellare il record. La cancellazione delle tabelle figlie avviene tramite
        il DELETE CASCADE della chiave relazionale*)
      if (RI <> DS.RowID) and DatiUguali then
      begin
        if InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti and (DS.FindField(InterfacciaWR102.CampoDecorrenzaFine) <> nil) then
        begin
          DecorrenzaFine:=DS.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).AsDateTime;
          DS.Prior;
          DS.Edit;
          DS.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).AsDateTime:=DecorrenzaFine;
          DS.Post;
          DS.Next;
        end;
        DS.Delete;
        Result:=True;
      end
      else
      begin
        Decorrenza:=DS.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime;
        if InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti and (DS.FindField(InterfacciaWR102.CampoDecorrenzaFine) <> nil) then
          DecorrenzaFine:=DS.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).AsDateTime;
        RI:=DS.RowID;
        DS.Next;
      end;
    end;
  finally
    if not TabRelaz then
      SetLength(InterfacciaWR102.TabelleRelazionate,0);
    DS.Free;
    L.Free;
  end;
end;

procedure TWR302FGestTabellaDM.AllineaDecorrenzaFine;
var
  Chiave,ChiaveVal:String;
  i:Integer;
begin
  if selTabella.FindField(InterfacciaWR102.CampoDecorrenzaFine) = nil then
    Exit;

  //L'allineamento solo per la chiave della tabella (FiltroChiave/ChiaveVal) avviene diversamente tra Win e Cloud
  //perché in Cloud è più facile circoscrivere gli eventi che possano caricare i valori originali per AllineaDecorrenzaFine
  //mentre in Win gli eventi possono essere nascosti (es. Ctrl+Canc su griglie o TGomma per datasource in AutoEdit, ecc..)
  //Quindi, allineamento intera tabella: in Win SEMPRE, TRANNE per P430; in Cloud SOLO per I501

  //Se è richiamato da 'Copia su', devo leggere i valori della chiave primaria perchè non si è passati dal DoAfterPost
  if InterfacciaWR102.StoricizzazioneInCorso and (Length(InterfacciaWR102.TabelleRelazionate) > 0) then
    SettaValoriChiavePrimaria;

  Chiave:='';
  ChiaveVal:='';
  for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
  begin
    if i > 0 then
    begin
      Chiave:=Chiave + ' and ';
      ChiaveVal:=ChiaveVal + ' and ';
    end;
    //Chiave:=Chiave + Format('%s = t.%s',[InterfacciaWR102.LChiavePrimaria[i],InterfacciaWR102.LChiavePrimaria[i]]);
    Chiave:=Chiave + InterfacciaWR102.LChiavePrimaria[i] + ' = t.' + InterfacciaWR102.LChiavePrimaria[i];
    if (VarArrayDimCount(ChiaveSenzaDec) = 1) and (VarArrayHighBound(ChiaveSenzaDec,1) >= i) then
      ChiaveVal:=ChiaveVal + InterfacciaWR102.LChiavePrimaria[i] + ' = ''' + AggiungiApice(VarToStr(ChiaveSenzaDec[i])) + '''';
  end;

  //Per le tabelle dei dati liberi, l'allineamento dei periodi storici si fa sempre per tutta la tabella
  if Copy(InterfacciaWR102.NomeTabella.ToUpper,1,4) = 'I501' then
    ChiaveVal:='';

  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Add('begin');
    // update 1: allineamento dei periodi
    // update 2: impostazione dell'ultima decorrenza al 31/12/3999
    SQL.Add('  update ' + InterfacciaWR102.NomeTabella + ' t set');
    SQL.Add('    ' + InterfacciaWR102.CampoDecorrenzaFine + ' = (select min(' + InterfacciaWR102.CampoDecorrenza + ') - 1 from ' + InterfacciaWR102.NomeTabella + ' where');
    if Trim(Chiave) <> '' then
      SQL.Add('                      ' + Chiave + ' and');
    SQL.Add(' ' + InterfacciaWR102.CampoDecorrenza + ' > t.' + InterfacciaWR102.CampoDecorrenza + ')');
    SQL.Add('  where');
    SQL.Add('    ' + InterfacciaWR102.CampoDecorrenza + ' < (select max(' + InterfacciaWR102.CampoDecorrenza + ') from ' + InterfacciaWR102.NomeTabella);
    if Trim(Chiave) <> '' then
      SQL.Add('                  where ' + Chiave);
    if InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti then
    begin
      // allinea solo i periodi che si intersecano
      SQL.Add('                  ) and');
      SQL.Add('    exists (select ''X'' from ' + InterfacciaWR102.NomeTabella + ' b');
      SQL.Add('            where  t.ROWID <> b.ROWID and');
      SQL.Add('                  ' + Chiave + ' and');
      SQL.Add('                   t.' + InterfacciaWR102.CampoDecorrenza + ' < b.' + InterfacciaWR102.CampoDecorrenza + ' and');
      SQL.Add('                    nvl(t.' + InterfacciaWR102.CampoDecorrenzaFine + ',b.' + InterfacciaWR102.CampoDecorrenza + ') >= b.' + InterfacciaWR102.CampoDecorrenza);
      SQL.Add('           )');
      if Trim(ChiaveVal) <> '' then
          SQL.Add('  and ' + ChiaveVal);
      SQL.Add('  ;');// chiude prima update

      SQL.Add('  update ' + InterfacciaWR102.NomeTabella + ' t set');
      SQL.Add('    ' + InterfacciaWR102.CampoDecorrenzaFine + ' = TO_DATE(''31123999'',''DDMMYYYY'')');
      SQL.Add('  where');
      SQL.Add('    ' + InterfacciaWR102.CampoDecorrenzaFine + ' is null and');
      SQL.Add('    ' + InterfacciaWR102.CampoDecorrenza + ' = (select max(' + InterfacciaWR102.CampoDecorrenza + ') from ' + InterfacciaWR102.NomeTabella);
      if Trim(Chiave) <> '' then
        SQL.Add('                  where ' + Chiave);
      SQL.Add('                  )');
      if Trim(ChiaveVal) <> '' then
          SQL.Add('  and ' + ChiaveVal);
      SQL.Add('  ;');// // chiude seconda update
    end
    else
    begin
      SQL.Add('                  )');
      if Trim(ChiaveVal) <> '' then
          SQL.Add('  and ' + ChiaveVal);
      SQL.Add('  ;');// chiude prima update
      // update 2. imposta come ultima decorrenza fine il 31/12/3999
      SQL.Add('  update ' + InterfacciaWR102.NomeTabella + ' t set');
      SQL.Add('    ' + InterfacciaWR102.CampoDecorrenzaFine + ' = TO_DATE(''31123999'',''DDMMYYYY'')');
      SQL.Add('  where');
      SQL.Add('    ' + InterfacciaWR102.CampoDecorrenza + ' = (select max(' + InterfacciaWR102.CampoDecorrenza + ') from ' + InterfacciaWR102.NomeTabella);
      if Trim(Chiave) <> '' then
        SQL.Add('                  where ' + Chiave);
      SQL.Add('                  )');
      if Trim(ChiaveVal) <> '' then
          SQL.Add('  and ' + ChiaveVal);
      SQL.Add('  ;');// // chiude seconda update
    end;
    SQL.Add('end;');
    try
      Execute;
      SessioneOracle.Commit;
    except
    end;
  finally
    Free;
  end;
end;

procedure TWR302FGestTabellaDM.BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',InterfacciaWR102.NomeTabella,Copy(Name,1,5),selTabella,True);
  SettaValoriChiavePrimaria;
end;

procedure TWR302FGestTabellaDM.AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  if InterfacciaWR102.GestioneStoricizzata then
  begin
    // debug
    //***StoricoOttimizzato:=OttimizzazioneStorico(DataSet);
    if InterfacciaWR102.GestioneDecorrenzaFine then
    begin
      AllineaDecorrenzaFine;
      selTabella.Refresh;
      if VarArrayDimCount(ChiaveSenzaDec) = 1 then
        selTabella.Locate(NomiSenzaDec,ChiaveSenzaDec,[]);
    end;
  end;
  SessioneOracle.Commit;
  //Caratto 26/06/2012 imposta tutti i componenti non data-aware del dettaglio prendendo dal dataset
  if InterfacciaWR102.DettaglioFM and (TWR102FGestTabella(Owner).WDettaglioFM <> nil) then
    TWR102FGestTabella(Owner).WDettaglioFM.DataSet2Componenti;
end;

procedure TWR302FGestTabellaDM.AfterCancel(DataSet: TDataSet);
begin
  //Caratto 26/06/2012 imposta tutti i componenti non data-aware del dettaglio prendendo dal dataset
  if InterfacciaWR102.DettaglioFM and (TWR102FGestTabella(Owner).WDettaglioFM <> nil) then
    TWR102FGestTabella(Owner).WDettaglioFM.DataSet2Componenti;
end;

procedure TWR302FGestTabellaDM.AfterScroll(DataSet: TDataSet);
begin
  //Caratto 26/06/2012 imposta tutti i componenti non data-aware del dettaglio prendendo dal dataset
  if InterfacciaWR102.DettaglioFM and (TWR102FGestTabella(Owner).WDettaglioFM <> nil) then
    (*per insert viene richiamato DataSet2Componenti nella OnNewRecord in modo da caricare i componenti prima di eseguire
    abilitaComponenti; Dopo farebbe anche afterscroll, quindi in questo caso non eseguo
    *)
    if (DataSet = nil) or (not (DataSet.State in [dsInsert,dsInactive])) then
      TWR102FGestTabella(Owner).WDettaglioFM.DataSet2Componenti;
  TWR102FGestTabella(Owner).GetDateDecorrenza;
  TWR102FGestTabella(Owner).AggiornaRecord;
end;

procedure TWR302FGestTabellaDM.OnTranslateMessage(Sender: TOracleDataSet;
  ErrorCode: Integer; const ConstraintName: String; Action: Char; var Msg: String);
// Conversione messaggi Oracle
// 2291 = integrity constraint str.name violated – parent key not found
// 2292 = integrity constraint str.name violated – child record found
begin
  case ErrorCode of
     2291: Msg:='Impossibile inserire - Riferimento mancante su ' + ConstraintName;
     2292: Msg:='Impossibile eliminare - Riferimento esistente su ' + ConstraintName;
    20010: Msg:='Record bloccato';
  end;
end;

end.
