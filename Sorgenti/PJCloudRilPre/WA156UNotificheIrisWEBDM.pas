unit WA156UNotificheIrisWEBDM;

interface

uses
  A156UNotificheIrisWEBMW,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  WR302UGestTabellaDM, Data.DB, OracleData;

type
  TWA156FNotificheIrisWEBDM = class(TWR302FGestTabellaDM)
    selTabellaID: TIntegerField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaNOTIFICA: TStringField;
    selTabellaNOTIFICA_SQL_TEXT: TStringField;
    selTabellaATTIVO: TStringField;
    selTabellaVALIDO_DAL: TDateTimeField;
    selTabellaVALIDO_AL: TDateTimeField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    //
  public
    A156MW: TA156FNotificheIrisWEBMW;
  end;

implementation

{$R *.dfm}

procedure TWA156FNotificheIrisWEBDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by i040.descrizione');
  inherited;
  A156MW:=TA156FNotificheIrisWEBMW.Create(nil);
  A156MW.selI040_Funzioni:=selTabella;
end;

procedure TWA156FNotificheIrisWEBDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A156MW);
  inherited;
end;

procedure TWA156FNotificheIrisWEBDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A156MW.selI040BeforePost;
end;

end.
