unit WA132UMagazzinoBuoniPastoDM;

interface

uses
  Windows, Messages, SysUtils,StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A132UMagazzinoBuoniPastoMW;

type
  TWA132FMagazzinoBuoniPastoDM = class(TWR302FGestTabellaDM)
    selTabellaDATA_ACQUISTO: TDateTimeField;
    selTabellaDATA_SCADENZA: TDateTimeField;
    selTabellaBUONIPASTO: TIntegerField;
    selTabellaTICKET: TIntegerField;
    selTabellaID_DAL: TFloatField;
    selTabellaID_AL: TFloatField;
    selTabellaDIM_BLOCCHETTO: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet);override;
  private
    { Private declarations }
  public
    A132MW:TA132FMagazzinoBuoniPastoMW;
  end;

implementation

{$R *.dfm}

procedure TWA132FMagazzinoBuoniPastoDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A132MW:=TA132FMagazzinoBuoniPastoMW.Create(nil);
  A132MW.selT691:=SelTabella;
  SelTabella.SetVariable('ORDERBY','ORDER BY DATA_ACQUISTO');
  inherited;
end;

procedure TWA132FMagazzinoBuoniPastoDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A132MW);
end;

procedure TWA132FMagazzinoBuoniPastoDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A132MW.selT691BeforePost;
end;

end.
