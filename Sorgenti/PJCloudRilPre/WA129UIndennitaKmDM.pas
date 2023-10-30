unit WA129UIndennitaKmDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A129UIndennitaKmMW,
  A000UInterfaccia, medpIWMessageDlg;

type
  TWA129FIndennitaKmDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaIMPORTO: TFloatField;
    selTabellaARROTONDAMENTO: TStringField;
    selTabelladescarrotondamento: TStringField;
    selTabellaCODVOCEPAGHE: TStringField;
    selTabellaCATEG_RIMBORSO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
  private
    CampoCodPaghe: String;
    procedure resultVerificaCodPaghe(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    { Private declarations }
  public
    A129FIndennitaKmMW : TA129FIndennitaKmMW;
  end;

implementation

{$R *.dfm}

procedure TWA129FIndennitaKmDM.BeforePost(DataSet: TDataSet);
var Msg: String;
begin
  inherited;
  //Controllo voci paghe
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    CampoCodPaghe:='CODVOCEPAGHE';
    Msg:=A129FIndennitaKmMW.VerificaVociPaghe(CampoCodPaghe);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultVerificaCodPaghe,'PUNTO_1');
      Abort;
    end;
  end;
end;

procedure TWA129FIndennitaKmDM.resultVerificaCodPaghe(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:
    begin
      A129FIndennitaKmMW.InserisciVocePaghe(CampoCodPaghe);
      selTabella.Post;
    end;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA129FIndennitaKmDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A129FIndennitaKmMW:=TA129FIndennitaKmMW.Create(Self);
  A129FIndennitaKmMW.selM021_Funzioni:=SelTabella;
  selTabella.FieldByName('descarrotondamento').LookupDataSet:=A129FIndennitaKmMW.selP050;

  selTabella.Open;
end;

procedure TWA129FIndennitaKmDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A129FIndennitaKmMW);
  inherited;
end;

procedure TWA129FIndennitaKmDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A129FIndennitaKmMW.selM021CalcFields;
end;

end.
