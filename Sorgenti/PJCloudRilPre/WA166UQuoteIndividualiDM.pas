unit WA166UQuoteIndividualiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A000UInterfaccia, A166UQuoteIndividualiMW, medpIWMessageDlg, A000UMessaggi, C180FunzioniGenerali;

type
  TWA166FQuoteIndividualiDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaSCADENZA: TDateTimeField;
    selTabellaCODTIPOQUOTA: TStringField;
    selTabellaPENALIZZAZIONE: TFloatField;
    selTabellaSALTAPROVA: TStringField;
    selTabellaIMPORTO: TFloatField;
    selTabellaNUM_ORE: TStringField;
    selTabellaPERC_INDIVIDUALE: TFloatField;
    selTabellaPERC_STRUTTURALE: TFloatField;
    selTabellaCONSIDERA_SALDO: TStringField;
    selTabellaSOSPENDI_PT: TStringField;
    selTabellaSOSPENDI_QUOTE: TStringField;
    selTabellaPERCENTUALE: TFloatField;
    selTabellaD_TIPOQUOTA: TStringField;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    procedure ResultForzaDateDecorrenzaScadenza(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    A166FQuoteIndividualiMW:TA166FQuoteIndividualiMW;
  end;

implementation

{$R *.dfm}
procedure TWA166FQuoteIndividualiDM.BeforePost(DataSet: TDataSet);
var msg: String;
begin
  inherited;
  if selTabella.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).IsNull then
    selTabella.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).AsDateTime:=StrToDate('31/12/3999');

  if (selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime > selTabella.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).AsDateTime) then
    raise Exception.Create(A000MSG_ERR_DECOR_SUP_SCAD);

  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    msg:=A166FQuoteIndividualiMW.MessaggioForzaDecorrenzaScadenza;
    if msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultForzaDateDecorrenzaScadenza,'PUNTO_1');
      Abort;
    end;
  end;
  try
    A166FQuoteIndividualiMW.ControlliBeforePost;
  finally
    //un eventuale errore bloccante deve resettare i punti preimpostati poichè
    //l'utente potrebbe cambiare date e riconfermare
    MsgBox.ClearKeys;
  end;
end;

procedure TWA166FQuoteIndividualiDM.ResultForzaDateDecorrenzaScadenza(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:
      begin
        selTabella.FieldByName('DECORRENZA').AsDateTime:=R180InizioMese(selTabella.FieldByName('DECORRENZA').AsDateTime);
        selTabella.FieldByName('SCADENZA').AsDateTime:=R180FineMese(selTabella.FieldByName('SCADENZA').AsDateTime);
      end;
  end;
  selTabella.Post;
end;

procedure TWA166FQuoteIndividualiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A166FQuoteIndividualiMW:=TA166FQuoteIndividualiMW.Create(Self);
  A166FQuoteIndividualiMW.selT775_Funzioni:=selTabella;

  A166FQuoteIndividualiMW.selT765.SetVariable('DECORRENZA',Parametri.DataLavoro);
  A166FQuoteIndividualiMW.selT765.Open;

  selTabella.FieldByName('D_TIPOQUOTA').LookupDataset:=A166FQuoteIndividualiMW.selT765;
  selTabella.SetVariable('ORDERBY','ORDER BY DECORRENZA DESC, CODTIPOQUOTA');
  selTabella.Open;
end;

procedure TWA166FQuoteIndividualiDM.AfterScroll(DataSet: TDataSet);
begin
  A166FQuoteIndividualiMW.SelT775AfterScroll;
  inherited;
end;

procedure TWA166FQuoteIndividualiDM.OnNewRecord(DataSet: TDataSet);
begin
  A166FQuoteIndividualiMW.SelT775OnNewRecord;
  inherited;
end;

procedure TWA166FQuoteIndividualiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A166FQuoteIndividualiMW);
  inherited;
end;

end.
