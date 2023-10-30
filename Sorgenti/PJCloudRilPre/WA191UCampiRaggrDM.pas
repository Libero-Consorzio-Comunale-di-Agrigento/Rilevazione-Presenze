unit WA191UCampiRaggrDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData,
  A094USkLimitiStraordMW;

type
  TWA191FCampiRaggrDM = class(TWR302FGestTabellaDM)
    selTabellaDATADECORR: TDateTimeField;
    selTabellaNOMECAMPO1: TStringField;
    selTabellaNOMECAMPO2: TStringField;
    selTabellaTIPOLIMITE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  public
    A094FSkLimitiStraordMW: TA094FSkLimitiStraordMW;
  end;

implementation

{$R *.dfm}

procedure TWA191FCampiRaggrDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY DATADECORR');
  inherited;
  A094FSkLimitiStraordMW:=TA094FSkLimitiStraordMW.Create(Self);
end;

procedure TWA191FCampiRaggrDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A094FSkLimitiStraordMW.T800BeforePost(DataSet);
  inherited;
end;

procedure TWA191FCampiRaggrDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A094FSkLimitiStraordMW);
  inherited;
end;

end.
