unit WA182UPermessiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, USelI010,
  A000UCostanti, A000USessione, L021Call,A000UMessaggi;

type
  TWA182FPermessiDM = class(TWR302FGestTabellaDM)
    DbIris008B: TOracleSession;
    selT033: TOracleDataSet;
    dsrT033: TDataSource;
    QI090: TOracleDataSet;
    D090: TDataSource;
    selPermessi: TOracleDataSet;
    selTabellaPROFILO: TStringField;
    selTabellaCANCELLA_TIMBRATURE: TStringField;
    selTabellaABILITA_SCHEDE_CHIUSE: TStringField;
    selTabellaT100_ORA: TStringField;
    selTabellaT100_RILEVATORE: TStringField;
    selTabellaT100_CAUSALE: TStringField;
    selTabellaA029_SALDI: TStringField;
    selTabellaA029_INDENNITA: TStringField;
    selTabellaA029_STRAORDINARIO: TStringField;
    selTabellaA029_CAUPRESENZA: TStringField;
    selTabellaLIQUIDAZIONE_FORZATA: TStringField;
    selTabellaINSERIMENTO_MATRICOLE: TStringField;
    selTabellaSTORICIZZAZIONE: TStringField;
    selTabellaLAYOUT: TStringField;
    selTabellaRIPRISTINO_TIMB_ORI: TStringField;
    selTabellaCANCELLAZIONE_DATI: TStringField;
    selTabellaMONITOR_INTEGRANAGRA: TStringField;
    selTabellaELIMINA_DATA_CASSA: TStringField;
    selTabellaRICREA_SCARICO_PAGHE: TStringField;
    selTabellaC700_SALVASELEZIONI: TStringField;
    selTabellaA058_OPERATIVA: TStringField;
    selTabellaA058_NONOPERATIVA: TStringField;
    selTabellaA094_MESE: TStringField;
    selTabellaA094_ANNO: TStringField;
    selTabellaA094_RAGGR: TStringField;
    selTabellaDEF_TIPO_PERSONALE: TStringField;
    selTabellaMOD_PERSONALE_ESTERNO: TStringField;
    selTabellaA131_ANTICIPIGESTIBILI: TStringField;
    selTabellaAZIENDA: TStringField;
    selTabellaINSERISCI_TIMBRATURE: TStringField;
    selTabellaT040_VALIDAZIONE: TStringField;
    selTabellaSERVIZI_COMANDATI: TStringField;
    selTabellaSERVIZI_BLOCCO: TStringField;
    selTabellaSERVIZI_SBLOCCO: TStringField;
    selTabellaDATIC700: TStringField;
    selTabellaWEB_ITERTIMB_GGPREC: TIntegerField;
    selTabellaWEB_ITERASS_GGPREC: TIntegerField;
    selTabellaWEB_ITERASS_GGSUCC: TIntegerField;
    selTabellaWEB_CARTELLINI_DATAMIN: TDateTimeField;
    selTabellaWEB_CARTELLINI_MMPREC: TIntegerField;
    selTabellaWEB_CARTELLINI_MMSUCC: TIntegerField;
    selTabellaWEB_CARTELLINI_CHIUSI: TStringField;
    selTabellaWEB_CEDOLINI_DATAMIN: TDateTimeField;
    selTabellaWEB_CEDOLINI_MMPREC: TIntegerField;
    selTabellaWEB_CEDOLINI_GGEMISS: TIntegerField;
    selTabellaS710_SUPERVISOREVALUT: TStringField;
    selTabellaMODIFICA_DATI_PROTETTI: TStringField;
    selTabellaELIMINA_STORICI: TStringField;
    selTabellaT100_CANC_ORIGINALI: TStringField;
    selTabellaS710_MOD_VALUTATORE: TStringField;
    selTabellaS710_STATI_ABILITATI: TStringField;
    selSG746: TOracleDataSet;
    selTabellaS710_VALIDA_STATO: TStringField;
    selTabellaWEB_RICHIESTA_CONSEGNA_CED: TStringField;
    selTabellaWEB_CEDOLINI_FILEPDF: TStringField;
    selTabellaWEB_RICHIESTA_CONSEGNA_VAL: TStringField;
    selTabellaI060_PASSWORD: TStringField;
    selTabellaI070_PASSWORD: TStringField;
    selTabellaMODIFICA_DECORRENZA: TStringField;
    selTabellaINSERIMENTO_MATRICOLE_P430: TStringField;
    selTabellaSTORICIZZAZIONE_P430: TStringField;
    selTabellaMODIFICA_DECORRENZA_P430: TStringField;
    selTabellaELIMINA_STORICI_P430: TStringField;
    selTabellaACCESSIBILITA_NONVEDENTI: TStringField;
    selTabellaSTORIA_INIZIO_FINE: TStringField;
    selTabellaDOWNLOAD_MASSIVO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selI010AfterOpen(DataSet: TDataSet);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaWEB_DATAMINSetText(Sender: TField; const Text: string);
    procedure AfterScroll(DataSet: TDataSet); override;
  private
    VecchiaAzienda:String;
    selI010:TSelI010;
  public
    function ProfiloUtilizzato:Boolean;
  end;

implementation

uses WA182UPermessi, WA182UPermessiDettFM;

{$R *.dfm}

procedure TWA182FPermessiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY AZIENDA,PROFILO');
  NonAprireSelTabella:=True;
  VecchiaAzienda:='';

  inherited;

  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';
  if Parametri.Azienda <> 'AZIN' then
  begin
    selTabella.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selTabella.Filtered:=True;
    QI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    QI090.Filtered:=True;
  end;
  selI010:=TselI010.Create(Self);
  selI010.AfterOpen:=selI010AfterOpen;
  QI090.Open;
  selTabella.Open;
end;

procedure TWA182FPermessiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  //Apertura del database indicato dall'Azienda
  if selTabella.FieldByName('AZIENDA').AsString <> VecchiaAzienda then
  begin
    VecchiaAzienda:=selTabella.FieldByName('AZIENDA').AsString;
    if QI090.SearchRecord('AZIENDA',selTabella.FieldByName('AZIENDA').AsString,[srFromBeginning]) then
      with DbIris008B do
      begin
        if (not Connected) or
           (UpperCase(LogonUserName) <> UpperCase(QI090.FieldByName('UTENTE').AsString)) then
        begin
          Logoff;
          LogonDataBase:=Parametri.Database;
          LogonUserName:=QI090.FieldByName('UTENTE').AsString;
          LogonPassword:=R180Decripta(QI090.FieldByName('PAROLACHIAVE').AsString,21041974);
          Preferences.UseOCI7:=False;
          BytesPerCharacter:=bc1Byte;
        end;
        {$IFDEF IRISWEB}
          ThreadSafe:=True;
        {$ENDIF}
        Logon;
        selT033.Open;
        selI010.Apri(DbIris008B,'',Parametri.Applicazione,'','','');
        TWA182FPermessi(Self.Owner).MessaggioStatus(INFORMA,'');
      end;
  end;
end;

procedure TWA182FPermessiDM.BeforePostNoStorico(DataSet: TDataSet);
begin

  if (selTabella.State = dsEdit) and
     ((selTabella.FieldByName('AZIENDA').Value <> selTabella.FieldByName('AZIENDA').medpOldValue) or (selTabella.FieldByName('PROFILO').Value <> selTabella.FieldByName('PROFILO').medpOldValue)) then
    if ProfiloUtilizzato then
      raise Exception.Create(A000MSG_ERR_MODIFICA_PROFILO);

  inherited;
  selTabella.FieldByName('WEB_CARTELLINI_DATAMIN').AsDateTime:=R180InizioMese(selTabella.FieldByName('WEB_CARTELLINI_DATAMIN').AsDateTime);
  selTabella.FieldByName('WEB_CEDOLINI_DATAMIN').AsDateTime:=R180InizioMese(selTabella.FieldByName('WEB_CEDOLINI_DATAMIN').AsDateTime);
end;

procedure TWA182FPermessiDM.selTabellaWEB_DATAMINSetText(Sender: TField; const Text: string);
begin
  inherited;
  try
    if Text = '' then
      Sender.Clear
    else
      Sender.AsDateTime:=StrToDateTime('01/' + Text);
  except
      Sender.Clear;
  end;
end;

procedure TWA182FPermessiDM.selI010AfterOpen(DataSet: TDataSet);
{Lettura dei nomi di colonna validi per l'azienda selezionata}
begin
  if TWA182FPermessiDettFM(TWA182FPermessi(Self.Owner).WDettaglioFM) <> nil then
    with TWA182FPermessiDettFM(TWA182FPermessi(Self.Owner).WDettaglioFM)do
    begin
      lstNomeCampo.Clear;
      while not selI010.Eof do
      begin
        lstNomeCampo.Add(selI010.FieldByName('NOME_CAMPO').AsString);
        selI010.Next;
      end;
    end;
end;

procedure TWA182FPermessiDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TDateTimeField(selTabella.FieldByName('WEB_CARTELLINI_DATAMIN')).OnSetText:=selTabellaWEB_DATAMINSetText;
  TDateTimeField(selTabella.FieldByName('WEB_CEDOLINI_DATAMIN')).OnSetText:=selTabellaWEB_DATAMINSetText;
  TDateTimeField(selTabella.FieldByName('WEB_CARTELLINI_DATAMIN')).EditMask:='!00/0000;1;_';
  TDateTimeField(selTabella.FieldByName('WEB_CARTELLINI_DATAMIN')).DisplayFormat:='mm/yyyy';
  TDateTimeField(selTabella.FieldByName('WEB_CEDOLINI_DATAMIN')).EditMask:='!00/0000;1;_';
  TDateTimeField(selTabella.FieldByName('WEB_CEDOLINI_DATAMIN')).DisplayFormat:='mm/yyyy';
end;

function TWA182FPermessiDM.ProfiloUtilizzato:Boolean;
begin
  with selPermessi do
  begin
    Close;
    if selTabella.State = dsEdit then
    begin
      SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').medpOldValue);
      SetVariable('PROFILO',selTabella.FieldByName('PROFILO').medpOldValue);
    end
    else
    begin
      SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
      SetVariable('PROFILO',selTabella.FieldByName('PROFILO').AsString);
    end;
    Open;
    Result:=RecordCount > 0;
    Close;
  end;
end;

end.
