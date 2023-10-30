unit WA150UCodiciAccorpamentoCausaliDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A150UAccorpamentoCausaliMW;

type
  TWA150FCodiciAccorpamentoCausaliDM = class(TWR302FGestTabellaDM)
    selTabellaCOD_TIPOACCORPCAUSALI: TStringField;
    selTabellaCOD_CODICIACCORPCAUSALI: TStringField;
    selTabellaCOD_CAUSALE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaPERCENTUALE: TFloatField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet);Override;
    procedure BeforeEdit(DataSet: TDataSet);Override;
    procedure AfterPost(DataSet: TDataSet);Override;
  private
    { Private declarations }
  public
    A150MW: TA150FAccorpamentoCausaliMW;
  end;

implementation

{$R *.dfm}

procedure TWA150FCodiciAccorpamentoCausaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A150MW:=TA150FAccorpamentoCausaliMW.Create(Self);
  inherited;
end;

procedure TWA150FCodiciAccorpamentoCausaliDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  // Massimo: Reimposto il campo in chiave COD_CAUSALE ReadOnly in modo che rientri nella gestione standard.
  SelTabella.FieldByName('COD_CAUSALE').ReadOnly:=True;
end;

procedure TWA150FCodiciAccorpamentoCausaliDM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  // Massimo: COD_CAUSALE è un campo in chiave, viene messo ReadOnly per poterlo modificare in edit.
  // Infatti, con gestioneStoricizzata i campi chiave vengono messi ReadOnly di default (WR302).
  SelTabella.FieldByName('COD_CAUSALE').ReadOnly:=False;
end;

procedure TWA150FCodiciAccorpamentoCausaliDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  SelTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString:=selTabella.GetVariable('CodTipoAccorpCausali');
  SelTabella.FieldByName('COD_CODICIACCORPCAUSALI').AsString:=selTabella.GetVariable('CodCodiciAccorpCausali');
end;

procedure TWA150FCodiciAccorpamentoCausaliDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  selTabella.FieldByName('DESCRIZIONE').AsString:=A150MW.CalcDescrizione(selTabella);
end;

end.
