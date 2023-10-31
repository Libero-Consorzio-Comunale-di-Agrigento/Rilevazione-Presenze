unit A205USquadreDM;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, Data.DB, OracleData,
  A205USquadreMW, C180FunzioniGenerali;

type
  TA205FSquadreDM = class(TR004FGestStoricoDtM)
    selT603: TOracleDataSet;
    selT603CODICE: TStringField;
    selT603DESCRIZIONE: TStringField;
    selT603DESCRIZIONELUNGA: TStringField;
    selT603CAUS_RIPOSO: TStringField;
    selT603CODICI_TURNAZIONE: TStringField;
    selT603INIZIO_VALIDITA: TDateTimeField;
    selT603FINE_VALIDITA: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT603AfterScroll(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT603NewRecord(DataSet: TDataSet);
    procedure selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    A205MW: TA205FSquadreMW;
  end;

var
  A205FSquadreDM: TA205FSquadreDM;

implementation

uses A205USquadre;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA205FSquadreDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A205MW.selT603BeforePost;
end;

procedure TA205FSquadreDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT603,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterPost,
                              evOnTranslateMessage]);
  A205MW:=TA205FSquadreMW.Create(Self);
  A205MW.selT603:=selT603;
  selT603.Open;
  A205FSquadre.dcmbCausRiposo.ListSource:=A205MW.dsrT265;
  A205FSquadre.dgrdAree.DataSource:=A205MW.dsrT651;
end;

procedure TA205FSquadreDM.selT603AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A205MW.selT603AfterScroll;
  A205FSquadre.dgrdAree.Columns[0].PickList.Clear;
  A205MW.selT430.First;
  while not A205MW.selT430.Eof do
  begin
    A205FSquadre.dgrdAree.Columns[0].PickList.Add(A205MW.selT430.FieldByName('TIPOOPE').AsString);
    A205MW.selT430.Next;
  end;
  if A205FSquadre.Visible then
    A205FSquadre.frmToolbarFiglio.AbilitaAzioniTF(nil);
end;

procedure TA205FSquadreDM.selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  A205MW.selT603FilterRecord(DataSet, Accept);
end;

procedure TA205FSquadreDM.selT603NewRecord(DataSet: TDataSet);
begin
  inherited;
  A205MW.selT603NewRecord;
end;

procedure TA205FSquadreDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A205MW.selT603AfterPost;
end;

procedure TA205FSquadreDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A205MW.selT603BeforeDelete;
end;

end.
