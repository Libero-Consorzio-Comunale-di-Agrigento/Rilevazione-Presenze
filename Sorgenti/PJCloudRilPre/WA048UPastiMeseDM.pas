unit WA048UPastiMeseDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB, OracleData,
  Dialogs, A000UCostanti, A000USessione,A000UInterfaccia,C180FunzioniGenerali, DatiBloccati, WR302UGestTabellaDM;

type
  TWA048FPastiMeseDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaANNO: TFloatField;
    selTabellaMESE: TFloatField;
    selTabellaCALCMESE: TStringField;
    selTabellaCAUSALE: TStringField;
    selTabellaPASTI: TFloatField;
    selTabellaPASTI2: TIntegerField;
    procedure AfterDelete(DataSet: TDataSet);override;
    procedure BeforeDelete(DataSet: TDataSet);override;
    procedure BeforePostNoStorico(DataSet: TDataSet);override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet);override;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    selDatiBloccati:TDatiBloccati;
  public
    {public declaration}

  end;

implementation

uses WA048UPastiMese;

{$R *.dfm}

procedure TWA048FPastiMeseDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  selTabella.SetVariable('ORDERBY','ORDER BY ANNO DESC,MESE DESC');
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='M';
end;

procedure TWA048FPastiMeseDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selDatiBloccati);
end;

procedure TWA048FPastiMeseDM.AfterDelete(DataSet: TDataSet);
var A,M:Word;
begin
  inherited;
  A:=SelTabella.FieldByName('Anno').AsInteger;
  M:=SelTabella.FieldByName('Mese').AsInteger;
  SelTabella.Refresh;
  SelTabella.Locate('Anno;Mese',VarArrayOf([A,M]),[]);
end;

procedure TWA048FPastiMeseDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if selDatiBloccati.DatoBloccato(TWA048FPastiMese(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger,Encodedate(StrToInt(SelTabella.FieldByName('Anno').AsString),StrToInt(SelTabella.FieldByName('Mese').AsString),1),'T410') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TWA048FPastiMeseDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if selDatiBloccati.DatoBloccato(TWA048FPastiMese(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger,Encodedate(StrToInt(SelTabella.FieldByName('Anno').AsString),StrToInt(SelTabella.FieldByName('Mese').AsString),1),'T410') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TWA048FPastiMeseDM.OnNewRecord(DataSet: TDataSet);
begin
  selTabella.FieldByName('Progressivo').AsInteger:=TWA048FPastiMese(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger;
  inherited;
end;

procedure TWA048FPastiMeseDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  SelTabella.FieldByName('CalcMese').AsString:=R180NomeMese(SelTabella.FieldByName('Mese').AsInteger);
end;

end.
