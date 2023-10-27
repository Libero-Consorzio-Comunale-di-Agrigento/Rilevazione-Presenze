unit WR003UGeneratoreStampeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, Datasnap.DBClient,
  A000USessione, A000UMessaggi, A000UInterfaccia, C180FunzioniGenerali, WR302UGestTabellaDM, R003UGeneratoreStampeMW,
  Generics.Collections, StrUtils, medpIWMEssageDlg;

type
  TWR003FGeneratoreStampeDM = class(TWR302FGestTabellaDM)
    selTabellaAPPLICAZIONE: TStringField;
    selTabellaCODICE: TStringField;
    selTabellaTITOLO: TStringField;
    selTabellaTABELLA_GENERATA: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaFORMATO_PAGINA: TStringField;
    selTabellaORIENTAMENTO_PAGINA: TStringField;
    selTabellaCONTEGGIGIORNALIERI: TStringField;
    selTabellaCDC_PERCENTUALIZZATI: TStringField;
    selTabellaDATA_ACCESSO: TDateTimeField;
    selTabellaUTENTE_ACCESSO: TStringField;
    selTabellaSEPARAH: TStringField;
    selTabellaSEPARAV: TStringField;
    selTabellaFONTNAME: TStringField;
    selTabellaSALTOPAGINA: TStringField;
    selTabellaTOTALI: TStringField;
    selTabellaTOTPARZIALI: TStringField;
    selTabellaTOTGENERALI: TStringField;
    selTabellaFILTROESCLUSIVO: TStringField;
    selTabellaVALORENULLO: TStringField;
    selTabellaIMPOSTAZIONI: TStringField;
    selTabellaSTAMPA_TITOLO: TStringField;
    selTabellaSTAMPA_PERIODO: TStringField;
    selTabellaSTAMPA_NUMPAG: TStringField;
    selTabellaSTAMPA_DATA: TStringField;
    selTabellaSTAMPA_AZIENDA: TStringField;
    selTabellaTOTRIEPILOGO: TStringField;
    selTabellaINTESTAZIONE_COLONNE: TStringField;
    selTabellaFILTRO_INSERVIZIO: TStringField;
    selTabellaSALTOPAGINA_TOTALI: TStringField;
    selTabellaTABELLA_GENERATA_DROP: TStringField;
    selTabellaTABELLA_GENERATA_KEY: TStringField;
    selTabellaFONTSIZE: TIntegerField;
    selTabellaTABELLA_GENERATA_DELETE: TStringField;
    selTabellaSTAMPA_BLOCCATA: TStringField;
    selTabellaQUERY_INTESTAZIONE: TStringField;
    selTabellaQUERY_FINESTAMPA: TStringField;
    cdsDatiIntestazione: TClientDataSet;
    cdsDatiIntestazioneNOME: TStringField;
    cdsDatiIntestazioneCAPTION: TStringField;
    cdsDatiDettaglio: TClientDataSet;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    cdsDatiIntestazioneTOP: TIntegerField;
    cdsDatiIntestazioneLEFT: TIntegerField;
    cdsDatiIntestazioneHEIGHT: TIntegerField;
    cdsDatiIntestazioneWIDTH: TIntegerField;
    cdsDatiDettaglioFITTIZIO: TStringField;
    cdsDatiIntestazioneFITTIZIO: TStringField;
    cdsDatiIntestazioneTOTALE: TStringField;
    cdsDatiDettaglioTOTALE: TStringField;
    delT910_TempB028: TOracleQuery;
    selTabellaROTTURA_PERIODI_NON_CONTIGUI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
  private
    OldCodice: String;
    procedure CaricaImpostazioni;
  public
    R003FGeneratoreStampeMW: TR003FGeneratoreStampeMW;
    procedure AggiungiDatoAreaStampa(val: String; dest, defTop,defLeft,defWidth: Integer);
    function getListCodiciSelezionati: TList<TCodiciTabCollegate>;
    procedure CreaStampaTempB028(pCodice:String);
    procedure EliminaStampaTempB028(pCodice:String);
  end;

implementation
uses WR003UGeneratoreStampe, WR003UGeneratoreStampeDettFM;

{$R *.dfm}

procedure TWR003FGeneratoreStampeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  R003FGeneratoreStampeMW.SelT910_Funzioni:=SelTabella;
  selTabella.SetVariable('ORDERBY','ORDER BY APPLICAZIONE,CODICE');
  selTabella.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  selTabella.SetVariable('TEMP_B028','N');
  cdsDatiIntestazione.CreateDataSet;
  cdsDatiDettaglio.CreateDataSet;
  R003FGeneratoreStampeMW.CaricaDati(True);
  inherited;
end;

procedure TWR003FGeneratoreStampeDM.OnNewRecord(DataSet: TDataSet);
begin
  R003FGeneratoreStampeMW.SelT910NewRecord;
  CaricaImpostazioni;
  inherited;
end;

procedure TWR003FGeneratoreStampeDM.AggiungiDatoAreaStampa(val:String;dest:Integer; defTop,defLeft,defWidth:Integer);
var
  P: Integer;
  cdsDati: TClientDataSet;
begin
  P:=R003FGeneratoreStampeMW.GetDato(val,False);
  if P >= 0 then
  begin
    R003FGeneratoreStampeMW.Dati[P].Cont:=0;
    R003FGeneratoreStampeMW.Dati[P].ConvValuta:=False;
    R003FGeneratoreStampeMW.Dati[P].Ripetuto:=False;
  end;
  if dest = 0 then
    cdsDati:=cdsDatiIntestazione
  else
    cdsDati:=cdsDatiDettaglio;

  cdsDati.Append;
  cdsDati.FieldByName('NOME').AsString:=val;
  cdsDati.FieldByName('CAPTION').AsString:=val;
  cdsDati.FieldByName('TOP').AsInteger:=defTop;
  cdsDati.FieldByName('LEFT').AsInteger:=defLeft;
  cdsDati.FieldByName('HEIGHT').AsInteger:=16; //1em circa
  cdsDati.FieldByName('WIDTH').AsInteger:=defWidth;
  //cdsDati.FieldByName('TOTALE').AsInteger:=1;
  cdsDati.FieldByName('TOTALE').AsString:='N';
  cdsDati.Post;
  R003FGeneratoreStampeMW.modAreaStampa:=True;
end;

function TWR003FGeneratoreStampeDM.getListCodiciSelezionati:TList<TCodiciTabCollegate>;
var
  i,j: Integer;
  CodiciTabCollegate: TCodiciTabCollegate;
  ListaCodici: TListaCodici;
begin
  Result:=TList<TCodiciTabCollegate>.Create;
  for i:=0 to High(R003FGeneratoreStampeMW.TabelleCollegate) do
  begin
    with ((Self.Owner as TWR003FGeneratoreStampe).WDettaglioFM as TWR003FGeneratoreStampeDettFM) do
      ListaCodici:=getCheckListBoxTabellaCollegata(R003FGeneratoreStampeMW.TabelleCollegate[i].M);

    if ListaCodici.chklst <> nil then
    begin
      for j:=0 to ListaCodici.chklst.Items.Count - 1 do
        if ListaCodici.chklst.Selected[j] then
        begin
          CodiciTabCollegate.IdSerbatoio:=R003FGeneratoreStampeMW.TabelleCollegate[i].M;
          CodiciTabCollegate.Codice:=Trim(Copy(ListaCodici.chklst.Items[j],1,ListaCodici.Lunghezza));
          Result.add(CodiciTabCollegate);
        end;
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  R003FGeneratoreStampeMW.DeleteTabelle(selTabella.FieldByName('CODICE').AsString);
  A000AggiornaFiltroDizionario('GENERATORE DI STAMPE',selTabella.FieldByName('CODICE').AsString,'');
end;

procedure TWR003FGeneratoreStampeDM.BeforePostNoStorico(DataSet: TDataSet);
var
  lstLabelDati: TList<TLabelDati>;
  lblDati: TLabelDati;
  lstCodiciTabCollegate: TList<TCodiciTabCollegate>;
  i: Integer;
  Impostazioni: String;
begin

  if (selTabella.FieldByName('CODICE').AsString = '') then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_CODICE]),mtError,[mbOk],nil,'');
    Abort;
  end;

  inherited;
  oldCodice:=VarToStr(selTabella.FieldByName('CODICE').OldValue);
  lstLabelDati:=TList<TLabelDati>.Create;

  try
    cdsDatiIntestazione.First;

    while not cdsDatiIntestazione.Eof do
    begin
      lblDati.Nome:=cdsDatiIntestazione.FieldByName('NOME').AsString;
      lblDati.Capt:=cdsDatiIntestazione.FieldByName('CAPTION').AsString;
      if cdsDatiIntestazione.FieldByName('TOTALE').AsString = 'S' then
        lblDati.Totale:=0
      else
        lblDati.Totale:=1;
      lblDati.Y:=cdsDatiIntestazione.FieldByName('TOP').AsInteger;
      lblDati.X:=cdsDatiIntestazione.FieldByName('LEFT').AsInteger;
      lblDati.W:=cdsDatiIntestazione.FieldByName('WIDTH').AsInteger;
      lblDati.H:=cdsDatiIntestazione.FieldByName('HEIGHT').AsInteger;
      lblDati.Banda:='I';
      lstLabelDati.Add(lblDati);
      cdsDatiIntestazione.Next;
    end;

    cdsDatiDettaglio.First;

    while not cdsDatiDettaglio.Eof do
    begin
      lblDati.Nome:=cdsDatiDettaglio.FieldByName('NOME').AsString;
      lblDati.Capt:=cdsDatiDettaglio.FieldByName('CAPTION').AsString;
      if cdsDatiDettaglio.FieldByName('TOTALE').AsString = 'S' then
        lblDati.Totale:=0
      else
        lblDati.Totale:=1;
      lblDati.Y:=cdsDatiDettaglio.FieldByName('TOP').AsInteger;
      lblDati.X:=cdsDatiDettaglio.FieldByName('LEFT').AsInteger;
      lblDati.W:=cdsDatiDettaglio.FieldByName('WIDTH').AsInteger;
      lblDati.H:=cdsDatiDettaglio.FieldByName('HEIGHT').AsInteger;
      lblDati.Banda:='D';
      lstLabelDati.Add(lblDati);
      cdsDatiDettaglio.Next;
    end;
    lstCodiciTabCollegate:=getListCodiciSelezionati;

    //Registrazione Opzioni Avanzate
    Impostazioni:='';
    for i:=0 to High(R003FGeneratoreStampeMW.OpzioniAvanzate) do
    begin
      if Impostazioni <> '' then Impostazioni:=Impostazioni + ',';
      with ((Self.Owner as TWR003FGeneratoreStampe).WDettaglioFM as TWR003FGeneratoreStampeDettFM) do
        Impostazioni:=Impostazioni +
                      R003FGeneratoreStampeMW.OpzioniAvanzate[i].Opzione + '=' +
                      getValoreOpzioneAvanzata(R003FGeneratoreStampeMW.OpzioniAvanzate[i].Opzione);
    end;

    R003FGeneratoreStampeMW.SelT910BeforePost(lstLabelDati,lstCodiciTabCollegate,Impostazioni);
  finally
    FreeAndNil(lstLabelDati);
    FreeAndNil(lstCodiciTabCollegate);
  end;
end;

procedure TWR003FGeneratoreStampeDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A000AggiornaFiltroDizionario('GENERATORE DI STAMPE',OldCodice,selTabella.FieldByName('CODICE').AsString);
  R003FGeneratoreStampeMW.ElencoDatiCalcolati;
end;

procedure TWR003FGeneratoreStampeDM.AfterScroll(DataSet: TDataSet);
begin
  R003FGeneratoreStampeMW.ElencoDatiCalcolati;
  CaricaImpostazioni;
  inherited;
end;

procedure TWR003FGeneratoreStampeDM.CaricaImpostazioni;
var
  lstLabels: TList<TLabelDati>;
  lbl: TLabelDati;
  cds: TClientDataSet;
begin
  R003FGeneratoreStampeMW.modOrdinamento:=False;
  R003FGeneratoreStampeMW.modAreaStampa:=False;
  R003FGeneratoreStampeMW.modFiltro:=False;
  R003FGeneratoreStampeMW.modDettaglioSerbatoio:=False;
  cdsDatiIntestazione.EmptyDataSet;
  cdsDatiDettaglio.EmptyDataSet;
  R003FGeneratoreStampeMW.ResetOrdinamentoeCumulo;
  R003FGeneratoreStampeMW.ResetDati;
  try
    lstLabels:=R003FGeneratoreStampeMW.LetturaLabelDati;
    for lbl in lstLabels do
    begin
      if lbl.Banda = 'I' then
        cds:=cdsDatiIntestazione
      else
        cds:=cdsDatiDettaglio;

      cds.Append;
      cds.FieldByName('TOP').AsInteger:=lbl.Y;
      cds.FieldByName('LEFT').AsInteger:=lbl.X;
      cds.FieldByName('HEIGHT').AsInteger:=lbl.H;
      cds.FieldByName('WIDTH').AsInteger:=lbl.W;
      cds.FieldByName('TOTALE').AsString:=IfThen(lbl.Totale = 0 , 'S','N');
      cds.FieldByName('NOME').AsString:=lbl.Nome;
      cds.FieldByName('CAPTION').AsString:=lbl.Capt;
      cds.Post;
    end;
  finally
    FreeAndNil(lstLabels);
  end;
  R003FGeneratoreStampeMW.LetturaOrdinamento;
  R003FGeneratoreStampeMW.LetturaChiaviCumulo;
  R003FGeneratoreStampeMW.LetturaFiltriSerbatoi;
  R003FGeneratoreStampeMW.AperturaCodiciSerbatoi;
end;

procedure TWR003FGeneratoreStampeDM.CreaStampaTempB028(pCodice: String);
{Creazione stampa temporanea con nome = codice di sessione Intraweb, per esecuzione da B028 con modifiche pendenti lato IrisCloud}
var
  lblDati,labelDati: TLabelDati;
  lstLabelDati: TList<TLabelDati>;
  lstCodiciTabCollegate: TList<TCodiciTabCollegate>;
  CodiciTabCollegate: TCodiciTabCollegate;
  Impostazioni,Fmt,Colonne,Valori: String;
  P,i,j: Integer;
begin
  if pCodice = '' then
    exit;
  EliminaStampaTempB028(pCodice);
  if QueryPK1.EsisteChiave('T910_RIEPILOGO','',dsInsert,['CODICE'],[pCodice]) then
    exit;

  lstLabelDati:=TList<TLabelDati>.Create;
  try
    cdsDatiIntestazione.First;

    while not cdsDatiIntestazione.Eof do
    begin
      lblDati.Nome:=cdsDatiIntestazione.FieldByName('NOME').AsString;
      lblDati.Capt:=cdsDatiIntestazione.FieldByName('CAPTION').AsString;
      if cdsDatiIntestazione.FieldByName('TOTALE').AsString = 'S' then
        lblDati.Totale:=0
      else
        lblDati.Totale:=1;
      lblDati.Y:=cdsDatiIntestazione.FieldByName('TOP').AsInteger;
      lblDati.X:=cdsDatiIntestazione.FieldByName('LEFT').AsInteger;
      lblDati.W:=cdsDatiIntestazione.FieldByName('WIDTH').AsInteger;
      lblDati.H:=cdsDatiIntestazione.FieldByName('HEIGHT').AsInteger;
      lblDati.Banda:='I';
      lstLabelDati.Add(lblDati);
      cdsDatiIntestazione.Next;
    end;

    cdsDatiDettaglio.First;

    while not cdsDatiDettaglio.Eof do
    begin
      lblDati.Nome:=cdsDatiDettaglio.FieldByName('NOME').AsString;
      lblDati.Capt:=cdsDatiDettaglio.FieldByName('CAPTION').AsString;
      if cdsDatiDettaglio.FieldByName('TOTALE').AsString = 'S' then
        lblDati.Totale:=0
      else
        lblDati.Totale:=1;
      lblDati.Y:=cdsDatiDettaglio.FieldByName('TOP').AsInteger;
      lblDati.X:=cdsDatiDettaglio.FieldByName('LEFT').AsInteger;
      lblDati.W:=cdsDatiDettaglio.FieldByName('WIDTH').AsInteger;
      lblDati.H:=cdsDatiDettaglio.FieldByName('HEIGHT').AsInteger;
      lblDati.Banda:='D';
      lstLabelDati.Add(lblDati);
      cdsDatiDettaglio.Next;
    end;
    lstCodiciTabCollegate:=getListCodiciSelezionati;

    //Registrazione Opzioni Avanzate
    Impostazioni:='';
    for i:=0 to High(R003FGeneratoreStampeMW.OpzioniAvanzate) do
    begin
      if Impostazioni <> '' then Impostazioni:=Impostazioni + ',';
      with ((Self.Owner as TWR003FGeneratoreStampe).WDettaglioFM as TWR003FGeneratoreStampeDettFM) do
        Impostazioni:=Impostazioni +
                      R003FGeneratoreStampeMW.OpzioniAvanzate[i].Opzione + '=' +
                      getValoreOpzioneAvanzata(R003FGeneratoreStampeMW.OpzioniAvanzate[i].Opzione);
    end;

    //R003FGeneratoreStampeMW.SelT910BeforePost(lstLabelDati,lstCodiciTabCollegate,Impostazioni);
    // |||| //
    // VVVV //
    R003FGeneratoreStampeMW.Ins911.ClearVariables;
    R003FGeneratoreStampeMW.Ins911.SetVariable('CODICE',pCodice);
    //Registrazione dati intestazione
    for labelDati in lstLabelDati do
    begin
      P:=R003FGeneratoreStampeMW.GetDato(labelDati.nome,False);
      if P >= 0 then
      begin
        R003FGeneratoreStampeMW.Ins911.SetVariable('NOME',labelDati.Nome);
        R003FGeneratoreStampeMW.Ins911.SetVariable('CAPTION',labelDati.Capt);
        R003FGeneratoreStampeMW.Ins911.SetVariable('TOTALE',IfThen(labelDati.Totale = 0,'S','N'));
        R003FGeneratoreStampeMW.Ins911.SetVariable('POST',labelDati.Y);
        R003FGeneratoreStampeMW.Ins911.SetVariable('POSL',labelDati.X);
        R003FGeneratoreStampeMW.Ins911.SetVariable('LUNG',labelDati.W);
        R003FGeneratoreStampeMW.Ins911.SetVariable('ALT',labelDati.H);
        R003FGeneratoreStampeMW.Ins911.SetVariable('BANDA',labelDati.Banda);
        R003FGeneratoreStampeMW.Ins911.SetVariable('CONTATORE',IfThen(R003FGeneratoreStampeMW.Dati[P].Cont = 0,'N','S'));
        //Registrazione del formato per DataConteggio,Giustificativi e Timbrature
        Fmt:=IfThen(R003FGeneratoreStampeMW.Dati[P].Fex = 'S',R003FGeneratoreStampeMW.Dati[P].Fmt,'');
        R003FGeneratoreStampeMW.Ins911.SetVariable('FORMATO',Copy(Fmt,1,2000));
        R003FGeneratoreStampeMW.Ins911.SetVariable('CDC_PERCENTUALIZZATI',IfThen(R003FGeneratoreStampeMW.Dati[P].CDCPerc,'S','N'));
        R003FGeneratoreStampeMW.Ins911.SetVariable('CONV_VALUTA',IfThen(R003FGeneratoreStampeMW.Dati[P].ConvValuta,'S','N'));
        R003FGeneratoreStampeMW.Ins911.SetVariable('RIPETUTO',IfThen(R003FGeneratoreStampeMW.Dati[P].Ripetuto,'S','N'));
        try
          R003FGeneratoreStampeMW.Ins911.Execute;
        except
        end;
      end;
    end;
    //Registrazione dati ordinamento
    R003FGeneratoreStampeMW.Ins912.SetVariable('CODICE',pCodice);
    for i:=0 to High(R003FGeneratoreStampeMW.Ordinamento) do
    begin
      R003FGeneratoreStampeMW.Ins912.SetVariable('POS',i);
      R003FGeneratoreStampeMW.Ins912.SetVariable('NOME',R003FGeneratoreStampeMW.Ordinamento[i].Nome);
      R003FGeneratoreStampeMW.Ins912.SetVariable('TIPO',IfThen(R003FGeneratoreStampeMW.Ordinamento[i].Discendente,'D','C'));
      R003FGeneratoreStampeMW.Ins912.SetVariable('ROTTKEY',IfThen(R003FGeneratoreStampeMW.Ordinamento[i].Rottura,'S','N'));
      try
        R003FGeneratoreStampeMW.Ins912.Execute;
      except
      end;
    end;
    //Registrazione chiavi di cumulo e filtro dei serbatoi
    R003FGeneratoreStampeMW.Ins913.SetVariable('CODICE',pCodice);
    R003FGeneratoreStampeMW.Ins914.SetVariable('CODICE',pCodice);
    for i:=0 to High(R003FGeneratoreStampeMW.Serbatoi) do
    begin
      R003FGeneratoreStampeMW.Ins913.SetVariable('ID_SERBATOIO',R003FGeneratoreStampeMW.Serbatoi[i].M);
      R003FGeneratoreStampeMW.Ins914.SetVariable('ID_SERBATOIO',R003FGeneratoreStampeMW.Serbatoi[i].M);
      for j:=0 to High(R003FGeneratoreStampeMW.Serbatoi[i].KeyCumulo) do
      begin
        R003FGeneratoreStampeMW.Ins913.SetVariable('POS',j);
        R003FGeneratoreStampeMW.Ins913.SetVariable('DATO',R003FGeneratoreStampeMW.Serbatoi[i].KeyCumulo[j].Nome);
        R003FGeneratoreStampeMW.Ins913.SetVariable('TOTALE',IfThen(R003FGeneratoreStampeMW.Serbatoi[i].KeyCumulo[j].Totale,'S','N'));
        R003FGeneratoreStampeMW.Ins913.Execute;
      end;
      R003FGeneratoreStampeMW.Ins914.SetVariable('ESCLUSIVO',IfThen(R003FGeneratoreStampeMW.Serbatoi[i].Esclusivo,'S','N'));
      R003FGeneratoreStampeMW.Ins914.SetVariable('FILTRO',Trim(R003FGeneratoreStampeMW.Serbatoi[i].FiltroTxt));
      R003FGeneratoreStampeMW.Ins914.SetVariable('DATO_DALAL',Trim(R003FGeneratoreStampeMW.Serbatoi[i].DatoDalAl));
      R003FGeneratoreStampeMW.Ins914.Execute;
    end;
    //Registrazione codici selezionati impostati sulle Check List
    R003FGeneratoreStampeMW.Ins915.SetVariable('CODICE',pCodice);
    for CodiciTabCollegate  in lstCodiciTabCollegate do
    begin
      R003FGeneratoreStampeMW.Ins915.SetVariable('ID_SERBATOIO',CodiciTabCollegate.IdSerbatoio);
      R003FGeneratoreStampeMW.Ins915.SetVariable('DATO',CodiciTabCollegate.Codice);
      R003FGeneratoreStampeMW.Ins915.Execute;
    end;

    Colonne:='';
    Valori:='';
    Colonne:=Colonne + IfThen(Colonne <> '',',') + 'CODICE';
    Valori:=Valori + IfThen(Valori <> '',',') + Format('''%s''',[pCodice]);
    Colonne:=Colonne + IfThen(Colonne <> '',',') + 'TEMP_B028';
    Valori:=Valori + IfThen(Valori <> '',',') + Format('''%s''',['S']);
    Colonne:=Colonne + IfThen(Colonne <> '',',') + 'TEMP_B028_CODICE';
    Valori:=Valori + IfThen(Valori <> '',',') + Format('''%s''',[selTabella.FieldByName('CODICE').AsString]);
    Colonne:=Colonne + IfThen(Colonne <> '',',') + 'IMPOSTAZIONI';
    Valori:=Valori + IfThen(Valori <> '',',') + Format('''%s''',[AggiungiApice(Impostazioni)]);
    for i:=0 to selTabella.FieldCount - 1 do
    begin
      if selTabella.Fields[i].FieldKind <> fkData then
        Continue;
      if R180In(selTabella.Fields[i].FieldName,['CODICE','TEMP_B028','TEMP_B028_CODICE','IMPOSTAZIONI','DATA_ACCESSO','UTENTE_ACCESSO']) then
        Continue;
      Colonne:=Colonne + IfThen(Colonne <> '',',') + selTabella.Fields[i].FieldName;
      Valori:=Valori + IfThen(Valori <> '',',') + Format('''%s''',[AggiungiApice(selTabella.Fields[i].AsString)]);
      //Registrazione Opzioni Avanzate
    end;
    R003FGeneratoreStampeMW.InsT910.SQL.Clear;
    R003FGeneratoreStampeMW.InsT910.SQL.Add('insert into T910_RIEPILOGO');
    R003FGeneratoreStampeMW.InsT910.SQL.Add(Format('(%s)',[Colonne]));
    R003FGeneratoreStampeMW.InsT910.SQL.Add(Format('values (%s)',[Valori]));
    R003FGeneratoreStampeMW.InsT910.Execute;
    SessioneOracle.Commit;

  finally
    FreeAndNil(lstLabelDati);
    FreeAndNil(lstCodiciTabCollegate);
  end;

end;

procedure TWR003FGeneratoreStampeDM.EliminaStampaTempB028(pCodice: String);
{Eliminazione stampa temporanea creata da IrisCloud}
begin
  delT910_TempB028.SetVariable('CODICE',pCodice);
  delT910_TempB028.Execute;
  SessioneOracle.Commit;
end;

procedure TWR003FGeneratoreStampeDM.selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('GENERATORE DI STAMPE',DataSet.FieldByName('CODICE').AsString)
end;

end.
