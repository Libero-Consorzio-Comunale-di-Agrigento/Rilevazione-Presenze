unit WA202URapportiLavoroDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB, OracleData, Oracle,
  A202URapportiLavoroMW, C180FunzioniGenerali;

type
  TWA202FRapportiLavoroDM = class(TWR303FGestMasterDetailDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaINIZIO: TDateTimeField;
    selTabellaFINE: TDateTimeField;
    selTabellaTIPORAPPORTO: TStringField;
    selTabellad_TIPORAPPORTO: TStringField;
    selTabellad_TIPO: TStringField;
    selTabellaENTE: TStringField;
    selTabellaNOTE: TStringField;
    selTabellaVALIDAZIONE: TStringField;
    selTabellad_ENTE: TStringField;
    selTabellaPARTTIME: TStringField;
    selTabellad_PARTTIME: TStringField;
    selTabellaQUALIFICA: TStringField;
    selTabellad_QUALIFICA: TStringField;
    selTabellaDISCIPLINA: TStringField;
    selTabellad_DISCIPLINA: TStringField;
    selTabellad_TIPOPT: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaPERC_PT: TFloatField;
    selTabellaTIPO_PT: TStringField;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
    procedure RelazionaTabelleFiglie; override;
  public
    { Public declarations }
    A202MW: TA202FRapportiLavoroMW;
    procedure ImpostaModalita(pModalita: TA202Modalita);
  end;

implementation

{$R *.dfm}

procedure TWA202FRapportiLavoroDM.ImpostaModalita(pModalita: TA202Modalita);
var i: integer;
begin
  A202MW.ModalitaA202:=pModalita;
  case A202MW.ModalitaA202 of
    VALIDAZIONE: begin
      R180SetVariable(selTabella,'F_VAL','''S'',''N'',''A'',''D''');
      A202MW.selT450.Filtered:=True;
      for i:=1 to selTabella.Fields.Count-1 do
        selTabella.Fields[i].Visible:=True;
      with selTabella do
      begin
        FieldByName('INIZIO').DisplayLabel:='Dal';
        FieldByName('FINE').DisplayLabel:='Al';
        FieldByName('TIPORAPPORTO').Visible:=False;
        FieldByName('PARTTIME').Visible:=False;
      end;
      A202MW.SetVariabiliGiuridico;
      A202MW.ImpostaCampiLookup(selTabella);
      A202MW.ImpostaCampiLookup(A202MW.selT430);

      A202MW.selT430.FieldByName('DAL').Visible:=True;
      A202MW.selT430.FieldByName('AL').Visible:=True;
      A202MW.selT430.FieldByName('INIZIO').Visible:=False;
      A202MW.selT430.FieldByName('FINE').Visible:=False;
      A202MW.selT430.FieldByName('INIZIO_RAPGIUR').Visible:=False;
      A202MW.selT430.FieldByName('FINE_RAPGIUR').Visible:=False;
    end;
    PASSENZE: begin
      A202MW.selT450.Filtered:=False;
      R180SetVariable(selTabella,'F_VAL','''P''');
      with selTabella do
      begin
        FieldByName('ENTE').Index:=FieldByName('NOTE').Index-1;
      end;
    end;
  end;
end;

procedure TWA202FRapportiLavoroDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A202MW:=TA202FRapportiLavoroMW.Create(nil);
  //selTabella.FieldByName('d_TIPORAPPORTO').LookupDataSet:=A202MW.selT450;
  A202MW.selT425:=selTabella;
  inherited;
end;

procedure TWA202FRapportiLavoroDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A202MW.selT425AfterDelete(DataSet);
end;

procedure TWA202FRapportiLavoroDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A202MW.selT425AfterPost(DataSet);
  if A202MW.MsgA202 <> '' then
    R180MessageBox(A202MW.MsgA202, INFORMA);

end;

procedure TWA202FRapportiLavoroDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
   A202MW.BeforePostNoStorico(DataSet)
end;

procedure TWA202FRapportiLavoroDM.RelazionaTabelleFiglie;
begin
  //Serve implementazione perchè metodo abstract
end;

procedure TWA202FRapportiLavoroDM.selTabellaAfterEdit(DataSet: TDataSet);
begin
  inherited;
  A202MW.selT425AfterEdit(DataSet);
end;

procedure TWA202FRapportiLavoroDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A202MW.selT425CalcFields(DataSet);
end;

procedure TWA202FRapportiLavoroDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A202MW.selT425NewRecord(DataSet);
end;

procedure TWA202FRapportiLavoroDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A202MW);
  inherited;
end;

end.
