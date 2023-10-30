unit WA164UQuoteIncentiviDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A164UQuoteIncentiviMW,
  A000UInterfaccia, C180FunzioniGenerali, medpIWMessageDlg;

type
  TWA164FQuoteIncentiviDM = class(TWR302FGestTabellaDM)
    selTabellaDATO1: TStringField;
    selTabellaDATO2: TStringField;
    selTabellaDATO3: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaCODTIPOQUOTA: TStringField;
    selTabellaCAUSALE: TStringField;
    selTabellaIMPORTO: TFloatField;
    selTabellaNUM_ORE: TStringField;
    selTabellaPERC_INDIVIDUALE: TFloatField;
    selTabellaPERC_STRUTTURALE: TFloatField;
    selTabellaCONSIDERA_SALDO: TStringField;
    selTabellaSOSPENDI_PT: TStringField;
    selTabellaPENALIZZAZIONE: TFloatField;
    selTabellaVALUT_STRUTTURALE: TFloatField;
    selTabellaTIPO_STAMPAQUANT: TStringField;
    selTabellaTOTNETTO: TFloatField;
    selTabellaD_DATO1: TStringField;
    selTabellaD_DATO2: TStringField;
    selTabellaD_DATO3: TStringField;
    selTabellaD_TIPOQUOTA: TStringField;
    selTabellaD_CAUSALE: TStringField;
    selTabellaPERCENTUALE: TFloatField;
    selTabellaCONSIDERA_PROVA: TStringField;
    selTabellaTIPIRAPPORTO_SOSPENSIONE: TStringField;
    selTabellaDURATA_SOSPENSIONE: TFloatField;
    selTabellaESCLUSIONE_VALORI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A164FQuoteIncentiviMW: TA164FQuoteIncentiviMW;
  end;

implementation

uses
  WA164UQuoteIncentivi;

{$R *.dfm}

procedure TWA164FQuoteIncentiviDM.AfterScroll(DataSet: TDataSet);
begin
  A164FQuoteIncentiviMW.SelT770AfterScroll;
  inherited;
end;

procedure TWA164FQuoteIncentiviDM.BeforePost(DataSet: TDataSet);
var
  Msg: String;
begin
  inherited;
  Msg:=A164FQuoteIncentiviMW.SelT770BeforePost;
  if Msg <> '' then
    MsgBox.WebMessageDlg(Msg,mtInformation,[mbOk],nil,'');
end;

procedure TWA164FQuoteIncentiviDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A164FQuoteIncentiviMW:=TA164FQuoteIncentiviMW.Create(Self);
  A164FQuoteIncentiviMW.selT770_Funzioni:=selTabella;
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
  begin
    A164FQuoteIncentiviMW.CaricamentoDati(A164FQuoteIncentiviMW.selDato1,Parametri.CampiRiferimento.C7_Dato1,Parametri.DataLavoro);
    selTabella.FieldByName('DATO1').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato1);
    selTabella.FieldByName('D_DATO1').DisplayLabel:='Desc. ' + selTabella.FieldByName('DATO1').DisplayLabel;
    selTabella.FieldByName('D_DATO1').LookupDataset:=A164FQuoteIncentiviMW.selDato1;
  end
  else
  begin
    selTabella.FieldByName('D_DATO1').Free;
    selTabella.FieldByName('DATO1').Visible:=False;
  end;

  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
  begin
    A164FQuoteIncentiviMW.CaricamentoDati(A164FQuoteIncentiviMW.selDato2,Parametri.CampiRiferimento.C7_Dato2,Parametri.DataLavoro);
    selTabella.FieldByName('DATO2').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato2);
    selTabella.FieldByName('D_DATO2').DisplayLabel:='Desc. ' + selTabella.FieldByName('DATO2').DisplayLabel;
    selTabella.FieldByName('D_DATO2').LookupDataset:=A164FQuoteIncentiviMW.selDato2;
  end
  else
  begin
    selTabella.FieldByName('D_DATO2').Free;
    selTabella.FieldByName('DATO2').Visible:=False;
  end;

  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
  begin
    A164FQuoteIncentiviMW.CaricamentoDati(A164FQuoteIncentiviMW.selDato3,Parametri.CampiRiferimento.C7_Dato3,Parametri.DataLavoro);
    selTabella.FieldByName('DATO3').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato3);
    selTabella.FieldByName('D_DATO3').DisplayLabel:='Desc. ' + selTabella.FieldByName('DATO3').DisplayLabel;
    selTabella.FieldByName('D_DATO3').LookupDataset:=A164FQuoteIncentiviMW.selDato3;
  end
  else
  begin
    selTabella.FieldByName('D_DATO3').Free;
    selTabella.FieldByName('DATO3').Visible:=False;
  end;
  A164FQuoteIncentiviMW.selT765.SetVariable('DECORRENZA',Parametri.DataLavoro);
  A164FQuoteIncentiviMW.selT765.Open;

  selTabella.FieldByName('D_TIPOQUOTA').LookupDataset:=A164FQuoteIncentiviMW.selT765;
  selTabella.FieldByName('D_CAUSALE').LookupDataset:=A164FQuoteIncentiviMW.selT265;

  selTabella.Open;
end;

procedure TWA164FQuoteIncentiviDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A164FQuoteIncentiviMW);
  inherited;
end;

procedure TWA164FQuoteIncentiviDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  (Self.Owner as TWA164FQuoteIncentivi).ReimpostaCampiDecorrenza;
end;

procedure TWA164FQuoteIncentiviDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A164FQuoteIncentiviMW.selT770CalcFields;
end;

end.
