unit A202URapportiLavoroDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStoricoDTM, Data.DB, OracleData, C180FunzioniGenerali,
  A202URapportiLavoroMW;

type
  TA202FRapportiLavoroDM = class(TR004FGestStoricoDtM)
    selT425: TOracleDataSet;
    selT425PROGRESSIVO: TFloatField;
    selT425INIZIO: TDateTimeField;
    selT425FINE: TDateTimeField;
    selT425TIPORAPPORTO: TStringField;
    selT425d_TIPORAPPORTO: TStringField;
    selT425d_TIPO: TStringField;
    selT425ENTE: TStringField;
    selT425NOTE: TStringField;
    selT425VALIDAZIONE: TStringField;
    selT425d_ENTE: TStringField;
    selT425PARTTIME: TStringField;
    selT425d_PARTTIME: TStringField;
    selT425d_TIPOPT: TStringField;
    selT425QUALIFICA: TStringField;
    selT425d_QUALIFICA: TStringField;
    selT425DISCIPLINA: TStringField;
    selT425d_DISCIPLINA: TStringField;
    selT425TIPO: TStringField;
    selT425PERC_PT: TFloatField;
    selT425TIPO_PT: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT425CalcFields(DataSet: TDataSet);
    procedure selT425NewRecord(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure selT425BeforeInsert(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selT425AfterEdit(DataSet: TDataSet);
    procedure selT425VALIDAZIONEValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    A202MW:TA202FRapportiLavoroMW;
    procedure ImpostaModalita(pModalita: TA202Modalita);
  end;

var
  A202FRapportiLavoroDM: TA202FRapportiLavoroDM;

implementation

{$R *.dfm}

procedure TA202FRapportiLavoroDM.ImpostaModalita(pModalita: TA202Modalita);
var i: integer;
begin
  A202MW.ModalitaA202:=pModalita;
  case A202MW.ModalitaA202 of
    VALIDAZIONE: begin
      R180SetVariable(selT425,'F_VAL','''S'',''N'',''A'',''D''');
      A202MW.selT450.Filtered:=True;
      for i:=1 to selT425.Fields.Count-1 do
        selT425.Fields[i].Visible:=True;
      with selT425 do
      begin
        FieldByName('INIZIO').DisplayLabel:='Dal';
        FieldByName('FINE').DisplayLabel:='Al';
        FieldByName('TIPORAPPORTO').Visible:=False;
        FieldByName('PARTTIME').Visible:=False;
      end;

      A202MW.SetVariabiliGiuridico;

      A202MW.ImpostaCampiLookup(selT425);
      A202MW.ImpostaCampiLookup(A202MW.selT430);

      A202MW.selT430.FieldByName('DAL').Visible:=True;
      A202MW.selT430.FieldByName('AL').Visible:=True;
      A202MW.selT430.FieldByName('INIZIO').Visible:=False;
      A202MW.selT430.FieldByName('FINE').Visible:=False;
      A202MW.selT430.FieldByName('INIZIO_RAPGIUR').Visible:=False;
      A202MW.selT430.FieldByName('FINE_RAPGIUR').Visible:=False;

      with A202MW.selT055 do
      begin
        FieldByName('VALIDAZIONE').DisplayWidth:=selT425.FieldByName('VALIDAZIONE').DisplayWidth;
        FieldByName('DAL').DisplayWidth:=selT425.FieldByName('INIZIO').DisplayWidth;
        FieldByName('AL').DisplayWidth:=selT425.FieldByName('FINE').DisplayWidth;
        FieldByName('CAUSALE').DisplayWidth:=selT425.FieldByName('ENTE').DisplayWidth;
        FieldByName('d_CAUSALE').DisplayWidth:=30;
        FieldByName('NOTE').DisplayWidth:=selT425.FieldByName('NOTE').DisplayWidth;
      end;

      with A202MW.selT040 do
      begin
        FieldByName('DAL').DisplayWidth:=selT425.FieldByName('INIZIO').DisplayWidth;
        FieldByName('AL').DisplayWidth:=selT425.FieldByName('FINE').DisplayWidth;
        FieldByName('CAUSALE').DisplayWidth:=selT425.FieldByName('ENTE').DisplayWidth;
        FieldByName('d_CAUSALE').DisplayWidth:=60;
      end;

      with A202MW.selT430 do
      begin
        FieldByName('DAL').DisplayWidth:=selT425.FieldByName('INIZIO').DisplayWidth;
        FieldByName('AL').DisplayWidth:=selT425.FieldByName('FINE').DisplayWidth;
        FieldByName('INIZIO').DisplayWidth:=selT425.FieldByName('INIZIO').DisplayWidth;
        FieldByName('FINE').DisplayWidth:=selT425.FieldByName('FINE').DisplayWidth;
        FieldByName('ENTE').DisplayWidth:=selT425.FieldByName('ENTE').DisplayWidth;
        FieldByName('d_ENTE').DisplayWidth:=selT425.FieldByName('d_ENTE').DisplayWidth;
        FieldByName('TIPO_RAPPORTO').DisplayWidth:=selT425.FieldByName('TIPORAPPORTO').DisplayWidth;
        FieldByName('d_TIPORAPPORTO').DisplayWidth:=selT425.FieldByName('d_TIPORAPPORTO').DisplayWidth;
        //FieldByName('TIPO').DisplayWidth:=selT425.FieldByName('TIPO').DisplayWidth;
        FieldByName('d_TIPO').DisplayWidth:=selT425.FieldByName('d_TIPO').DisplayWidth;
        FieldByName('d_TIPORAPPORTO').DisplayWidth:=selT425.FieldByName('d_TIPORAPPORTO').DisplayWidth;
        FieldByName('PARTTIME').DisplayWidth:=selT425.FieldByName('PARTTIME').DisplayWidth;
        FieldByName('d_PARTTIME').DisplayWidth:=selT425.FieldByName('d_PARTTIME').DisplayWidth;
        FieldByName('PERC_PT').DisplayWidth:=selT425.FieldByName('PERC_PT').DisplayWidth;
        FieldByName('d_TIPOPT').DisplayWidth:=selT425.FieldByName('d_TIPOPT').DisplayWidth;
        FieldByName('QUALIFICA').DisplayWidth:=selT425.FieldByName('QUALIFICA').DisplayWidth;
        FieldByName('d_QUALIFICA').DisplayWidth:=selT425.FieldByName('d_QUALIFICA').DisplayWidth;
        FieldByName('DISCIPLINA').DisplayWidth:=selT425.FieldByName('DISCIPLINA').DisplayWidth;
        FieldByName('d_DISCIPLINA').DisplayWidth:=selT425.FieldByName('d_DISCIPLINA').DisplayWidth;
        FieldByName('INIZIO_RAPGIUR').DisplayWidth:=selT425.FieldByName('INIZIO').DisplayWidth;
        FieldByName('FINE_RAPGIUR').DisplayWidth:=selT425.FieldByName('FINE').DisplayWidth;
      end;
    end;
    PASSENZE: begin
      A202MW.selT450.Filtered:=False;
      R180SetVariable(selT425,'F_VAL','''P''');
      with selT425 do
      begin
        FieldByName('PROGRESSIVO').DisplayWidth:=10;
        FieldByName('INIZIO').DisplayWidth:=10;
        FieldByName('FINE').DisplayWidth:=10;
        FieldByName('TIPORAPPORTO').DisplayWidth:=5;
        FieldByName('d_TIPORAPPORTO').DisplayWidth:=30;
        FieldByName('d_TIPO').DisplayWidth:=20;
        FieldByName('ENTE').DisplayWidth:=30;
        FieldByName('ENTE').Index:=FieldByName('NOTE').Index-1;
        FieldByName('NOTE').DisplayWidth:=30;
      end;
    end;
  end;
end;

procedure TA202FRapportiLavoroDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A202MW:=TA202FRapportiLavoroMW.Create(nil);
  selT425.FieldByName('d_TIPORAPPORTO').LookupDataSet:=A202MW.selT450;
  InizializzaDataSet(selT425,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A202MW.selT425:=selT425;
end;

procedure TA202FRapportiLavoroDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A202MW.selT425AfterDelete(DataSet);
end;

procedure TA202FRapportiLavoroDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A202MW.selT425AfterPost(DataSet);
  if A202MW.MsgA202 <> '' then
    ShowMessage(A202MW.MsgA202);
end;

procedure TA202FRapportiLavoroDM.BeforeDelete(DataSet: TDataSet);
begin
  if A202MW.ModalitaA202 = VALIDAZIONE then
    Abort;
  inherited;
end;

procedure TA202FRapportiLavoroDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A202MW.BeforePostNoStorico(DataSet);
end;

procedure TA202FRapportiLavoroDM.selT425AfterEdit(DataSet: TDataSet);
begin
  inherited;
  A202MW.selT425AfterEdit(DataSet);
end;

procedure TA202FRapportiLavoroDM.selT425BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if A202MW.ModalitaA202 = VALIDAZIONE then
    Abort;
end;

procedure TA202FRapportiLavoroDM.selT425CalcFields(DataSet: TDataSet);
begin
  inherited;
  A202MW.selT425CalcFields(DataSet);
end;

procedure TA202FRapportiLavoroDM.selT425NewRecord(DataSet: TDataSet);
begin
  inherited;
  A202MW.selT425NewRecord(DataSet);
end;

procedure TA202FRapportiLavoroDM.selT425VALIDAZIONEValidate(Sender: TField);
begin
  inherited;
  if A202MW.ModalitaA202 = VALIDAZIONE then
    if not R180In(TField(Sender).AsString,['S','N']) then
    begin
      TField(Sender).Value:= TField(Sender).OldValue;
      abort;
    end;
end;

procedure TA202FRapportiLavoroDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A202MW);
  inherited;
end;

end.
