unit WA015UPlusOraIndivDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, medpIWMessageDlg;

type
  TWA015FPlusOraIndivDM = class(TWR302FGestTabellaDM)
    T090Progressivo: TFloatField;
    T090Anno: TFloatField;
    T090DESCRIZIONE: TStringField;
    T090TipoPO: TStringField;
    T090TipoDebito: TStringField;
    selTabellaTipoGest1: TStringField;
    selTabellaTipoGest2: TStringField;
    selTabellaTipoGest3: TStringField;
    selTabellaTipoGest4: TStringField;
    selTabellaTipoGest5: TStringField;
    selTabellaTipoGest6: TStringField;
    selTabellaTipoGest7: TStringField;
    selTabellaTipoGest8: TStringField;
    selTabellaTipoGest9: TStringField;
    selTabellaTipoGest10: TStringField;
    selTabellaTipoGest11: TStringField;
    selTabellaTipoGest12: TStringField;
    selTabellaOre1: TStringField;
    selTabellaOre2: TStringField;
    selTabellaOre3: TStringField;
    selTabellaOre4: TStringField;
    selTabellaOre5: TStringField;
    selTabellaOre6: TStringField;
    selTabellaOre7: TStringField;
    selTabellaOre8: TStringField;
    selTabellaOre9: TStringField;
    selTabellaOre10: TStringField;
    selTabellaOre11: TStringField;
    selTabellaOre12: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet);Override;
    procedure selTabellaPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
  private
    { Private declarations }
  public
    {public declarations}
  end;

implementation

uses A000UInterfaccia, A000UMessaggi, WR100UBase;

{$R *.dfm}

procedure TWA015FPlusOraIndivDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  SelTabella.SetVariable(':ORDERBY','ORDER BY ANNO DESC');
  inherited;
end;

procedure TWA015FPlusOraIndivDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  with SelTabella do
  begin
    FieldByName('Progressivo').AsInteger:=(Self.Owner as TWR100FBase).grdC700.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('TipoDebito').AsString:='M';
    FieldByName('TipoPO').AsString:='0';
    FieldByName('TipoGest1').AsString:='0';
    FieldByName('TipoGest2').AsString:='0';
    FieldByName('TipoGest3').AsString:='0';
    FieldByName('TipoGest4').AsString:='0';
    FieldByName('TipoGest5').AsString:='0';
    FieldByName('TipoGest6').AsString:='0';
    FieldByName('TipoGest7').AsString:='0';
    FieldByName('TipoGest8').AsString:='0';
    FieldByName('TipoGest9').AsString:='0';
    FieldByName('TipoGest10').AsString:='0';
    FieldByName('TipoGest11').AsString:='0';
    FieldByName('TipoGest12').AsString:='0';
  end;
end;

procedure TWA015FPlusOraIndivDM.selTabellaPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  MsgBox.WebMessageDlg(Format(A000MSG_A015_MSG_FMT_PLUS_GIA_INSERITO,[SelTabella.FieldByName('Anno').AsString]),mtInformation,[mbOK],nil,'');
  Action:=daAbort;
end;

end.
