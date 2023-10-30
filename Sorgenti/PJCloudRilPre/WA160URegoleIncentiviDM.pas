unit WA160URegoleIncentiviDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A160URegoleIncentiviMW, A000UInterfaccia, medpIWMessageDlg, C180FunzioniGenerali;

type
  TWA160FRegoleIncentiviDM = class(TWR302FGestTabellaDM)
    selTabellaLIVELLO: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaELENCOLIV: TStringField;
    selTabellaPROPORZIONE_INCENTIVI: TStringField;
    selTabellaPROPORZIONE_PARTTIME: TStringField;
    selTabellaD_LIVELLO: TStringField;
    selTabellaTIPO_QUOTEQUANT: TStringField;
    selTabellaFILE_ISTRUZIONI: TStringField;
    selTabellaSCAGLIONI_GGEFF: TStringField;
    selTabellaABBATTIMENTO_MAX: TFloatField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaD_PROPORZIONE_INCENTIVI: TStringField;
    selTabellaD_TIPO: TStringField;
    selTabellaD_TIPO_QUOTEQUANT: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure selTabellaABBATTIMENTO_MAXSetText(Sender: TField;
      const Text: string);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
  private
    procedure ResultDecorrenza(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
  public
    A160FRegoleIncentiviMW:TA160FRegoleIncentiviMW;
  end;


implementation

uses WR102UGestTabella;

{$R *.dfm}

procedure TWA160FRegoleIncentiviDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY LIVELLO, DECORRENZA');
  NonAprireSelTabella:=True;
  inherited;
  A160FRegoleIncentiviMW:=TA160FRegoleIncentiviMW.Create(Self);
  A160FRegoleIncentiviMW.selT760:=selTabella;
  selTabella.Open;
end;

procedure TWA160FRegoleIncentiviDM.selTabellaABBATTIMENTO_MAXSetText(
  Sender: TField; const Text: string);
begin
  inherited;
  A160FRegoleIncentiviMW.selT760ABBATTIMENTO_MAXSetText(Sender, Text);
end;

procedure TWA160FRegoleIncentiviDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A160FRegoleIncentiviMW.selT760CalcFields;
end;

procedure TWA160FRegoleIncentiviDM.BeforePost(DataSet: TDataSet);
var
  Msg: String;
  VoceOld:String;
begin
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    Msg:=A160FRegoleIncentiviMW.BeforePost;
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbOK],ResultDecorrenza,'PUNTO_1');
      Abort;
    end;
  end;

  if A160FRegoleIncentiviMW.selT760.FieldByName('TIPO').AsString = 'D' then
  begin
    VoceOld:='';
    Msg:=A160FRegoleIncentiviMW.VerificaVociPaghe(VoceOld,'A#I');
    if not MsgBox.KeyExists('PUNTO_2') then
    begin
      if Msg <> '' then
      begin
        MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultDecorrenza,'PUNTO_2');
        Abort;
      end;
    end;
    if Msg <> '' then
      A160FRegoleIncentiviMW.ValutaInserimentoVocePaghe('A#I');
  end;
  inherited;
end;

procedure TWA160FRegoleIncentiviDM.ResultDecorrenza(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrOK,mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA160FRegoleIncentiviDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if InterfacciaWR102.DettaglioFM and (TWR102FGestTabella(Owner).WDettaglioFM <> nil) then
    TWR102FGestTabella(Owner).WDettaglioFM.AbilitaComponenti;
end;

end.
