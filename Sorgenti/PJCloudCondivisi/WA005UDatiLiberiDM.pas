unit WA005UDatiLiberiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, C180FunzioniGenerali,
  medpIWMessageDlg,A000UMessaggi, medpBackupOldValue;

type
  TWA005FDatiLiberiDM = class(TWR302FGestTabellaDM)
    selI500: TOracleDataSet;
    scrT430: TOracleQuery;
    OperSQL: TOracleQuery;
    selaI500: TOracleDataSet;
    tabT430: TClientDataSet;
    selT430: TOracleDataSet;
    selaT430: TOracleDataSet;
    insSG310: TOracleQuery;
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
  private
    { Private declarations }
    decSG310:TDateTime;
    function ControlloAnagrafe:TDateTime;
    procedure RegistraProgressiviVariati;
    procedure RegistraAllineamentiIncarichi(Modifica: String);
  public
    bVariazioneDati: boolean;
    selI501OldValues:TmedpBackupOldValue;
  end;

implementation

uses WA005UDatiLiberi, WR100UBase;

{$R *.dfm}

procedure TWA005FDatiLiberiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  //Creazione tabella contenente progressivi da allineare
  tabT430.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
  tabT430.IndexDefs.Clear;
  tabT430.IndexDefs.Add('Primario',('PROGRESSIVO'),[ixUnique]);
  tabT430.IndexName:='Primario';
  tabT430.CreateDataSet;
  tabT430.LogChanges:=False;
  tabT430.EmptyDataSet;
  selI501OldValues:=TmedpBackupOldValue.Create(Self,selTabella);
end;

procedure TWA005FDatiLiberiDM.selTabellaAfterOpen(DataSet: TDataSet);
var
  i: Integer;
begin
  selI501OldValues.CreaStruttura;
  with TWA005FDatiLiberi(Self.Owner) do
  begin
    for i:=0 to selTabella.Fields.Count - 1 do
    begin
      if selTabella.Fields[i].FieldName = 'CODICE' then
      begin
        selTabella.Fields[i].DisplayLabel:='Codice';
        selTabella.Fields[i].Index:=0;
      end
      else if selTabella.Fields[i].FieldName = 'DESCRIZIONE' then
      begin
        selTabella.Fields[i].DisplayLabel:='Descrizione';
        if not TabelleDatiStorici[cmbDatoLibero.ItemIndex].Storico then
          selTabella.Fields[i].Index:=1
        else
          selTabella.Fields[i].Index:=3;
      end
      else if selTabella.Fields[i].FieldName = 'DECORRENZA' then
      begin
        selTabella.Fields[i].DisplayLabel:='Decorrenza';
        selTabella.Fields[i].Index:=1;
        selTabella.Fields[i].Alignment:=taCenter;
      end
      else if selTabella.Fields[i].FieldName = 'DECORRENZA_FINE' then
      begin
        selTabella.Fields[i].DisplayLabel:='Scadenza';
        selTabella.Fields[i].Index:=2;
        selTabella.Fields[i].Alignment:=taCenter;
      end
      else
      begin
        selTabella.Fields[i].DisplayLabel:=R180Capitalize(selTabella.Fields[i].FieldName);
      end;
    end;
    //if not TabelleDatiStorici[cmbDatoLibero.ItemIndex].Storico then
    //  exit;
  end;

  if DataSet.FindField('DECORRENZA_FINE') <> nil then
    DataSet.FieldByName('DECORRENZA_FINE').Visible:=False;

  // gestione scadenza.ini
  with TWA005FDatiLiberi(Self.Owner) do
    for i:=0 to selTabella.Fields.Count - 1 do
    begin
      selTabella.Fields[i].Visible:=((TabelleDatiStorici[cmbDatoLibero.ItemIndex].Scadenza = 'S') and // gestione scadenza
                                     (selTabella.Fields[i].FieldName = 'DECORRENZA_FINE')) or
                                    (selTabella.Fields[i].FieldName = 'CODICE') or
                                    (selTabella.Fields[i].FieldName = 'DESCRIZIONE') or
                                    (selTabella.Fields[i].FieldName = 'DECORRENZA');
      //Alberto 13/03/2019 - IMPERIA_ASL1: il dato libero indicato come filtro per Personale reperibile (W028)
      if TabelleDatiStorici[cmbDatoLibero.ItemIndex].NomeTabelle.ToUpper = 'I501' + Parametri.CampiRiferimento.C29_ChiamateRepFiltro1.ToUpper then
      begin
        selTabella.Fields[i].Visible:=selTabella.Fields[i].Visible or R180In(selTabella.Fields[i].FieldName,['TELEFONO','EMAIL']);
      end;
    end;
end;

procedure TWA005FDatiLiberiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  selI501OldValues.Aggiorna;
end;

procedure TWA005FDatiLiberiDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  with TWA005FDatiLiberi(Self.Owner) do
    if not TabelleDatiStorici[cmbDatoLibero.ItemIndex].Storico then
      exit;
  //Controllare che il codice che si cancella non abbia una corrispondenza in anagrafico
  //valido con questa data decorrenza
  if ControlloAnagrafe <> 0 then
    raise Exception.Create(A000MSG_ERR_CANC_ESISTE_MOV_STORICO);
  //Se la cancellazione non è attivata dalla storicizzazione
  if not TWA005FDatiLiberi(Self.Owner).bStoricizza then
    //Registro progressivi dei dipendenti che contengono il dato cancellato per allineare i periodi storici
    RegistraProgressiviVariati;
  bVariazioneDati:=True;
  //Registro gli eventuali allineamenti incarichi
  if (TWA005FDatiLiberi(Self.Owner).TabelleDatiStorici[TWA005FDatiLiberi(Self.Owner).cmbDatoLibero.ItemIndex].NomeCampo = Parametri.CampiRiferimento.C20_IncaricoUnitaOrg) then
  begin
    decSG310:=selTabella.FieldByName('DECORRENZA').AsDateTime;
    RegistraAllineamentiIncarichi('C');
  end;
end;

function TWA005FDatiLiberiDM.ControlloAnagrafe:TDateTime;
//Estraggo da T430_STORICO la decorrenza minima del dipendente collegato con il dato tabellare
//e relativa decorrenza. Se esiste , il dato non può essere cancellato e la decorrenza non può
//essere superiore alla minima decorrenza anagrafica.
begin
  if TWA005FDatiLiberi(Self.Owner).bStoricizza then
    Result:=0
  else
  begin
    selT430.Close;
    with TWA005FDatiLiberi(Self.Owner) do
    begin
      selT430.SetVariable('NomeCampo',TabelleDatiStorici[cmbDatoLibero.ItemIndex].NomeCampo);
      selT430.SetVariable('Codice',selTabella.FieldByName('CODICE').AsString);
      selT430.SetVariable('Decorrenza',selI501OldValues.FieldByName('DECORRENZA').Value);
      selT430.SetVariable('NomeTabella',TabelleDatiStorici[cmbDatoLibero.ItemIndex].NomeTabelle);
      selT430.Open;
      Result:=selT430.FieldByName('DATA_MIN').AsDateTime;
    end;
  end;
end;

procedure TWA005FDatiLiberiDM.RegistraProgressiviVariati;
//Inserimento progressivi dei dipendenti che contengono i dati interessati dalle modifiche
begin
  with TWA005FDatiLiberi(Self.Owner) do
  begin
    //Se la variazione riguarda sempre lo stesso dato non ricerco più le anagrafiche
    if (selaT430.GetVariable('NomeCampo') = TabelleDatiStorici[cmbDatoLibero.ItemIndex].NomeCampo) and
      (selaT430.GetVariable('Codice') = selTabella.FieldByName('CODICE').AsString) then
      exit;
    selaT430.SetVariable('NomeCampo',TabelleDatiStorici[cmbDatoLibero.ItemIndex].NomeCampo);
    selaT430.SetVariable('Codice',selTabella.FieldByName('CODICE').AsString);
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

procedure TWA005FDatiLiberiDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  if InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti and selTabella.FieldByName('DECORRENZA_FINE').IsNull then
    selTabella.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(3999,12,31);
  if (selTabella.State = dsEdit) or (InterfacciaWR102.StoricizzazioneInCorso) then
  begin
    if selI501OldValues.FieldByName('DECORRENZA').Value <> selTabella.FieldByName('DECORRENZA').Value then
    begin
      //Controllo che la data di decorrenza non sia superiore alla decorrenza minima dei movimenti
      //storici dell'anagrafico collegato al dato variato
      if not(ControlloAnagrafe = 0) then
        if selTabella.FieldByName('DECORRENZA').AsDateTime > ControlloAnagrafe then
          raise Exception.Create(A000MSG_ERR_MODIF_ESISTE_MOV_STORICO);
      //Se cambia la decorrenza e quindi esiste nuova storicizzazione ricerco i progressivi dei
      //dipendenti assegnati al codice variato
      RegistraProgressiviVariati;
      bVariazioneDati:=True;
    end;
  end;
  //Registro gli eventuali allineamenti incarichi
  if (TWA005FDatiLiberi(Self.Owner).TabelleDatiStorici[TWA005FDatiLiberi(Self.Owner).cmbDatoLibero.ItemIndex].NomeCampo = Parametri.CampiRiferimento.C20_IncaricoUnitaOrg) then
  begin
    decSG310:=selTabella.FieldByName('DECORRENZA').AsDateTime;
    if InterfacciaWR102.StoricizzazioneInCorso then //Creazione decorrenza
      RegistraAllineamentiIncarichi('I');
  end;
end;

procedure TWA005FDatiLiberiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  TWA005FDatiLiberi(Self.Owner).bStoricizza:=False;
  //Registro gli eventuali allineamenti incarichi
  if (TWA005FDatiLiberi(Self.Owner).TabelleDatiStorici[TWA005FDatiLiberi(Self.Owner).cmbDatoLibero.ItemIndex].NomeCampo = Parametri.CampiRiferimento.C20_IncaricoUnitaOrg) then
  begin
    if not InterfacciaWR102.StoricizzazioneInCorso and StoricoOttimizzato then  //Appiattimento decorrenza
    begin
      RegistraAllineamentiIncarichi('C');
      SessioneOracle.Commit;
    end;
  end;
end;

procedure TWA005FDatiLiberiDM.RegistraAllineamentiIncarichi(Modifica:String);
begin
  //Se la variazione riguarda codici per i quali sono presenti incarichi, registro la variazione stessa sulla tabella degli allineamenti
  OperSQL.SQL.Clear;
  OperSQL.SQL.Text:='SELECT COUNT(*) FROM SG302_INCAZIENDALI SG302 WHERE COD_UNITAORG = ''' + selTabella.FieldByName('CODICE').AsString + '''';
  OperSQL.Execute;
  if (OperSQL.RowCount > 0) and (StrToIntDef(VarToStr(OperSQL.Field(0)),0) > 0) then
  begin
    insSG310.SetVariable('OPERATORE',Parametri.Operatore);
    insSG310.SetVariable('DATA_VARIAZIONE',Now);
    insSG310.SetVariable('COD_UNITAORG',selTabella.FieldByName('CODICE').AsString);
    insSG310.SetVariable('DECORRENZA',decSG310);
    insSG310.SetVariable('FLAG_MODIFICA',Modifica);
    insSG310.SetVariable('STATO','D');
    insSG310.Execute;
  end;
end;


end.
