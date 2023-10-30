unit WA088UDatiLiberiIterMissioniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  WR303UGestMasterDetailDM, Data.DB, OracleData,
  A088UDatiLiberiIterMissioniMW, A000UMessaggi, WR302UGestTabellaDM;

type
  TWA088FDatiLiberiIterMissioniDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaORDINE: TIntegerField;
    selM025: TOracleDataSet;
    selM025CODICE: TStringField;
    selM025DESCRIZIONE: TStringField;
    selM025CATEGORIA: TStringField;
    selM025ORDINE: TIntegerField;
    selM025VALORI: TStringField;
    selM025OBBLIGATORIO: TStringField;
    selM025RIGHE: TIntegerField;
    selTabellaMIN_FASE_VISIBILE: TIntegerField;
    selTabellaMAX_FASE_VISIBILE: TIntegerField;
    selTabellaMIN_FASE_MODIFICA: TIntegerField;
    selTabellaMAX_FASE_MODIFICA: TIntegerField;
    selM025FORMATO: TStringField;
    selM025LUNG_MAX: TIntegerField;
    selM025DATO_ANAGRAFICO: TStringField;
    selM025QUERY_VALORE: TStringField;
    selM025ELENCO_FISSO: TStringField;
    selM025VALORE_DEFAULT: TStringField;
    dsrM025: TDataSource;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selM025BeforeDelete(DataSet: TDataSet);
    procedure selM025BeforePost(DataSet: TDataSet);
    procedure selM025NewRecord(DataSet: TDataSet);
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    A088FDatiLiberiIterMissioniMW: TA088FDatiLiberiIterMissioniMW;
  end;

implementation

uses
  A000UInterfaccia,
  WA088UDatiLiberiIterMissioni, WA088UDatiLiberiIterMissioniBrowseFM;

{$R *.dfm}

procedure TWA088FDatiLiberiIterMissioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY M024.ORDINE, M024.CODICE');
  inherited;
  A088FDatiLiberiIterMissioniMW:=TA088FDatiLiberiIterMissioniMW.Create(Self);
  A088FDatiLiberiIterMissioniMW.selm024_Funzioni:=selTabella;
  A088FDatiLiberiIterMissioniMW.selm025_Funzioni:=selM025;
end;

procedure TWA088FDatiLiberiIterMissioniDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A088FDatiLiberiIterMissioniMW);
  inherited;
end;

procedure TWA088FDatiLiberiIterMissioniDM.RelazionaTabelleFiglie;
begin
  selM025.Close;
  selM025.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
  selM025.Open;
end;


// ###################################################
// ##########    GESTIONE TABELLA MASTER    ##########
// ###################################################
procedure TWA088FDatiLiberiIterMissioniDM.BeforeDelete(DataSet: TDataSet);
begin
  A088FDatiLiberiIterMissioniMW.SelM024BeforeDelete;
  inherited;
end;

procedure TWA088FDatiLiberiIterMissioniDM.BeforeEdit(DataSet: TDataSet);
begin
  A088FDatiLiberiIterMissioniMW.SelM024BeforeEdit;
  inherited;
end;

procedure TWA088FDatiLiberiIterMissioniDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A088FDatiLiberiIterMissioniMW.SelM024BeforePost;
end;



// ###################################################
// ##########    GESTIONE TABELLA DETAIL    ##########
// ###################################################

procedure TWA088FDatiLiberiIterMissioniDM.selM025BeforeDelete(DataSet: TDataSet);
begin
  A088FDatiLiberiIterMissioniMW.SelM025BeforeDelete;
  inherited;
end;

procedure TWA088FDatiLiberiIterMissioniDM.selM025BeforePost(DataSet: TDataSet);
begin
  A088FDatiLiberiIterMissioniMW.SelM025BeforePost;
  inherited;
end;

procedure TWA088FDatiLiberiIterMissioniDM.selM025NewRecord(DataSet: TDataSet);
begin
  inherited;
  A088FDatiLiberiIterMissioniMW.SelM025NewRecord(selTabella.FieldByName('CODICE').AsString);
end;

end.
