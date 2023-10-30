unit WA133UTariffeMissioniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, A133UTariffeMissioniMW, A000UInterfaccia, medpIWMessageDlg;

type
  TWA133FTariffeMissioniDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODICE: TStringField;
    selTabellaCOD_TARIFFA: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaIND_GIORNALIERA: TFloatField;
    selTabelladesc_trasferta: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaVOCEPAGHE_ESENTE: TStringField;
    selTabellaVOCEPAGHE_ASSOG: TStringField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    CampoCodPaghe: String;
    Storicizza: Boolean;
    procedure resultVerificaCodPaghe(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    A133FTariffeMissioniMW: TA133FTariffeMissioniMW;
  end;

implementation

{$R *.dfm}

procedure TWA133FTariffeMissioniDM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  A133FTariffeMissioniMW.selM065BeforeInsert;
end;

procedure TWA133FTariffeMissioniDM.BeforePost(DataSet: TDataSet);
var Msg: String;
begin
  inherited;
  A133FTariffeMissioniMW.selM065BeforePost;
  //Controllo voci paghe
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    CampoCodPaghe:='VOCEPAGHE_ESENTE';
    Msg:=A133FTariffeMissioniMW.VerificaVociPaghe(CampoCodPaghe);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultVerificaCodPaghe,'PUNTO_1');
      Abort;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_2') then
  begin
    CampoCodPaghe:='VOCEPAGHE_ASSOG';
    Msg:=A133FTariffeMissioniMW.VerificaVociPaghe(CampoCodPaghe);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultVerificaCodPaghe,'PUNTO_2');
      Abort;
    end;
  end;

  Storicizza:=InterfacciaWR102.StoricizzazioneInCorso;
end;

procedure TWA133FTariffeMissioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A133FTariffeMissioniMW:=TA133FTariffeMissioniMW.Create(Self);
  A133FTariffeMissioniMW.selM065_Funzioni:=selTabella;
  selTabella.FieldByName('desc_trasferta').LookupDataSet:=A133FTariffeMissioniMW.QSource;
  selTabella.Open;

  SetTabelleRelazionate([selTabella,A133FTariffeMissioniMW.selM066]);
end;

procedure TWA133FTariffeMissioniDM.RelazionaTabelleFiglie;
begin
  inherited;
  A133FTariffeMissioniMW.RelazionaM066;
end;

procedure TWA133FTariffeMissioniDM.resultVerificaCodPaghe(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:
    begin
      A133FTariffeMissioniMW.InserisciVocePaghe(CampoCodPaghe);
      selTabella.Post;
    end;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA133FTariffeMissioniDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A133FTariffeMissioniMW);
  inherited;
end;
procedure TWA133FTariffeMissioniDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  if not InterfacciaWR102.StoricizzazioneInCorso then
    selTabella.FieldByName('DECORRENZA').AsDateTime:=strToDate('01/01/1900');
end;

end.

