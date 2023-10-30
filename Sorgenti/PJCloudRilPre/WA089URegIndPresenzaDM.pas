unit WA089URegIndPresenzaDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, A000UCostanti, A000USessione, Math, StrUtils,
  A000UInterfaccia, WR303UGestMasterDetailDM, WR300UBaseDM, DBClient,
  WR302UGestTabellaDM, medpIWMessageDlg, ControlloVociPaghe, L021Call,
  C180FunzioniGenerali,A000UMessaggi,A024UIndPresenzaMW;

type
  TWA089FRegIndPresenzaDM = class(TWR303FGestMasterDetailDM)
    selT275: TOracleDataSet;
    selT275Escluse: TOracleDataSet;
    selT275EscluseCODICE: TStringField;
    selT275EscluseDESCRIZIONE: TStringField;
    dsrT275Escluse: TDataSource;
    SelQ162: TOracleDataSet;
    selT162Incomp: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    D162: TDataSource;
    Look162: TOracleDataSet;
    Look162CODICE: TStringField;
    Look162DESCRIZIONE: TStringField;
    Q265: TOracleDataSet;
    dsrT164: TDataSource;
    selT164: TOracleDataSet;
    selT164CODICE: TStringField;
    selT164DECORRENZA: TDateTimeField;
    selT164ESPRESSIONE: TStringField;
    selT164SCADENZA: TDateTimeField;
    selT164TIPO_ASSOCIAZIONE: TStringField;
    dsrT171: TDataSource;
    selT171: TOracleDataSet;
    selT171CODICE: TStringField;
    selT171GIORNI: TFloatField;
    selT171ESPRESSIONE: TStringField;
    Del171: TOracleQuery;
    Upd171: TOracleQuery;
    delT164: TOracleQuery;
    updT164: TOracleQuery;
    selI010: TOracleDataSet;
    dsrI010: TDataSource;
    selSQL: TOracleDataSet;
    testSQL: TOracleQuery;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaIMPORTO: TFloatField;
    selTabellaVOCEPAGHE: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaNUMTURNI: TFloatField;
    selTabellaTURNI: TStringField;
    selTabellaASSENZE: TStringField;
    selTabellaCODICE2: TStringField;
    selTabellaTURNO1: TFloatField;
    selTabellaTURNO2: TFloatField;
    selTabellaTURNO3: TFloatField;
    selTabellaTURNO4: TFloatField;
    selTabellaPRIORITA: TIntegerField;
    selTabellaINDENNITA_INCOMPATIBILI: TStringField;
    selTabellaCOEFFICIENTE: TFloatField;
    selTabellaARROTONDAMENTO: TStringField;
    selTabellaASSENZE_ABILITATE: TStringField;
    selTabellaSUPPL_5GGLAV: TStringField;
    selTabellaCAUPRES_RIEPORE: TStringField;
    selTabellaD_CAUPRES_RIEPORE: TStringField;
    selTabellaNMESI_EQUITURNI: TFloatField;
    selTabellaOFFSET_METADEBITO: TIntegerField;
    selTabellaMATURA_SABATO: TStringField;
    selTabellaPIANIF_NOOP: TStringField;
    selTabellaMIN_TURNI_PRIORITARI: TStringField;
    selTabellaMIN_TURNI_SECONDARI: TStringField;
    selTabellaOFFSET_GGPREC: TStringField;
    selTabellaESCLUDI_FESTIVI: TStringField;
    selTabellaMATURAZ_PROP_DEBITOGG: TStringField;
    selTabellaMATURAZ_PROP_IGNORA_SCOSTNEG: TStringField;
    selTabellaCONGUAGLIO_EQUITURNI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCODICEValidate(Sender: TField);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT171NewRecord(DataSet: TDataSet);
    procedure selT164NewRecord(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    A024MW:TA024FIndPresenzaMW;
    selControlloVociPaghe:TControlloVociPaghe;
    procedure CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  protected
    procedure RelazionaTabelleFiglie; override;
  public
  end;

implementation

uses WA089URegIndPresenzaDettFM, WA089URegIndPresenza, WA089URegIndPresenzaRegoleFM,
     WR100UBase;

{$R *.dfm}

procedure TWA089FRegIndPresenzaDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  NonAprireSelTabella:=True;
  inherited;
  A024MW:=TA024FIndPresenzaMW.Create(Self);
  A024MW.selT162:=selTabella;
  selI010.Open;
  selT275Escluse.Open;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
  selTabella.Open;
end;


procedure TWA089FRegIndPresenzaDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  if A024MW <> nil then
    FreeAndNil(A024MW);
end;

procedure TWA089FRegIndPresenzaDM.selT171NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT171.FieldByName('CODICE').AsString:=selTabella.FieldByName('CODICE').AsString;
end;

procedure TWA089FRegIndPresenzaDM.RelazionaTabelleFiglie;
begin
  with selT164 do
  begin
    DisableControls;
    Close;
    SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
    Open;
    EnableControls;
  end;
end;

procedure TWA089FRegIndPresenzaDM.selT164NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT164.FieldByName('CODICE').AsString:=selTabella.FieldByName('CODICE').AsString;
end;

procedure TWA089FRegIndPresenzaDM.AfterScroll(DataSet: TDataSet);
begin
  with selT171 do
  begin
    DisableControls;
    Close;
    SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
    SetVariable('ORDERBY','ORDER BY CODICE,GIORNI');
    Open;
    EnableControls;
  end;
  with Look162 do
  begin
    //DisableControls;
    Close;
    SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
    Open;
    //EnableControls;
  end;
  inherited;
end;

procedure TWA089FRegIndPresenzaDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  with Del171 do
  begin
    SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
    Execute;
  end;
  with delT164 do
  begin
    SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
    Execute;
  end;
end;

procedure TWA089FRegIndPresenzaDM.BeforePostNoStorico(DataSet: TDataSet);
var Tipo,VoceOld,sAltraIndennita:String;
begin
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    inherited;
    if not IndennitaTurno then
      if (not R180In(selTabella.FieldByName('TIPO').AsString,['Z','F','G','H','P'])) then
      begin
        MsgBox.WebMessageDlg(A000MSG_A089_ERR_TIPO_NON_DISPONIBILE,mtError,[mbOk],nil,'');
        Abort;
      end;

    if selTabella.FieldByName('Tipo').AsString = 'A' then
      selTabella.FieldByName('NumTurni').AsInteger:=Trunc(selTabella.FieldByName('NumTurni').Value)
    else if selTabella.FieldByName('Tipo').AsString = 'B' then
      if selTabella.FieldByName('NumTurni').AsInteger > 100 then
      begin
        MsgBox.WebMessageDlg(A000MSG_A089_ERR_PROP_TURNI_PCT,mtError,[mbOk],nil,'');
        Abort;
      end;

    if (selTabella.FieldByName('Tipo').AsString = 'E') then
    begin
      if (trim(selTabella.FieldByName('TURNI').AsString)='') then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['turno da considerare']),mtError,[mbOk],nil,'');
        Abort;
      end
    end;

    Tipo:=selTabella.FieldByName('Tipo').AsString;
    If (Tipo = 'A') or (Tipo = 'B') or (Tipo = 'C') or (Tipo = 'D') or (Tipo = 'P') or (Tipo = 'E') then
    begin
      sAltraIndennita:=selTabella.FieldByName('CODICE2').AsString;
      while sAltraIndennita<>'' do
      begin
        if sAltraIndennita=selTabella.FieldByName('CODICE').AsString  then
        begin
          MsgBox.WebMessageDlg(Format(A000MSG_A089_ERR_FMT_LEGAME_INDENNITA,[sAltraIndennita]),mtError,[mbOk],nil,'');
          Abort;
        end;

        //Verifico che, tra i puntamenti tra le varie indennità, non vi siano cicli ricorsivi...

        SelQ162.Close;
        SelQ162.SetVariable('CODICE', sAltraIndennita);
        SelQ162.Open;
        if SelQ162.RecordCount > 0 then
          sAltraIndennita:=SelQ162.FieldByName('CODICE2').AsString
        else
          sAltraIndennita:='';
        end;
      end;

      //Controllo voci paghe
      if (selTabella.State = dsInsert) or (selTabella.FieldByName('VOCEPAGHE').medpOldValue = null) then
        VoceOld:=''
       else
        VoceOld:=selTabella.FieldByName('VOCEPAGHE').medpOldValue;
      if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selTabella.FieldByName('VOCEPAGHE').AsString) then
      begin
        MsgBox.WebMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],CheckBeforePost,'PUNTO_1');
        Abort;
      end;
    end;

    selControlloVociPaghe.ValutaInserimentoVocePaghe(selTabella.FieldByName('VOCEPAGHE').AsString);

    try
      //Cambio il codice di T171 se è stato cambiato in T170
      if (selTabella.State = dsEdit) and (selTabella.FieldByName('CODICE').medpOldValue <> selTabella.FieldByName('CODICE').Value) then
      begin
        with Upd171 do
        begin
          SetVariable('CODICEOLD',selTabella.FieldByName('CODICE').medpOldValue);
          SetVariable('CODICENEW',selTabella.FieldByName('CODICE').Value);
          Execute;
        end;
        with updT164 do
        begin
          SetVariable('CODICEOLD',selTabella.FieldByName('CODICE').medpOldValue);
          SetVariable('CODICENEW',selTabella.FieldByName('CODICE').Value);
          Execute;
        end;
      end;
    except
  end;

  if not (R180CarattereDef(selTabella.FieldByName('TIPO').AsString) in ['A','B','P']) or
    ((not selTabella.FieldByName('CODICE2').IsNull) and (selTabella.FieldByName('CONGUAGLIO_EQUITURNI').AsString = 'N'))then
    selTabella.FieldByName('NMESI_EQUITURNI').AsInteger:=1;

  A024MW.selT162BeforePost(DataSet);
end;

procedure TWA089FRegIndPresenzaDM.CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA089FRegIndPresenzaDM.selTabellaCODICEValidate(Sender: TField);
begin
  with Look162 do
  begin
    DisableControls;
    Close;
    SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
    Open;
    EnableControls;
  end;
end;

procedure TWA089FRegIndPresenzaDM.AfterPost(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([selT171],True);
  //SessioneOracle.CancelUpdates([selT171]);
  selT171.CancelUpdates;
  inherited;
end;

end.
