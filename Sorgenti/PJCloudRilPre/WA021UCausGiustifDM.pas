unit WA021UCausGiustifDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione, ControlloVociPaghe, medpIWMessageDlg, C180FunzioniGenerali,A000UMessaggi;

type
  TWA021FCausGiustifDM = class(TWR302FGestTabellaDM)
    selTabellaCodice: TStringField;
    selTabellaDescrizione: TStringField;
    selTabellaCodRaggr: TStringField;
    selTabellaVocePaghe1: TStringField;
    selTabellaVocePaghe2: TStringField;
    selTabellaVocePaghe3: TStringField;
    selTabellaVocePaghe4: TStringField;
    selTabellaD_CodRaggr: TStringField;
    selTabellaSIGLA: TStringField;
    selTabellaASSEST_ANNUO: TStringField;
    selTabellaABBATTE_ECC_GIORN: TStringField;
    selTabellaLIMITE_LIQ: TStringField;
    selTabellaBANCAORE_NEGATIVA: TStringField;
    selTabellaDATA_MIN_ASSEST: TDateTimeField;
    Q300: TOracleDataSet;
    D300: TDataSource;
    Q265: TOracleDataSet;
    Q275: TOracleDataSet;
    selTabellaAUMENTA_ECC_GIORN: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaDATA_MIN_ASSESTSetText(Sender: TField;
      const Text: string);
  private
    selControlloVociPaghe:TControlloVociPaghe;
    procedure CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
  end;

implementation

uses WA021UCausGiustif, WA021UCausGiustifDettFM;

{$R *.dfm}

procedure TWA021FCausGiustifDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
  Q300.Open;
  Q265.Open;
  Q275.Open;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;


procedure TWA021FCausGiustifDM.AfterPost(DataSet: TDataSet);
var S:String;
begin
  inherited;
  MsgBox.ClearKeys;

  with DataSet do
  begin
    S:=FieldByName('CODICE').AsString;
    DisableControls;
    Refresh;
    Locate('CODICE',S,[]);
    EnableControls;
  end;
end;

procedure TWA021FCausGiustifDM.BeforePostNoStorico(DataSet: TDataSet);
var VoceOld:String;
    Messaggi:String;
begin
  inherited;

  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    Messaggi:='';

    Q265.Close;
    Q265.SetVariable('Codice',selTabella.FieldByName('Codice').AsString);
    Q265.Open;
    if Q265.RecordCount > 0 then
      Raise Exception.Create(A000MSG_ERR_CODICE_ASS_DUPLICATO);
    Q275.Close;
    Q275.SetVariable('Codice',selTabella.FieldByName('Codice').AsString);
    Q275.Open;
    if Q275.RecordCount > 0 then
      Raise Exception.Create(A000MSG_ERR_CODICE_PRES_DUPLICATO);
    //Controllo voci paghe
    if (DataSet.State = dsInsert) or (selTabella.FieldByName('VOCEPAGHE1').medpOldValue = null)  then
      VoceOld:=''
    else
      VoceOld:=selTabella.FieldByName('VOCEPAGHE1').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selTabella.FieldByName('VOCEPAGHE1').AsString) then
      Messaggi:=Messaggi + #13#10 + selControlloVociPaghe.MessaggioLog;

    if (DataSet.State = dsInsert) or (selTabella.FieldByName('VOCEPAGHE2').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selTabella.FieldByName('VOCEPAGHE2').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selTabella.FieldByName('VOCEPAGHE2').AsString) then
      Messaggi:=Messaggi + #13#10 + selControlloVociPaghe.MessaggioLog;

    if (DataSet.State = dsInsert) or (selTabella.FieldByName('VOCEPAGHE3').medpOldValue = null)  then
      VoceOld:=''
    else
      VoceOld:=selTabella.FieldByName('VOCEPAGHE3').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selTabella.FieldByName('VOCEPAGHE3').AsString) then
      Messaggi:=Messaggi + #13#10 + selControlloVociPaghe.MessaggioLog;

    if (DataSet.State = dsInsert) or (selTabella.FieldByName('VOCEPAGHE4').medpOldValue = null)  then
      VoceOld:=''
    else
      VoceOld:=selTabella.FieldByName('VOCEPAGHE4').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selTabella.FieldByName('VOCEPAGHE4').AsString) then
      Messaggi:=Messaggi + #13#10 + selControlloVociPaghe.MessaggioLog;
  end;

  if Messaggi <> '' then
  begin
    MsgBox.WebMessageDlg(Messaggi,mtConfirmation,[mbYes,mbNo],CheckBeforePost,'PUNTO_1');
    Abort;
  end
  else
  begin
    selControlloVociPaghe.ValutaInserimentoVocePaghe(selTabella.FieldByName('VOCEPAGHE1').AsString);
    selControlloVociPaghe.ValutaInserimentoVocePaghe(selTabella.FieldByName('VOCEPAGHE2').AsString);
    selControlloVociPaghe.ValutaInserimentoVocePaghe(selTabella.FieldByName('VOCEPAGHE3').AsString);
    selControlloVociPaghe.ValutaInserimentoVocePaghe(selTabella.FieldByName('VOCEPAGHE4').AsString);

    MsgBox.ClearKeys;
  end;

end;

procedure TWA021FCausGiustifDM.CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;


procedure TWA021FCausGiustifDM.selTabellaDATA_MIN_ASSESTSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  try
    if Text = '' then
      selTabellaDATA_MIN_ASSEST.Clear
    else
      selTabellaDATA_MIN_ASSEST.AsDateTime:=StrToDateTime('01/' + Text);
  except
      selTabellaDATA_MIN_ASSEST.Clear;
  end;
end;

end.
