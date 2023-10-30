unit WA072UBuoniMeseDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, DatiBloccati, WR302UGestTabellaDM;

type
  TWA072FBuoniMeseDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaANNO: TIntegerField;
    selTabellaMESE: TIntegerField;
    selTabellaCALCMESE: TStringField;
    selTabellaBUONIPASTO: TIntegerField;
    selTabellaVARBUONIPASTO: TIntegerField;
    selTabellaTICKET: TIntegerField;
    selTabellaVARTICKET: TIntegerField;
    procedure AfterPost(DataSet: TDataSet);override;
    procedure BeforeDelete(DataSet: TDataSet);override;
    procedure BeforePostNoStorico(DataSet: TDataSet);override;
    procedure OnNewRecord(DataSet: TDataSet);override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
  private
    selDatiBloccati:TDatiBloccati;
  public
    { Public declarations }
  end;

implementation

uses WA072UBuoniMese;

{$R *.dfm}

procedure TWA072FBuoniMeseDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  SelTabella.SetVariable('ORDERBY','ORDER BY ANNO DESC,MESE DESC');
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='M';
end;

procedure TWA072FBuoniMeseDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selDatiBloccati);
end;

procedure TWA072FBuoniMeseDM.AfterPost(DataSet: TDataSet);
var A,M:Word;
begin
  A:=SelTabella.FieldByName('Anno').AsInteger;
  M:=SelTabella.FieldByName('Mese').AsInteger;
  SelTabella.Refresh;
  SelTabella.Locate('Anno;Mese',VarArrayOf([A,M]),[]);
end;

procedure TWA072FBuoniMeseDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if selDatiBloccati.DatoBloccato(TWA072FBuoniMese(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger,Encodedate(StrToInt(SelTabella.FieldByName('Anno').AsString),StrToInt(SelTabella.FieldByName('Mese').AsString),1),'T680') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TWA072FBuoniMeseDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if selDatiBloccati.DatoBloccato(TWA072FBuoniMese(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger,Encodedate(StrToInt(SelTabella.FieldByName('Anno').AsString),StrToInt(SelTabella.FieldByName('Mese').AsString),1),'T680') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TWA072FBuoniMeseDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  SelTabella.FieldByName('Progressivo').AsInteger:=TWA072FBuoniMese(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger;
end;

procedure TWA072FBuoniMeseDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  SelTabella.FieldByName('VARBUONIPASTO').EditMask:='!#nnn';
  SelTabella.FieldByName('VARTICKET').EditMask:='!#nnn';
end;

procedure TWA072FBuoniMeseDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  SelTabella.FieldByName('CalcMese').AsString:=R180NomeMese(SelTabella.FieldByName('Mese').AsInteger);
end;

end.
