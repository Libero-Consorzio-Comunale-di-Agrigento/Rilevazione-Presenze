unit WA198UDatiCalcolatiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A000UInterfaccia,
  {$IFDEF RILPRE} A077UGeneratoreStampeMW,{$ENDIF}
  {$IFDEF PAGHE} P077UGeneratoreStampeMW, {$ENDIF}
  R003UGeneratoreStampeMW, C180FunzioniGenerali,
  A000UMessaggi, medpIWMessageDlg;

type
  TWA198FDatiCalcolatiDM = class(TWR302FGestTabellaDM)
    selTabellaAPPLICAZIONE: TStringField;
    selTabellaCODICE_STAMPA: TStringField;
    selTabellaID_SERBATOIO: TIntegerField;
    selTabellaD_SERBATOIO: TStringField;
    selTabellaNOME: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaESPRESSIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    bSostituisci: Boolean;
    OldNome, NewNome: String;
    procedure ResultConfermaSostituisci(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
  public
    R003FGeneratoreStampeMW: TR003FGeneratoreStampeMW;
  end;

implementation

{$R *.dfm}

procedure TWA198FDatiCalcolatiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
   if bSostituisci then
   begin
    MsgBox.WebMessageDlg(A000MSG_R003_MSG_CONFERMA_SOSTITUISCI,mtConfirmation,[mbYes,mbNo],ResultConfermaSostituisci,'');
    //non fare abort. il post deve finire normalmente e committare
   end;
end;

procedure TWA198FDatiCalcolatiDM.ResultConfermaSostituisci(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    R003FGeneratoreStampeMW.updNomeDatoCalcolato.SetVariable('APPLICAZIONE',Parametri.Applicazione);
    R003FGeneratoreStampeMW.updNomeDatoCalcolato.SetVariable('VECCHIO_NOME',OldNome);
    R003FGeneratoreStampeMW.updNomeDatoCalcolato.SetVariable('NUOVO_NOME',NewNome);
    R003FGeneratoreStampeMW.updNomeDatoCalcolato.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TWA198FDatiCalcolatiDM.BeforeDelete(DataSet: TDataSet);
begin
  try
    R003FGeneratoreStampeMW.selT909ControlliBeforeDelete(selTabella.FieldByName('NOME').ASString);
  except
    on E: Exception do
    begin
      MsgBox.WebMessageDlg(e.Message,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;
  inherited;
end;

procedure TWA198FDatiCalcolatiDM.BeforePostNoStorico(DataSet: TDataSet);
var
  i, P, idxSerbatoio: Integer;
begin
  inherited;
  if selTabella.FieldByName('ID_SERBATOIO').AsString = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A198_MSG_SERBATOIO]),mtError,[mbOk],nil,'');
    Abort;
  end;

  if selTabella.FieldByName('NOME').AsString = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A198_MSG_NOME]),mtError,[mbOk],nil,'');
    Abort;
  end;

  P:=R003FGeneratoreStampeMW.GetDato(Identificatore(selTabella.FieldByName('NOME').AsString),True);
  if P >= 0 then
  begin
    if not R003FGeneratoreStampeMW.Dati[P].Calcolato then
    begin
      MsgBox.WebMessageDlg(A000MSG_R003_ERR_DATO_ESISTENTE,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;

  if selTabella.FieldByName('ESPRESSIONE').AsString = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A198_MSG_ESPRESSIONE]),mtError,[mbOk],nil,'');
    Abort;
  end;

  idxSerbatoio:=-1;
  selTabella.FieldByName('ESPRESSIONE').AsString:=EliminaRitornoACapo(selTabella.FieldByName('ESPRESSIONE').AsString);
  for i:=Low(R003FGeneratoreStampeMW.Serbatoi) to High(R003FGeneratoreStampeMW.Serbatoi) do
    if (R003FGeneratoreStampeMW.Serbatoi[i].X = selTabella.FieldByName('ID_SERBATOIO').AsInteger) then
    begin
      idxSerbatoio:=i;
      break;
    end;

  if idxSerbatoio >= 0 then
  try
    R003FGeneratoreStampeMW.EsplodiEspressione(idxSerbatoio,selTabella.FieldByName('ESPRESSIONE').AsString);
    R003FGeneratoreStampeMW.selT909VerificaNome(selTabella);
  except
    on E: Exception do
    begin
      MsgBox.WebMessageDlg(e.Message,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;

  bSostituisci:=False;
  if (selTabella.State = dsEdit) and
     (selTabella.FieldByName('NOME').medpOldValue <> selTabella.FieldByName('NOME').AsString) then
  begin
    bSostituisci:=True;
    OldNome:=selTabella.FieldByName('NOME').medpOldValue;
    NewNome:=selTabella.FieldByName('NOME').AsString;
  end;
end;

procedure TWA198FDatiCalcolatiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  selTabella.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  selTabella.SetVariable('ORDERBY','ORDER BY ID_SERBATOIO,NOME');
  {$IFDEF RILPRE}
   R003FGeneratoreStampeMW:=TA077FGeneratoreStampeMW.Create(Self);
  {$ENDIF}
  {$IFDEF PAGHE}
   R003FGeneratoreStampeMW:=TP077FGeneratoreStampeMW.Create(Self);
  {$ENDIF}

  R003FGeneratoreStampeMW.CaricaDati(False);
  selTabella.Open;
end;

procedure TWA198FDatiCalcolatiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(R003FGeneratoreStampeMW);
  inherited;
end;

procedure TWA198FDatiCalcolatiDM.OnNewRecord(DataSet: TDataSet);
begin
  R003FGeneratoreStampeMW.selT909ImpostaNewRecord(selTabella);
  inherited;

end;

procedure TWA198FDatiCalcolatiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  R003FGeneratoreStampeMW.selT909CampiCalcolati(SelTabella);
end;

end.
