unit WA052UParCarDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A052UParCarMW,
  Datasnap.DBClient, Generics.Collections, A000UMessaggi, A000UInterfaccia, medpIWMessageDlg;

type
  TWA052FParCarDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaSEPARARIGHE: TStringField;
    selTabellaSEPARADATI: TStringField;
    selTabellaANOMALIA: TStringField;
    selTabellaFESTIVO: TStringField;
    selTabellaNONLAV: TStringField;
    selTabellaGRASSETTO: TStringField;
    selTabellaRAGIONE_SOCIALE: TStringField;
    selTabellaDATA_STAMPA: TStringField;
    selTabellaNUM_PAGINE: TStringField;
    selTabellaMARGINE_SUP: TIntegerField;
    selTabellaLOGO_LARGHEZZA: TIntegerField;
    selTabellaANOMALIE2: TStringField;
    selTabellaANOMALIE3: TStringField;
    selTabellaORIENTAMENTO: TStringField;
    selTabellaCAUPRES_ESCLUSE: TStringField;
    selTabellaINTESTAZIONE_RIPETUTA: TStringField;
    selTabellaCAUPRES: TStringField;
    selTabellaCAUASS_NO_RIEPILOGO: TStringField;
    selTabellaTIMBRATURE_MANUALI: TStringField;
    selTabellaCARTELLINI_VALIDATI: TStringField;
    ClientDataSet1: TClientDataSet;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
  private
    procedure ImpostaClientDataset(cds: TClientDataset);
    procedure cdsBeforePost(DataSet: TDataSet);
    procedure cdsBeforeDelete(DataSet: TDataSet);
  public
    dicCdsLabels: TDictionary<String,TClientDataset>;
    A052FParCarMW: TA052FParCarMW;
    procedure CaricaClientDataset(cds: TClientDataset; Sezione: TSezione);
  end;

implementation

{$R *.dfm}

procedure TWA052FParCarDM.IWUserSessionBaseCreate(Sender: TObject);
var
  s: String;
  cds: TClientDataset;
begin
  NonAprireSelTabella:=True;
  inherited;
  A052FParCarMW:=TA052FParCarMW.Create(Self);
  A052FParCarMW.SelT950_Funzioni:=selTabella;
  dicCdsLabels:=TDictionary<String,TClientDataset>.Create;
  for s in TSezione.ELENCO_SEZIONI do
  begin
    cds:=TClientDataSet.Create(Self);
    cds.Name:=s;
    ImpostaClientDataset(cds);
    dicCdsLabels.Add(s,cds);
  end;
  selTabella.Open;
end;

procedure TWA052FParCarDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A052FParCarMW.selT950AfterDelete;
end;

procedure TWA052FParCarDM.AfterPost(DataSet: TDataSet);
begin
  A052FParCarMW.selT950AfterPost; //eseguire prima di inherited perchè fa locate che scatena afterscroll e quindi ricaricamento
  inherited;
end;

procedure TWA052FParCarDM.AfterScroll(DataSet: TDataSet);
var
  s,Msg: string;
  lstErrori: TStringList;
begin
  lstErrori:=A052FParCarMW.SelT950AfterScroll;
  Msg:='';
  for s in lstErrori do
  begin
    msg:=s + #13#10;
  end;
  if Msg <> '' then
    MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,''); //non fare abort

  FreeAndNil(lstErrori);
  for s in A052FParCarMW.dicSezioni.Keys do
  begin
    CaricaClientDataset(dicCdsLabels[s],A052FParCarMW.dicSezioni[s]);
  end;

  inherited;
end;

procedure TWA052FParCarDM.ImpostaClientDataset(cds: TClientDataset);
begin
  cds.FieldDefs.Add('NOMECAMPO',ftString,50,True);
  cds.FieldDefs.Add('CAMPOVIS',ftString,50,True);
  cds.FieldDefs.Add('UNIQUENAME',ftString,100,True);
  cds.FieldDefs.Add('CAPTION',ftString,50,False);
  cds.FieldDefs.Add('LARGH',ftString,3,True);
  cds.FieldDefs.Add('ALT',ftString,3,True);
  cds.FieldDefs.Add('SINISTRA',ftString,3,True);
  cds.FieldDefs.Add('ALTO',ftString,3,True);
  cds.FieldDefs.Add('TAG',ftInteger,0,False);
  cds.CreateDataSet;
end;

procedure TWA052FParCarDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A052FParCarMW.selT950BeforeDelete;
end;

procedure TWA052FParCarDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A052FParCarMW.selT950BeforePost;
  inherited;
end;

procedure TWA052FParCarDM.CaricaClientDataset(cds: TClientDataset; Sezione: TSezione);
var LabelProperties: TLabelProperties;
begin
  cds.BeforePost:=nil;
  cds.BeforeDelete:=nil;
  cds.EmptyDataSet;
  for LabelProperties in Sezione.LstLabels do
  begin
    cds.Append;
    cds.FieldByName('NOMECAMPO').AsString:=LabelProperties.Name;
    cds.FieldByName('NOMECAMPO').Visible:=False;
    //per intestazione viene salvato il nome_campo ma visualizzato il nome_logico

    cds.FieldByName('CAMPOVIS').AsString:=LabelProperties.Name;
    if (sezione.Name = TSezione.INTESTAZIONE) then
    begin
      A052FParCarMW.selI010.SearchRecord('NOME_CAMPO',LabelProperties.Name,[srFromBeginning]);
      cds.FieldByName('CAMPOVIS').AsString:=A052FParCarMW.selI010.FieldByName('NOME_LOGICO').AsString;
    end;
    cds.FieldByName('CAMPOVIS').DisplayLabel:='Campo';

    cds.FieldByName('UNIQUENAME').AsString:=LabelProperties.UniqueName;
    cds.FieldByName('UNIQUENAME').Visible:=False;

    cds.FieldByName('CAPTION').AsString:=LabelProperties.Caption;
    cds.FieldByName('CAPTION').DisplayLabel:='Caption';
    cds.FieldByName('LARGH').AsInteger:=LabelProperties.Width;
    cds.FieldByName('LARGH').DisplayLabel:='Largh.';
    cds.FieldByName('ALT').AsInteger:=LabelProperties.Height;
    cds.FieldByName('ALT').DisplayLabel:='Alt.';
    cds.FieldByName('SINISTRA').AsInteger:=LabelProperties.Left;
    cds.FieldByName('SINISTRA').DisplayLabel:='Sinistra';
    cds.FieldByName('ALTO').AsInteger:=LabelProperties.Top;
    cds.FieldByName('ALTO').DisplayLabel:='Alto';
    cds.FieldByName('TAG').AsInteger:=LabelProperties.Tag;
    cds.FieldByName('TAG').Visible:=False;
    cds.Post;
  end;
  cds.BeforePost:=cdsBeforePost;
  cds.BeforeDelete:=cdsBeforeDelete;
end;

procedure TWA052FParCarDM.cdsBeforeDelete(DataSet: TDataSet);
begin
  A052FParCarMW.dicSezioni[DataSet.Name].removeLabel(DataSet.FieldByName('UNIQUENAME').AsString);
end;

procedure TWA052FParCarDM.cdsBeforePost(DataSet: TDataSet);
var LabelProperties: TLabelProperties;
begin
  inherited;
  if DataSet.FieldByName('NOMECAMPO').AsString = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['campo']));

  if DataSet.FieldByName('LARGH').AsString = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['larghezza']));
  try
    if DataSet.FieldByName('LARGH').AsInteger = 0 then
      raise Exception.Create(Format(A000MSG_ERR_FMT_VALORE_NON_CORRETTO,['larghezza']));
  except
    raise Exception.Create(Format(A000MSG_ERR_FMT_VALORE_NON_CORRETTO,['larghezza']));
  end;

  if DataSet.FieldByName('ALT').AsString = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['altezza']));
  try
    if DataSet.FieldByName('ALT').AsInteger = 0 then
      raise Exception.Create(Format(A000MSG_ERR_FMT_VALORE_NON_CORRETTO,['altezza']));
  except
    raise Exception.Create(Format(A000MSG_ERR_FMT_VALORE_NON_CORRETTO,['altezza']));
  end;

  if DataSet.FieldByName('SINISTRA').AsString = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['sinistra']));

  if DataSet.FieldByName('ALTO').AsString = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['alto']));

  //Il clientDataset ha il nome della sezione a cui si riferisce
  LabelProperties:=A052FParCarMW.dicSezioni[DataSet.Name].getLabel(DataSet.FieldByName('UNIQUENAME').AsString);

  if (DataSet.state = dsInsert) then
  begin
    if LabelProperties <> nil then //se uniquename già presente do errore
      raise Exception.Create(Format(A000MSG_A052_ERR_FMT_CAMPO_PRESENTE,[DataSet.FieldByName('CAMPOVIS').AsString]));
    LabelProperties:=TLabelProperties.Create;
  end;
  //come win da interfacia a labelproperties
  with DataSet do
  begin
    LabelProperties.Name:=FieldByName('NOMECAMPO').AsString;
    LabelProperties.Caption:=FieldByName('CAPTION').AsString;
    LabelProperties.Top:=FieldByName('ALTO').AsInteger;
    LabelProperties.Left:=FieldByName('SINISTRA').AsInteger;
    LabelProperties.Height:=FieldByName('ALT').AsInteger;
    LabelProperties.Width:=FieldByName('LARGH').AsInteger;
    LabelProperties.Tag:=FieldByName('TAG').AsInteger;
    LabelProperties.UniqueName:=DataSet.FieldByName('UNIQUENAME').AsString; //il nome è stato creato da CreaNomeUnivocoLabel
    if (DataSet.state = dsInsert) then
      A052FParCarMW.dicSezioni[DataSet.name].LstLabels.Add(LabelProperties);
  end;
end;

procedure TWA052FParCarDM.IWUserSessionBaseDestroy(Sender: TObject);
var s: String;
  cds: TClientDataSet;
begin
  //Non usare direttamente dicSezioni.Keys  ma il toArray
  //perchè rimuovendo le chiavi, l'iterator sulle chiavi non scorre tutti gli elementi
  for s in dicCdsLabels.Keys.ToArray do
  begin
    dicCdsLabels[s].Close;
    cds:=dicCdsLabels[s];
    FreeAndNil(cds);
    dicCdsLabels.Remove(s);
  end;
  FreeAndNil(dicCdsLabels);
  FreeAndNil(A052FParCarMW);
  inherited;
end;

procedure TWA052FParCarDM.OnNewRecord(DataSet: TDataSet);
var
  s: string;
begin
  A052FParCarMW.resetDictSezioni;
  for s in A052FParCarMW.dicSezioni.Keys do
    CaricaClientDataset(dicCdsLabels[s],A052FParCarMW.dicSezioni[s]);

  inherited;
end;

procedure TWA052FParCarDM.selTabellaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=A052FParCarMW.SelT950Filter;
end;

end.
