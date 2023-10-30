unit WA181UAziendeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, A000UMessaggi,
  A000UCostanti, A000USessione,A181UAziendeMW,medpIWDBGrid,medpIWMessageDlg;

type
  TWA181FAziendeDM = class(TWR302FGestTabellaDM)
    selDizionario: TOracleDataSet;
    DbIris008B: TOracleSession;
    D091: TDataSource;
    QI092: TOracleDataSet;
    selTabellaAZIENDA: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaINDIRIZZO: TStringField;
    selTabellaSTORIAINTERVENTO: TStringField;
    selTabellaUTENTE: TStringField;
    selTabellaPAROLACHIAVE: TStringField;
    selTabellaTSLAVORO: TStringField;
    selTabellaTSINDICI: TStringField;
    selTabellaTSAUSILIARIO: TStringField;
    selTabellaTIMBORIG_VERSO: TStringField;
    selTabellaTIMBORIG_CAUSALE: TStringField;
    selTabellaCODICE_INTEGRAZIONE: TStringField;
    selTabellaLUNG_PASSWORD: TIntegerField;
    selTabellaVALID_PASSWORD: TIntegerField;
    selTabellaVALID_UTENTE: TIntegerField;
    selTabellaPATHALLCLIENT: TStringField;
    selTabellaDOMINIO_USR: TStringField;
    selTabellaDOMINIO_DIP: TStringField;
    selTabellaDOMINIO_DIP_TIPO: TStringField;
    selTabellaDOMINIO_USR_TIPO: TStringField;
    selTabellaPASSWORD_CIFRE: TIntegerField;
    selTabellaPASSWORD_MAIUSCOLE: TIntegerField;
    selTabellaPASSWORD_CARSPECIALI: TIntegerField;
    selTabellaGRUPPO_BADGE: TStringField;
    selTabellaDOMINIO_LDAP_DN: TStringField;
    selTabellaDOMINIO_LDAP_SUFFISSO: TStringField;
    selI060UtentiRipetuti: TOracleQuery;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selTabellaPAROLACHIAVEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure selTabellaPAROLACHIAVESetText(Sender: TField; const Text: string);
    procedure selTabellaDOMINIO_DIP_TIPOChange(Sender: TField);
    procedure selTabellaAfterEdit(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selDizionarioBeforeOpen(DataSet: TDataSet);
  private
    function GetI091Gruppo(CodI091:String):String;
    procedure CancellazioneAzienda(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CheckParolaChiave(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    //function Decod_Iter(InIter:String):String;   Massimo 14/12/2012 gestione A181UAziendeMW
  public
    A181MW:TA181FAziendeMW;
    BrowseProfili:Boolean;
    AziendaCorrente:String;
    //GruppoFiltroI091:String;  Massimo 17/12/2012 gestione A181UAziendeMW
    //ModuloIterAutorizzativi, I093EnabledInsert:Boolean;    Massimo 14/12/2012 gestione A181UAziendeMW
  end;

implementation

uses
  WA181UAziende, WA181UAziendeDettFM;

{$R *.dfm}

procedure TWA181FAziendeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  // Massimo 14/12/2012 gestione A181UAziendeMW
  A181MW:=TA181FAziendeMW.Create(nil);
  A181MW.QI090:=SelTabella;
  selTabella.SetVariable('ORDERBY','ORDER BY AZIENDA');
  NonAprireSelTabella:=True;
  inherited;
  BrowseProfili:=True;
  selTabella.AfterScroll:=nil;
  if Parametri.Azienda <> 'AZIN' then
  begin
    //selTabella.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selTabella.Filtered:=True;
  end;
  selTabella.Open;
  DbIris008B.LogonDatabase:=Parametri.Database;
  DbIris008B.LogonUserName:=selTabella.FieldByName('UTENTE').AsString;
  DbIris008B.LogonPassword:=R180Decripta(selTabella.FieldByName('PAROLACHIAVE').AsString,21041974);
  DbIris008B.Preferences.UseOCI7:=False;
  DbIris008B.BytesPerCharacter:=bc1Byte;
  {$IFDEF IRISWEB}
    DbIris008B.ThreadSafe:=True;
  {$ENDIF}
  DbIris008B.Logon;
  try
    selDizionario.Open;
    A181MW.selDizionario.Open;
  except
  end;
  A181MW.AggiornaDatiEnte;
  selTabella.AfterScroll:=AfterScroll;
  selTabella.First;
end;

procedure TWA181FAziendeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A181MW);
  inherited;
end;

procedure TWA181FAziendeDM.OnNewRecord(DataSet: TDataSet);
begin
  selTabella.FieldByName('PAROLACHIAVE').AsString:=R180Cripta(A000PasswordFissa,21041974);
  inherited;
end;

(* Massimo 17/12/2012 gestione A181UAziendeMW
procedure TWA181FAziendeDM.OpenSelI094;
begin
  R180SetVariable(A181MW.selI094,'AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
  selI094.Open;
end;
*)

function TWA181FAziendeDM.GetI091Gruppo(CodI091:String):String;
var i:Integer;
begin
  i:=Low(DatiEnte);
  while (i < High(DatiEnte)) and (DatiEnte[i].Nome <> CodI091) do
    inc(i);
  Result:=DatiEnte[i].Gruppo;
end;

procedure TWA181FAziendeDM.AfterPost(DataSet: TDataSet);
var Az(*,AzOld*):String;
    i:Integer;
begin
  Az:=DataSet.FieldByName('Azienda').AsString;
  //AzOld:=VarToStr(DataSet.FieldByName('Azienda').medpOldValue);
  try
    SessioneOracle.ApplyUpdates([A181MW.QI091],False);
    (*17/07/2017 Danilo: inibita la possibilità di modificare il codice dell'azienda
    if (AzOld <> '') and (Az <> AzOld) then
    begin
      A181MW.scrupdI090.SetVariable('AZIENDA_OLD',AzOld);
      A181MW.scrupdI090.SetVariable('AZIENDA_NEW',Az);
      A181MW.scrupdI090.Execute;
    end;*)
    if selTabella.FieldByName('STORIAINTERVENTO').AsString = 'S' then
    begin
      //Scrivo le tabelle selezionate per il log cancellando quelle non selezionate
      A181MW.scrI092.SQL.Clear;
      A181MW.scrI092.DeleteVariables;
      A181MW.scrI092.SQL.Add('begin');
      A181MW.scrI092.SQL.Add('  null;');
      if TWA181FAziendeDettFM(TWA181FAziende(Self.Owner).WDettaglioFM) <> nil then
        with TWA181FAziendeDettFM(TWA181FAziende(Self.Owner).WDettaglioFM) do
          for i:=0 to cgpTabelleLog.Items.Count - 1 do
            if cgpTabelleLog.IsChecked[i] then
            begin
              A181MW.scrI092.SQL.Add(Format('  insert into MONDOEDP.I092_LOGTABELLE (AZIENDA,SCHEDA) select ''%s'',''%s'' from dual where (''%s'',''%s'') not in (select AZIENDA,SCHEDA from MONDOEDP.I092_LOGTABELLE where AZIENDA = ''%s'' and SCHEDA = ''%s'');',[Az,CdFnz[i],Az,CdFnz[i],Az,CdFnz[i]]));
              //Caratto: 11/04/2013. Unificazione L021. abilito anche la maschera web
              if (CdFnz[i] <> CdFnzWeb[i]) and (CdFnzWeb[i] <> '') then
              begin
                A181MW.scrI092.SQL.Add(Format('  insert into MONDOEDP.I092_LOGTABELLE (AZIENDA,SCHEDA) select ''%s'',''%s'' from dual where (''%s'',''%s'') not in (select AZIENDA,SCHEDA from MONDOEDP.I092_LOGTABELLE where AZIENDA = ''%s'' and SCHEDA = ''%s'');',[Az,CdFnzWeb[i],Az,CdFnzWeb[i],Az,CdFnzWeb[i]]));
              end;
            end
            else
            begin
              A181MW.scrI092.SQL.Add(Format('  delete MONDOEDP.I092_LOGTABELLE where AZIENDA = ''%s'' and SCHEDA = ''%s'';',[Az,CdFnz[i]]));
              //Caratto: 11/04/2013. Unificazione L021. disabilito anche la maschera web
              if (CdFnz[i] <> CdFnzWeb[i]) and (CdFnzWeb[i] <> '') then
              begin
                A181MW.scrI092.SQL.Add(Format('  delete MONDOEDP.I092_LOGTABELLE where AZIENDA = ''%s'' and SCHEDA = ''%s'';',[Az,CdFnzWeb[i]]));
              end;
            end;
      A181MW.scrI092.SQL.Add('end;');
      A181MW.scrI092.Execute;
    end;
  except
    SessioneOracle.Rollback;
  end;
  SessioneOracle.Commit;
  A181MW.QI091.CancelUpdates;
  A181MW.QI091.CachedUpdates:=False;
  selTabella.Close;
  selTabella.AfterScroll:=nil;
  selTabella.Open;
  selTabella.AfterScroll:=AfterScroll;
  selTabella.Locate('Azienda',Az,[]);
  if A181MW.QI091.RecordCount = 0 then
  begin
    A181MW.PutDatiEnte(Az);
    A181MW.QI091.Close;
    A181MW.QI091.Open;
  end;
  //Gestione Jobs Archiviazione Log
  A181MW.JobArchiviazioneLOG;

  if Az = Parametri.Azienda then
    //ASSEGNAZIONE DEGLI EVENTUALI CAMBIAMENTI SUI PARAMETRI AZIENDALI IN TEMPO REALE
  begin
    Parametri.LogTabelle:=selTabella.FieldByName('STORIAINTERVENTO').AsString;
    if Parametri.LogTabelle = 'S' then
    begin
      QI092.First;
      Parametri.NomiTabelleLog.Clear;
      while not QI092.Eof do
      begin
        Parametri.NomiTabelleLog.Add(QI092.FieldByName('SCHEDA').AsString);
        QI092.Next;
      end;
      QI092.First;
    end;
    A181MW.PutParametri;
  end;
  inherited;
end;

procedure TWA181FAziendeDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
   //Rilettura dati aziendali
  with A181MW.QI091 do
  begin
    Close;
    SetVariable('AZIENDA',selTabellaAzienda.AsString);
    Open;
  end;
  //Rilettura indicazioni sui log
  with QI092 do
  begin
    Close;
    SetVariable('AZIENDA',selTabellaAzienda.AsString);
    Open;
  end;
  //Apertura del database indicato dall'Azienda
  with DbIris008B do
  begin
    if (not Connected) or
       (UpperCase(LogonUserName) <> UpperCase(selTabella.FieldByName('UTENTE').AsString)) then
      begin
      Logoff;
      if selTabella.State = dsInsert then
      begin
        LogonDataBase:=Parametri.Database;
        LogonUserName:='MONDOEDP';
        LogonPassword:=Parametri.PasswordMondoEDP;
      end
      else
      begin
        LogonDataBase:=Parametri.Database;
        LogonUserName:=selTabella.FieldByName('UTENTE').AsString;
        LogonPassword:=R180Decripta(selTabella.FieldByName('PAROLACHIAVE').AsString,21041974);
      end;
      {$IFDEF IRISWEB}
        ThreadSafe:=True;
      {$ENDIF}
      try
        Logon;
        TWA181FAziende(Self.Owner).MessaggioStatus(INFORMA,'');
      except
        on E:Exception do
          TWA181FAziende(Self.Owner).MessaggioStatus(ERRORE,E.Message);
      end;
    end;
  end;
  //Apertura tabelle dell'Azienda
  if DbIris008B.Connected then
  begin
    A181MW.QCols.Open;
    try
      selDizionario.Open;
    except
    end;
  end;

  // abilitazione componenti
  if Self.Owner <> nil then
  begin
    if (Self.Owner as TWA181FAziende).WDettaglioFM <> nil then
      ((Self.Owner as TWA181FAziende).WDettaglioFM as TWA181FAziendeDettFM).AbilitaComponenti;
  end;
  (Self.Owner as TWA181FAziende).AggiornaDetails;
end;

procedure TWA181FAziendeDM.selDizionarioBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  selDizionario.SQL.Text:='select * from (' + A000selDizionario + A000selDizionarioDatiAziendali(selDizionario.Session) + A000selDizionarioSicurezzaRiepiloghi;
  selDizionario.SQL.Add(') ORDER BY TABELLA, upper(CODICE)');
end;

procedure TWA181FAziendeDM.selTabellaAfterEdit(DataSet: TDataSet);
begin
  inherited;
  A181MW.QI091.CachedUpdates:=True;
end;

procedure TWA181FAziendeDM.selTabellaDOMINIO_DIP_TIPOChange(Sender: TField);
begin
  inherited;
  if Sender.IsNull then
    Sender.AsString:='NTLM';
end;

procedure TWA181FAziendeDM.selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=(Parametri.Azienda = 'AZIN') or (selTabella.FieldByName('AZIENDA').AsString = Parametri.Azienda);
end;

procedure TWA181FAziendeDM.selTabellaPAROLACHIAVEGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text:=R180Decripta(Sender.AsString,21041974);
end;

procedure TWA181FAziendeDM.selTabellaPAROLACHIAVESetText(Sender: TField;
  const Text: string);
begin
  inherited;
  Sender.AsString:=R180Cripta(Text,21041974);
end;

procedure TWA181FAziendeDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
     MsgBox.webMessageDlg('ATTENZIONE!' + #13#10 +
                          Format('Eliminare definitivamente l''azienda %s?',[selTabella.FieldByName('AZIENDA').AsString]),
                          mtConfirmation,[mbYes,mbNo],CancellazioneAzienda,'PUNTO_1');
     Abort;
  end
  else
  begin
    MsgBox.ClearKeys;
    with A181MW.scrdelI090 do
    begin
      SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
      Execute;
    end;
  end;
end;

procedure TWA181FAziendeDM.CancellazioneAzienda(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:selTabella.Delete;
    mrNo:MsgBox.ClearKeys;
  end;
end;

procedure TWA181FAziendeDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    if selTabella.State = dsInsert then
    begin
      A181MW.QI091.CachedUpdates:=True;
      A181MW.QI091.ReadOnly:=False;
      selTabella.FieldByName('AZIENDA').AsString:=UpperCase(selTabella.FieldByName('AZIENDA').AsString);
    end;
    if ((selTabella.State = dsInsert) or
        ((selTabella.State = dsEdit) and (selTabella.FieldByName('DOMINIO_LDAP_SUFFISSO').Value <> selTabella.FieldByName('DOMINIO_LDAP_SUFFISSO').medpOldValue))) and
       (not selTabella.FieldByName('DOMINIO_LDAP_SUFFISSO').IsNull)
    then
    begin
      //Controllo che il suffisso LDAP non crei degli utenti duplicati
      selI060UtentiRipetuti.Close;
      selI060UtentiRipetuti.SetVariable('AZIENDA', selTabella.FieldByName('AZIENDA').AsString);
      selI060UtentiRipetuti.SetVariable('DOMINIO_LDAP_SUFFISSO', selTabella.FieldByName('DOMINIO_LDAP_SUFFISSO').AsString);
      selI060UtentiRipetuti.Execute;
      if selI060UtentiRipetuti.RowCount > 0 then
        raise Exception.Create(A000MSG_A008_NOME_UTENTE_DUPLICATI);
    end;
    if (selTabella.State = dsEdit) and
       (selTabella.FieldByName('PAROLACHIAVE').Value <> selTabella.FieldByName('PAROLACHIAVE').medpOldValue) then
       begin
         MsgBox.webMessageDlg('ATTENZIONE!' + #13#10 +
                        'E'' stata modificata la password di connessione al database.' + #13#10 +
                        'Si ricorda che questa NON E'' la password del proprio operatore.' + #13#10 +
                        'Questa operazione avrà effetto a livello globale per tutti' + #13#10 +
                        'gli utenti dell''azienda "' + selTabella.FieldByName('AZIENDA').AsString + '".' + #13#10 +
                        'Vuoi continuare?',mtConfirmation,[mbYes,mbNo],CheckParolaChiave,'PUNTO_1');
         Abort;
       end;
  end
  else
  begin
    MsgBox.ClearKeys;
  end;
end;

procedure TWA181FAziendeDM.CheckParolaChiave(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:selTabella.Post;
    mrNo:MsgBox.ClearKeys;
  end;
end;

procedure TWA181FAziendeDM.dsrTabellaStateChange(Sender: TObject);
var
  WA181FAziende:TWA181FAziende;
begin
  inherited;
  selTabella.FieldByName('AZIENDA').ReadOnly:=not (dsrTabella.State in [dsInsert]);
  WA181FAziende:=Self.Owner as TWA181FAziende;
  if WA181FAziende <> nil then
    WA181FAziende.AbilitaFunzioni;
end;

end.
