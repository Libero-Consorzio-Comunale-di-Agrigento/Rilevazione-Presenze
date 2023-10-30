unit WA036UTurniRepDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A036UTurniRepMW;

type
  TWA036FTurniRepDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaANNO: TFloatField;
    selTabellaMESE: TFloatField;
    selTabellaCALCMESE: TStringField;
    selTabellaTURNIINTERI: TFloatField;
    selTabellaVP_TURNO: TStringField;
    selTabellaTURNIORE: TStringField;
    selTabellaVP_ORE: TStringField;
    selTabellaOREMAGG: TStringField;
    selTabellaVP_MAGGIORATE: TStringField;
    selTabellaORENONMAGG: TStringField;
    selTabellaVP_NONMAGGIORATE: TStringField;
    selTabellaGETTONE_CHIAMATA: TIntegerField;
    selTabellaVP_GETTONE_CHIAMATA: TStringField;
    selTabellaTURNI_OLTREMAX: TIntegerField;
    selTabellaVP_TURNI_OLTREMAX: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure ValidaOre(Sender: TField);
    procedure ValidaVoce(Sender: TField);
  private
    { Private declarations }
  public
    A036MW: TA036FTurniRepMW;
  end;

implementation

{$R *.dfm}

procedure TWA036FTurniRepDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY ANNO DESC,MESE DESC');
  A036MW:=TA036FTurniRepMW.Create(Self);
  A036MW.selT340:=SelTabella;
  inherited;
end;

procedure TWA036FTurniRepDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  A036MW.OnCalcFields;
end;

procedure TWA036FTurniRepDM.OnNewRecord(DataSet: TDataSet);
begin
  A036MW.OnNewRecord;
  inherited;
end;

procedure TWA036FTurniRepDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A036MW.BeforePost;
  inherited;
end;

procedure TWA036FTurniRepDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A036MW.AfterDelete;
end;

procedure TWA036FTurniRepDM.BeforeDelete(DataSet: TDataSet);
begin
  A036MW.BeforeDelete;
  inherited;
end;

procedure TWA036FTurniRepDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A036MW.AfterDelete;
end;

procedure TWA036FTurniRepDM.ValidaOre(Sender: TField);
begin
  A036MW.selT340ValidaOre(Sender);
end;

procedure TWA036FTurniRepDM.ValidaVoce(Sender: TField);
begin
  A036MW.selT340ValidaVoce(Sender);
end;

end.
