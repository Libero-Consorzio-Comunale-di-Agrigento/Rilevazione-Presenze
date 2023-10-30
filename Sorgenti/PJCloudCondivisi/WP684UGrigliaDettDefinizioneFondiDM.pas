unit WP684UGrigliaDettDefinizioneFondiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData;

type
  TWP684FGrigliaDettDefinizioneFondiDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaMATRICOLA: TStringField;
    selTabellaCOGNOME: TStringField;
    selTabellaNOME: TStringField;
    selTabellaCOD_POSIZIONE_ECONOMICA: TStringField;
    selTabellaCOD_FONDO: TStringField;
    selTabellaDECORRENZA_DA: TDateTimeField;
    selTabellaCLASS_VOCE: TStringField;
    selTabellaCOD_VOCE_GEN: TStringField;
    selTabellaCOD_VOCE_DET: TStringField;
    selTabellaDATA_RETRIBUZIONE: TDateTimeField;
    selTabellaCOD_CONTRATTO: TStringField;
    selTabellaCOD_VOCE: TStringField;
    selTabellaDescrizione: TStringField;
    selTabellaIMPORTO: TFloatField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WP684UGrigliaDettDefinizioneFondi;

{$R *.dfm}

procedure TWP684FGrigliaDettDefinizioneFondiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by cognome, nome, matricola, data_retribuzione, P690.cod_contratto, cod_voce');
  (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW.selP690:=selTabella;
  inherited;
end;

procedure TWP684FGrigliaDettDefinizioneFondiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW.selP690CalcFields;
end;

procedure TWP684FGrigliaDettDefinizioneFondiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW.selP690BeforePost;
  inherited;
end;

procedure TWP684FGrigliaDettDefinizioneFondiDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW.selP690NewRecord;
end;

procedure TWP684FGrigliaDettDefinizioneFondiDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  if (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW.selP690.Eof then
  begin
    (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).actModifica.Enabled:=False;
    (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).actElimina.Enabled:=False;
    with (Self.Owner as TWP684FGrigliaDettDefinizioneFondi) do
      AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;
end;

end.
