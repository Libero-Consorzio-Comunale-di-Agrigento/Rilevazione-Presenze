unit WA189uLimitiEccedenzaLiqDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR303UGestMasterDetailDM, DB, OracleData, A094USkLimitiStraordMW,
  DBClient, A000UInterfaccia;

type
  TWA189FLimitiEccedenzaLiqDM = class(TWR303FGestMasterDetailDM)
    selTabellaANNO: TIntegerField;
    selTabellaCAMPO1: TStringField;
    selTabellaCAMPO2: TStringField;
    selTabellaNOMECAMPO1: TStringField;
    selTabellaNOMECAMPO2: TStringField;
    selTabellaMESE: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    A094FSkLimitiStraordMW: TA094FSkLimitiStraordMW;
  end;

implementation

{$R *.dfm}

{ TWA189FLimitiEccedenzaLiqDM }

procedure TWA189FLimitiEccedenzaLiqDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  selTabella.SetVariable('ORDERBY','ORDER BY ANNO,NOMECAMPO1,NOMECAMPO2');
  inherited;

  A094FSkLimitiStraordMW:=TA094FSkLimitiStraordMW.Create(Self);
  SetTabelleRelazionate([selTabella,A094FSkLimitiStraordMW.selT810]);
  SelTabella.Open;
end;

procedure TWA189FLimitiEccedenzaLiqDM.AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([selTabella],True);
  inherited;
end;

procedure TWA189FLimitiEccedenzaLiqDM.AfterPost(DataSet: TDataSet);
var
  FAnno: Integer;
  FCampo1, FCampo2: String;
begin
  FAnno:=selTabella.FieldByName('Anno').AsInteger;
  FCampo1:=selTabella.FieldByName('CAMPO1').AsString;
  FCampo2:=selTabella.FieldByName('CAMPO2').AsString;

  SessioneOracle.ApplyUpdates([selTabella],True);
  inherited;
  //In caso di inserimento mi posiziono sul record appena inserito
  selTabella.SearchRecord('Anno;Campo1;Campo2',VarArrayOf([FAnno,FCampo1,FCampo2]),[srFromBeginning]);
end;

procedure TWA189FLimitiEccedenzaLiqDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  //Imposto il campo mese per poter eseguire il controllo corretto per duplicazione chiave
  selTabella.FieldByName('MESE').AsString:='1';
  inherited;
  A094FSkLimitiStraordMW.selAnnoBeforePost(DataSet);
end;

procedure TWA189FLimitiEccedenzaLiqDM.RelazionaTabelleFiglie;
begin
  A094FSkLimitiStraordMW.RefrAnno(selTabella.FieldByName('ANNO').AsInteger,
                                  selTabella.FieldByName('CAMPO1').AsString,
                                  selTabella.FieldByName('CAMPO2').AsString,
                                  'L');
end;

procedure TWA189FLimitiEccedenzaLiqDM.selTabellaApplyRecord(
  Sender: TOracleDataSet; Action: Char; var Applied: Boolean;
  var NewRowId: string);
begin
  inherited;
  Applied:=True;
  A094FSkLimitiStraordMW.SincronizzaT810(selTabella, Action);
end;

procedure TWA189FLimitiEccedenzaLiqDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A094FSkLimitiStraordMW);
  inherited;
end;

end.
