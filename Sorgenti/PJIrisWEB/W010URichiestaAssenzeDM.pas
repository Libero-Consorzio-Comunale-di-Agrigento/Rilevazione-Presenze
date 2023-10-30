unit W010URichiestaAssenzeDM;

interface

uses
  A000USessione, A000UInterfaccia, A000UMessaggi, C018UIterAutDM, W000UMessaggi,
  SysUtils, Classes, DB, Oracle, OracleData, Variants, StrUtils;

type
  TW010FRichiestaAssenzeDM = class(TDataModule)
    selT050: TOracleDataSet;
    selT050ID: TFloatField;
    selT050ID_REVOCA: TFloatField;
    selT050ID_REVOCATO: TFloatField;
    selT050PROGRESSIVO: TIntegerField;
    selT050DAL: TDateTimeField;
    selT050AL: TDateTimeField;
    selT050CAUSALE: TStringField;
    selT050TIPOGIUST: TStringField;
    selT050NUMEROORE: TStringField;
    selT050AORE: TStringField;
    selT050AUTORIZZAZIONE: TStringField;
    selT050DATANAS: TDateTimeField;
    selT050MATRICOLA: TStringField;
    selT050SESSO: TStringField;
    selT050DATA_RICHIESTA: TDateTimeField;
    selT050DATA_AUTORIZZAZIONE: TDateTimeField;
    selT050ELABORATO: TStringField;
    selT050NOMINATIVO: TStringField;
    selT050TIPO_RICHIESTA: TStringField;
    selT050AUTORIZZ_PREV: TStringField;
    selT050NUMEROORE_PREV: TStringField;
    selT050AORE_PREV: TStringField;
    selT050AUTORIZZ_UTILE: TStringField;
    selT050NOMINATIVO_RESP: TStringField;
    selT050AUTORIZZ_REVOCA: TStringField;
    selT050D_CAUSALE: TStringField;
    selT050D_CAUSALE_2: TStringField;
    selT050D_TIPOGIUST: TStringField;
    selT050D_DAORE_AORE: TStringField;
    selT050D_RESPONSABILE: TStringField;
    selT050D_TIPO_RICHIESTA: TStringField;
    selT050D_ELABORATO: TStringField;
    selT050D_DAORE_AORE_PREV: TStringField;
    selT050AUTORIZZ_AUTOMATICA: TStringField;
    selT050COD_ITER: TStringField;
    selT050AUTORIZZ_AUTOM_PREV: TStringField;
    selT050RESPONSABILE_PREV: TStringField;
    selT050LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT050REVOCABILE: TStringField;
    selT050D_AUTORIZZAZIONE: TStringField;
    selT050D_VISTI_PREC: TStringField;
    selT050D_AVVERTIMENTI: TStringField;
    selCancInt: TOracleDataSet;
    selT050D_CARTELLINO: TStringField;
    selT106: TOracleDataSet;
    selT050MOTIVAZIONE: TStringField;
    selT050MSGAUT_SI: TStringField;
    selT050MSGAUT_NO: TStringField;
    selT265_T275: TOracleDataSet;
    selT050NOTE_GIUSTIFICATIVO: TStringField;
    selT050D_TIPO_CAUSALE: TStringField;
    selT106Lookup: TOracleDataSet;
    selT050D_MOTIVAZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT050CalcFields(DataSet: TDataSet);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
  public
    // MONDOEDP - commessa MAN/09 SVILUPPO#1.ini
    // dati da valorizzare esternamente
    C018DM: TC018FIterAutDM;
    Causale, Allegato, CondizAllegato: String;
    // MONDOEDP - commessa MAN/09 SVILUPPO#1.fine
  end;

implementation

{$R *.dfm}

// MONDOEDP - commessa MAN/09 SVILUPPO#1.ini
// non includere unit web
//uses W010URichiestaAssenze;
// MONDOEDP - commessa MAN/09 SVILUPPO#1.fine

procedure TW010FRichiestaAssenzeDM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;

  // dataset di supporto per lookup
  selT265_T275.Open;
  selT106Lookup.Open;
end;

procedure TW010FRichiestaAssenzeDM.selT050CalcFields(DataSet: TDataSet);
var
  DescCaus,TipoGius,Orario,Aut,DescResp,TipoRichiesta,DescTipoRichiesta: String;
begin
  // D_TIPO_RICHIESTA: descrizione tipo richiesta
  TipoRichiesta:=selT050.FieldByName('TIPO_RICHIESTA').AsString;
  if TipoRichiesta = 'P' then
    DescTipoRichiesta:=A000TraduzioneStringhe(A000MSG_R013_MSG_TIPORICH_PREVENTIVA)
  else if TipoRichiesta = 'D' then
    DescTipoRichiesta:=A000TraduzioneStringhe(A000MSG_R013_MSG_TIPORICH_DEFINITIVA)
  else if TipoRichiesta = 'R' then
    DescTipoRichiesta:=A000TraduzioneStringhe(A000MSG_R013_MSG_TIPORICH_REVOCA)
  // empoli - commessa 2012/102.ini
  else if TipoRichiesta = 'C' then
    DescTipoRichiesta:=A000TraduzioneStringhe(A000MSG_R013_MSG_TIPORICH_CANCELLAZIONE);
  // empoli - commessa 2012/102.fine

  // diciture per legenda
  if not selT050.FieldByName('ID_REVOCA').IsNull then
  begin
    if selT050.FieldByName('ID_REVOCA').AsInteger > 0 then
      DescTipoRichiesta:=DescTipoRichiesta + '(1)'
    else
      DescTipoRichiesta:=DescTipoRichiesta + '(3)'
  end;
  if (TipoRichiesta = 'P') and (selT050.FieldByName('AUTORIZZ_UTILE').AsString = 'N') then
    DescTipoRichiesta:=DescTipoRichiesta + '(2)';
  selT050.FieldByName('D_TIPO_RICHIESTA').AsString:=DescTipoRichiesta;

  // D_CAUSALE: descrizione causale
  // D_CAUSALE_2: codice + descrizione causale
  // MONDOEDP - commessa MAN/09 SVILUPPO#1.ini
  DescCaus:=VarToStr(selT265_T275.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'DESCRIZIONE'));
  selT050.FieldByName('D_CAUSALE').AsString:=DescCaus;
  selT050.FieldByName('D_CAUSALE_2').AsString:=selT050.FieldByName('CAUSALE').AsString;
  if DescCaus <> '' then
    selT050.FieldByName('D_CAUSALE_2').AsString:=selT050.FieldByName('D_CAUSALE_2').AsString + ' - ' + DescCaus;

  // D_TIPO_CAUSALE: tipo causale
  // - A = assenza
  // - P = presenza
  selT050.FieldByName('D_TIPO_CAUSALE').AsString:=VarToStr(selT265_T275.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'TIPO_CAUSALE'));

  // D_TIPOGIUST: descrizione tipo giustificativo
  TipoGius:=selT050.FieldByName('TIPOGIUST').AsString;
  if TipoGius = 'I' then
    selT050.FieldByName('D_TIPOGIUST').AsString:=A000TraduzioneStringhe('Giornate')
  else if TipoGius = 'M' then
    selT050.FieldByName('D_TIPOGIUST').AsString:=A000TraduzioneStringhe('Mezze giorn.') + IfThen(not selT050.FieldByName('NOTE_GIUSTIFICATIVO').IsNull,Format(' [%s]',[selT050.FieldByName('NOTE_GIUSTIFICATIVO').AsString]))
  else if TipoGius = 'N' then
   selT050. FieldByName('D_TIPOGIUST').AsString:=A000TraduzioneStringhe('Numero Ore')
  else if TipoGius = 'D' then
    selT050.FieldByName('D_TIPOGIUST').AsString:=A000TraduzioneStringhe('Da ore/A ore');

  // D_DAORE_AORE: descrizione daore - a ore
  Orario:=selT050.FieldByName('NUMEROORE').AsString;
  if selT050.FieldByName('AORE').AsString <> '' then
    Orario:=Orario + ' - ' + selT050.FieldByName('AORE').AsString;
  selT050.FieldByName('D_DAORE_AORE').AsString:=Orario;

  // D_DAORE_AORE_PREV: descrizione daore - a ore rif. richiesta preventiva
  //                    visualizzato solo se differente da rich. definitiva
  if (TipoRichiesta = 'R') or
     ((selT050.FieldByName('NUMEROORE').Value = selT050.FieldByName('NUMEROORE_PREV').Value) and
      (selT050.FieldByName('AORE').Value =  selT050.FieldByName('AORE_PREV').Value)) then
    Orario:=''
  else
  begin
    Orario:=selT050.FieldByName('NUMEROORE_PREV').AsString;
    if selT050.FieldByName('AORE_PREV').AsString <> '' then
      Orario:=Orario + ' - ' + selT050.FieldByName('AORE_PREV').AsString;
  end;
  selT050.FieldByName('D_DAORE_AORE_PREV').AsString:=Orario;

  // D_AUTORIZZAZIONE: descr. autorizzazione
  if selT050.FieldByName('AUTORIZZ_UTILE').AsString = '' then
    Aut:=''
  else if selT050.FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
    Aut:=A000TraduzioneStringhe(A000MSG_MSG_NO)
  else
    Aut:=A000TraduzioneStringhe(A000MSG_MSG_SI);
  selT050.FieldByName('D_AUTORIZZAZIONE').AsString:=Aut;

  // D_ELABORATO: stato elaborazione
  if selT050.FieldByName('ELABORATO').AsString = 'S' then
    selT050.FieldByName('D_ELABORATO').AsString:='OK'
  else if selT050.FieldByName('ELABORATO').AsString = 'E' then
    selT050.FieldByName('D_ELABORATO').AsString:='Err'
  else
    selT050.FieldByName('D_ELABORATO').AsString:='';

  // D_RESPONSABILE: nominativo reale del responsabile oppure nome utente
  // visualizza responsabile solo se c'è un'autorizzazione utile
  if Aut = '' then
    DescResp:=''
  else
    DescResp:=selT050.FieldByName('NOMINATIVO_RESP').AsString;
  selT050.FieldByName('D_RESPONSABILE').AsString:=DescResp;
end;

procedure TW010FRichiestaAssenzeDM.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
var
  Tipo: String;
begin
  // MONDOEDP - commessa MAN/09 SVILUPPO#1.ini
  //Tipo:=IfThen(VarIsNull(WR000DM.selT275.Lookup('CODICE',DataSet.FieldByName('CAUSALE').AsString,'CODICE')),'CAUSALI ASSENZA','CAUSALI PRESENZA');
  Tipo:=IfThen(VarToStr(selT265_T275.Lookup('CODICE',DataSet.FieldByName('CAUSALE').AsString,'TIPO_CAUSALE')) = 'A','CAUSALI ASSENZA','CAUSALI PRESENZA');
  // MONDOEDP - commessa MAN/09 SVILUPPO#1.fine

  Accept:=A000FiltroDizionario(Tipo,DataSet.FieldByName('CAUSALE').AsString);

  // MONDOEDP - commessa MAN/09 SVILUPPO#1.ini
  //if WR000DM.Responsabile then
  if C018DM.Responsabile then
  // MONDOEDP - commessa MAN/09 SVILUPPO#1.fine
  begin
    //empoli

    // MONDOEDP - commessa MAN/09 SVILUPPO#1.ini
    // evita l'include della form web
    {
    if (Self.Owner is TW010FRichiestaAssenze) and
       ((Self.Owner as TW010FRichiestaAssenze).C018.TipoRichiesteSel = [trDaAutorizzare]) then
    begin
      Accept:=Accept and (Dataset.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0);
    end;
    }
    if C018DM.TipoRichiesteSel = [trDaAutorizzare] then
    begin
      if Parametri.CampiRiferimento.C90_W010AcquisizioneAuto = 'S' then
        Accept:=Accept and (Dataset.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger <> 0)
      else
        Accept:=Accept and (Dataset.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0);
    end;
    // MONDOEDP - commessa MAN/09 SVILUPPO#1.fine

    // SGIULIANOMILANESE_COMUNE - chiamata <80446>.ini
    // esclude le richieste (preventive / definitive) che sarebbero da autorizzare al proprio livello,
    // ma per cui esiste già una revoca pendente
    // in questo modo si tenta di escludere dalla visualizzazione delle richieste da autorizzare
    // quelle che non sono state autorizzate al proprio livello, ma già revocate dal dipendente
    // perché autorizzate a livelli precedenti dal proprio
    // es.
    //   Proprio livello = 2
    //   DIP:    richiesta effettuata
    //   AUT L1: autorizzazione concessa al livello 1
    //   DIP:    richiesta revocata
    //   AUT L2:
    if Dataset.FieldByName('TIPO_RICHIESTA').AsString <> 'R' then
    begin
      // *esclude* le richieste non ancora considerate al proprio livello
      // ma che hanno una revoca in corso (autorizzata o in fase di autorizzazione)
      Accept:=Accept and
              not ((Dataset.FieldByName('DATA_AUTORIZZAZIONE').IsNull) and        // richieste non considerate al proprio livello di autorizzazione
                   (not Dataset.FieldByName('ID_REVOCA').IsNull) and              // revoca pendente...
                   (Dataset.FieldByName('AUTORIZZ_REVOCA').AsString <> C018NO));  // .... autorizzata o in fase di autorizzazione
    end;
    // SGIULIANOMILANESE_COMUNE - chiamata <80446>.fine
  end;
  if Causale <> '' then
    Accept:=Accept and (DataSet.FieldByName('CAUSALE').AsString = Causale);
end;

end.
