unit A118UPubblicazioneDocumentiDtM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A118UPubblicazioneDocumentiMW,
  C180FunzioniGenerali,
  R004UGestStoricoDTM,
  StrUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, DB, OracleData, Oracle, System.IOUtils;

type
  TA118FPubblicazioneDocumentiDtM = class(TR004FGestStoricoDtM)
    selI200: TOracleDataSet;
    selI201: TOracleDataSet;
    selI202: TOracleDataSet;
    dsrI201: TDataSource;
    dsrI202: TDataSource;
    selI202CAMPO: TStringField;
    selI202DAL: TIntegerField;
    selI202LUNG: TIntegerField;
    selI202CODICE: TStringField;
    selI202LIVELLO: TIntegerField;
    selI202VISIBILE: TStringField;
    selT962Lookup: TOracleDataSet;
    dsrT962Lookup: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure selI200AfterScroll(DataSet: TDataSet);
    procedure selI201AfterScroll(DataSet: TDataSet);
    procedure selI201BeforePost(DataSet: TDataSet);
    procedure selI201AfterPost(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selI201NewRecord(DataSet: TDataSet);
    procedure selI201BeforeDelete(DataSet: TDataSet);
    procedure selI201AfterDelete(DataSet: TDataSet);
    procedure selI202NewRecord(DataSet: TDataSet);
    procedure selI200AfterCancel(DataSet: TDataSet);
    procedure selI202BeforePost(DataSet: TDataSet);
    procedure selI201BeforeInsert(DataSet: TDataSet);
    procedure selI201BeforeEdit(DataSet: TDataSet);
    procedure selI202BeforeInsert(DataSet: TDataSet);
    procedure selI202BeforeEdit(DataSet: TDataSet);
    procedure selI202BeforeDelete(DataSet: TDataSet);
    procedure selI201BeforeScroll(DataSet: TDataSet);
    procedure selI202VISIBILEValidate(Sender: TField);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FOperazione: String;
    FOperazioneI201: String;
    function  CheckFiltroLivello(const PFiltro: String): TResCtrl;
  public
    A118MW: TA118FPubblicazioneDocumentiMW;
    MaxLiv,MaxPos: Integer;
  end;

var
  A118FPubblicazioneDocumentiDtM: TA118FPubblicazioneDocumentiDtM;

implementation

uses A118UPubblicazioneDocumenti;

{$R *.dfm}

procedure TA118FPubblicazioneDocumentiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A118MW:=TA118FPubblicazioneDocumentiMW.Create(nil);
  MaxLiv:=-1;
  MaxPos:=0;
  InizializzaDataSet(selI200,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selT962Lookup.Open;
  selI200.Open;
end;

procedure TA118FPubblicazioneDocumentiDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A118MW);
  inherited;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI200AfterScroll(DataSet: TDataSet);
begin
  // apre il dataset dei campi
  selI202.Close;
  selI202.SetVariable('CODICE',selI200.FieldByName('CODICE').AsString);
  selI202.Open;

  // apre dataset dei livelli
  selI201.DisableControls;
  selI201.AfterScroll:=nil;
  selI201.Close;
  selI201.SetVariable('CODICE',selI200.FieldByName('CODICE').AsString);
  selI201.Open;
  if selI201.RecordCount > 0 then
  begin
    selI201.Last;
    MaxLiv:=selI201.FieldByName('LIVELLO').AsInteger;
    selI201.AfterScroll:=selI201AfterScroll;
    selI201.First;
  end
  else
  begin
    MaxLiv:=-1;
  end;
  selI201.EnableControls;

  A118FPubblicazioneDocumenti.OnI200AfterScroll;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI200AfterCancel(DataSet: TDataSet);
begin
  FOperazione:='';
  //SessioneOracle.CancelUpdates([selI201,selI202]);
  selI201.CancelUpdates;
  selI202.CancelUpdates;
end;

procedure TA118FPubblicazioneDocumentiDtM.BeforePostNoStorico(DataSet: TDataSet);
var
  LFiltro: String;
  LResCtrl: TResCtrl;
begin
  inherited;

  // correttezza filtro visualizzazione
  LFiltro:=selI200.FieldByName('FILTRO').AsString.Trim;
  selI200.FieldByName('FILTRO').AsString:=LFiltro;
  if LFiltro <> '' then
  begin
    LResCtrl:=A118MW.CheckFiltroDocumenti(LFiltro);
    if (not LResCtrl.Ok) and (LResCtrl.Messaggio <> '') then
      raise Exception.CreateFmt('Il filtro di visualizzazione documenti non è corretto:'#13#10'%s',[LResCtrl.Messaggio]);
  end;

  if selI200.FieldByName('SORGENTE_DOCUMENTI').AsString = SORGENTE_FS_EXT then
  begin
    // sorgente documenti: cartella esterna

    // verifica esistenza directory base per documenti se specificata
    // prima del controllo effettua trim
    selI200.FieldByName('ROOT').AsString:=selI200.FieldByName('ROOT').AsString.Trim;
    if not selI200.FieldByName('ROOT').IsNull then
    begin
      if not TDirectory.Exists(selI200.FieldByName('ROOT').AsString) then
      begin
        if R180MessageBox('La directory base per i documenti è inesistente oppure non accessibile.'#13#10'Vuoi continuare?',DOMANDA) = mrNo then
          Abort;
      end;
    end;

    // conferma eventuali modifiche non salvate sui campi
    if selI202.State <> dsBrowse then
      selI202.Post;

    // conferma eventuali modifiche non salvate sul livello
    if selI201.State <> dsBrowse then
      selI201.Post;

    // verifica le impostazioni dei livelli
    selI201.DisableControls;
    try
      selI201.First;
      while not selI201.Eof do
      begin
        // estensione valida solo su ultimo livello
        if (selI201.FieldByName('EXT').AsString <> '') and
           (selI201.FieldByName('LIVELLO').AsInteger < MaxLiv) then
          raise Exception.Create('E'' possibile indicare l''estensione solo sull''ultimo livello!');

        // correttezza filtro
        LFiltro:=selI201.FieldByName('FILTRO').AsString.Trim;
        if LFiltro <> '' then
        begin
          LResCtrl:=CheckFiltroLivello(LFiltro);
          if not LResCtrl.Ok then
            raise Exception.CreateFmt('Il filtro indicato per il livello %d non è corretto:'#13#10'%s',
                                      [selI201.FieldByName('LIVELLO').AsInteger,
                                       LResCtrl.Messaggio]);
        end;
        selI201.Next;
      end;
      selI201.First;
    finally
      selI201.EnableControls;
    end;

    // rimuove il filtro dal dataset selI202 per il post
    selI202.Filtered:=False;
  end
  else if selI200.FieldByName('SORGENTE_DOCUMENTI').AsString = SORGENTE_T960 then
  begin
    // sorgente documenti: modulo documentale

    // la tipologia documenti deve essere selezionata
    if (selI200.FieldByName('TIPOLOGIA_DOCUMENTI').AsString = '') then
      raise Exception.Create('E'' necessario selezionare la tipologia di documenti!');
  end
  else if R180In(selI200.FieldByName('SORGENTE_DOCUMENTI').AsString,[SORGENTE_WS_ENGI_CU,SORGENTE_WS_ENGI_CEDOL]) then
  begin
    // sorgente documenti: webservice engineering

    // l'URL del webservice deve essere indicato
    selI200.FieldByName('URL_WS').AsString:=selI200.FieldByName('URL_WS').AsString.Trim;
    if selI200.FieldByName('URL_WS').AsString = '' then
      raise Exception.Create('E'' necessario selezionare l''URL del webservice da invocare!');
  end;

  case DataSet.State of
    dsInsert: FOperazione:='I';
    dsEdit:   FOperazione:='M';
  end;
end;

procedure TA118FPubblicazioneDocumentiDtM.AfterPost(DataSet: TDataSet);
begin
  // operazioni nel caso di documenti su cartella esterna
  if selI200.FieldByName('SORGENTE_DOCUMENTI').AsString = SORGENTE_FS_EXT then
  begin
    // dopo l'inserimento di un nuovo tipo di documento
    // inserisce automaticamente un livello
    if FOperazione = 'I' then
    begin
      selI201.Append;
      selI201.FieldByName('NOME').AsString:='nome cartella';
      selI201.Post;
    end;
    if selI201.UpdatesPending or selI202.UpdatesPending then
      SessioneOracle.ApplyUpdates([selI201,selI202],True);
  end;

  inherited;

  // porta in edit il dataset dei livelli
  // operazioni nel caso di documenti su cartella esterna
  if selI200.FieldByName('SORGENTE_DOCUMENTI').AsString = SORGENTE_FS_EXT then
  begin
    if FOperazione = 'I' then
      selI201.Edit;
  end;

  // annulla dati
  FOperazione:='';
end;

// ############# Dataset dei livelli  #############

procedure TA118FPubblicazioneDocumentiDtM.selI201BeforeScroll(DataSet: TDataSet);
begin
  if selI202.State <> dsBrowse then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201AfterScroll(DataSet: TDataSet);
var
  LLiv: Integer;
begin
  LLiv:=selI201.FieldByName('LIVELLO').AsInteger;

  // intestazione groupbox
  A118FPubblicazioneDocumenti.grpCampi.Caption:=Format('Definizione campi - livello %d',[LLiv]);

  // nasconde il campo lunghezza se è indicato un separatore
  A118FPubblicazioneDocumenti.dgrdCampi.Columns.Items[2].Visible:=selI201.FieldByName('SEPARATORE').IsNull;

  // indicazione per i test
  A118FPubblicazioneDocumenti.lblTest.Caption:=Format('Test impostazioni livello %d',[LLiv]);

  // filtra il dataset dei campi
  selI202.Filtered:=False;
  selI202.Filter:=Format('LIVELLO = %d',[LLiv]);
  selI202.Filtered:=True;

  // se il nome contiene separatori estrae la posizione massima
  if selI201.FieldByName('SEPARATORE').IsNull then
    MaxPos:=-1
  else
  begin
    if selI202.RecordCount = 0 then
      MaxPos:=0
    else
    begin
      selI202.Last;
      MaxPos:=selI202.FieldByName('DAL').AsInteger;
      selI202.First;
    end;
  end;
  //selI202.EnableControls;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201BeforeInsert(DataSet: TDataSet);
begin
  if (FOperazione <> 'I') and (selI200.State <> dsEdit) then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201NewRecord(DataSet: TDataSet);
begin
  selI201.FieldByName('CODICE').AsString:=selI200.FieldByName('CODICE').AsString;
  selI201.FieldByName('LIVELLO').AsInteger:=MaxLiv + 1;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201BeforeEdit(DataSet: TDataSet);
begin
  if selI200.State <> dsEdit then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201BeforeDelete(DataSet: TDataSet);
var
  LLiv: Integer;
begin
  if selI200.State <> dsEdit then
    Abort;

  // controllo livello
  LLiv:=selI201.FieldByName('LIVELLO').AsInteger;
  if LLiv <> MaxLiv then
    raise Exception.Create('E'' possibile eliminare solo l''ultimo livello!')
  else if LLiv = 0 then
    raise Exception.Create('Non è possibile eliminare l''unico livello definito!');

  // conferma se sono presenti dettagli
  if selI202.RecordCount > 0 then
    if R180MessageBox('Il livello ' + IntToStr(LLiv) + ' contiene delle righe di dettaglio.' + CRLF +
                      'Confermi la cancellazione?',DOMANDA) = mrNo then
      Abort;
end;

function TA118FPubblicazioneDocumentiDtM.CheckFiltroLivello(const PFiltro: String): TResCtrl;
var
  LFiltroSrc: String;
  LCampo: String;
  LValore: Variant;
  LTipoVar: Integer;
  i: Integer;
  LVar: TVariabile;
  LNomeVar: String;
begin
  Result.Ok:=PFiltro = '';
  Result.Messaggio:='';

  if Result.Ok then
    Exit;

  try
    A118MW.selFiltro.ClearVariables;
    A118MW.selFiltro.DeleteVariables;
    A118MW.selFiltro.SQL.Text:=Format('select count(*) TOT from dual where %s',[PFiltro]);

    LFiltroSrc:=PFiltro.ToUpper;

    // fase 1/2
    //   ricerca i campi variabili previsti nella struttura
    if Pos(':',LFiltroSrc) > 0 then
    begin
      selI202.DisableControls;
      selI202.First;
      while not selI202.Eof do
      begin
        LCampo:=selI202.FieldByName('CAMPO').AsString.ToUpper;
        if LCampo.StartsWith(PREFISSO_VAR) then
        begin
          // se la variabile è presente nel filtro, la dichiara
          if R180CercaParolaIntera(LCampo,LFiltroSrc,SEPARATORI_TOKEN) > 0 then
          begin
            LCampo:=LCampo.Substring(PREFISSO_VAR.Length);
            LTipoVar:=-1;
            LValore:='X';

            // cerca il tipo della variabile nell'array
            for i:=0 to High(A118MW.Variabili) do
            begin
              if LCampo = A118MW.Variabili[i].Nome then
              begin
                LTipoVar:=A118MW.Variabili[i].Tipo;
                Break;
              end;
            end;
            if LTipoVar = -1 then
              LTipoVar:=otString
            else
            begin
              case LTipoVar of
                otString:  LValore:='X';
                otInteger: LValore:=1;
              end;
            end;
            A118MW.selFiltro.DeclareVariable(LCampo,LTipoVar);
            A118MW.selFiltro.SetVariable(LCampo,LValore);
          end;

          LFiltroSrc:=StringReplace(LFiltroSrc,PREFISSO_VAR + LCampo,'',[rfReplaceAll,rfIgnoreCase]);
          if Pos(PREFISSO_VAR,LFiltroSrc) = 0 then
            Break;
        end;
        selI202.Next;
      end;
      selI202.First;
      selI202.EnableControls;
    end;

    // fase 2/2
    //   ricerca variabili anagrafiche
    if Pos(':',LFiltroSrc) > 0 then
    begin
      for i:=Low(A118MW.Variabili) to High(A118MW.Variabili) do
      begin
        LVar:=A118MW.Variabili[i];

        if not LVar.RifAnag then
          Continue;

        LNomeVar:=LVar.Nome;
        if R180CercaParolaIntera(PREFISSO_VAR + LNomeVar,LFiltroSrc,SEPARATORI_TOKEN) > 0 then
        begin
          A118MW.selFiltro.DeclareVariable(LNomeVar,LVar.Tipo);
          case LVar.Tipo of
            otDate:
              A118MW.selFiltro.SetVariable(LNomeVar,LVar.ValoreDate);
            otInteger:
              A118MW.selFiltro.SetVariable(LNomeVar,LVar.ValoreInt);
            otString:
              A118MW.selFiltro.SetVariable(LNomeVar,LVar.ValoreStr);
          else
            begin
              Result.Messaggio:=Format('il tipo di variabile non è previsto: %d',[LVar.Tipo]);
              Exit;
            end;
          end;
          LFiltroSrc:=StringReplace(LFiltroSrc,PREFISSO_VAR + LNomeVar,'',[rfReplaceAll,rfIgnoreCase]);
        end;
      end;
    end;

    // verifica se sono presenti altre variabili
    if Pos(':',LFiltroSrc) > 0 then
      Result.Messaggio:='una o più variabili utilizzate nel filtro non sono state definite nella struttura!'
    else
    begin
      A118MW.selFiltro.Execute;
      Result.Ok:=True;
    end;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201BeforePost(DataSet: TDataSet);
var
  LLiv: Integer;
  //Filtro,Err: String;
begin
  LLiv:=selI201.FieldByName('LIVELLO').AsInteger;

  // nome
  if selI201.FieldByName('NOME').AsString.Trim = '' then
    raise Exception.Create(Format('Indicare un nome descrittivo per il file del livello %d',[LLiv]));

  // estensione: rimuove punto iniziale
  if selI201.FieldByName('EXT').AsString.StartsWith('.') then
    selI201.FieldByName('EXT').AsString:=selI201.FieldByName('EXT').AsString.Substring(1);

  // separatore
  if Pos(' ',selI201.FieldByName('SEPARATORE').AsString) > 0 then
    if R180MessageBox('Attenzione! Nel campo separatore' + CRLF +
                      'è stato inserito il carattere SPAZIO.' + CRLF +
                      'Se possibile si raccomanda di sostituirlo' + CRLF +
                      'con un altro carattere maggiormente visibile,' + CRLF +
                      'quale l''underscore "_".' + CRLF +
                      'Vuoi continuare?',DOMANDA) = mrNo then
      Abort;

  // correttezza filtro
  {
  Filtro:=Trim(selI201.FieldByName('FILTRO').AsString);
  if (Filtro <> '') and (not CheckFiltroLivello(Filtro,Err)) then
    raise Exception.Create(Format('Il filtro indicato per il livello %d contiene errori:%s%s',[L,CRLF,Err]));
  }

  // imposta tipo operazione
  case DataSet.State of
    dsInsert: FOperazioneI201:='I';
    dsEdit:   FOperazioneI201:='M';
  end;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201AfterPost(DataSet: TDataSet);
begin
  if FOperazioneI201 = 'I' then
  begin
    if selI201.FieldByName('LIVELLO').AsInteger > MaxLiv then
      MaxLiv:=selI201.FieldByName('LIVELLO').AsInteger;
  end;
  FOperazioneI201:='';
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201AfterDelete(DataSet: TDataSet);
begin
  // esegue cancellazione del dettaglio del livello
  selI202.DisableControls;
  selI202.First;
  while not selI202.Eof do
    selI202.Delete;
  selI202.EnableControls;

  dec(MaxLiv);
end;

// ############# Dataset del dettaglio di livello  #############

procedure TA118FPubblicazioneDocumentiDtM.selI202NewRecord(DataSet: TDataSet);
begin
  selI202.FieldByName('CODICE').AsString:=selI201.FieldByName('CODICE').AsString;
  selI202.FieldByName('LIVELLO').AsInteger:=selI201.FieldByName('LIVELLO').AsInteger;
  if MaxPos <> -1 then
    selI202.FieldByName('DAL').AsInteger:=MaxPos + 1;
  selI202.FieldByName('VISIBILE').AsString:='N';
end;

procedure TA118FPubblicazioneDocumentiDtM.selI202VISIBILEValidate(Sender: TField);
begin
  if not ((Sender.AsString = 'S') or (Sender.AsString = 'N')) then
    raise Exception.Create('Introdurre S oppure N');
end;

procedure TA118FPubblicazioneDocumentiDtM.selI202BeforeInsert(DataSet: TDataSet);
begin
  if selI200.State <> dsEdit then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI202BeforeEdit(DataSet: TDataSet);
begin
  if selI200.State <> dsEdit then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI202BeforeDelete(DataSet: TDataSet);
begin
  if selI200.State <> dsEdit then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI202BeforePost(DataSet: TDataSet);
var
  LTipo: String;
begin
  // nome del campo obbligatorio (effettuata una trim degli spazi)
  selI202.FieldByName('CAMPO').AsString:=selI202.FieldByName('CAMPO').AsString.Trim;
  if selI202.FieldByName('CAMPO').AsString = '' then
    raise Exception.Create('Indicare il nome del campo!');

  // posizione obbligatoria
  if selI202.FieldByName('DAL').IsNull then
  begin
    LTipo:=IfThen(LeftStr(selI202.FieldByName('CAMPO').AsString,1) = ':','variabile','costante');
    raise Exception.Create(Format('Indicare la posizione del campo %s "%s"',
                                  [LTipo,selI202.FieldByName('CAMPO').AsString]));
  end;
end;

end.
