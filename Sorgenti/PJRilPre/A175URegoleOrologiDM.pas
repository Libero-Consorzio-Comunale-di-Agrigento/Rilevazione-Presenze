unit A175URegoleOrologiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStoricoDTM, Data.DB, OracleData, Math, A175URegoleOrologiMW, Oracle;

type
  TA175FRegoleOrologiDM = class(TR004FGestStoricoDtM)
    selT362: TOracleDataSet;
    selT362FILTRO_ANAGRAFE: TStringField;
    selT362DESCRIZIONE: TStringField;
    selT362CAUSALI_ABILITATE: TStringField;
    selT362RILEVATORE: TStringField;
    selT362ID: TFloatField;
    selT362DECORRENZA: TDateTimeField;
    selT362DECORRENZA_FINE: TDateTimeField;
    selT363: TOracleDataSet;
    dsrSelT363: TDataSource;
    selT363GG: TStringField;
    selT363DALLE: TStringField;
    selT363ALLE: TStringField;
    selT363CAUSALI_ABILITATE: TStringField;
    selT363ID: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selT362AfterScroll(DataSet: TDataSet);
    procedure selT363BeforePost(DataSet: TDataSet);
    procedure selT363NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A175MW: TA175FRegoleOrologiMW;
  end;

var
  A175FRegoleOrologiDM: TA175FRegoleOrologiDM;

implementation

uses
  A175URegoleOrologi;

{$R *.dfm}

procedure TA175FRegoleOrologiDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A175FRegoleOrologi.InterfacciaR004;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;  //se ci sono periodi che si accavallano, le storicizzazioni vengono automaticamente riorganizzate
  InizializzaDataSet(selT362,[evBeforeInsert, evBeforePost, evBeforeDelete, evAfterDelete, evAfterPost, evOnNewRecord, evOnTranslateMessage]);
  A175MW:=TA175FRegoleOrologiMW.Create(nil);  //si lascia come parametro "nil" se ci si occupa autonomamente della distruzione dell'oggetto
  //copia dei dataset presenti nel datamodulo
  A175MW.selT362:=selT362;
  A175MW.selT363:=selT363;
  selT362.Open;
end;

procedure TA175FRegoleOrologiDM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A175MW);
end;

procedure TA175FRegoleOrologiDM.BeforePost(DataSet: TDataSet);
begin
  A175MW.Storicizza:=InterfacciaR004.StoricizzazioneInCorso;
  A175MW.selT362BeforePost;
  inherited;
end;

procedure TA175FRegoleOrologiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A175MW.selT362AfterPost;
end;

procedure TA175FRegoleOrologiDM.selT362AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A175MW.selT362AfterScroll;
end;

procedure TA175FRegoleOrologiDM.selT363BeforePost(DataSet: TDataSet);
begin
  inherited;
  A175MW.selT363BeforePost;
end;

procedure TA175FRegoleOrologiDM.selT363NewRecord(DataSet: TDataSet);
begin
  inherited;
  A175MW.selT363OnNewRecord;
end;

end.
