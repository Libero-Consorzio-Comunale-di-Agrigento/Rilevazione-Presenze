unit WA174UParPianifTurniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A174UParPianifTurniMW,
  Oracle;

type
  TWA174FParPianifTurniDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTITOLO: TStringField;
    selTabellaNOTE_STAMPA: TStringField;
    selTabellaDESCRIZIONE1: TStringField;
    selTabellaDESCRIZIONE2: TStringField;
    selTabellaDETT_STAMPA: TStringField;
    selTabellaRIGHE_DIP: TStringField;
    selTabellaORD_STAMPA: TStringField;
    selTabellaTIPO_STAMPA: TStringField;
    selTabellaTOT_TURNO: TStringField;
    selTabellaTOT_OPE_TURNO: TStringField;
    selTabellaTOT_LIQUIDABILE: TStringField;
    selTabellaDETT_ORARI: TStringField;
    selTabellaTOT_TURNI_MESE: TStringField;
    selTabellaTOT_GENERALI: TStringField;
    selTabellaASSENZE: TStringField;
    selTabellaSALDI_ORE: TStringField;
    selTabellaMARGINE_SX: TIntegerField;
    selTabellaDIMENSIONE_FONT: TIntegerField;
    selTabellaGG_PAGINA: TIntegerField;
    selTabellaSEPARATORE_COL: TStringField;
    selTabellaSEPARATORE_RIGHE: TStringField;
    selTabellaORIENTAMENTO_PAG: TStringField;
    selTabellaMODALITA_LAVORO: TStringField;
    selTabellaORD_VIS: TStringField;
    selTabellaPIANIF_GG_FEST: TStringField;
    selTabellaPIANIF_SOLO_TURN: TStringField;
    selTabellaPIANIF_GG_ASS: TStringField;
    selTabellaCAUS_ECLUDITURNO: TStringField;
    selTabellaRIGHE_NOME: TStringField;
    selTabellaORARIO_SINTETICO: TStringField;
    selTabellaDATO_ANAGRAFICO: TStringField;
    selTabellaGENERAZIONE: TStringField;
    selTabellaINIZIALE: TStringField;
    selTabellaCORRENTE: TStringField;
    selTabellaASSENZE_OPERATIVE: TStringField;
    selTabellaRENDI_OPERATIVA: TStringField;
    selTabellaREPERIBILITA: TStringField;
    selTabellaRIEPILOGO_NOTE: TStringField;
    selTabellaCOMPATTA_RIGHE_DIP: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaAfterInsert(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet);Override;
    procedure AfterScroll(DataSet: TDataSet); Override;
  private
    { Private declarations }
  public
    A174MW: TA174FParPianifTurniMW;
  end;


implementation

uses WA174UParPianifTurni, WA174UParPianifTurniDettFM;

{$R *.dfm}

procedure TWA174FParPianifTurniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by CODICE');
  inherited;
  A174MW:=TA174FParPianifTurniMW.Create(Self);
  A174MW.selT082:=selTabella;
end;

procedure TWA174FParPianifTurniDM.selTabellaAfterInsert(DataSet: TDataSet);
begin
  inherited;
  A174MW.AfterInsert;
end;

procedure TWA174FParPianifTurniDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (Self.Owner as TWA174FParPianifTurni).WDettaglioFM <> nil then
    ((Self.Owner as TWA174FParPianifTurni).WDettaglioFM as TWA174FParPianifTurniDettFM).Abilitazioni;
end;

procedure TWA174FParPianifTurniDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A174MW.BeforePost;
end;

end.
