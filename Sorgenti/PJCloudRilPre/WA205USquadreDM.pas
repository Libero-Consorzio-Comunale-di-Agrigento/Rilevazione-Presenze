unit WA205USquadreDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, A205USquadreMW;

type
  TWA205FSquadreDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODICE: TStringField;
    selTabellaINIZIO_VALIDITA: TDateTimeField;
    selTabellaFINE_VALIDITA: TDateTimeField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaDESCRIZIONELUNGA: TStringField;
    selTabellaCAUS_RIPOSO: TStringField;
    selTabellaCODICI_TURNAZIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selTabellaAfterPost(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A205MW: TA205FSquadreMW;
    procedure RelazionaTabelleFiglie; override;
  end;

implementation

uses WA205USquadre, WA205USquadreDettFM, WA205UAreeSquadreFM;

{$R *.dfm}

procedure TWA205FSquadreDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by T603.CODICE');
  inherited;
  A205MW:=TA205FSquadreMW.Create(Self);
  A205MW.selT603:=selTabella;
  SetTabelleRelazionate([selTabella,A205MW.selT651]);
end;

procedure TWA205FSquadreDM.RelazionaTabelleFiglie;
begin
  inherited;
  if (Self.Owner as TWA205FSquadre).DetailFM[0] <> nil then
    with ((Self.Owner as TWA205FSquadre).DetailFM[0] as TWA205FAreeSquadreFM) do
      A205MW.selT603AfterScroll;
end;

procedure TWA205FSquadreDM.selTabellaAfterPost(DataSet: TDataSet);
begin
  inherited;
  A205MW.selT603AfterPost;
end;

procedure TWA205FSquadreDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A205MW.selT603NewRecord;
  selTabella.FieldByName('CODICE').ReadOnly:=False;
end;

procedure TWA205FSquadreDM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('CODICE').ReadOnly:=True;
end;

procedure TWA205FSquadreDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A205MW.selT603BeforePost;
end;

procedure TWA205FSquadreDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A205MW.selT603BeforeDelete;
end;

end.
