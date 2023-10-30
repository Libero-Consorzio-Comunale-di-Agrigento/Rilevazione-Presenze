unit A177UFerieSolidaliMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Variants, Controls, Math,
  Oracle, C700USelezioneAnagrafe, A000USessione, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali,
  Data.DB, R600, StrUtils;

type
  TParametriElaborazione = record
    bAggiornaQuantita:   Boolean;      //chkAggiornaQuantita.Checked
    bAggiornaProfili:    Boolean;      //chkAggiornaProfili.Checked
    bAzzeraQuantita:     Boolean;      //chkAzzeraQuantita.Checked
    bImpostaTermine:     Boolean;      //chkImpostaTermine.Checked
    sDataTermine:        String;       //edtDataTermine.Text
  end;

  TA177FFerieSolidaliMW = class(TR005FDataModuleMW)
    selSQL: TOracleQuery;
    selT254_ID: TOracleQuery;
    dsrT262: TDataSource;
    selT262: TOracleDataSet;
    selT262CODICE: TStringField;
    selT262DESCRIZIONE: TStringField;
    selT262UMISURA: TStringField;
    selT260: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    dsrT260: TDataSource;
    updT254Stato: TOracleQuery;
    updT254: TOracleQuery;
    selT254Rich: TOracleDataSet;
    selT254RichID_RICHIESTA: TFloatField;
    selT254RichDESCRIZIONE: TStringField;
    selT254RichANNO: TFloatField;
    selT254RichDECORRENZA: TDateTimeField;
    selT254RichDECORRENZA_FINE: TDateTimeField;
    insT254: TOracleQuery;
    selT254RichUMISURA: TStringField;
    selT430_PT: TOracleQuery;
    selT262CODINTERNO: TStringField;
    selT265: TOracleDataSet;
    StringField3: TStringField;
    StringField4: TStringField;
    selT254Off: TOracleDataSet;
    delT254: TOracleQuery;
    selT254a: TOracleDataSet;
    dsrT254a: TDataSource;
    dsrT265: TDataSource;
    updT254Stato1: TOracleQuery;
    selT254aPROGRESSIVO: TIntegerField;
    selT254aTIPO: TStringField;
    selT254aCODRAGGR: TStringField;
    selT254aANNO: TFloatField;
    selT254aDECORRENZA: TDateTimeField;
    selT254aID_RICHIESTA: TFloatField;
    selT254aDESCRIZIONE: TStringField;
    selT254aDECORRENZA_FINE: TDateTimeField;
    selT254aTERMINE_DIRITTO: TDateTimeField;
    selT254aSTATO: TStringField;
    selT254aCAUSALE: TStringField;
    selT254aUMISURA: TStringField;
    selT254aQUANTITA_RICHIESTA: TStringField;
    selT254aQUANTITA_OFFERTA: TStringField;
    selT254aQUANTITA_OTTENUTA: TStringField;
    selT254aQUANTITA_ACCETTATA: TStringField;
    selT254aQUANTITA_RESTITUITA: TStringField;
    selT254aMATRICOLA: TStringField;
    selT254aCOGNOME: TStringField;
    selT254aNOME: TStringField;
    selT254RichQUANTITA_RICHIESTA: TStringField;
    insT263: TOracleQuery;
    selT263: TOracleDataSet;
    selT254aDESCR_RAGGR: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    R600DtM1:TR600DtM1;
    procedure ControlliRichiesta;
    procedure ControlliOfferta;
    procedure ControlloTotaleOfferteDip;
    procedure DistribuisciQuantita(Tipo:String;QuantDaDistribuire:Real);
  public
    { Public declarations }
    ValenzaGiornata:Integer;  //ValenzaGiornata = durata media della giornata lavorativa
    MaxOffertaHH,ResiduoOffertaHH,ResiduoRichiestaHH:Integer;
    MaxOfferta,ResiduoOfferta,ResiduoRichiesta:Real;
    ParametriElaborazione:TParametriElaborazione;
    selT254: TOracleDataset;
    procedure selT254NewRecord(Tipo:String);
    procedure selT254BeforePost;
    procedure selT254AfterPost;
    procedure selT254BeforeDelete;
    procedure selT254AfterDelete;
    procedure selT254CalcFields(Dataset:TDataset);
    procedure ImpostaCausale(Raggruppamento,UMisura:String);
    procedure AggiornaProfili(Tipo:String);
    procedure ControllaTermineDiritto;
    procedure CancellaOfferte;
    procedure Elaborazione;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TA177FFerieSolidaliMW }

procedure TA177FFerieSolidaliMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  R600DtM1:=TR600DtM1.Create(Self);
  ValenzaGiornata:=R180OreMinutiExt('07.12');  //Considero una giornata di 7.12 ore
  selT260.Open;
end;

procedure TA177FFerieSolidaliMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(R600DtM1);
end;

procedure TA177FFerieSolidaliMW.AggiornaProfili(Tipo:String);
var Decurtazione,VariazRichiesta,VariazOfferta:Real;
begin
  //----------------------------------------------------------------------
  //-------------------------- AGGIORNA PROFILI --------------------------
  //----------------------------------------------------------------------
  //Inserimento profilo ass.ind. per richiesta su CODRAGGR FSOLR
  if Tipo = 'Richiesta' then
  begin
    if selT254.FieldByName('UMISURA').AsString = 'G' then
      VariazRichiesta:=StrToFloat(selT254.FieldByName('QUANTITA_OTTENUTA').AsString)
    else
      VariazRichiesta:=R180OreMinutiExt(selT254.FieldByName('QUANTITA_OTTENUTA').AsString);
  end
  else
  begin
    if selT254.FieldByName('UMISURA').AsString = 'G' then
      VariazRichiesta:=StrToFloat(selT254.FieldByName('QUANTITA_RESTITUITA').AsString) * -1
    else
      VariazRichiesta:=R180OreMinutiExt(selT254.FieldByName('QUANTITA_RESTITUITA').AsString) * -1;
  end;
  if VariazRichiesta <> 0 then
  begin
    selT263.Close;
    selT263.SetVariable('PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
    selT263.SetVariable('DAL',StrToDate('01/01/' + selT254.FieldByName('ANNO').AsString));
    selT263.SetVariable('CODRAGGR',selT254.FieldByName('CODRAGGR').AsString);
    selT263.Open;
    if selT263.RecordCount <= 0 then
    begin
      insT263.SetVariable('PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
      insT263.SetVariable('DAL',StrToDate('01/01/' + selT254.FieldByName('ANNO').AsString));
      insT263.SetVariable('AL',StrToDate('31/12/' + selT254.FieldByName('ANNO').AsString));
      insT263.SetVariable('CODRAGGR',selT254.FieldByName('CODRAGGR').AsString);
      insT263.SetVariable('UMISURA',selT254.FieldByName('UMISURA').AsString);
      insT263.SetVariable('DECURTAZIONE',IfThen(selT254.FieldByName('UMISURA').AsString = 'G',FloatToStr(VariazRichiesta),R180MinutiOre(Trunc(VariazRichiesta))));
      insT263.SetVariable('VARIAZ_FERIESOL',IfThen(selT254.FieldByName('UMISURA').AsString = 'G',FloatToStr(VariazRichiesta),R180MinutiOre(Trunc(VariazRichiesta))));
      insT263.SetVariable('NOTE',Tipo + ' ferie solidali numero ' + selT254.FieldByName('ID_RICHIESTA').AsString + ' (Quantità ' + IfThen(selT254.FieldByName('UMISURA').AsString = 'G',FloatToStr(VariazRichiesta),R180MinutiOre(Trunc(VariazRichiesta))) + ')');
      insT263.Execute;
    end
    else
    begin
      if selT263.FieldByName('UMISURA').AsString <> selT254.FieldByName('UMISURA').AsString then
        RegistraMsg.InserisciMessaggio('A','Dipendente con profilo assenze individuale ' + selT254.FieldByName('CODRAGGR').AsString + ' esistente con diversa unità di misura','',selT254.FieldByName('PROGRESSIVO').AsInteger)
      else
      begin
        selT263.Edit;
        Decurtazione:=0;
        if Trim(selT263.FieldByName('DECURTAZIONE').AsString) <> '' then
        begin
          if selT263.FieldByName('UMISURA').AsString = 'G' then
            Decurtazione:=StrToFloat(selT263.FieldByName('DECURTAZIONE').AsString)
          else
            Decurtazione:=R180OreMinutiExt(selT263.FieldByName('DECURTAZIONE').AsString);
        end;
        Decurtazione:=Decurtazione + VariazRichiesta;
        selT263.FieldByName('DECURTAZIONE').AsString:=IfThen(selT263.FieldByName('UMISURA').AsString = 'G',FloatToStr(Decurtazione),R180MinutiOre(Trunc(Decurtazione)));
        Decurtazione:=0;
        if Trim(selT263.FieldByName('VARIAZ_FERIESOL').AsString) <> '' then
        begin
          if selT263.FieldByName('UMISURA').AsString = 'G' then
            Decurtazione:=StrToFloat(selT263.FieldByName('VARIAZ_FERIESOL').AsString)
          else
            Decurtazione:=R180OreMinutiExt(selT263.FieldByName('VARIAZ_FERIESOL').AsString);
        end;
        Decurtazione:=Decurtazione + VariazRichiesta;
        selT263.FieldByName('VARIAZ_FERIESOL').AsString:=IfThen(selT263.FieldByName('UMISURA').AsString = 'G',FloatToStr(Decurtazione),R180MinutiOre(Trunc(Decurtazione)));
        if Trim(selT263.FieldByName('NOTE').AsString) <> '' then
          selT263.FieldByName('NOTE').AsString:=selT263.FieldByName('NOTE').AsString + #$D#$A;
        selT263.FieldByName('NOTE').AsString:=selT263.FieldByName('NOTE').AsString + Tipo + ' ferie solidali numero ' + selT254.FieldByName('ID_RICHIESTA').AsString +
          ' (Quantità ' + IfThen(selT263.FieldByName('UMISURA').AsString = 'G',FloatToStr(VariazRichiesta),R180MinutiOre(Trunc(VariazRichiesta))) + ')';
        selT263.Post;
      end;
    end;
  end;
  //Inserimento profili ass.ind. per offerte su CODRAGGR FERIE-FESTIVITA'
  selT254a.Refresh;
  selT254a.First;
  while not selT254a.Eof do
  begin
    if Tipo = 'Richiesta' then
    begin
      if selT254a.FieldByName('UMISURA').AsString = 'G' then
        VariazOfferta:=StrToFloat(selT254a.FieldByName('QUANTITA_ACCETTATA').AsString) * -1
      else
        VariazOfferta:=R180OreMinutiExt(selT254a.FieldByName('QUANTITA_ACCETTATA').AsString) * -1;
    end
    else
    begin
      if selT254a.FieldByName('UMISURA').AsString = 'G' then
        VariazOfferta:=StrToFloat(selT254a.FieldByName('QUANTITA_RESTITUITA').AsString)
      else
        VariazOfferta:=R180OreMinutiExt(selT254a.FieldByName('QUANTITA_RESTITUITA').AsString);
    end;
    if VariazOfferta <> 0 then
    begin
      selT263.Close;
      selT263.SetVariable('PROGRESSIVO',selT254a.FieldByName('PROGRESSIVO').AsInteger);
      selT263.SetVariable('DAL',StrToDate('01/01/' + selT254a.FieldByName('ANNO').AsString));
      selT263.SetVariable('CODRAGGR',selT254a.FieldByName('CODRAGGR').AsString);
      selT263.Open;
      if selT263.RecordCount <= 0 then
      begin
        insT263.SetVariable('PROGRESSIVO',selT254a.FieldByName('PROGRESSIVO').AsInteger);
        insT263.SetVariable('DAL',StrToDate('01/01/' + selT254.FieldByName('ANNO').AsString));
        insT263.SetVariable('AL',StrToDate('31/12/' + selT254.FieldByName('ANNO').AsString));
        insT263.SetVariable('CODRAGGR',selT254a.FieldByName('CODRAGGR').AsString);
        insT263.SetVariable('UMISURA',selT254a.FieldByName('UMISURA').AsString);
        insT263.SetVariable('DECURTAZIONE',IfThen(selT254a.FieldByName('UMISURA').AsString = 'G',FloatToStr(VariazOfferta),R180MinutiOre(Trunc(VariazOfferta))));
        insT263.SetVariable('VARIAZ_FERIESOL',IfThen(selT254a.FieldByName('UMISURA').AsString = 'G',FloatToStr(VariazOfferta),R180MinutiOre(Trunc(VariazOfferta))));
        insT263.SetVariable('NOTE',Tipo + ' ferie solidali numero ' + selT254.FieldByName('ID_RICHIESTA').AsString +
          ' (Quantità ' + IfThen(selT254a.FieldByName('UMISURA').AsString = 'G',FloatToStr(VariazOfferta),R180MinutiOre(Trunc(VariazOfferta))) + ')');
        insT263.Execute;
      end
      else
      begin
        if selT263.FieldByName('UMISURA').AsString <> selT254a.FieldByName('UMISURA').AsString then
          RegistraMsg.InserisciMessaggio('A','Dipendente con profilo assenze individuale ' + selT254a.FieldByName('CODRAGGR').AsString + ' esistente con diversa unità di misura','',selT254a.FieldByName('PROGRESSIVO').AsInteger)
        else
        begin
          selT263.Edit;
          Decurtazione:=0;
          if Trim(selT263.FieldByName('DECURTAZIONE').AsString) <> '' then
          begin
            if selT263.FieldByName('UMISURA').AsString = 'G' then
              Decurtazione:=StrToFloat(selT263.FieldByName('DECURTAZIONE').AsString)
            else
              Decurtazione:=R180OreMinutiExt(selT263.FieldByName('DECURTAZIONE').AsString);
          end;
          Decurtazione:=Decurtazione + VariazOfferta;
          selT263.FieldByName('DECURTAZIONE').AsString:=IfThen(selT263.FieldByName('UMISURA').AsString = 'G',FloatToStr(Decurtazione),R180MinutiOre(Trunc(Decurtazione)));
          Decurtazione:=0;
          if Trim(selT263.FieldByName('VARIAZ_FERIESOL').AsString) <> '' then
          begin
            if selT263.FieldByName('UMISURA').AsString = 'G' then
              Decurtazione:=StrToFloat(selT263.FieldByName('VARIAZ_FERIESOL').AsString)
            else
              Decurtazione:=R180OreMinutiExt(selT263.FieldByName('VARIAZ_FERIESOL').AsString);
          end;
          Decurtazione:=Decurtazione + VariazOfferta;
          selT263.FieldByName('VARIAZ_FERIESOL').AsString:=IfThen(selT263.FieldByName('UMISURA').AsString = 'G',FloatToStr(Decurtazione),R180MinutiOre(Trunc(Decurtazione)));
          if Trim(selT263.FieldByName('NOTE').AsString) <> '' then
            selT263.FieldByName('NOTE').AsString:=selT263.FieldByName('NOTE').AsString + #$D#$A;
          selT263.FieldByName('NOTE').AsString:=selT263.FieldByName('NOTE').AsString + Tipo + ' ferie solidali numero ' + selT254a.FieldByName('ID_RICHIESTA').AsString +
            ' (Quantità ' + IfThen(selT254a.FieldByName('UMISURA').AsString = 'G',FloatToStr(VariazOfferta),R180MinutiOre(Trunc(VariazOfferta))) + ')';
          selT263.Post;
        end;
      end;
    end;
    selT254a.Next;
  end;
end;

procedure TA177FFerieSolidaliMW.ControllaTermineDiritto;
var DataTermine:TDateTime;
    G:TGiustificativo;
    Residuo,ResiduoAnno:String;
begin
  if not TryStrToDate(ParametriElaborazione.sDataTermine,DataTermine) then
    raise Exception.Create(A000MSG_ERR_DATA_VALIDA);
  //La data termine diritto deve essere successiva alla scadenza!
  if DataTermine <= selT254.FieldByName('DECORRENZA_FINE').AsDateTime then
    raise Exception.Create(A000MSG_A177_ERR_RIC_DATA_TERMINE);
  //La data termine diritto deve essere compresa nell''anno di riferimento!
  if Copy(ParametriElaborazione.sDataTermine,7,4) <> selT254.FieldByName('ANNO').AsString then
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_DATA_ANNO,['termine diritto']));
  //Va controllato che sia presente un residuo a data termine - utilizzando la causale specificata FSOLR
  G.Inserimento:=False;
  G.Modo:='I';
  G.Causale:=selT254.FieldByName('CAUSALE').AsString;
  R600DtM1.GetAssenze(selT254.FieldByName('PROGRESSIVO').AsInteger,DataTermine,DataTermine,0,G);
  Residuo:=R600DtM1.GetResiduo;
  if R600DtM1.UMisura = '' then
    raise Exception.Create('Il dipendente non ha le competenze della causale espresse correttamente!');
  if R600DtM1.UMisura = 'G' then
    ResiduoRichiesta:=StrToFloat(Residuo)
  else
    ResiduoRichiestaHH:=R180OreMinutiExt(Residuo);
  //'Sono presenti %s giorni fruiti di ferie solidali successivi alla data termine %s: prima di procedere, cancellare i relativi giustificativi!'
  R600DtM1.GetAssenze(selT254.FieldByName('PROGRESSIVO').AsInteger,StrToDate('31/12/' + selT254.FieldByName('ANNO').AsString),StrToDate('31/12/' + selT254.FieldByName('ANNO').AsString),0,G);
  ResiduoAnno:=R600DtM1.GetResiduo;
  if R600DtM1.UMisura = '' then
    raise Exception.Create('Il dipendente non ha le competenze della causale espresse correttamente!');
  if (R600DtM1.UMisura = 'G') and (ResiduoRichiesta <> StrToFloat(ResiduoAnno)) then
    raise Exception.Create(Format(A000MSG_A177_ERR_GIORNI_FRUITI,[FloatToStr(ResiduoRichiesta - StrToFloat(ResiduoAnno))+' giorni fruiti',ParametriElaborazione.sDataTermine]))
  else if (R600DtM1.UMisura = 'O') and (ResiduoRichiestaHH <> R180OreMinutiExt(ResiduoAnno)) then
    raise Exception.Create(Format(A000MSG_A177_ERR_GIORNI_FRUITI,[R180MinutiOre(ResiduoRichiestaHH - R180OreMinutiExt(ResiduoAnno))+' ore fruite',ParametriElaborazione.sDataTermine]));
end;

procedure TA177FFerieSolidaliMW.DistribuisciQuantita(Tipo:String;QuantDaDistribuire:Real);
var
  TotOfferte,QuantOfferta,QuantDistribuita,TotDistribuito:Real;
  SoggettiSvantaggiati: TStringList;
begin
  SoggettiSvantaggiati:=TStringList.Create;
  //Ordino le offerte legate a questa richiesta per quantità offerta dal più grande al più piccolo
  R180SetVariable(selT254a,'ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
  if selT254.FieldByName('UMISURA').AsString = 'G' then
    R180SetVariable(selT254a,'ORDINAMENTO','TO_NUMBER(T254.QUANTITA_OFFERTA) DESC, T254.DECORRENZA, T030.COGNOME, T030.NOME, T030.MATRICOLA, T254.CODRAGGR')
  else
    R180SetVariable(selT254a,'ORDINAMENTO','OREMINUTI(T254.QUANTITA_OFFERTA) DESC, T254.DECORRENZA, T030.COGNOME, T030.NOME, T030.MATRICOLA, T254.CODRAGGR');
  R180SetVariable(selT254a,'DATI',',T254.ROWID');
  selT254a.Open;
  selT254a.Refresh;
  selT254a.First;
  //Conteggio il totale delle offerte legate a questo ID_Richiesta
  TotOfferte:=0;
  while not selT254a.Eof do
  begin
    if selT254a.FieldByName('UMISURA').AsString = 'G' then
      TotOfferte:=TotOfferte + StrToFloat(selT254a.FieldByName('QUANTITA_OFFERTA').AsString)
    else
      TotOfferte:=TotOfferte + R180OreMinutiExt(selT254a.FieldByName('QUANTITA_OFFERTA').AsString);
    selT254a.Next;
  end;
  //Se il totale offerte è inferiore alla richiesta (es.richiesta di 30, totale offerte 10), imposto QUANTITA_ACCETTATA per ogni offerta uguale alla QUANTITA_OFFERTA e aggiorno la QUANTITA_OTTENUTA con il TotaleOfferte
  if (Tipo = 'Richiesta') and (TotOfferte <= QuantDaDistribuire) then
  begin
    selT254a.First;
    while not selT254a.Eof do
    begin
      selT254a.Edit;
      selT254a.FieldByName('QUANTITA_ACCETTATA').AsString:=selT254a.FieldByName('QUANTITA_OFFERTA').AsString;
      selT254a.Post;
      selT254a.Next;
    end;
    //Aggiorno la quantità ottenuta sulla richiesta
    updT254.SetVariable('DATI','QUANTITA_OTTENUTA = ''' + IfThen(selT254.FieldByName('UMISURA').AsString = 'G',FloatToStr(TotOfferte),R180MinutiOre(Trunc(TotOfferte))) + '''');
    updT254.SetVariable('ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
    updT254.SetVariable('FILTRO',' AND TIPO = ''R''');
    updT254.Execute;
  end
  else
  begin
    //Se il totale offerte è superiore alla richiesta (es.richiesta di 30, totale offerte 46), imposto QUANTITA_ACCETTATA per ogni offerta proporzionando la QUANTITA_OFFERTA sul rapporto tra QUANTITA_RICHIESTA e TotaleOfferte (30/46) e aggiorno la QUANTITA_OTTENUTA uguale alla QUANTITA_RICHIESTA
    TotDistribuito:=0;
    selT254a.First;
    while not selT254a.Eof do
    begin
      if selT254a.FieldByName('UMISURA').AsString = 'G' then
        QuantOfferta:=StrToFloat(selT254a.FieldByName('QUANTITA_OFFERTA').AsString)
      else
        QuantOfferta:=R180OreMinutiExt(selT254a.FieldByName('QUANTITA_OFFERTA').AsString);
      //La quantità accettata può essere al massimo la quantità offerta
      QuantDistribuita:=Min(QuantOfferta,(QuantDaDistribuire / TotOfferte * QuantOfferta));
      //Arrotondo alla giornata intera o ai minuti interi
      if (Abs(QuantDistribuita - R180Arrotonda(QuantDistribuita,1,'P')) > 0.4) and (SoggettiSvantaggiati.IndexOf(selT254a.FieldByName('PROGRESSIVO').AsString) = -1) then
      begin
        SoggettiSvantaggiati.Add(selT254a.FieldByName('PROGRESSIVO').AsString);
      end;
      QuantDistribuita:=R180Arrotonda(QuantDistribuita,1,'P');
      selT254a.Edit;
      if Tipo = 'Richiesta' then
        selT254a.FieldByName('QUANTITA_ACCETTATA').AsString:=IfThen(selT254a.FieldByName('UMISURA').AsString = 'G',FloatToStr(QuantDistribuita),R180MinutiOre(Trunc(QuantDistribuita)))
      else
        selT254a.FieldByName('QUANTITA_RESTITUITA').AsString:=IfThen(selT254a.FieldByName('UMISURA').AsString = 'G',FloatToStr(QuantDistribuita),R180MinutiOre(Trunc(QuantDistribuita)));
      selT254a.Post;
      TotDistribuito:=TotDistribuito + QuantDistribuita;
      selT254a.Next;
    end;
    //Se dopo l'arrotondamento, il totale accettato è diverso dalla quantità richiesta aggiungo o tolgo un giorno/un'ora ad ogni quantAccettata fino ad arrivare a QuantRichiesta
    if TotDistribuito <> QuantDaDistribuire then
    begin
      while (TotDistribuito <> QuantDaDistribuire) do
      begin
        selT254a.First;
        while (not selT254a.Eof) and (TotDistribuito <> QuantDaDistribuire) do
        begin
          if SoggettiSvantaggiati.Count > 0 then
          begin
            if SoggettiSvantaggiati.IndexOf(selT254a.FieldByName('PROGRESSIVO').AsString) = -1 then
            begin
              selT254a.Next;
              Continue;
            end
            else
              SoggettiSvantaggiati.Delete(SoggettiSvantaggiati.IndexOf(selT254a.FieldByName('PROGRESSIVO').AsString));
          end;
          if selT254a.FieldByName('UMISURA').AsString = 'G' then
            QuantOfferta:=StrToFloat(selT254a.FieldByName('QUANTITA_OFFERTA').AsString)
          else
            QuantOfferta:=R180OreMinutiExt(selT254a.FieldByName('QUANTITA_OFFERTA').AsString);
          if Tipo = 'Richiesta' then
          begin
            if selT254a.FieldByName('UMISURA').AsString = 'G' then
              QuantDistribuita:=StrToFloat(selT254a.FieldByName('QUANTITA_ACCETTATA').AsString)
            else
              QuantDistribuita:=R180OreMinutiExt(selT254a.FieldByName('QUANTITA_ACCETTATA').AsString);
          end
          else
          begin
            if selT254a.FieldByName('UMISURA').AsString = 'G' then
              QuantDistribuita:=StrToFloat(selT254a.FieldByName('QUANTITA_RESTITUITA').AsString)
            else
              QuantDistribuita:=R180OreMinutiExt(selT254a.FieldByName('QUANTITA_RESTITUITA').AsString);
          end;
          if TotDistribuito < QuantDaDistribuire then
          begin
            if QuantDistribuita < QuantOfferta then
            begin
              QuantDistribuita:=QuantDistribuita + 1;
              TotDistribuito:=TotDistribuito + 1;
            end;
          end
          else
          begin
            if QuantDistribuita > 0 then
            begin
              QuantDistribuita:=QuantDistribuita - 1;
              TotDistribuito:=TotDistribuito - 1;
            end;
          end;
          selT254a.Edit;
          if Tipo = 'Richiesta' then
            selT254a.FieldByName('QUANTITA_ACCETTATA').AsString:=IfThen(selT254a.FieldByName('UMISURA').AsString = 'G',FloatToStr(QuantDistribuita),R180MinutiOre(Trunc(QuantDistribuita)))
          else
            selT254a.FieldByName('QUANTITA_RESTITUITA').AsString:=IfThen(selT254a.FieldByName('UMISURA').AsString = 'G',FloatToStr(QuantDistribuita),R180MinutiOre(Trunc(QuantDistribuita)));
          selT254a.Post;
          selT254a.Next;
        end;
      end;
    end;
    //Aggiorno la quantità ottenuta/restituita sulla richiesta
    if Tipo = 'Richiesta' then
      updT254.SetVariable('DATI','QUANTITA_OTTENUTA = ''' + IfThen(selT254.FieldByName('UMISURA').AsString = 'G',FloatToStr(QuantDaDistribuire),R180MinutiOre(Trunc(QuantDaDistribuire))) + '''')
    else
      updT254.SetVariable('DATI','QUANTITA_RESTITUITA = ''' + IfThen(selT254.FieldByName('UMISURA').AsString = 'G',FloatToStr(QuantDaDistribuire),R180MinutiOre(Trunc(QuantDaDistribuire))) + '''');
    updT254.SetVariable('ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
    updT254.SetVariable('FILTRO',' AND TIPO = ''R''');
    updT254.Execute;
  end;
  SoggettiSvantaggiati.Free;
end;

procedure TA177FFerieSolidaliMW.Elaborazione;
var StatoNew:String;
  Residuo:Real;
begin
  //-------------------------- AGGIORNA QUANTITA -------------------------
  if ParametriElaborazione.bAggiornaQuantita then
  begin
    StatoNew:='C';
    if selT254.FieldByName('UMISURA').AsString = 'G' then
      DistribuisciQuantita('Richiesta',StrToFloat(selT254.FieldByName('QUANTITA_RICHIESTA').AsString))
    else
      DistribuisciQuantita('Richiesta',R180OreMinutiExt(selT254.FieldByName('QUANTITA_RICHIESTA').AsString));
    SessioneOracle.Commit;
  end
  //-------------------------- AZZERA QUANTITA ---------------------------
  else if ParametriElaborazione.bAzzeraQuantita then
  begin
    StatoNew:='A';
    //Pulisco tutte le quantità ottenute/accettate e coeff.
    updT254.SetVariable('DATI','QUANTITA_OTTENUTA = NULL, QUANTITA_ACCETTATA = NULL');
    updT254.SetVariable('ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
    updT254.SetVariable('FILTRO','');
    updT254.Execute;
    SessioneOracle.Commit;
  end
  //-------------------------- AGGIORNA PROFILI --------------------------
  else if ParametriElaborazione.bAggiornaProfili then
  begin
    StatoNew:='F';
    AggiornaProfili('Richiesta');
    if RegistraMsg.ContieneTipoA then
      SessioneOracle.Rollback
    else
      SessioneOracle.Commit;
  end
  //-------------------------- IMPOSTA TERMINE DIRITTO -------------------
  else if ParametriElaborazione.bImpostaTermine then
  begin
    if selT254.FieldByName('UMISURA').AsString = 'G' then
      Residuo:=Min(ResiduoRichiesta,StrToFloat(selT254.FieldByName('QUANTITA_OTTENUTA').AsString))
    else
      Residuo:=Min(ResiduoRichiestaHH,R180OreMinutiExt(selT254.FieldByName('QUANTITA_OTTENUTA').AsString));
    if Residuo > 0 then
    begin
      DistribuisciQuantita('Restituzione',Residuo);
      selT254.Refresh;
      AggiornaProfili('Restituzione');
      if RegistraMsg.ContieneTipoA then
        SessioneOracle.Rollback
      else
        SessioneOracle.Commit;
    end;
    //Aggiorno Termine diritto su richiesta e offerta
    updT254.SetVariable('DATI','TERMINE_DIRITTO = TO_DATE(''' + ParametriElaborazione.sDataTermine + ''',''DD/MM/YYYY'')');
    updT254.SetVariable('ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
    updT254.SetVariable('FILTRO','');
    updT254.Execute;
    SessioneOracle.Commit;
  end;
  //----------------------------------------------------------------------
  //------------------ AGGIORNAMENTO STATO RICHIESTA/OFFERTE -------------
  //----------------------------------------------------------------------
  if (not ParametriElaborazione.bImpostaTermine) and (not RegistraMsg.ContieneTipoA) then
  begin
    //Aggiorno lo stato della richiesta e di tutte le offerte con stesso ID
    updT254Stato.SetVariable('ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
    updT254Stato.SetVariable('STATO',StatoNew);
    updT254Stato.Execute;
    //Aggiorno lo stato delle offerte con ID-1
    updT254Stato1.SetVariable('ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
    updT254Stato1.SetVariable('STATO',StatoNew);
    updT254Stato1.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TA177FFerieSolidaliMW.selT254AfterPost;
var TotRichieste,QuantOfferta,TotOfferte,OffertaIniz,QuantRichiesta:Real;
begin
  //--------------- OFFERTA ------------------
  //Se ID_RICHIESTA = -1 vuol dire che l'offerta è valida per tutte le richieste presenti sul db: inserire tante offerte quante sono le richieste valide (decorrenza offerta between decorrenza-scadenza richiesta)
  //L'offerta con ID richiesta = -1 sarà quella originale che contiene il totale dell'offerta del dipendente
  if (selT254.FieldByName('TIPO').AsString = 'O') and (selT254.FieldByName('ID_RICHIESTA').AsInteger = -1) then
  begin
    //Ordino le richieste valide per questa offerta per quantità richiesta dal più grande al più piccolo
    R180SetVariable(selT254Rich,'DEC_OFFERTA',selT254.FieldByName('DECORRENZA').AsDateTime);
    R180SetVariable(selT254Rich,'PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT254Rich,'UMISURA',selT254.FieldByName('UMISURA').AsString);
    selT254Rich.Open;
    selT254Rich.Refresh;
    selT254Rich.Filter:='ID_RICHIESTA <> -1';
    selT254Rich.Filtered:=True;
    selT254Rich.First;
    //Conteggio il totale delle richieste valide per questa offerta
    TotRichieste:=0;
    while not selT254Rich.Eof do
    begin
      if selT254Rich.FieldByName('UMISURA').AsString = 'G' then
        TotRichieste:=TotRichieste + StrToFloat(selT254Rich.FieldByName('QUANTITA_RICHIESTA').AsString)
      else
        TotRichieste:=TotRichieste + R180OreMinutiExt(selT254Rich.FieldByName('QUANTITA_RICHIESTA').AsString);
      selT254Rich.Next;
    end;
    //Carico QUANTITA_OFFERTA per ogni ID_RICHIESTA proporzionando la QUANTITA_RICHIESTA sul rapporto tra QUANTITA_OFFERTA iniziale e TotaleRichieste
    if selT254.FieldByName('UMISURA').AsString = 'G' then
      OffertaIniz:=StrToFloat(selT254.FieldByName('QUANTITA_OFFERTA').AsString)
    else
      OffertaIniz:=R180OreMinutiExt(selT254.FieldByName('QUANTITA_OFFERTA').AsString);
    TotOfferte:=0;
    selT254Rich.First;
    while (not selT254Rich.Eof) and (TotOfferte < OffertaIniz) do
    begin
      if selT254Rich.FieldByName('UMISURA').AsString = 'G' then
        QuantRichiesta:=StrToFloat(selT254Rich.FieldByName('QUANTITA_RICHIESTA').AsString)
      else
        QuantRichiesta:=R180OreMinutiExt(selT254Rich.FieldByName('QUANTITA_RICHIESTA').AsString);
      //La quantità offerta non ha limiti
      QuantOfferta:=OffertaIniz / TotRichieste * QuantRichiesta;
      //Arrotondo alla giornata intera
      QuantOfferta:=IfThen(selT254.FieldByName('UMISURA').AsString = 'G',R180Arrotonda(QuantOfferta,1,'P'),R180Arrotonda(QuantOfferta,1,'P'));
      //Carico solo se la quantità è diversa da 0
      if QuantOfferta <> 0 then
      begin
        insT254.SetVariable('PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
        insT254.SetVariable('ANNO',selT254.FieldByName('ANNO').AsInteger);
        insT254.SetVariable('DECORRENZA',selT254.FieldByName('DECORRENZA').AsDateTime);
        insT254.SetVariable('CODRAGGR',selT254.FieldByName('CODRAGGR').AsString);
        insT254.SetVariable('CAUSALE',selT254.FieldByName('CAUSALE').AsString);
        insT254.SetVariable('UMISURA',selT254.FieldByName('UMISURA').AsString);
        insT254.SetVariable('ID_RICHIESTA',selT254Rich.FieldByName('ID_RICHIESTA').AsInteger);
        insT254.SetVariable('QUANTITA_OFFERTA',IfThen(selT254Rich.FieldByName('UMISURA').AsString = 'G',FloatToStr(QuantOfferta),R180MinutiOre(Trunc(QuantOfferta))));
        //Carico anche la quantità richiesta perchè mi serve per il successivo ordinamento
        insT254.SetVariable('QUANTITA_RICHIESTA',IfThen(selT254Rich.FieldByName('UMISURA').AsString = 'G',FloatToStr(QuantRichiesta),R180MinutiOre(Trunc(QuantRichiesta))));
        insT254.Execute;
        TotOfferte:=TotOfferte + QuantOfferta;
      end;
      selT254Rich.Next;
    end;
    SessioneOracle.Commit;
    //Ordino le offerte per quantità richiesta dal più grande al più piccolo
    R180SetVariable(selT254Off,'PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT254Off,'ANNO',selT254.FieldByName('ANNO').AsInteger);
    R180SetVariable(selT254Off,'DECORRENZA',selT254.FieldByName('DECORRENZA').AsDateTime);
    R180SetVariable(selT254Off,'CODRAGGR',selT254.FieldByName('CODRAGGR').AsString);
    R180SetVariable(selT254Off,'CAUSALE',selT254.FieldByName('CAUSALE').AsString);
    R180SetVariable(selT254Off,'UMISURA',selT254.FieldByName('UMISURA').AsString);
    selT254Off.Open;
    selT254Off.Refresh;
    selT254Off.Filter:='ID_RICHIESTA <> -1';
    selT254Off.Filtered:=True;
    //Se dopo l'arrotondamento, il totale offerte è diverso dall'offerta iniziale aggiungo o tolgo un giorno ad ogni quantOfferta fino ad arrivare all'offerta iniziale
    if TotOfferte <> OffertaIniz then
    begin
      selT254Off.First;
      while (not selT254Off.Eof) and (TotOfferte <> OffertaIniz) do
      begin
        if selT254Off.FieldByName('UMISURA').AsString = 'G' then
          QuantOfferta:=StrToFloat(selT254Off.FieldByName('QUANTITA_OFFERTA').AsString)
        else
          QuantOfferta:=R180OreMinutiExt(selT254Off.FieldByName('QUANTITA_OFFERTA').AsString);
        if TotOfferte < OffertaIniz then
        begin
          QuantOfferta:=QuantOfferta + 1;
          TotOfferte:=TotOfferte + 1;
        end
        else
        begin
          if QuantOfferta > 0 then
          begin
            QuantOfferta:=QuantOfferta - 1;
            TotOfferte:=TotOfferte - 1;
          end;
        end;
        selT254Off.Edit;
        selT254Off.FieldByName('QUANTITA_OFFERTA').AsString:=IfThen(selT254Off.FieldByName('UMISURA').AsString = 'G',FloatToStr(QuantOfferta),R180MinutiOre(Trunc(QuantOfferta)));
        selT254Off.Post;
        selT254Off.Next;
      end;
    end;
    SessioneOracle.Commit;
    //Ripulisco la QUANTITA_RICHIESTA
    selT254Off.First;
    while not selT254Off.Eof do
    begin
      selT254Off.Edit;
      selT254Off.FieldByName('QUANTITA_RICHIESTA').AsString:='';
      selT254Off.Post;
      selT254Off.Next;
    end;
    SessioneOracle.Commit;
    selT254.Refresh;
    selT254Off.Filter:='';
    selT254Off.Filtered:=False;
    selT254Rich.Filter:='';
    selT254Rich.Filtered:=False;
  end;
  //Se l’offerta è collegata all’ID_RICHIESTA
  if (selT254.FieldByName('TIPO').AsString = 'O') and (selT254.FieldByName('ID_RICHIESTA').AsInteger <> -1) then
    ControlloTotaleOfferteDip;
end;

procedure TA177FFerieSolidaliMW.ControlloTotaleOfferteDip;
var TotOfferte,OffertaIniz:Real;
begin
  //Controllo che il totale offerte del dipendente corrisponda alla sua offerta iniziale
  R180SetVariable(selT254Off,'PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
  R180SetVariable(selT254Off,'ANNO',selT254.FieldByName('ANNO').AsInteger);
  R180SetVariable(selT254Off,'DECORRENZA',selT254.FieldByName('DECORRENZA').AsDateTime);
  R180SetVariable(selT254Off,'CODRAGGR',selT254.FieldByName('CODRAGGR').AsString);
  R180SetVariable(selT254Off,'CAUSALE',selT254.FieldByName('CAUSALE').AsString);
  R180SetVariable(selT254Off,'UMISURA',selT254.FieldByName('UMISURA').AsString);
  selT254Off.Open;
  selT254Off.Refresh;
  //se è presente un’offerta con stesso ANNO, DECORRENZA, CODRAGGR, CAUSALE e UM e ID_RICHIESTA -1
  if (selT254Off.RecordCount > 0) and (selT254Off.SearchRecord('ID_RICHIESTA',-1,[srFromBeginning])) then
  begin
    if selT254Off.FieldByName('UMISURA').AsString = 'G' then
      OffertaIniz:=StrToFloat(selT254Off.FieldByName('QUANTITA_OFFERTA').AsString)
    else
      OffertaIniz:=R180OreMinutiExt(selT254Off.FieldByName('QUANTITA_OFFERTA').AsString);
    //Totalizzo la quantità offerta
    selT254Off.First;
    TotOfferte:=0;
    while not selT254Off.Eof do
    begin
      if selT254Off.FieldByName('ID_RICHIESTA').AsInteger <> -1 then
      begin
        if selT254Off.FieldByName('UMISURA').AsString = 'G' then
          TotOfferte:=TotOfferte + StrToFloat(selT254Off.FieldByName('QUANTITA_OFFERTA').AsString)
        else
          TotOfferte:=TotOfferte + R180OreMinutiExt(selT254Off.FieldByName('QUANTITA_OFFERTA').AsString);
      end;
      selT254Off.Next;
    end;
    if TotOfferte <> OffertaIniz then
    begin
      if selT254Off.FieldByName('UMISURA').AsString = 'G' then
        R180MessageBox(Format(A000MSG_A177_MSG_OFF_TOTQUANTITA,[FloatToStr(TotOfferte)+' giorni',FloatToStr(OffertaIniz)+' giorni']),'INFORMA')    //Attenzione: il totale delle quantità offerte (%s) non corrisponde all''offerta iniziale del dipendente (%s)!
      else
        R180MessageBox(Format(A000MSG_A177_MSG_OFF_TOTQUANTITA,[R180MinutiOre(Trunc(TotOfferte))+' ore',R180MinutiOre(Trunc(OffertaIniz))+' ore']),'INFORMA');    //Attenzione: il totale delle quantità offerte (%s) non corrisponde all''offerta iniziale del dipendente (%s)!
    end;
  end;
end;

procedure TA177FFerieSolidaliMW.selT254BeforeDelete;
begin
  //Se cancello una richiesta e sono già presenti offerte con stesso ID_RICHIESTA: cancellazione impossibile
  if selT254.FieldByName('TIPO').AsString = 'R' then
  begin
    selSQL.SQL.Text:='SELECT COUNT(*) CONTA FROM T254_FERIESOLIDALI WHERE TIPO = ''O'' AND ID_RICHIESTA = ' + selT254.FieldByName('ID_RICHIESTA').AsString;
    selSQL.Execute;
    if selSQL.Field(0) > 0 then
      raise Exception.Create(Format(A000MSG_A177_ERR_FMT_CANCELLAZIONE,['con lo stesso numero richiesta']));   //Attenzione: cancellazione impossibile perchè sono presenti offerte con lo stesso numero richiesta.
  end;
  //Se cancello un’offerta con ID_RICHIESTA = -1 cancello anche tutte le offerte con stesso PROGRESSIVO, stesso ANNO, stessa DECORRENZA, stesso CODRAGGR, stessa CAUSALE e stessa UM: attenzione allo stato delle offerte che cancello, se sono già chiuse/fruibili non posso cancellarle e quindi non posso cancellare l’offerta con ID -1
  if (selT254.FieldByName('TIPO').AsString = 'O') and (selT254.FieldByName('ID_RICHIESTA').AsInteger = -1) then
  begin
    R180SetVariable(selT254Off,'PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT254Off,'ANNO',selT254.FieldByName('ANNO').AsInteger);
    R180SetVariable(selT254Off,'DECORRENZA',selT254.FieldByName('DECORRENZA').AsDateTime);
    R180SetVariable(selT254Off,'CODRAGGR',selT254.FieldByName('CODRAGGR').AsString);
    R180SetVariable(selT254Off,'CAUSALE',selT254.FieldByName('CAUSALE').AsString);
    R180SetVariable(selT254Off,'UMISURA',selT254.FieldByName('UMISURA').AsString);
    selT254Off.Open;
    selT254Off.Refresh;
    //se è presente un’offerta con stesso ANNO, DECORRENZA, CODRAGGR, CAUSALE e UM e ID_RICHIESTA <> -1 --> i record sono > 1
    if selT254Off.RecordCount > 1 then
    begin
      //se esiste un'offerta collegata con stato diverso da 'A' non posso cancellare nulla
      if selT254Off.SearchRecord('STATO','C',[srFromBeginning]) or selT254Off.SearchRecord('STATO','F',[srFromBeginning]) then
        raise Exception.Create(Format(A000MSG_A177_ERR_FMT_CANCELLAZIONE,['collegate già chiuse o fruibili']));   //Attenzione: cancellazione impossibile perchè sono presenti offerte collegate già chiuse o fruibili.
    end;
  end;
end;

procedure TA177FFerieSolidaliMW.CancellaOfferte;
begin
  delT254.SetVariable('PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
  delT254.SetVariable('ANNO',selT254.FieldByName('ANNO').AsInteger);
  delT254.SetVariable('DECORRENZA',selT254.FieldByName('DECORRENZA').AsDateTime);
  delT254.SetVariable('CODRAGGR',selT254.FieldByName('CODRAGGR').AsString);
  delT254.SetVariable('CAUSALE',selT254.FieldByName('CAUSALE').AsString);
  delT254.SetVariable('UMISURA',selT254.FieldByName('UMISURA').AsString);
  delT254.Execute;
end;

procedure TA177FFerieSolidaliMW.selT254AfterDelete;
begin
  //Se l’offerta è collegata all’ID_RICHIESTA
  if (selT254.RecordCount > 0) and (selT254.FieldByName('TIPO').AsString = 'O') and (selT254.FieldByName('ID_RICHIESTA').AsInteger <> -1) then
    ControlloTotaleOfferteDip;
end;

procedure TA177FFerieSolidaliMW.selT254BeforePost;
begin
  if selT254.FieldByName('TIPO').AsString = 'R' then
    ControlliRichiesta;
  if selT254.FieldByName('TIPO').AsString = 'O' then
    ControlliOfferta;
end;

procedure TA177FFerieSolidaliMW.selT254CalcFields(Dataset: TDataSet);
begin
  Dataset.FieldByName('DESCR_OFFERTA').AsString:='';
  Dataset.FieldByName('DESCR_RAGGR').AsString:='';
  if not Dataset.FieldByName('ID_RICHIESTA').IsNull then
  begin
    if Dataset.FieldByName('ID_RICHIESTA').AsInteger = -1 then
      Dataset.FieldByName('DESCR_OFFERTA').AsString:='TUTTE LE RICHIESTE'
    else
    begin
      selSQL.SQL.Text:='SELECT DESCRIZIONE FROM T254_FERIESOLIDALI WHERE TIPO = ''R'' AND ID_RICHIESTA = ' + Dataset.FieldByName('ID_RICHIESTA').AsString;
      selSQL.Execute;
      if selSQL.RowsProcessed > 0 then
        Dataset.FieldByName('DESCR_OFFERTA').AsString:=VarToStr(selSQL.Field(0));
    end;
  end;
  if not Dataset.FieldByName('CODRAGGR').IsNull then
  begin
    selSQL.SQL.Text:='SELECT DESCRIZIONE FROM T260_RAGGRASSENZE WHERE CODICE = ''' + Dataset.FieldByName('CODRAGGR').AsString + '''';
    selSQL.Execute;
    if selSQL.RowsProcessed > 0 then
      Dataset.FieldByName('DESCR_RAGGR').AsString:=Dataset.FieldByName('CODRAGGR').AsString + ' - ' + VarToStr(selSQL.Field(0));
  end;
end;

//------------------------------------------------------------
//--------------- CONTROLLI SULLA RICHIESTA ------------------
//------------------------------------------------------------
procedure TA177FFerieSolidaliMW.ControlliRichiesta;
begin
  selT254.FieldByName('QUANTITA_OFFERTA').Clear;
  //La decorrenza deve essere compresa nell''anno di riferimento!
  if (not selT254.FieldByName('DECORRENZA').IsNull) and (Copy(selT254.FieldByName('DECORRENZA').AsString,7,4) <> selT254.FieldByName('ANNO').AsString) then
  begin
    selT254.FieldByName('DECORRENZA').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_DATA_ANNO,['decorrenza']));
  end;
  //La scadenza deve essere compresa nell''anno di riferimento!
  if (not selT254.FieldByName('DECORRENZA_FINE').IsNull) and (Copy(selT254.FieldByName('DECORRENZA_FINE').AsString,7,4) <> selT254.FieldByName('ANNO').AsString) then
  begin
    selT254.FieldByName('DECORRENZA_FINE').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_DATA_ANNO,['scadenza']));
  end;
  //La decorrenza non può essere successiva alla scadenza!
  if (not selT254.FieldByName('DECORRENZA_FINE').IsNull) and (selT254.FieldByName('DECORRENZA_FINE').AsDateTime < selT254.FieldByName('DECORRENZA').AsDateTime) then
  begin
    selT254.FieldByName('DECORRENZA_FINE').FocusControl;
    raise Exception.Create(A000MSG_ERR_DECORR_NON_SUCC_SCAD);
  end;
  //Specificare la causale di assenza per la verifica del residuo sulla quantità ottenuta! Utile quando viene indicato il Termine diritto
  if selT254.FieldByName('CAUSALE').IsNull then
  begin
    selT254.FieldByName('CAUSALE').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_CAUSALE_NULLA,['ottenuta']));
  end;
  //Specificare la quantità richiesta!
  if selT254.FieldByName('QUANTITA_RICHIESTA').IsNull then
  begin
    selT254.FieldByName('QUANTITA_RICHIESTA').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_QUANTITA_NULLA,['richiesta']));
  end;
  //La quantità richiesta deve essere superiore a 0!
  if ((selT254.FieldByName('UMISURA').AsString = 'G') and (selT254.FieldByName('QUANTITA_RICHIESTA').AsFloat <= 0)) or
     ((selT254.FieldByName('UMISURA').AsString = 'O') and (R180OreMinutiExt(selT254.FieldByName('QUANTITA_RICHIESTA').AsString) <= 0)) then
  begin
    selT254.FieldByName('QUANTITA_RICHIESTA').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_QUANTITA_ZERO,['richiesta']));
  end;
  //La quantità richiesta non può avere decimali, deve essere un numero intero!
  if (selT254.FieldByName('UMISURA').AsString = 'G') and (Pos(',',selT254.FieldByName('QUANTITA_RICHIESTA').AsString) > 0) and
     (Trim(Copy(selT254.FieldByName('QUANTITA_RICHIESTA').AsString,Pos(',',selT254.FieldByName('QUANTITA_RICHIESTA').AsString)+1,1)) <> '') and
     (Copy(selT254.FieldByName('QUANTITA_RICHIESTA').AsString,Pos(',',selT254.FieldByName('QUANTITA_RICHIESTA').AsString)+1,1) <> '0') then
  begin
    selT254.FieldByName('QUANTITA_RICHIESTA').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_QUANTITA_DEC,['richiesta']));
  end;
  //La quantità richiesta non può essere superiore a 30 giorni!
  if ((selT254.FieldByName('UMISURA').AsString = 'G') and (selT254.FieldByName('QUANTITA_RICHIESTA').AsFloat > 30)) or
     ((selT254.FieldByName('UMISURA').AsString = 'O') and (R180OreMinutiExt(selT254.FieldByName('QUANTITA_RICHIESTA').AsString) > (30*ValenzaGiornata))) then  //30 giorni * 7.20 ore al giorno = 216 ore * 60 minuti = 12960
  begin
    selT254.FieldByName('QUANTITA_RICHIESTA').FocusControl;
    if selT254.FieldByName('UMISURA').AsString = 'G' then
      raise Exception.Create(Format(A000MSG_A177_ERR_FMT_QUANTITA,['richiesta','30 giorni!']))
    else
      raise Exception.Create(Format(A000MSG_A177_ERR_FMT_QUANTITA,['richiesta',R180MinutiOre(30*ValenzaGiornata) + ' ore!']))
  end;

  //Se ci sono già offerte con stesso ID richiesta verifico che siano tutte valide nel periodo decorrenza-scadenza
  if selT254.State = dsEdit then
  begin
    selSQL.SQL.Text:='SELECT COUNT(*) CONTA FROM T254_FERIESOLIDALI WHERE TIPO = ''O'' AND ID_RICHIESTA = ' + selT254.FieldByName('ID_RICHIESTA').AsString +
      ' AND (DECORRENZA < TO_DATE(''' + selT254.FieldByName('DECORRENZA').AsString + ''',''DD/MM/YYYY'') ' +
      '  OR DECORRENZA > NVL(TO_DATE(''' + selT254.FieldByName('DECORRENZA_FINE').AsString + ''',''DD/MM/YYYY''),TO_DATE(''31/12/3999'',''DD/MM/YYYY'')))';
    selSQL.Execute;
    if selSQL.Field(0) > 0 then
      raise Exception.Create(A000MSG_A177_ERR_RIC_VARIAZIONE);  //'Attenzione: variazione impossibile perchè sono presenti offerte con lo stesso Numero richiesta che verrebbero escluse dal periodo Decorrenza-Scadenza'
  end;
end;

//---------------------------------------------------------
//--------------- CONTROLLI SULL'OFFERTA ------------------
//---------------------------------------------------------
procedure TA177FFerieSolidaliMW.ControlliOfferta;
var MaxOffertaFerie,MaxOffertaFest:Real;
  MaxOffertaFerieHH,MaxOffertaFestHH:Integer;
  G:TGiustificativo;
begin
  //---------------------------------------
  //  CONTROLLI BLOCCANTI
  //---------------------------------------
  selT254.FieldByName('QUANTITA_RICHIESTA').Clear;
  selT254.FieldByName('DECORRENZA_FINE').Clear;
  //La decorrenza deve essere compresa nell''anno di riferimento!
  if (not selT254.FieldByName('DECORRENZA').IsNull) and (Copy(selT254.FieldByName('DECORRENZA').AsString,7,4) <> selT254.FieldByName('ANNO').AsString) then
  begin
    selT254.FieldByName('DECORRENZA').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_DATA_ANNO,['decorrenza']));
  end;
  //Specificare la causale di assenza per la verifica del residuo sulla quantità offerta!
  if selT254.FieldByName('CAUSALE').IsNull then
  begin
    selT254.FieldByName('CAUSALE').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_CAUSALE_NULLA,['offerta']));
  end;
  //Specificare la quantità offerta!
  if selT254.FieldByName('QUANTITA_OFFERTA').IsNull then
  begin
    selT254.FieldByName('QUANTITA_OFFERTA').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_QUANTITA_NULLA,['offerta']));
  end;
  //La quantità offerta deve essere superiore a 0!
  if ((selT254.FieldByName('UMISURA').AsString = 'G') and (selT254.FieldByName('QUANTITA_OFFERTA').AsFloat <= 0)) or
     ((selT254.FieldByName('UMISURA').AsString = 'O') and (R180OreMinutiExt(selT254.FieldByName('QUANTITA_OFFERTA').AsString) <= 0)) then
  begin
    selT254.FieldByName('QUANTITA_OFFERTA').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_QUANTITA_ZERO,['offerta']));
  end;
  //La quantità offerta non può avere decimali, deve essere un numero intero!
  if (selT254.FieldByName('UMISURA').AsString = 'G') and (Pos(',',selT254.FieldByName('QUANTITA_OFFERTA').AsString) > 0) and
     (Trim(Copy(selT254.FieldByName('QUANTITA_OFFERTA').AsString,Pos(',',selT254.FieldByName('QUANTITA_OFFERTA').AsString)+1,1)) <> '') and
     (Copy(selT254.FieldByName('QUANTITA_OFFERTA').AsString,Pos(',',selT254.FieldByName('QUANTITA_OFFERTA').AsString)+1,1) <> '0') then
  begin
    selT254.FieldByName('QUANTITA_OFFERTA').FocusControl;
    raise Exception.Create(Format(A000MSG_A177_ERR_FMT_QUANTITA_DEC,['offerta']));
  end;

  //In Insert, controllo la validità dell'offerta: decorrenza offerta between decorrenza-scadenza richiesta
  if (selT254.State = dsInsert) and (not selT254.FieldByName('ID_RICHIESTA').IsNull) then
  begin
    R180SetVariable(selT254Rich,'DEC_OFFERTA',selT254.FieldByName('DECORRENZA').AsDateTime);
    R180SetVariable(selT254Rich,'PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT254Rich,'UMISURA',selT254.FieldByName('UMISURA').AsString);
    selT254Rich.Open;
    selT254Rich.Refresh;
    selT254Rich.First;
    if selT254.FieldByName('ID_RICHIESTA').AsInteger = -1 then  //Se ID_RICHIESTA = -1 vuol dire che l'offerta è valida per tutte le richieste presenti sul db: verificare che sia presente almeno una richiesta valida
    begin
      if selT254Rich.RecordCount <= 1 then  //1 record c'è per id_richiesta -1 (tutte) quindi deve essercene almeno un'altra
      begin
        selT254.FieldByName('UMISURA').FocusControl;
        raise Exception.Create(A000MSG_A177_ERR_OFF_UMISURA);  //'Alla decorrenza specificata, non sono presenti richieste aperte valide con questa unità di misura!'
      end;
    end
    else //Se l’offerta è collegata all’ID_RICHIESTA: verificare la corrispondenza tra offerta e richiesta
    begin
      if not selT254Rich.SearchRecord('ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger,[srFromBeginning]) then
      begin
        selT254.FieldByName('DECORRENZA').FocusControl;
        raise Exception.Create(A000MSG_A177_ERR_OFF_DECORRENZA);  //'Il numero richiesta indicato non è valido alla decorrenza specificata con questa unità di misura!'
      end;
    end;
  end;
  //---------------------------------------
  //  CONTROLLI NON BLOCCANTI
  //---------------------------------------
  if (not selT254.FieldByName('CODRAGGR').IsNull) and (not selT254.FieldByName('CAUSALE').IsNull) then
  begin
    //QUANTITA_OFFERTA massimo che il dipendente può donare, 4 giorni di festività soppresse + 8 giorni di ferie (per preservare 4 settimane di ferie).
    //Questo quantitativo viene proporzionato sul part-time
    MaxOffertaFerie:=8;
    MaxOffertaFest:=4;
    MaxOffertaFerieHH:=8*ValenzaGiornata;
    MaxOffertaFestHH:=4*ValenzaGiornata;
    selT430_PT.SetVariable('PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
    selT430_PT.SetVariable('ANNO',selT254.FieldByName('ANNO').AsString);
    selT430_PT.Execute;
    if (selT430_PT.RowsProcessed > 0) and (StrToFloatDef(VarToStr(selT430_PT.Field(0)),1) <> 1) then
    begin
      MaxOffertaFerie:=R180Arrotonda(MaxOffertaFerie * StrToFloatDef(VarToStr(selT430_PT.Field(0)),1),1,'P');
      MaxOffertaFest:=R180Arrotonda(MaxOffertaFest * StrToFloatDef(VarToStr(selT430_PT.Field(0)),1),1,'P');
      MaxOffertaFerieHH:=Trunc(R180Arrotonda(MaxOffertaFerieHH * StrToFloatDef(VarToStr(selT430_PT.Field(0)),1),1,'P'));
      MaxOffertaFestHH:=Trunc(R180Arrotonda(MaxOffertaFestHH * StrToFloatDef(VarToStr(selT430_PT.Field(0)),1),1,'P'));
    end;
    if selT262.SearchRecord('CODICE',selT254.FieldByName('CODRAGGR').AsString,[srFromBeginning]) then
    begin
      if selT262.FieldByName('CODINTERNO').AsString = 'B' then  //Festività soppresse
      begin
        MaxOfferta:=MaxOffertaFest;
        MaxOffertaHH:=MaxOffertaFestHH;
      end
      else if selT262.FieldByName('CODINTERNO').AsString = 'A' then  //Ferie
      begin
        if selT262.SearchRecord('CODINTERNO','B',[srFromBeginning]) then  //se esiste anche il raggr.x le festività soppresse
        begin
          MaxOfferta:=MaxOffertaFerie;
          MaxOffertaHH:=MaxOffertaFerieHH;
        end
        else
        begin
          MaxOfferta:=MaxOffertaFerie + MaxOffertaFest;
          MaxOffertaHH:=MaxOffertaFerieHH + MaxOffertaFestHH;
        end;
      end;
    end;

    //Va controllato che il quantitativo sia residuo a fine anno - utilizzando la causale specificata
    G.Inserimento:=False;
    G.Modo:='I';
    G.Causale:=selT254.FieldByName('CAUSALE').AsString;
    R600DtM1.GetAssenze(selT254.FieldByName('PROGRESSIVO').AsInteger,StrToDate('31/12/' + selT254.FieldByName('ANNO').AsString),StrToDate('31/12/' + selT254.FieldByName('ANNO').AsString),0,G);
    if R600DtM1.UMisura = '' then
      raise Exception.Create('Il dipendente non ha le competenze della causale espresse correttamente!');
    if R600DtM1.UMisura <> selT254.FieldByName('UMISURA').AsString then
      raise Exception.Create('Il dipendente, diversamente da quanto indicato, ha le competenze della causale espresse in ' + IfThen(R600DtM1.UMisura='G','Giorni','Ore'));
    if R600DtM1.UMisura = 'G' then
      ResiduoOfferta:=StrToFloat(R600DtM1.GetResiduo)
    else
      ResiduoOffertaHH:=R180OreMinutiExt(R600DtM1.GetResiduo);
  end;
end;

procedure TA177FFerieSolidaliMW.selT254NewRecord(Tipo:String);
begin
  selT254.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('Progressivo').AsInteger;
  selT254.FieldByName('ANNO').AsInteger:=R180Anno(Parametri.DataLavoro);
  selT254.FieldByName('DECORRENZA').AsDateTime:=Parametri.DataLavoro;
  selT254.FieldByName('STATO').AsString:='A';
  selT254.FieldByName('TIPO').AsString:=Tipo;
  selT254.FieldByName('CODRAGGR').Clear;
  selT254.FieldByName('CAUSALE').Clear;
  R180SetVariable(selT262,'ANNO',selT254.FieldByName('ANNO').AsString);
  R180SetVariable(selT262,'PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
  selT262.Open;
  if selT262.RecordCount <= 0 then
    raise Exception.Create(A000MSG_A177_ERR_RAGGR_ASSENZE_DIP);     //Inserimento impossibile: dipendente senza raggruppamento assenze!
  selT262.First;
  selT254.FieldByName('UMISURA').AsString:=selT262.FieldByName('UMISURA').AsString;
  if Tipo = 'R' then  //Richiesta
  begin
    selT254.FieldByName('QUANTITA_OFFERTA').Clear;
    if selT254.FieldByName('UMISURA').AsString = 'G' then
      selT254.FieldByName('QUANTITA_RICHIESTA').AsString:='30'
    else
      selT254.FieldByName('QUANTITA_RICHIESTA').AsString:=R180MinutiOre(ValenzaGiornata * 30);
    //In inserimento, propongo max ID richiesta
    selT254_ID.Execute;
    selT254.FieldByName('ID_RICHIESTA').AsInteger:=StrToIntDef(VarToStr(selT254_ID.Field(0)),0);
    //In inserimento, propongo il primo codraggr di tipo 'ferie solidali'
    if selT260.RecordCount <= 0 then
      raise Exception.Create(A000MSG_A177_ERR_RAGGR_ASSENZE);     //Inserimento impossibile: raggruppamento assenze con inquadramento ''Ferie solidali'' assente, inserirlo nella relativa tabella!
    selT260.First;
    selT254.FieldByName('CODRAGGR').AsString:=selT260.FieldByName('CODICE').AsString;
    ImpostaCausale(selT254.FieldByName('CODRAGGR').AsString,selT254.FieldByName('UMISURA').AsString);
  end
  else
  begin
    //In inserimento, propongo il primo codraggr di tipo 'ferie/fest.soppresse'
    selT254.FieldByName('CODRAGGR').AsString:=selT262.FieldByName('CODICE').AsString;
    ImpostaCausale(selT254.FieldByName('CODRAGGR').AsString,'');
    //In inserimento, propongo ID richiesta
    selT254.FieldByName('QUANTITA_RICHIESTA').Clear;
    selT254.FieldByName('ID_RICHIESTA').Clear;
    R180SetVariable(selT254Rich,'DEC_OFFERTA',selT254.FieldByName('DECORRENZA').AsDateTime);
    R180SetVariable(selT254Rich,'PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT254Rich,'UMISURA',selT254.FieldByName('UMISURA').AsString);
    selT254Rich.Open;
    selT254Rich.Refresh;
    if selT254Rich.RecordCount = 2 then  //Ho solo una richiesta di riferimento oltre all'ID -1
    begin
      selT254Rich.Last;
      selT254.FieldByName('ID_RICHIESTA').AsInteger:=selT254Rich.FieldByName('ID_RICHIESTA').AsInteger;
    end;
  end;
end;

procedure TA177FFerieSolidaliMW.ImpostaCausale(Raggruppamento,UMisura:String);
begin
  R180SetVariable(selT265,'CODRAGGR',Raggruppamento);
  if UMisura <> '' then
    R180SetVariable(selT265,'UMISURA','AND UMISURA = ''' + UMisura + '''')
  else
    R180SetVariable(selT265,'UMISURA',' ');
  selT265.Open;
  selT265.First;
  if selT254.State = dsInsert then
    selT254.FieldByName('CAUSALE').AsString:=selT265.FieldByName('CODICE').AsString;
end;

end.
