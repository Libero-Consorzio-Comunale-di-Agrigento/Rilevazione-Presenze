unit WR303UGestMasterDetailDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DBClient, DB, OracleData;

type
  TWR303FGestMasterDetailDM = class(TWR302FGestTabellaDM)
    procedure AfterScroll(DataSet: TDataSet); override;
  protected
    procedure RelazionaTabelleFiglie; virtual; abstract;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WR103UGestMasterDetail;

{$R *.dfm}

procedure TWR303FGestMasterDetailDM.AfterScroll(DataSet: TDataSet);
begin
  inherited afterScroll(DataSet);
  RelazionaTabelleFiglie;
  TWR103FGestMasterDetail(Owner).AggiornaDetails;
end;

end.
