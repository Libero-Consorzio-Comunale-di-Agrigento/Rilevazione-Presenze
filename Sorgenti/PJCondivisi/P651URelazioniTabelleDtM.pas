unit P651URelazioniTabelleDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, R004UGESTSTORICODTM, A000UMessaggi,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FUNZIONIGENERALI, C700USelezioneAnagrafe,
  DBClient, Variants, P651URelazioniTabelleMW;

type
  TP651FRelazioniTabelleDtM = class(TR004FGestStoricoDtM)
    selI037: TOracleDataSet;
    selI037NOME_FLUSSO: TStringField;
    selI037DECORRENZA: TDateTimeField;
    selI037DECORRENZA_FINE: TDateTimeField;
    selI037COD_DATO1: TStringField;
    selI037COD_DATO2: TStringField;
    selI037DESCR_DATO1: TStringField;
    selI037DESCR_DATO2: TStringField;
    dsrFlussi: TDataSource;
    selI037PERCENTUALE: TFloatField;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure DataModuleCreate(Sender: TObject);
    procedure selI037CalcFields(DataSet: TDataSet);
    procedure selI037COD_DATO1SetText(Sender: TField; const Text: string);
    procedure selI037COD_DATO2SetText(Sender: TField; const Text: string);
    procedure selI037NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    P651FRelazioniTabelleMW: TP651FRelazioniTabelleMW;
    procedure Controlli;
  end;

var
  P651FRelazioniTabelleDtM: TP651FRelazioniTabelleDtM;

implementation

uses P651URelazioniTabelle;

{$R *.DFM}

procedure TP651FRelazioniTabelleDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=P651FRelazioniTabelle.InterfacciaR004;
  InizializzaDataSet(selI037,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnTranslateMessage]);
  //InterfacciaR004.GestioneDecorrenzaFine:=True;
  P651FRelazioniTabelleMW:=TP651FRelazioniTabelleMW.Create(Self);
  P651FRelazioniTabelleMW.selI037:=selI037;
  dsrFlussi.DataSet:=P651FRelazioniTabelleMW.selFlussi;
end;

procedure TP651FRelazioniTabelleDtM.selI037CalcFields(DataSet: TDataSet);
begin
  inherited;
  P651FRelazioniTabelleMW.selI037CalcFields;
end;

procedure TP651FRelazioniTabelleDtM.selI037COD_DATO1SetText(Sender: TField; const Text: string);
begin
  inherited;
  Sender.AsString:=Trim(Copy(Text,1,P651FRelazioniTabelleMW.LungTipoQuota1));
end;

procedure TP651FRelazioniTabelleDtM.selI037COD_DATO2SetText(Sender: TField; const Text: string);
begin
  inherited;
  Sender.AsString:=Trim(Copy(Text,1,P651FRelazioniTabelleMW.LungTipoQuota2));
end;

procedure TP651FRelazioniTabelleDtM.selI037NewRecord(DataSet: TDataSet);
begin
  inherited;
  P651FRelazioniTabelleMW.selI037NewRecord;
end;

procedure TP651FRelazioniTabelleDtM.BeforePost(DataSet: TDataSet);
begin
  P651FRelazioniTabelleMW.selI037BeforePost;
  inherited;
end;

procedure TP651FRelazioniTabelleDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  Controlli;
end;

procedure TP651FRelazioniTabelleDtM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  Controlli;
end;

procedure TP651FRelazioniTabelleDtM.Controlli;
var lstAnomalie:TStringList;
begin
  P651FRelazioniTabelle.MemoControlli.Clear;
  lstAnomalie:=TStringList.Create;
  try
    lstAnomalie.Text:=P651FRelazioniTabelleMW.Controlli;
    P651FRelazioniTabelle.MemoControlli.Lines.Assign(lstAnomalie);
  finally
    lstAnomalie.Free;
  end;
end;

end.
