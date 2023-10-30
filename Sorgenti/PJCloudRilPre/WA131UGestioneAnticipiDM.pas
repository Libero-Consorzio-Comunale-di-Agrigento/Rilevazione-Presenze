unit WA131UGestioneAnticipiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A131UGestioneAnticipiMW, A000UInterfaccia, medpIWMessageDlg;

type
  TWA131FGestioneAnticipiDM = class(TWR302FGestTabellaDM)
    selTabellaCASSA: TStringField;
    selTabellaNUM_MOVIMENTO: TFloatField;
    selTabellaANNO_MOVIMENTO: TStringField;
    selTabellaDATA_MOVIMENTO: TDateTimeField;
    selTabellaCOD_VOCE: TStringField;
    selTabellaDATA_MISSIONE: TDateTimeField;
    selTabellaQUANTITA: TFloatField;
    selTabellaIMPORTO: TFloatField;
    selTabellaFLAG_TOTALIZZATORE: TStringField;
    selTabellaSTATO: TStringField;
    selTabellaDATA_IMPOSTAZIONE_STATO: TDateTimeField;
    selTabellaNOTE: TStringField;
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaITA_EST: TStringField;
    selTabellaID_MISSIONE: TIntegerField;
    selTabellaNROSOSP: TFloatField;
    selTabellaDESC_CODVOCE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
  private
    procedure ResPost(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    A131FGestioneAnticipiMW: TA131FGestioneAnticipiMW;
  end;

implementation

{$R *.dfm}

procedure TWA131FGestioneAnticipiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A131FGestioneAnticipiMW:=TA131FGestioneAnticipiMW.Create(Self);
  A131FGestioneAnticipiMW.SelM060_Funzioni:=selTabella;

  selTabella.FieldByName('DESC_CODVOCE').LookupDataSet:=A131FGestioneAnticipiMW.selTAnticipi;
  //inizializzo con progressivo 0.
  //su cambia progressivo viene impostato quello corretto
  A131FGestioneAnticipiMW.ImpostaProgressivo;
end;

procedure TWA131FGestioneAnticipiDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A131FGestioneAnticipiMW.selM060AfterDelete;
end;

procedure TWA131FGestioneAnticipiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A131FGestioneAnticipiMW.selM060AfterPost;
end;

procedure TWA131FGestioneAnticipiDM.AfterScroll(DataSet: TDataSet);
begin
  //GroupM060 al momento non usato su cloud. Lasciato per eventuale aggiunta futura
  A131FGestioneAnticipiMW.selM060AfterScroll;
  inherited;
end;

procedure TWA131FGestioneAnticipiDM.BeforePostNoStorico(DataSet: TDataSet);
var Msg: String;
begin
  inherited;
  if (not MsgBox.KeyExists('PUNTO_1')) then
  begin
    Msg:=A131FGestioneAnticipiMW.selM060BeforePost;
    if (Msg <> '') then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResPost,'PUNTO_1');
      Abort;
    end;
  end;
end;

procedure TWA131FGestioneAnticipiDM.ResPost(Sender: TObject; R: TmeIWModalResult; KI: String);
var Azienda,Profilo:String;
begin
  if R = mrYes then
    selTabella.Post
  else
    MsgBox.ClearKeys;
end;

procedure TWA131FGestioneAnticipiDM.OnNewRecord(DataSet: TDataSet);
begin
  A131FGestioneAnticipiMW.selM060NewRecord;
  inherited;
end;

procedure TWA131FGestioneAnticipiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A131FGestioneAnticipiMW);
  inherited;
end;

end.
