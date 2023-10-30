unit WA195UImpRichRimborsoDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A100UImpRimborsiIterMW,
  A000UInterfaccia, medpIWMessageDlg;

type
  TWA195FImpRichRimborsoDM = class(TWR302FGestTabellaDM)
    selM150TIPO_RICHIESTA: TStringField;
    selM150NOMINATIVO: TStringField;
    selM150MATRICOLA: TStringField;
    selM150D_DESTINAZIONE: TStringField;
    selM150FLAG_ISPETTIVA: TStringField;
    selM150PARTENZA: TStringField;
    selM150RIENTRO: TStringField;
    selM150C_PERCORSO: TStringField;
    selM150DATADA: TDateTimeField;
    selM150DATAA: TDateTimeField;
    selM150ORADA: TStringField;
    selM150ORAA: TStringField;
    selM150INDENNITA_KM: TStringField;
    selM150DESCRIZIONE: TStringField;
    selM150KMPERCORSI: TFloatField;
    selTabellaCOD_VALUTA: TStringField;
    selTabellaRIMBORSO: TFloatField;
    selTabellaRIMBORSO_VARIATO: TFloatField;
    selTabellaSTATO: TStringField;
    selTabellaCODICE: TStringField;
    selTabellaPROTOCOLLO: TStringField;
    selTabellaNOTE: TStringField;
    selTabellaID: TFloatField;
    selTabellaKMPERCORSI_VARIATO: TFloatField;
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaC_SEDE_LAVORO: TStringField;
    selTabellaC_COMUNE_RES: TStringField;
    selTabellaCOMUNE_RESIDENZA: TStringField;
    selTabellaCAP_RESIDENZA: TStringField;
    selTabellaELENCO_DESTINAZIONI: TStringField;
    selTabellaCOMUNE_DOMICILIO: TStringField;
    selTabellaCAP_DOMICILIO: TStringField;
    selTabellaC_COMUNE_DOM: TStringField;
    selTabellaID_RIMBORSO: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure AfterScroll(DataSet: TDataSet); override;
  private
    procedure ResultConfermaPostSelTabella(Sender: TObject;
      Res: TmeIWModalResult; KeyID: String);
    { Private declarations }
  public
    A100FImpRimborsiIterMW: TA100FImpRimborsiIterMW;
  end;

implementation

uses WA195UImpRichRimborso, WA195UImpRichRimborsoDettFM;

{$R *.dfm}

procedure TWA195FImpRichRimborsoDM.AfterScroll(DataSet: TDataSet);
var
  WA195DettFM: TWA195FImpRichRimborsoDettFM;
begin
  A100FImpRimborsiIterMW.selM150AfterScroll;

  // CUNEO_ASLCN1 - chiamata 88143.ini
  // bugfix: non aggiornava le grid in visualizzazione
  WA195DettFM:=((Self.Owner as TWA195FImpRichRimborso).WDettaglioFM as TWA195FImpRichRimborsoDettFM);
  if WA195DettFM <> nil then
  begin
    WA195DettFM.dgrdMotivazioni.medpAttivaGrid(A100FImpRimborsiIterMW.selM175,False,False,False);
    WA195DettFM.dgrdMezzi.medpAttivaGrid(A100FImpRimborsiIterMW.selM170,False,False,False);
    WA195DettFM.dgrdDettaglioGG.medpAttivaGrid(A100FImpRimborsiIterMW.selM143,False,False,False);
  end;
  // CUNEO_ASLCN1 - chiamata 88143.fine

  inherited;
end;

procedure TWA195FImpRichRimborsoDM.BeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TWA195FImpRichRimborsoDM.BeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TWA195FImpRichRimborsoDM.BeforePostNoStorico(DataSet: TDataSet);
var Msg: String;
begin
  inherited;
  if (not MsgBox.KeyExists('PUNTO_1')) then
  begin
    Msg:=A100FImpRimborsiIterMW.selM150BeforePostPasso1;
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultConfermaPostSelTabella,'PUNTO_1');
      Abort;
    end;
  end;

  if (not MsgBox.KeyExists('PUNTO_2')) then
  begin
    Msg:=A100FImpRimborsiIterMW.selM150BeforePostPasso2;
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultConfermaPostSelTabella,'PUNTO_2');
      Abort;
    end;
  end;
end;

procedure TWA195FImpRichRimborsoDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A100FImpRimborsiIterMW:=TA100FImpRimborsiIterMW.Create(Self);
  A100FImpRimborsiIterMW.selm150_funzioni:=selTabella;
end;

procedure TWA195FImpRichRimborsoDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A100FImpRimborsiIterMW);
  inherited;
end;

procedure TWA195FImpRichRimborsoDM.selTabellaApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  A100FImpRimborsiIterMW.selM150ApplyRecord(Action,Applied);
end;

procedure TWA195FImpRichRimborsoDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A100FImpRimborsiIterMW.selM150CalcFields;
end;

procedure TWA195FImpRichRimborsoDM.ResultConfermaPostSelTabella(Sender: TObject;Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) then
    selTabella.Post
  else
    MsgBox.clearKeys;
end;

end.
