unit WA179UProfiliIterAutDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  Datasnap.DBClient, A179UProfiliIterAutMW, C180FunzioniGenerali, Oracle, medpIWMultiColumnComboBox;

type
  TWA179FProfiliIterAutDM = class(TWR302FGestTabellaDM)
    QI090: TOracleDataSet;
    D090: TDataSource;
    dsrI075: TDataSource;
    selI075: TOracleDataSet;
    selI075AZIENDA: TStringField;
    selI075PROFILO: TStringField;
    selI075ITER: TStringField;
    selI075COD_ITER: TStringField;
    selI075LIVELLO: TIntegerField;
    selI075ACCESSO: TStringField;
    insI075: TOracleQuery;
    selI075D_ACCESSO: TStringField;
    delI075: TOracleQuery;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure dsrI075StateChange(Sender: TObject);
    procedure selI075ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure selI075CalcFields(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
    A179MW:TA179FProfiliIterAutMW;
    AziendaMain:string;
    procedure OpenSelI075(const Azienda:string; CodIter:string = '');
  end;

implementation

uses
  WA179UProfiliIterAut, WR205UDettTabellaFM, WA179UProfiliIterAutDettFM,
  medpIWDBGrid, A000UCostanti, A000UInterfaccia;

{$R *.dfm}

procedure TWA179FProfiliIterAutDM.AfterScroll(DataSet: TDataSet);
var
  WA179DettFM:TWA179FProfiliIterAutDettFM;
  CmbAzienda, CmbIter:TMedpIWMultiColumnComboBox;
  CodIter:string;
begin
  inherited;
  WA179DettFM:=((Self.Owner as TWA179FProfiliIterAut).WDettaglioFM as TWA179FProfiliIterAutDettFM);
  if WA179DettFM <> nil then
  begin
    WA179DettFM.edtProfilo.Text:=selTabella.FieldByName('PROFILO').AsString;
    CmbAzienda:=(Self.Owner as TWA179FProfiliIterAut).cmbAzienda;
    CmbIter:=WA179DettFM.cmbCodiceIter;
    //Quando si cambia l'azienda specifico come iter di default quello dei giustificativi
    //Questo perchè l'evento afterscroll scatta subito dopo l'evento status change in cui il comportamento
    //ereditato cancella gli item della combobox iter
    CodIter:=A000IterAutorizzativi[0].Cod;
    if CmbIter.Items.Count > 0 then
    begin
      CodIter:=CmbIter.Items[CmbIter.ItemIndex].RowData[0];
    end;
    OpenSelI075(CmbAzienda.Items[CmbAzienda.ItemIndex].RowData[0], CodIter);
    WA179DettFM.GrdIterAutorizzativi.medpAggiornaCDS(True);
  end;
end;

procedure TWA179FProfiliIterAutDM.dsrI075StateChange(Sender: TObject);
var
  WA179DettFM:TWA179FProfiliIterAutDettFM;
begin
  inherited;
  if Self.Owner = nil then
    exit;
  WA179DettFM:=(Self.Owner as TWA179FProfiliIterAut).WDettaglioFM as TWA179FProfiliIterAutDettFM;
  if WA179DettFM = nil then
    exit;
  if (WA179DettFM.GrdIterAutorizzativi.medpDataSet.State <> dsBrowse) and
     (WA179DettFM.GrdIterAutorizzativi.medpStato <> msBrowse) then
    exit;
  (Self.Owner as TWA179FProfiliIterAut).cmbAzienda.Enabled:=(selI075.State in [dsBrowse]);
  WA179DettFM.cmbCodiceIter.ReadOnly:=(selI075.State in [dsInsert,dsEdit]);
end;

procedure TWA179FProfiliIterAutDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('AZIENDA',Parametri.Azienda);
  selTabella.SetVariable('ORDERBY','ORDER BY AZIENDA,PROFILO');
  inherited;
  A179MW:=TA179FProfiliIterAutMW.Create(nil);
  QI090.Open;
  OpenSelI075(AziendaMain,A000IterAutorizzativi[0].Cod);
end;

procedure TWA179FProfiliIterAutDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A179MW);
end;

procedure TWA179FProfiliIterAutDM.OpenSelI075(const Azienda:string; CodIter:string = '');
var
  MyAzienda:string;
begin
  MyAzienda:=Azienda;
  if MyAzienda.Trim.IsEmpty then
  begin
    MyAzienda:=Parametri.Azienda;
  end;
  R180SetVariable(selI075,'AZIENDA',MyAzienda);
  R180SetVariable(selI075,'PROFILO',selTabella.FieldByName('PROFILO').AsString);
  R180SetVariable(selI075,'ITER',CodIter);
  selI075.Open;
end;

procedure TWA179FProfiliIterAutDM.selI075ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  //Comporatmento necessario in quanto alcuni record visualizzati possono essere non presenti
  //quando rowid = null(nessun record su tabella), viene fatto in insert
  if (Action = 'C') and (Sender.RowID = '') then
  begin
    Applied:=True;
  end
  else if Sender.RowID = '' then
  begin
    if Action = 'U' then
    begin
      insI075.SetVariable('AZIENDA',selI075.FieldByName('AZIENDA').AsString);
      insI075.SetVariable('PROFILO',selI075.FieldByName('PROFILO').AsString);
      insI075.SetVariable('ITER',selI075.FieldByName('ITER').AsString);
      insI075.SetVariable('COD_ITER',selI075.FieldByName('COD_ITER').AsString);
      insI075.SetVariable('LIVELLO',selI075.FieldByName('LIVELLO').AsString);
      insI075.SetVariable('ACCESSO',selI075.FieldByName('ACCESSO').AsString);
      insI075.Execute;
    end;
    Applied:=True;
  end;
end;

procedure TWA179FProfiliIterAutDM.selI075CalcFields(DataSet: TDataSet);
var
  i:integer;
begin
  inherited;
  i:=Low(A179MW.D_TipoAccesso);
  while (i <= High(A179MW.D_TipoAccesso)) and
        (A179MW.D_TipoAccesso[i].Value <> DataSet.FieldByName('ACCESSO').AsString) do
  begin
    inc(i);
  end;
  if A179MW.D_TipoAccesso[i].Value = DataSet.FieldByName('ACCESSO').AsString then
  begin
    DataSet.FieldByName('D_ACCESSO').AsString:=A179MW.D_TipoAccesso[i].Item;
  end;
end;

end.
