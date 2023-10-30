unit WA050UOrologiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione, medpIWMessageDlg,A000UMessaggi;

type
  TWA050FOrologiDM = class(TWR302FGestTabellaDM)
    Q305: TOracleDataSet;
    D305: TDataSource;
    selI100: TOracleDataSet;
    dsrI100: TDataSource;
    DSelLocalita: TDataSource;
    SelLocalita: TOracleDataSet;
    ControlloRilev: TOracleQuery;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaFUNZIONE: TStringField;
    selTabellaCAUSMENSA: TStringField;
    selTabellaVERSO: TStringField;
    selTabellaPOSTAZIONE: TStringField;
    selTabellaINDIRIZZO_TERMINALE: TStringField;
    selTabellaINDIRIZZO_IP: TStringField;
    selTabellaRICEZIONE_MESSAG: TStringField;
    selTabellaAPPLICA_PERCORRENZA_PM: TStringField;
    selTabellaTIPO_LOCALITA: TStringField;
    selTabellaCOD_LOCALITA: TStringField;
    selTabellaINDIRIZZO: TStringField;
    selTabellaD_LOCALITA: TStringField;
    selTabellaSCARICO: TStringField;
    selTabellaRILEVATORE: TStringField;
    SelLocalitaCODICE: TStringField;
    SelLocalitaCITTA: TStringField;
    selM042: TOracleDataSet;
    selM042CODICE: TStringField;
    selM042DESCRIZIONE: TStringField;
    dsrM042: TDataSource;
    selTabellaLAT: TFloatField;
    selTabellaLNG: TFloatField;
    selTabellaRAGGIO_VALIDITA: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
  public
  end;

implementation

uses WA050UOrologi, WA050UOrologiDettFM, WR100UBase;

{$R *.dfm}

procedure TWA050FOrologiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  NonAprireSelTabella:=True;
  inherited;
  selLocalita.SetVariable('ORDERBY','ORDER BY CITTA');
  selLocalita.Open;
  SelM042.SetVariable('ORDERBY','ORDER BY DESCRIZIONE');
  SelM042.Open;
  Q305.Open;
  selI100.Open;
  selTabella.Open;
end;

procedure TWA050FOrologiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;

  if (not selTabella.FieldByName('RILEVATORE').IsNull) and (Trim(selTabella.FieldByName('RILEVATORE').AsString) <> '') then
  begin //Verifico se esiste un altro orologio con lo stesso rilevatore
    ControlloRilev.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
    ControlloRilev.SetVariable('RILEV',selTabella.FieldByName('RILEVATORE').AsString);
    ControlloRilev.Execute;
    if ControlloRilev.RowsProcessed > 0 then
    begin
      if (VarToStr(ControlloRilev.Field(0)) = '') or (VarToStr(ControlloRilev.Field(0)) = selTabella.FieldByName('SCARICO').AsString) then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_A050_ERR_FMT_OROLOGIO_DUPL,[VarToStr(ControlloRilev.Field(1))]),mtError,[mbOk],nil,'');
        Abort;
      end;
      if (VarToStr(ControlloRilev.Field(0)) <> '') and (selTabella.FieldByName('SCARICO').IsNull or (selTabella.FieldByName('SCARICO').AsString = '')) then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_A050_ERR_FMT_SCARICO,[VarToStr(ControlloRilev.Field(1)),VarToStr(ControlloRilev.Field(0))]),mtError,[mbOk],nil,'');
        Abort;
      end;
    end;
  end
  else
    selTabella.FieldByName('SCARICO').AsString:='';  //se il rilev. è nullo pulisco lo scarico

end;

end.
