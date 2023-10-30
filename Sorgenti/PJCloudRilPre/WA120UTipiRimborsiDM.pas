unit WA120UTipiRimborsiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A000UInterfaccia, A120UTipiRimborsiMW, medpIWMessageDlg;

type
  TWA120FTipiRimborsiDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaCODICEVOCEPAGHE: TStringField;
    selTabellaSCARICOPAGHE: TStringField;
    selTabellaESISTENZAINDENNITASUPPL: TStringField;
    selTabellaCODICEVOCEPAGHEINDENNITASUPPL: TStringField;
    selTabellaSCARICOPAGHEINDENNITASUPPL: TStringField;
    selTabellaPERCINDENNITASUPPL: TFloatField;
    selTabellaARROTINDENNITASUPPL: TStringField;
    selTabellaFLAG_ANTICIPO: TStringField;
    selTabellaCalcArrotIndennitaSuppl: TStringField;
    selTabellaTIPO_QUANTITA: TStringField;
    selTabellaPERC_ANTICIPO: TFloatField;
    selTabellaNOTE_FISSE: TStringField;
    selTabellaFLAG_MOTIVAZIONE: TStringField;
    selTabellaFLAG_TARGA: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaCATEG_RIMBORSO: TStringField;
    selTabellaIMPORTO_MAX: TFloatField;
    selTabellaFASI_COMPETENZA: TStringField;
    selTabellaFLAG_MEZZO_PROPRIO: TStringField;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    CampoCodPaghe: String;
    procedure resultVerificaCodPaghe(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
  public
    A120FTipiRimborsiMW: TA120FTipiRimborsiMW;
  end;

implementation

{$R *.dfm}

procedure TWA120FTipiRimborsiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A120FTipiRimborsiMW:=TA120FTipiRimborsiMW.Create(Self);
  A120FTipiRimborsiMW.selM020_Funzioni:=selTabella;
  selTabella.Open;
end;

procedure TWA120FTipiRimborsiDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A120FTipiRimborsiMW.selM020AfterDelete;
end;

procedure TWA120FTipiRimborsiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A120FTipiRimborsiMW.selM020AfterPost;
end;

procedure TWA120FTipiRimborsiDM.BeforeDelete(DataSet: TDataSet);
begin
  A120FTipiRimborsiMW.selM020BeforeDelete;
  inherited;
end;

procedure TWA120FTipiRimborsiDM.BeforePostNoStorico(DataSet: TDataSet);
var Msg: String;
begin
  inherited;
   A120FTipiRimborsiMW.Ins:=Dataset.State = dsInsert;

  //Controllo voci paghe
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    CampoCodPaghe:='CODICEVOCEPAGHE';
    Msg:=A120FTipiRimborsiMW.VerificaVociPaghe(CampoCodPaghe);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultVerificaCodPaghe,'PUNTO_1');
      Abort;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_2') then
  begin
    CampoCodPaghe:='CODICEVOCEPAGHEINDENNITASUPPL';
    Msg:=A120FTipiRimborsiMW.VerificaVociPaghe(CampoCodPaghe);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultVerificaCodPaghe,'PUNTO_2');
      Abort;
    end;
  end;
end;

procedure TWA120FTipiRimborsiDM.resultVerificaCodPaghe(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:
    begin
      A120FTipiRimborsiMW.InserisciVocePaghe(CampoCodPaghe);
      selTabella.Post;
    end;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA120FTipiRimborsiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A120FTipiRimborsiMW.selM020CalcFields;
end;

procedure TWA120FTipiRimborsiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A120FTipiRimborsiMW);
  inherited;
end;

end.
