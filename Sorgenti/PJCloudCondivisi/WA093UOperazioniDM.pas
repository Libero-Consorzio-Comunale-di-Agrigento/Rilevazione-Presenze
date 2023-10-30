unit WA093UOperazioniDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, A000UCostanti, A000USessione, L021Call,
  A000UInterfaccia, C180FunzioniGenerali, WR300UBaseDM;

type
  TWA093FOperazioniDM = class(TWR300FBaseDM)
    Q000_Tabelle: TOracleDataSet;
    Q000_TabelleTABELLA: TStringField;
    Q000: TOracleDataSet;
    Q000_Operatori: TOracleDataSet;
    Q000_OperatoriOPERATORE: TStringField;
    D000: TDataSource;
    Q001: TOracleDataSet;
    Q001COLONNA: TStringField;
    Q001VALORE_OLD: TStringField;
    Q001VALORE_NEW: TStringField;
    D001: TDataSource;
    selCols: TOracleDataSet;
    delI000: TOracleQuery;
    procedure Q000AfterOpen(DataSet: TDataSet);
    procedure Q000AfterScroll(DataSet: TDataSet);
    procedure Q000CalcFields(DataSet: TDataSet);
    procedure Q000FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure QAnagraAfterScroll(DataSet: TDataSet);
  private
  public
  end;

implementation

{$R *.dfm}

uses WA093UOperazioni, WA093UOperazioniRisultatiFM;

procedure TWA093FOperazioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  Q000_Operatori.Open;
  Q000_Tabelle.Open;
  Q000.Open;
end;

procedure TWA093FOperazioniDM.Q000AfterOpen(DataSet: TDataSet);
begin
  Q000.FieldByName('ID').DisplayWidth:=8;
  Q000.FieldByName('OPERATORE').DisplayWidth:=15;
  Q000.FieldByName('OPERATORE').DisplayLabel:='Operatore';
  Q000.FieldByName('TABELLA').DisplayWidth:=15;
  Q000.FieldByName('TABELLA').DisplayLabel:='Tabella';
  Q000.FieldByName('OPERAZIONE').DisplayWidth:=3;
  Q000.FieldByName('OPERAZIONE').DisplayLabel:='Op.';
  Q000.FieldByName('DATA').DisplayWidth:=12;
  Q000.FieldByName('DATA').DisplayLabel:='Data';
  TDateTimeField(Q000.FieldByName('DATA')).DisplayFormat:='dd/mm/yyyy hhhh.nn';
  try
    if Q000.FindField('ID_1') <> nil then
      Q000.FieldByName('ID_1').Visible:=False;
    if Q000.FindField('COLONNA') <> nil then
    begin
      Q000.FieldByName('COLONNA').DisplayWidth:=15;
      Q000.FieldByName('COLONNA').DisplayLabel:='Colonna';
    end;
    if Q000.FindField('VALORE_OLD') <> nil then
    begin
      Q000.FieldByName('VALORE_OLD').DisplayWidth:=10;
      Q000.FieldByName('VALORE_OLD').DisplayLabel:='Valore_Old';
    end;
    if Q000.FindField('VALORE_NEW') <> nil then
    begin
      Q000.FieldByName('VALORE_NEW').DisplayWidth:=10;
      Q000.FieldByName('VALORE_NEW').DisplayLabel:='Valore_New';
    end;
  except
  end;
end;

procedure TWA093FOperazioniDM.Q000AfterScroll(DataSet: TDataSet);
begin
  Q001.Close;
  Q001.SetVariable('ID',Q000.FieldByName('ID').AsInteger);
  Q001.Open;

  if TWA093FOperazioni(Self.Owner).WRisultatiFM <> nil then
  begin
    with TWA093FOperazioniRisultatiFM(TWA093FOperazioni(Self.Owner).WRisultatiFM) do
    begin
      if grdDettaglio.Visible then
        CreaGrid(grdDettaglio);
    end;
  end;
end;

procedure TWA093FOperazioniDM.Q000CalcFields(DataSet: TDataSet);
var i:Integer;
begin
  for i:=1 to High(FunzioniDisponibili) do
    //Caratto: 11/04/2013. Unificazione L021. Considero le maschere win e web (FunzioniDisponibili.S ,FunzioniDisponibili.SW)
    if L021VerificaMaschera(Q000.FieldByName('Maschera').AsString,i) and
       L021VerificaApplicazione(Parametri.Applicazione,i) then
    begin
      Q000.FieldByName('Funzione').AsString:=FunzioniDisponibili[i].G + ':' + FunzioniDisponibili[i].N;
      Break;
    end;
end;

procedure TWA093FOperazioniDM.Q000FilterRecord(DataSet: TDataSet; var Accept: Boolean);
var
  LProg: Integer;
begin
  Accept:=False;

  LProg:=Q000.FieldByName('PROGRESSIVO').AsInteger;
  if LProg > 0 then
    if TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe.SearchRecord('Progressivo',LProg,[srFromBeginning]) then
      Accept:=True;
end;

procedure TWA093FOperazioniDM.QAnagraAfterScroll(DataSet: TDataSet);
begin
  Q000.Close;
  Q001.Close;
  Q000.SetVariable('Progressivo',TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger);
  Q000.Open;

  if TWA093FOperazioni(Self.Owner).WRisultatiFM <> nil then
    with TWA093FOperazioniRisultatiFM(TWA093FOperazioni(Self.Owner).WRisultatiFM) do
      CreaGrid(grdRisultati);
end;

end.
