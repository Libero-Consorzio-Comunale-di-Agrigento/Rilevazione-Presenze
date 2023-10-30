unit WA038UVociVariabiliDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM,A038UVociVariabiliMW,StrUtils,Db, DBClient;

type
  TWA038FVociVariabiliDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    procedure SelT195FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure SelT195StateChange(Sender: TObject);
  public
    A038FVociVariabiliMW : TA038FVociVariabiliMW;
    procedure SettaQuery(Data1,Data2: TDateTime; TuttiDip,SolaLettura:Boolean;TipoElenco,Progressivo:Integer;OpenSelT195:Boolean);
  end;

implementation

uses WA038UVociVariabili;

{$R *.dfm}

procedure TWA038FVociVariabiliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A038FVociVariabiliMW:=TA038FVociVariabiliMW.Create(Self);
  A038FVociVariabiliMW.SelT195.FieldByName('D_CODICE').ReadOnly:=True;
  A038FVociVariabiliMW.OnFilterRecord:=SelT195FilterRecord;
  A038FVociVariabiliMW.OnStateChange:=SelT195StateChange;
end;

procedure TWA038FVociVariabiliDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A038FVociVariabiliMW);
end;

procedure TWA038FVociVariabiliDM.SettaQuery(Data1,Data2: TDateTime; TuttiDip,SolaLettura:Boolean;TipoElenco,Progressivo:Integer; OpenSelT195:Boolean);
begin
  with A038FVociVariabiliMW.selT195 do
  begin
    Close;
    SetVariable('DATA1',Data1);
    SetVariable('DATA2',Data2);
    SetVariable('T',IfThen(TuttiDip, 'T','1'));

    if TipoElenco = 0 then
    begin
      SetVariable('T195_ROWID',',T195.ROWID');
      SetVariable('T195','T195_VOCIVARIABILI T195');
    end
    else
    begin
      SetVariable('T195_ROWID','');
      SetVariable('T195','(SELECT PROGRESSIVO,DATARIF,VOCEPAGHE,SUM(VALORE) VALORE,SUM(IMPORTO) IMPORTO,UM,DAL,AL,OPERAZIONE,COD_INTERNO,MAX(DATA_CASSA) DATA_CASSA ' +
                           'FROM T195_VOCIVARIABILI '+
                           'GROUP BY PROGRESSIVO,DATARIF,VOCEPAGHE,UM,DAL,AL,OPERAZIONE,COD_INTERNO) T195');
    end;
    ReadOnly:=(TipoElenco = 1) or SolaLettura;

    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('ORDERBY','ORDER BY COGNOME,MATRICOLA,DATARIF,VOCEPAGHE,DATA_CASSA');
    if OpenSelT195 then
      Open;
  end
end;

procedure TWA038FVociVariabiliDM.SelT195FilterRecord(DataSet: TDataSet; var Accept: Boolean);
var
  i: Integer;
begin
  Accept:=False;
  with (Self.Owner as TWA038FVociVariabili) do
  begin
    if chkMeseCassa.Checked then
    begin
      Accept:=StrToDate(cmbMeseCassa.Items[cmbMeseCassa.ItemIndex]) = DataSet.FieldByName('Data_Cassa').AsDateTime;
      if not Accept then exit;
    end;

    Accept:=chkUMNumero.Checked and (DataSet.FieldByName('UM').AsString = 'N') or
            chkUMOre.Checked and (DataSet.FieldByName('UM').AsString = 'H') or
            chkUMValuta.Checked and (DataSet.FieldByName('UM').AsString = 'V');
    if not Accept then exit;

    if chkVoci.Checked then
    begin
      i:=LstVociPagheSelezionate.IndexOf(DataSet.FieldByName('VocePaghe').AsString);
      Accept:=i >= 0;
    end;
    if chkCodici.Checked then
    begin
      i:=LstCodiciInterniSelezionati.IndexOf(DataSet.FieldByName('Cod_Interno').AsString);
      Accept:=i >= 0;
    end;
  end;
end;

procedure TWA038FVociVariabiliDM.SelT195StateChange(Sender: TObject);
begin
  with (Self.Owner as TWA038FVociVariabili) do
    AbilitaToolbarWC700(not (A038FVociVariabiliMW.selT195.State in [dsEdit,dsInsert]));
end;

end.
