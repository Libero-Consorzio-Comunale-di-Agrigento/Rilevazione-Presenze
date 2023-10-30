unit A115UDatiLiberiStoricizzatiDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData,
  C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, R004UGestStoricoDtM, Variants,
  (*Midaslib,*) Crtl, DBClient, medpBackupOldValue;

type
  TA115FDatiLiberiStoricizzatiDtM = class(TR004FGestStoricoDtM)
    selI500: TOracleDataSet;
    selI501: TOracleDataSet;
    selaI500: TOracleDataSet;
    scrT430: TOracleQuery;
    OperSQL: TOracleQuery;
    selT430: TOracleDataSet;
    tabT430: TClientDataSet;
    selaT430: TOracleDataSet;
    insSG310: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure RegistraProgressiviVariati;
    procedure RegistraAllineamentiIncarichi(Modifica:String);
    function ControlloAnagrafe:TDateTime;
    procedure selI501AfterOpen(DataSet: TDataSet);
    procedure selI501AfterScroll(DataSet: TDataSet);
    procedure selI501AfterClose(DataSet: TDataSet);
  private
    { Private declarations }
    decSG310:TDateTime;
  public
    { Public declarations }
    bVariazioneDati: boolean;
    selI501OldValues:TmedpBackupOldValue;
    procedure InizializzaDButton;
  end;

var
  A115FDatiLiberiStoricizzatiDtM: TA115FDatiLiberiStoricizzatiDtM;

implementation

uses A115UDatiLiberiStoricizzati;

{$R *.DFM}

procedure TA115FDatiLiberiStoricizzatiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A115FDatiLiberiStoricizzati.InterfacciaR004;
  InizializzaDataSet(selI501,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  A115FDatiLiberiStoricizzati.DButton.DataSet:=selI501;
  selI501OldValues:=TmedpBackupOldValue.Create(Self,selI501);

  //Creazione tabella contenente progressivi da allineare
  tabT430.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
  tabT430.IndexDefs.Clear;
  tabT430.IndexDefs.Add('Primario',('PROGRESSIVO'),[ixUnique]);
  tabT430.IndexName:='Primario';
  tabT430.CreateDataSet;
  tabT430.LogChanges:=False;
  tabT430.EmptyDataSet;
end;

procedure TA115FDatiLiberiStoricizzatiDtM.InizializzaDButton;
begin
  InizializzaDataSet(selI501,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
end;

procedure TA115FDatiLiberiStoricizzatiDtM.BeforePost(DataSet: TDataSet);
begin
  if InterfacciaR004.AllineaSoloDecorrenzeIntersecanti and selI501.FieldByName('DECORRENZA_FINE').IsNull then
    selI501.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(3999,12,31);
  if (selI501.State = dsEdit) or (InterfacciaR004.StoricizzazioneInCorso) then
  begin
    if selI501OldValues.FieldByName('DECORRENZA').Value <> selI501.FieldByName('DECORRENZA').Value then
    begin
      //Controllo che la data di decorrenza non sia superiore alla decorrenza minima dei movimenti
      //storici dell'anagrafico collegato al dato variato
      if not(ControlloAnagrafe = 0) then
        if selI501.FieldByName('DECORRENZA').AsDateTime > ControlloAnagrafe then
          raise Exception.Create('Esiste almeno un movimento storico associato al dato con decorrenza precedente a quella impostata: impossibile procedere con la modifica!');
      //Se cambia la decorrenza e quindi esiste nuova storicizzazione ricerco i progressivi dei
      //dipendenti assegnati al codice variato
      RegistraProgressiviVariati;
      bVariazioneDati:=True;
    end;
  end;
  inherited;
  //Registro gli eventuali allineamenti incarichi
  if (A115FDatiLiberiStoricizzati.TabelleDatiStorici[A115FDatiLiberiStoricizzati.tbcMain.TabIndex].NomeCampo = Parametri.CampiRiferimento.C20_IncaricoUnitaOrg) then
  begin
    decSG310:=selI501.FieldByName('DECORRENZA').AsDateTime;
    if InterfacciaR004.StoricizzazioneInCorso then //Creazione decorrenza
      RegistraAllineamentiIncarichi('I');
  end;
end;

procedure TA115FDatiLiberiStoricizzatiDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A115FDatiLiberiStoricizzati.bStoricizza:=False;
  //Registro gli eventuali allineamenti incarichi
  if (A115FDatiLiberiStoricizzati.TabelleDatiStorici[A115FDatiLiberiStoricizzati.tbcMain.TabIndex].NomeCampo = Parametri.CampiRiferimento.C20_IncaricoUnitaOrg) then
  begin
    if not InterfacciaR004.StoricizzazioneInCorso and StoricoOttimizzato then  //Appiattimento decorrenza
    begin
      RegistraAllineamentiIncarichi('C');
      SessioneOracle.Commit;
    end;
  end;
end;

procedure TA115FDatiLiberiStoricizzatiDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  //Controllare che il codice che si cancella non abbia una corrispondenza in anagrafico
  //valido con questa data decorrenza
  if not (ControlloAnagrafe = 0) then
    raise Exception.Create('Esiste almeno un movimento storico associato al dato: impossibile procedere con la cancellazione!');
  //Se la cancellazione non è attivata dalla storicizzazione
  if not A115FDatiLiberiStoricizzati.bStoricizza then
  begin
    //Registro progressivi dei dipendenti che contengono il dato cancellato per allineare i periodi storici
    RegistraProgressiviVariati;
  end;
  bVariazioneDati:=True;
  //Registro gli eventuali allineamenti incarichi
  if (A115FDatiLiberiStoricizzati.TabelleDatiStorici[A115FDatiLiberiStoricizzati.tbcMain.TabIndex].NomeCampo = Parametri.CampiRiferimento.C20_IncaricoUnitaOrg) then
  begin
    decSG310:=selI501.FieldByName('DECORRENZA').AsDateTime;
    RegistraAllineamentiIncarichi('C');
  end;
end;

procedure TA115FDatiLiberiStoricizzatiDtM.RegistraProgressiviVariati;
//Inserimento progressivi dei dipendenti che contengono i dati interessati dalle modifiche
begin
  with A115FDatiLiberiStoricizzati do
  begin
    //Se la variazione riguarda sempre lo stesso dato non ricerco più le anagrafiche
    if (selaT430.GetVariable('NomeCampo') = TabelleDatiStorici[tbcMain.TabIndex].NomeCampo) and
      (selaT430.GetVariable('Codice') = selI501.FieldByName('CODICE').AsString) then
      exit;
    selaT430.SetVariable('NomeCampo',TabelleDatiStorici[tbcMain.TabIndex].NomeCampo);
    selaT430.SetVariable('Codice',selI501.FieldByName('CODICE').AsString);
    selaT430.Close;
    selaT430.Open;
    while not selaT430.Eof do
    begin
      if not tabT430.Locate('PROGRESSIVO',selaT430.FieldByName('PROGRESSIVO').AsInteger,[]) then
      begin
        tabT430.Insert;
        tabT430.FieldByName('PROGRESSIVO').Value:=selaT430.FieldByName('PROGRESSIVO').AsInteger;
        tabT430.Post;
      end;
      selaT430.Next;
    end;
  end;
end;

procedure TA115FDatiLiberiStoricizzatiDtM.RegistraAllineamentiIncarichi(Modifica:String);
begin
  //Se la variazione riguarda codici per i quali sono presenti incarichi, registro la variazione stessa sulla tabella degli allineamenti
  OperSQL.SQL.Clear;
  OperSQL.SQL.Text:='SELECT COUNT(*) FROM SG302_INCAZIENDALI SG302 WHERE COD_UNITAORG = ''' + selI501.FieldByName('CODICE').AsString + '''';
  OperSQL.Execute;
  if (OperSQL.RowCount > 0) and (StrToIntDef(VarToStr(OperSQL.Field(0)),0) > 0) then
  begin
    insSG310.SetVariable('OPERATORE',Parametri.Operatore);
    insSG310.SetVariable('DATA_VARIAZIONE',Now);
    insSG310.SetVariable('COD_UNITAORG',selI501.FieldByName('CODICE').AsString);
    insSG310.SetVariable('DECORRENZA',decSG310);
    insSG310.SetVariable('FLAG_MODIFICA',Modifica);
    insSG310.SetVariable('STATO','D');
    insSG310.Execute;
  end;
end;

function TA115FDatiLiberiStoricizzatiDtM.ControlloAnagrafe:TDateTime;
//Estraggo da T430_STORICO la decorrenza minima del dipendente collegato con il dato tabellare
//e relativa decorrenza. Se esiste , il dato non può essere cancellato e la decorrenza non può
//essere superiore alla minima decorrenza anagrafica.
begin
  if A115FDatiLiberiStoricizzati.bStoricizza then
    Result:=0
  else
  begin
    selT430.Close;
    with A115FDatiLiberiStoricizzati do
    begin
      selT430.SetVariable('NomeCampo',TabelleDatiStorici[tbcMain.TabIndex].NomeCampo);
      selT430.SetVariable('Codice',selI501.FieldByName('CODICE').AsString);
      selT430.SetVariable('Decorrenza',selI501OldValues.FieldByName('DECORRENZA').Value);
      selT430.SetVariable('NomeTabella',TabelleDatiStorici[tbcMain.TabIndex].NomeTabelle);
      selT430.Open;
      Result:=selT430.FieldByName('DATA_MIN').AsDateTime;
    end;
  end;
end;

procedure TA115FDatiLiberiStoricizzatiDtM.selI501AfterClose(DataSet: TDataSet);
begin
  selI501OldValues.Reimposta;
end;

procedure TA115FDatiLiberiStoricizzatiDtM.selI501AfterOpen(
  DataSet: TDataSet);
var
  i: Integer;
begin
  if DataSet.FindField('DEBITOGGQM') <> nil then
    TStringField(DataSet.FieldByName('DEBITOGGQM')).EditMask:='!90:00;1;_';
  if DataSet.FindField('DECORRENZA_FINE') <> nil then
    DataSet.FieldByName('DECORRENZA_FINE').Visible:=False;

  // gestione scadenza.ini
  with A115FDatiLiberiStoricizzati do
  for i:=0 to selI501.Fields.Count - 1 do
  begin
    selI501.Fields[i].Visible:=((TabelleDatiStorici[tbcMain.TabIndex].Scadenza = 'S') and // gestione scadenza
                                (selI501.Fields[i].FieldName = 'DECORRENZA_FINE')) or
                               (selI501.Fields[i].FieldName = 'CODICE') or
                               (selI501.Fields[i].FieldName = 'DESCRIZIONE') or
                               (selI501.Fields[i].FieldName = 'DECORRENZA');

    if TabelleDatiStorici[tbcMain.TabIndex].NomeTabelle.ToUpper = 'I501' + Parametri.CampiRiferimento.C29_ChiamateRepFiltro1.ToUpper then
    begin
      selI501.Fields[i].Visible:=selI501.Fields[i].Visible or R180In(selI501.Fields[i].FieldName,['TELEFONO','EMAIL']);
    end;
  end;
  // editmask per decorrenza
  try
    TDateTimeField(DataSet.FieldByName('DECORRENZA')).DisplayFormat:='dd/mm/yyyy';
    DataSet.FieldByName('DECORRENZA').EditMask:='!00/00/0000;1;_';
    DataSet.FieldByName('DECORRENZA_FINE').EditMask:='!00/00/0000;1;_'; // gestione scadenza
  except
  end;
  // gestione scadenza.fine

  selI501OldValues.CreaStruttura;
end;

procedure TA115FDatiLiberiStoricizzatiDtM.selI501AfterScroll(DataSet: TDataSet);
begin
  selI501OldValues.Aggiorna;
end;

end.
