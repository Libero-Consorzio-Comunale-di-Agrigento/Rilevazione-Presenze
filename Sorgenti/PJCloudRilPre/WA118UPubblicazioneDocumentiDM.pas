unit WA118UPubblicazioneDocumentiDM;

interface

uses
  A000UCostanti,
  A118UPubblicazioneDocumentiMW,
  C180FunzioniGenerali,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, Oracle, System.Math, System.StrUtils;

type
  TWA118FPubblicazioneDocumentiDM = class(TWR303FGestMasterDetailDM)
    selI201: TOracleDataSet;
    selI202: TOracleDataSet;
    selI202CODICE: TStringField;
    selI202LIVELLO: TIntegerField;
    selI202CAMPO: TStringField;
    selI202DAL: TIntegerField;
    selI202LUNG: TIntegerField;
    selI202VISIBILE: TStringField;
    dsrI201: TDataSource;
    dsrI202: TDataSource;
    selT962Lookup: TOracleDataSet;
    dsrT962Lookup: TDataSource;
    selI201CODICE: TStringField;
    selI201LIVELLO: TIntegerField;
    selI201NOME: TStringField;
    selI201EXT: TStringField;
    selI201SEPARATORE: TStringField;
    selI201FILTRO: TStringField;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaFILTRO: TStringField;
    selTabellaROOT: TStringField;
    selTabellaTIPOLOGIA_DOCUMENTI: TStringField;
    selTabellaSORGENTE_DOCUMENTI: TStringField;
    selTabellaURL_WS: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure AfterPost(DateSet: TDataSet); override;
    procedure selI201AfterPost(DataSet: TDataSet);
    procedure selI201AfterScroll(DataSet: TDataSet);
    procedure selI201BeforeDelete(DataSet: TDataSet);
    procedure selI201BeforeEdit(DataSet: TDataSet);
    procedure selI201BeforeInsert(DataSet: TDataSet);
    procedure selI201BeforePost(DataSet: TDataSet);
    procedure selI201NewRecord(DataSet: TDataSet);
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure dsrTabellaDataChange(Sender: TObject; Field: TField);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selI202BeforePost(DataSet: TDataSet);
    procedure selI202NewRecord(DataSet: TDataSet);
    procedure AfterCancel(DataSet: TDataSet); override;
  private
    FOperazione: String;
    FSorg: String;
    FOperazioneI201: String;
    function  CheckFiltroLivello(const PFiltro: String): TResCtrl;
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    A118MW: TA118FPubblicazioneDocumentiMW;
    MaxLiv: Integer;
    MaxPos: Integer;
  end;

implementation

uses
  WA118UPubblicazioneDocumenti,
  WA118UPubblicazioneDocumentiDettFM,
  WA118ULivelliFM,
  WR205UDettTabellaFM;

{$R *.dfm}

{ TWA118FPubblicazioneDocumentiDM }

procedure TWA118FPubblicazioneDocumentiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  selI201.SetVariable('ORDERBY','ORDER BY LIVELLO');

  inherited;

  A118MW:=TA118FPubblicazioneDocumentiMW.Create(nil);

  selT962Lookup.Open;
  selI201.Open;
  SetTabelleRelazionate([selTabella,selI201]);
end;

procedure TWA118FPubblicazioneDocumentiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A118MW);
  inherited;
end;

procedure TWA118FPubblicazioneDocumentiDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  FOperazione:='';
end;

procedure TWA118FPubblicazioneDocumentiDM.AfterPost(DateSet: TDataSet);
begin
  // operazioni nel caso di documenti su cartella esterna
  if FSorg = SORGENTE_FS_EXT then
  begin
    // dopo l'inserimento di un nuovo tipo di documento
    // inserisce automaticamente un livello
    if FOperazione = 'I' then
    begin
      selI201.Append;
      selI201.FieldByName('NOME').AsString:='nome cartella';
      selI201.Post;
    end;
    //***if selI201.UpdatesPending or selI202.UpdatesPending then
    //***  SessioneOracle.ApplyUpdates([selI201,selI202],True);
  end;

  inherited;

  //***
  // porta in edit il dataset dei livelli
  // operazioni nel caso di documenti su cartella esterna
  {
  if FSorg = SORGENTE_FS_EXT then
  begin
    if FOperazione = 'I' then
      //***selI201.Edit;
  end;
  }

  // annulla dati
  FOperazione:='';
end;

procedure TWA118FPubblicazioneDocumentiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;

  // apre il dataset dei campi
  selI202.Close;
  selI202.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
  selI202.Open;

  // apre dataset dei livelli
  selI201.DisableControls;
  selI201.AfterScroll:=nil;
  selI201.Close;
  selI201.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
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

  TWA118FPubblicazioneDocumenti(Self.Owner).OnI200AfterScroll;

  // ricarica grid
end;

procedure TWA118FPubblicazioneDocumentiDM.BeforePostNoStorico(DataSet: TDataSet);
var
  LFiltro: String;
  LResCtrl: TResCtrl;
begin
  inherited;

  // correttezza filtro visualizzazione
  LFiltro:=selTabella.FieldByName('FILTRO').AsString.Trim;
  selTabella.FieldByName('FILTRO').AsString:=LFiltro;
  if LFiltro <> '' then
  begin
    LResCtrl:=A118MW.CheckFiltroDocumenti(LFiltro);
    if (not LResCtrl.Ok) and (LResCtrl.Messaggio <> '') then
      raise Exception.CreateFmt('Il filtro di visualizzazione documenti non è corretto:'#13#10'%s',[LResCtrl.Messaggio]);
  end;

  FSorg:=selTabella.FieldByName('SORGENTE_DOCUMENTI').AsString;
  if FSorg = SORGENTE_FS_EXT then
  begin
    // sorgente documenti: cartella esterna

    // verifica esistenza directory base per documenti se specificata
    // prima del controllo effettua trim
    selTabella.FieldByName('ROOT').AsString:=Trim(selTabella.FieldByName('ROOT').AsString);
    if not selTabella.FieldByName('ROOT').IsNull then
    begin
      if not TDirectory.Exists(selTabella.FieldByName('ROOT').AsString) then
        raise Exception.Create('La directory base per i documenti è inesistente oppure non accessibile');
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
  else if FSorg = SORGENTE_T960 then
  begin
    // sorgente documenti: modulo documentale

    // la tipologia documenti deve essere selezionata
    if (selTabella.FieldByName('TIPOLOGIA_DOCUMENTI').AsString = '') then
      raise Exception.Create('E'' necessario selezionare la tipologia di documenti!');
  end
  else if R180In(FSorg,[SORGENTE_WS_ENGI_CU,SORGENTE_WS_ENGI_CEDOL]) then
  begin
    // sorgente documenti: webservice engineering

    // l'URL del webservice deve essere indicato
    selTabella.FieldByName('URL_WS').AsString:=selTabella.FieldByName('URL_WS').AsString.Trim;
    if selTabella.FieldByName('URL_WS').AsString = '' then
      raise Exception.Create('E'' necessario indicare l''URL del webservice da invocare!');
  end;

  case DataSet.State of
    dsInsert: FOperazione:='I';
    dsEdit:   FOperazione:='M';
  end;
end;

function TWA118FPubblicazioneDocumentiDM.CheckFiltroLivello(const PFiltro: String): TResCtrl;
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

procedure TWA118FPubblicazioneDocumentiDM.dsrTabellaDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  //
end;

procedure TWA118FPubblicazioneDocumentiDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;

  //
end;

procedure TWA118FPubblicazioneDocumentiDM.RelazionaTabelleFiglie;
begin
  // apre il dataset dei campi
  selI202.Close;
  selI202.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
  selI202.Open;

  // apre il dataset dei livelli
  selI201.Close;
  selI201.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
  selI201.Open;
end;

procedure TWA118FPubblicazioneDocumentiDM.selI201AfterPost(DataSet: TDataSet);
begin
  if FOperazioneI201 = 'I' then
  begin
    if selI201.FieldByName('LIVELLO').AsInteger > MaxLiv then
      MaxLiv:=selI201.FieldByName('LIVELLO').AsInteger;
  end;
  FOperazioneI201:='';
end;

procedure TWA118FPubblicazioneDocumentiDM.selI201AfterScroll(DataSet: TDataSet);
var
  LLiv: Integer;
begin
  LLiv:=selI201.FieldByName('LIVELLO').AsInteger;

  //selI202.DisableControls;

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

  TWA118FPubblicazioneDocumenti(Self.Owner).OnI201AfterScroll;
end;

procedure TWA118FPubblicazioneDocumentiDM.selI201BeforeDelete(DataSet: TDataSet);
var
  LLiv: Integer;
begin
  if selTabella.State <> dsEdit then
    Abort;

  // controllo livello
  LLiv:=selI201.FieldByName('LIVELLO').AsInteger;
  if LLiv <> MaxLiv then
    raise Exception.Create('E'' possibile eliminare solo l''ultimo livello!')
  else if LLiv = 0 then
    raise Exception.Create('Non è possibile eliminare l''unico livello definito!');

  // conferma se sono presenti dettagli
  //if selI202.RecordCount > 0 then
  //  if R180MessageBox('Il livello ' + IntToStr(LLiv) + ' contiene delle righe di dettaglio.' + CRLF +
  //                    'Confermi la cancellazione?',DOMANDA) = mrNo then
  //    Abort;
end;

procedure TWA118FPubblicazioneDocumentiDM.selI201BeforeEdit(DataSet: TDataSet);
begin
  //if selTabella.State <> dsEdit then
  // Abort;
end;

procedure TWA118FPubblicazioneDocumentiDM.selI201BeforeInsert(DataSet: TDataSet);
begin
  //if (FOperazione <> 'I') and (selTabella.State <> dsEdit) then
  //  Abort;
end;

procedure TWA118FPubblicazioneDocumentiDM.selI201BeforePost(DataSet: TDataSet);
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
  //if Pos(' ',selI201.FieldByName('SEPARATORE').AsString) > 0 then
  //  if R180MessageBox('Attenzione! Nel campo separatore' + CRLF +
  //                    'è stato inserito il carattere SPAZIO.' + CRLF +
  //                    'Se possibile si raccomanda di sostituirlo' + CRLF +
  //                    'con un altro carattere maggiormente visibile,' + CRLF +
  //                    'quale l''underscore "_".' + CRLF +
  //                    'Vuoi continuare?',DOMANDA) = mrNo then
  //    Abort;

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

procedure TWA118FPubblicazioneDocumentiDM.selI201NewRecord(DataSet: TDataSet);
begin
  selI201.FieldByName('CODICE').AsString:=selTabella.FieldByName('CODICE').AsString;
  selI201.FieldByName('LIVELLO').AsInteger:=MaxLiv + 1;
end;

procedure TWA118FPubblicazioneDocumentiDM.selI202BeforePost(DataSet: TDataSet);
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

procedure TWA118FPubblicazioneDocumentiDM.selI202NewRecord(DataSet: TDataSet);
begin
  selI202.FieldByName('CODICE').AsString:=selI201.FieldByName('CODICE').AsString;
  selI202.FieldByName('LIVELLO').AsInteger:=selI201.FieldByName('LIVELLO').AsInteger;
  if MaxPos <> -1 then
    selI202.FieldByName('DAL').AsInteger:=MaxPos + 1;
  selI202.FieldByName('VISIBILE').AsString:='N';
end;

end.
