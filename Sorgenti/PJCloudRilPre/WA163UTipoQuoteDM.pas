unit WA163UTipoQuoteDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A163UTipoQuoteMW, C180FunzioniGenerali,
  A000UInterfaccia, medpIWMessageDlg;

type
  TWA163FTipoQuoteDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPOQUOTA: TStringField;
    selTabellaD_TIPOQUOTA: TStringField;
    selTabellaCAUSALE_ASSESTAMENTO: TStringField;
    selTabellaVP_INTERA: TStringField;
    selTabellaVP_PROPORZIONATA: TStringField;
    selTabellaVP_NETTA: TStringField;
    selTabellaVP_NETTARISP: TStringField;
    selTabellaVP_RISPARMIO: TStringField;
    selTabellaVP_NORISPARMIO: TStringField;
    selTabellaVP_QUANTITATIVA: TStringField;
    selTabellaACCONTI: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selT305: TOracleDataSet;
    selTabellaD_CAUSALE_ASSESTAMENTO: TStringField;
    selTabellaIMPOSTA_MESE_COMP_MAX: TStringField;
    selTabellaRIF_SALDO_ANNO_CORR: TStringField;
    selTabellaGIORNI_MESE: TFloatField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selT765CalcFields(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    procedure ResultDecorrenza(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    { Private declarations }
  public
    A163FTipoQuoteMW: TA163FTipoQuoteMW;
  end;

implementation

uses WR102UGestTabella;

{$R *.dfm}

procedure TWA163FTipoQuoteDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if InterfacciaWR102.DettaglioFM and (TWR102FGestTabella(Owner).WDettaglioFM <> nil) then
      TWR102FGestTabella(Owner).WDettaglioFM.AbilitaComponenti;
end;

procedure TWA163FTipoQuoteDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE, DECORRENZA');
  NonAprireSelTabella:=True;
  inherited;
  A163FTipoQuoteMW:=TA163FTipoQuoteMW.Create(Self);
  A163FTipoQuoteMW.selT765:=selTabella;
  selTabella.Open;
end;

procedure TWA163FTipoQuoteDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A163FTipoQuoteMW);
  inherited;
end;

procedure TWA163FTipoQuoteDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A163FTipoQuoteMW.BeforeDelete(DataSet);

end;

procedure TWA163FTipoQuoteDM.selT765CalcFields(DataSet: TDataSet);
begin
  inherited;
  A163FTipoQuoteMW.selT765CalcFields(DataSet);
end;

procedure TWA163FTipoQuoteDM.BeforePost(DataSet: TDataSet);
var
  Msg: String;
begin
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    Msg:=A163FTipoQuoteMW.BeforePost;
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultDecorrenza,'PUNTO_1');
      Abort;
    end;
  end;

  Msg:=A163FTipoQuoteMW.VerificaVociPaghe;

  if not MsgBox.KeyExists('PUNTO_2') then
  begin
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultDecorrenza,'PUNTO_2');
      Abort;
    end;
  end;

  if Msg <> '' then
    A163FTipoQuoteMW.ValutaInserimentoVocePaghe;
  inherited;
end;

procedure TWA163FTipoQuoteDM.ResultDecorrenza(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

end.
