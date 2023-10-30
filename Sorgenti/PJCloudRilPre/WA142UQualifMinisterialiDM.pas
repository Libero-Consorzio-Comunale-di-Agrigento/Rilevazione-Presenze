unit WA142UQualifMinisterialiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient;

type
  TWA142FQualifMinisterialiDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaDEBITOGGQM: TStringField;
    selTabellaMACRO_CATEG_QM: TStringField;
    selTabellaPROGRESSIVOQM: TIntegerField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA142UQualifMinisterialiDettFM, WA142UQualifMinisteriali;

{$R *.dfm}

procedure TWA142FQualifMinisterialiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  TWA142FQualifMinisterialiDettFM(TWA142FQualifMinisteriali(Owner).WDettaglioFM).selTabellaAfterPost(DataSet);
end;

procedure TWA142FQualifMinisterialiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY T470.CODICE, T470.DECORRENZA');
  inherited;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;
end;

end.
