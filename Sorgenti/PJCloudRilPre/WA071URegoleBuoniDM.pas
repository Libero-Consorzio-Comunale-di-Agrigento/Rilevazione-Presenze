unit WA071URegoleBuoniDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, A000UCostanti, A000USessione, medpIWMessageDlg,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, C180FunzioniGenerali, A000UMessaggi;

type
  TWA071FRegoleBuoniDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaPASTO_TICKET: TStringField;
    selTabellaASSENZA: TStringField;
    selTabellaPRESENZA: TStringField;
    selTabellaOREMINIME: TDateTimeField;
    selTabellaCAUS_TICKET: TStringField;
    selTabellaDA1: TDateTimeField;
    selTabellaA1: TDateTimeField;
    selTabellaDA2: TDateTimeField;
    selTabellaA2: TDateTimeField;
    selTabellaD_Codice: TStringField;
    selTabellaNONLAVORATIVO: TStringField;
    selTabellaFORZAMATURAZIONE: TStringField;
    selTabellaINIBMATURAZIONE: TStringField;
    selTabellaORARISPEZZATI: TStringField;
    selTabellaINTERVALLOMIN: TStringField;
    selTabellaINTERVALLOMAX: TStringField;
    selTabellaMESE_ASSENZE: TIntegerField;
    selTabellaORE_MATTINA: TStringField;
    selTabellaORE_POMERIGGIO: TStringField;
    selTabellaCONGUAGLIO_MAX: TIntegerField;
    selTabellaPERIODICITA_ACQUISTO: TStringField;
    selTabellaACQUISTO_TEORICO: TStringField;
    selTabellaHHMIN_ACQUISTO: TStringField;
    selTabellaASSENZE_ACQUISTO: TStringField;
    selTabellaMEDIAMAX_ACQUISTO: TIntegerField;
    selTabellaMEDIAMIN_ACQUISTO: TIntegerField;
    selTabellaACCESSI_MENSA: TStringField;
    selTabellaACQUISTO_MINIMO: TIntegerField;
    selTabellaRESTITUZIONE_MAX: TIntegerField;
    selTabellaPAUSA_MENSA: TStringField;
    selTabellaMISSIONI: TStringField;
    selTabellaDEBITO_GIORN_MIN: TStringField;
    selTabellaGIORNI_FISSI: TStringField;
    selTabellaECCEDENZA_MIN: TStringField;
    selTabellaNUM_MAX_BUONI: TIntegerField;
    selTabellaCONGUAGLIO_PREC_MAX: TIntegerField;
    selTabellaRESIDUO_PRECEDENTE: TDateTimeField;
    selTabellaOREMIN_NETTOPM: TStringField;
    selTabellaINIZIO_POMERIGGIO: TStringField;
    selTabellaPAUSA_MENSA_GESTITA: TStringField;
    selTabellaOREMINIME_FASCE: TStringField;
    selTabellaINTERVALLO_EFFETTIVO: TStringField;
    selTabellaFASCIA1_ESCLUSIVA: TStringField;
    selTabellaREGOLA_SUCCESSIVA: TStringField;
    selTabellaD_RegolaSuccessiva: TStringField;
    selT670lkp: TOracleDataSet;
    dsrT670lkp: TDataSource;
    DSource: TDataSource;
    QSource: TOracleDataSet;
    QTabs: TOracleDataSet;
    Q265: TOracleDataSet;
    Q275: TOracleDataSet;
    Q305: TOracleDataSet;
    selTabellaFASCE_MATPOM_PMT: TStringField;
    selTabellaREGOLA_RIENTRO_POMERIDIANO: TStringField;
    selTabellaRIENTRO_MASSIMO_PM: TStringField;
    selTabellaTIPO_GIORNI_FISSI: TStringField;
    selTabellaDEBITO_MIN: TStringField;
    selTabellaDEBITO_MAX: TStringField;
    selTabellaASSENZA_PM: TStringField;
    selTabellaGGLAV_SEMPRE_CALENDARIO: TStringField;
    selTabellaGGLAV_NOPIANIF_CALENDARIO: TStringField;
    selTabellaTURNILAV_GG: TIntegerField;
    selTabellaTURNILAV_ORE: TStringField;
    selTabellaRECUPERO_DEBITO_START: TDateTimeField;
    selTabellaRECUPERO_DEBITO_MM: TIntegerField;
    selTabellaSALDO_ANNUO_MINIMO: TStringField;
    selTabellaINTERVALLO_INTERNO_PMT: TStringField;
    selTabellaACQUISTO_QUANTITA: TIntegerField;
    selTabellaNUM_MAX_BUONI_SETTIMANA: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaA2GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure selTabellaOREMINIMEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure selTabellaRESIDUO_PRECEDENTESetText(Sender: TField;
      const Text: string);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selTabellaRECUPERO_DEBITO_STARTGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure selTabellaRECUPERO_DEBITO_STARTSetText(Sender: TField;
      const Text: string);
  private

  public
  end;

implementation

{$R *.dfm}

uses WA071URegoleBuoni, WA071URegoleBuoniDettFM, WR100UBase;

procedure TWA071FRegoleBuoniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  try
    NonAprireSelTabella:=True;
    inherited;
    if A000LookupTabella(Parametri.CampiRiferimento.C4_BuoniMensa,QSource) then
    begin
      if QSource.VariableIndex('DECORRENZA') >= 0 then
        QSource.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
      QSource.Open;
      Q265.Open;
      Q275.Open;
      Q305.Open;
      selTabella.Open;
    end
    else
      raise Exception.Create(A000MSG_A071_ERR_DATO_NON_SPECIF);
  except
    Abort;
  end;
end;

procedure TWA071FRegoleBuoniDM.selTabellaA2GetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then Text:=''
  else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TWA071FRegoleBuoniDM.selTabellaOREMINIMEGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TWA071FRegoleBuoniDM.selTabellaRECUPERO_DEBITO_STARTGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('mm/yyyy',Sender.AsDateTime);
end;

procedure TWA071FRegoleBuoniDM.selTabellaRECUPERO_DEBITO_STARTSetText(
  Sender: TField; const Text: string);
begin
  inherited;
  if Trim(Text) <> '/' then
    Sender.AsString:=FormatDateTime('dd/mm/yyyy',StrToDate('01/' + Text))
  else
    Sender.Clear;
end;

procedure TWA071FRegoleBuoniDM.selTabellaRESIDUO_PRECEDENTESetText(
  Sender: TField; const Text: string);
begin
  inherited;
  try
    if Text = '' then
      selTabellaResiduo_Precedente.Clear
    else
      selTabellaResiduo_Precedente.AsDateTime:=StrToDateTime('01/' + Text);
  except
    selTabellaResiduo_Precedente.Clear;
  end;
end;

procedure TWA071FRegoleBuoniDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  selT670lkp.Close;
  selT670lkp.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
  selT670lkp.Open;
end;

procedure TWA071FRegoleBuoniDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  try
    R180OraValidate(TWA071FRegoleBuoniDettFM(TWA071FRegoleBuoni(Self.Owner).WDettaglioFM).dedtDebitoGiornMin.Text);
  except
     MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_VALORE_NON_CORRETTO,['Debito Giornaliero Minimo']),mtError,[mbOk],nil,'');
     Abort;
  end;
  try
    R180OraValidate(TWA071FRegoleBuoniDettFM(TWA071FRegoleBuoni(Self.Owner).WDettaglioFM).dedtEccedenzaMin.Text);
  except
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_VALORE_NON_CORRETTO,['Eccedenza Giornaliera Minima']),mtError,[mbOk],nil,'');
    Abort;
  end;
  if not(selTabellaDa1.IsNull) and not(selTabellaA1.IsNull) then
    if selTabellaDa1.AsDateTime >= selTabellaA1.AsDateTime then
      raise Exception.Create(Format(A000MSG_ERR_FMT_PERIODO_NON_CORRETTO,['1°fascia di maturazione']));
  if not(selTabellaDa2.IsNull) and not(selTabellaA2.IsNull) then
    if selTabellaDa2.AsDateTime >= selTabellaA2.AsDateTime then
      raise Exception.Create(Format(A000MSG_ERR_FMT_PERIODO_NON_CORRETTO,['2°fascia di maturazione']));
  if R180OreMinutiExt(selTabellaIntervalloMin.AsString) >
     R180OreMinutiExt(selTabellaIntervalloMax.AsString) then
    raise Exception.Create(Format(A000MSG_ERR_FMT_PERIODO_NON_CORRETTO,['Intervallo Mensa']));

  with TWA071FRegoleBuoniDettFM(TWA071FRegoleBuoni(Self.Owner).WDettaglioFM) do
    if (selTabella.State in [dsBrowse,dsEdit,dsInsert]) and (selTabella.FieldByNaME(dedtDA1.DataField) <> nil) then
      if (selTabella.FieldByName('OREMINIME_FASCE').AsString = 'S') or (selTabella.FieldByName('OREMINIME_FASCE').AsString = 'E') then
        if (selTabella.FieldByNaME(dedtDA1.DataField).IsNull or selTabella.FieldByNaME(dedtDA1.DataField).IsNull) and
           (selTabella.FieldByNaME(dedtDA1.DataField).IsNull or selTabella.FieldByNaME(dedtDA1.DataField).IsNull) then
          raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO, ['Fascia']));
end;

end.
