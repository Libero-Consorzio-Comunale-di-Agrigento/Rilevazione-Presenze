unit WA146UFotoDipendenteDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A146UFotoDipendenteMW, WA146UFotoDipendente;

type
  TWA146FFotoDipendenteDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaFILE_FOTO: TStringField;
    selTabellaFOTO: TBlobField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A146MW: TA146FFotoDipendenteMW;
  end;

implementation

{$R *.dfm}

procedure TWA146FFotoDipendenteDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A146MW:=TA146FFotoDipendenteMW.Create(Self);
  A146MW.selT032:=selTabella;
end;

procedure TWA146FFotoDipendenteDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A146MW);
end;

procedure TWA146FFotoDipendenteDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A146MW.selT032BeforePost(DataSet);
end;

end.
