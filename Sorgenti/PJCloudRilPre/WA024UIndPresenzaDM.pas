unit WA024UIndPresenzaDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, A000UCostanti, A000USessione, Math, StrUtils,
  A000UInterfaccia, WR303UGestMasterDetailDM, WR300UBaseDM, DBClient,
  WR302UGestTabellaDM, medpIWMessageDlg, medpIWDBGrid;

type
  TWA024FIndPresenzaDM = class(TWR303FGestMasterDetailDM)
    dsrT160: TDataSource;
    selT160: TOracleDataSet;
    selT160CODICE: TStringField;
    selT160INDENNITA: TStringField;
    selT160D_INDENNITA: TStringField;
    Ins160: TOracleQuery;
    Update160: TOracleQuery;
    Delete160: TOracleQuery;
    Upd160: TOracleQuery;
    Del160: TOracleQuery;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    Q162: TOracleDataSet;
    Q162CODICE: TStringField;
    Q162DESCRIZIONE: TStringField;
    Q162IMPORTO: TFloatField;
    Q162VOCEPAGHE: TStringField;
    Q162TIPO: TStringField;
    Q162NUMTURNI: TFloatField;
    Q162TURNI: TStringField;
    Q162ASSENZE: TStringField;
    Q162CODICE2: TStringField;
    Q162TURNO1: TFloatField;
    Q162TURNO2: TFloatField;
    Q162TURNO3: TFloatField;
    Q162TURNO4: TFloatField;
    Q162PRIORITA: TIntegerField;
    Q162INDENNITA_INCOMPATIBILI: TStringField;
    Q162COEFFICIENTE: TFloatField;
    Q162ARROTONDAMENTO: TStringField;
    Q162ASSENZE_ABILITATE: TStringField;
    Q162SUPPL_5GGLAV: TStringField;
    Q162CAUPRES_RIEPORE: TStringField;
    Q162D_CAUPRES_RIEPORE: TStringField;
    Q162NMESI_EQUITURNI: TFloatField;
    selT275Escluse: TOracleDataSet;
    selT275EscluseCODICE: TStringField;
    selT275EscluseDESCRIZIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
  private
    Operazione:String;
    OldValue:String;
    Value:String;
  protected
    procedure RelazionaTabelleFiglie; override;
  public
  end;

implementation

uses WA024UIndPresenza, WA024UIndPresenzaIndennitaFM,
     WR100UBase;

{$R *.dfm}

procedure TWA024FIndPresenzaDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  NonAprireSelTabella:=True;
  inherited;
  selT275Escluse.Open;
  Q162.Open;
  selT160.Open;
  selTabella.Open;
end;

procedure TWA024FIndPresenzaDM.RelazionaTabelleFiglie;
begin
  selT160.Close;
  selT160.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
  selT160.Open;
end;

procedure TWA024FIndPresenzaDM.AfterDelete(DataSet: TDataSet);
begin
  if Operazione = 'D' then
  begin
    with Del160 do
    begin
      SetVariable('CODICE',OldValue);
      Execute;
    end;
  end;
  inherited;
end;

procedure TWA024FIndPresenzaDM.AfterPost(DataSet: TDataSet);
begin
  if Operazione = 'U' then
  begin
    with Upd160 do
    begin
      SetVariable('NEW_CODICE',Value);
      SetVariable('OLD_CODICE',OldValue);
      Execute;
    end;
  end;
  inherited;
end;

procedure TWA024FIndPresenzaDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Operazione:='D';
  OldValue:=selTabella.FieldByName('CODICE').medpOldValue;
end;

procedure TWA024FIndPresenzaDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  Operazione:=IfThen((selTabella.State in [dsEdit]),'U','');
  OldValue:=VarToStr(selTabella.FieldByName('CODICE').OldValue);
  Value:=selTabella.FieldByName('CODICE').Value;

end;

end.
