unit WP651URelazioniTabelleDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, P651URelazioniTabelleMW,
  Oracle, A000UMessaggi, A000UCostanti, A000USessione, A000UInterfaccia;

type
  TWP651FRelazioniTabelleDM = class(TWR302FGestTabellaDM)
    selTabellaNOME_FLUSSO: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaCOD_DATO1: TStringField;
    selTabellaCOD_DATO2: TStringField;
    selTabellaDESCR_DATO1: TStringField;
    selTabellaDESCR_DATO2: TStringField;
    selTabellaPERCENTUALE: TFloatField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
    P651FRelazioniTabelleMW: TP651FRelazioniTabelleMW;
    procedure Controlli;
  end;

implementation

{$R *.dfm}

uses WP651URelazioniTabelle;

procedure TWP651FRelazioniTabelleDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  Controlli;
end;

procedure TWP651FRelazioniTabelleDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  Controlli;
end;

procedure TWP651FRelazioniTabelleDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  P651FRelazioniTabelleMW.selI037BeforePost;
end;

procedure TWP651FRelazioniTabelleDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  P651FRelazioniTabelleMW:=TP651FRelazioniTabelleMW.Create(Self);
  P651FRelazioniTabelleMW.selI037:=selTabella;
end;

procedure TWP651FRelazioniTabelleDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P651FRelazioniTabelleMW);
  inherited;
end;

procedure TWP651FRelazioniTabelleDM.OnNewRecord(DataSet: TDataSet);
begin
  P651FRelazioniTabelleMW.selI037NewRecord;
  inherited;
end;

procedure TWP651FRelazioniTabelleDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  P651FRelazioniTabelleMW.selI037CalcFields;
end;

procedure TWP651FRelazioniTabelleDM.Controlli;
var lstAnomalie:TStringList;
begin
  (self.Owner as TWP651FRelazioniTabelle).MemoControlli.Clear;
  lstAnomalie:=TStringList.Create;
  try
    lstAnomalie.Text:=P651FRelazioniTabelleMW.Controlli;
    (self.Owner as TWP651FRelazioniTabelle).MemoControlli.Lines.Assign(lstAnomalie);
  finally
    lstAnomalie.Free;
  end;
end;

end.
