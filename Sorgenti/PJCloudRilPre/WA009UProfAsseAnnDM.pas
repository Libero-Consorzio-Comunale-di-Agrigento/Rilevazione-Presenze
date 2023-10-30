unit WA009UProfAsseAnnDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione, ControlloVociPaghe, medpIWMessageDlg, C180FunzioniGenerali,A000UMessaggi;

type
  TWA009FProfAsseAnnDM = class(TWR302FGestTabellaDM)
    selTabellaAnno: TFloatField;
    selTabellaCodProfilo: TStringField;
    selTabellaD_Profilo: TStringField;
    selTabellaCodRaggr: TStringField;
    selTabellaUMisura: TStringField;
    selTabellaCompetenza1: TStringField;
    selTabellaRetribuzione1: TFloatField;
    selTabellaCompetenza2: TStringField;
    selTabellaRetribuzione2: TFloatField;
    selTabellaCompetenza3: TStringField;
    selTabellaRetribuzione3: TFloatField;
    selTabellaCompetenza4: TStringField;
    selTabellaRetribuzione4: TFloatField;
    selTabellaCompetenza5: TStringField;
    selTabellaRetribuzione5: TFloatField;
    selTabellaCompetenza6: TStringField;
    selTabellaRetribuzione6: TFloatField;
    selTabellaPROPORZIONE: TStringField;
    selTabellaSOMMA: TStringField;
    selTabellaMG: TStringField;
    selTabellaARRFAV: TStringField;
    selTabellaDATARES: TDateTimeField;
    selTabellaPROPGGMM: TStringField;
    selTabellaARR_COMPETENZA_IN_ORE: TStringField;
    selTabellaMAX_FRUIZIONE_GIORN_IN_ORE: TStringField;
    selTabellaFRUIZ_ANNO_MINIMA: TStringField;
    selTabellaFRUIZ_MINIMA_DAL: TDateTimeField;
    selTabellaRAPPORTI_UNITI: TStringField;
    dsrT261: TDataSource;
    D260: TDataSource;
    D262: TDataSource;
    selT261: TOracleDataSet;
    Q260: TOracleDataSet;
    Q262: TOracleDataSet;
    Q262ANNO: TFloatField;
    Q262CODPROFILO: TStringField;
    Q262CODRAGGR: TStringField;
    Q262DESCRIZIONE: TStringField;
    Q262UMISURA: TStringField;
    Q262COMPETENZA1: TStringField;
    Q262COMPETENZA2: TStringField;
    Q262COMPETENZA3: TStringField;
    Q262COMPETENZA4: TStringField;
    Q262COMPETENZA5: TStringField;
    Q262COMPETENZA6: TStringField;
    selTabellaD_Raggruppamento: TStringField;
    selTabellaCOMPETENZE_PERSONALIZZATE: TStringField;
    selTabellaPROPGG_INFSOGLIA: TStringField;
    procedure selTabellaAfterRefreshRecord(Sender: TOracleDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure dsrTabellaDataChange(Sender: TObject; Field: TField);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure dsrTabellaStateChange(Sender: TObject);
  private
    SalvaAnno,SalvaProfilo:String;
    AnnoOld:Integer;
    ProfOld:String;
    procedure CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CompetenzaValidate(Text: String);
    procedure ValidateOreMinuti(Text,SenderField: String);
  public
  end;

implementation

uses WA009UProfAsseAnn, WA009UProfAsseAnnDettFM, WA009UProfiliAssenzeFM,
     WR100UBase;

{$R *.dfm}

procedure TWA009FProfAsseAnnDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  AnnoOld:=0;
  ProfOld:='';
  selTabella.SetVariable('ORDERBY','ORDER BY ANNO,CODPROFILO,CODRAGGR');
  inherited;
  selT261.Open;
  Q260.Open;
  Q262.Open;
end;

procedure TWA009FProfAsseAnnDM.AfterPost(DataSet: TDataSet);
begin
  MsgBox.ClearKeys;
  inherited;
end;

procedure TWA009FProfAsseAnnDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  if not MsgBox.KeyExists('PUNTO_2') then
   inherited;

  with selTabella do
  begin
    CompetenzaValidate(FieldByName('COMPETENZA1').AsString);
    CompetenzaValidate(FieldByName('COMPETENZA2').AsString);
    CompetenzaValidate(FieldByName('COMPETENZA3').AsString);
    CompetenzaValidate(FieldByName('COMPETENZA4').AsString);
    CompetenzaValidate(FieldByName('COMPETENZA5').AsString);
    CompetenzaValidate(FieldByName('COMPETENZA6').AsString);
    CompetenzaValidate(FieldByName('FRUIZ_ANNO_MINIMA').AsString);
    ValidateOreMinuti(FieldByName('ARR_COMPETENZA_IN_ORE').AsString,'ARR_COMPETENZA_IN_ORE');
    ValidateOreMinuti(FieldByName('MAX_FRUIZIONE_GIORN_IN_ORE').AsString,'MAX_FRUIZIONE_GIORN_IN_ORE');
  end;

  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    if (selTabella.State = dsEdit) and
       (selTabella.FieldByName('CODRAGGR').AsString <> selTabella.FieldByName('CODRAGGR').medpOldValue) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_A009_DLG_FMT_ELIM_COMP,[selTabella.FieldByName('CODRAGGR').medpOldValue]),mtConfirmation,[mbYes,mbNo],CheckBeforePost,'PUNTO_1');
      Abort;
    end;
  end;
end;

procedure TWA009FProfAsseAnnDM.CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA009FProfAsseAnnDM.dsrTabellaDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if ((selTabella.State = dsBrowse) and (Field = nil)) or
     ((selTabella.State in [dsInsert,dsEdit]) and ((Field = selTabellaAnno) or (Field = selTabellaCodProfilo))) then
    if (selTabellaAnno.AsInteger <> AnnoOld) or (selTabellaCodProfilo.AsString <> ProfOld) then
    begin
      AnnoOld:=selTabellaAnno.AsInteger;
      ProfOld:=selTabellaCodProfilo.AsString;
      Q262.Close;
      Q262.SetVariable('Anno',selTabellaAnno.AsInteger);
      Q262.SetVariable('CodProfilo',selTabellaCodProfilo.AsString);
      Q262.Open;
    end;
end;

procedure TWA009FProfAsseAnnDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  if TWA009FProfiliAssenzeFM(TWA009FProfAsseAnn(Self.Owner).WProfiliAssenzeFM) <> nil then
    with TWA009FProfiliAssenzeFM(TWA009FProfAsseAnn(Self.Owner).WProfiliAssenzeFM) do
      grdProfiliAssenze.medpAttivaGrid(selT261,not (selTabella.State in [dsInsert,dsEdit]),not (selTabella.State in [dsInsert,dsEdit]));
end;

procedure TWA009FProfAsseAnnDM.FiltroDizionario(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  if DataSet = selTabella then
    Accept:=A000FiltroDizionario('PROFILI ASSENZA',DataSet.FieldByName('CODPROFILO').AsString) and
            A000FiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODRAGGR').AsString)
  else if DataSet = selT261 then
    Accept:=A000FiltroDizionario('PROFILI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = Q260 then
    Accept:=A000FiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODICE').AsString)
end;

procedure TWA009FProfAsseAnnDM.selTabellaAfterRefreshRecord(
  Sender: TOracleDataSet);
begin
  SalvaAnno:=selTabella.FieldByName('ANNO').AsString;
  SalvaProfilo:=selTabella.FieldByName('CODPROFILO').AsString;
end;

procedure TWA009FProfAsseAnnDM.CompetenzaValidate(Text: String);
var
  x : Integer;
begin
  {Controllo sui dati competenze: i giorni possono avere la parte decimale .5
  e le ore possono avere i minuti < 60}
  if selTabella.FieldByName('UMisura').AsString = 'G' then
  begin
    x:=Pos(',',Text);
    if (x>0) then
      if (Copy(Text,x+1,1) <> '5') then
      begin
        MsgBox.WebMessageDlg(A000MSG_ERR_DECIMALI_GIORNI,mtError,[mbOk],nil,'');
        Abort;
      end;
  end
  else
    x:=Pos('.',Text);
    if (x>0) then
      if (Copy(Text,x+1,2) > '59') then
      begin
        MsgBox.WebMessageDlg(A000MSG_ERR_MINUTI,mtError,[mbOk],nil,'');
        Abort;
      end;
end;

procedure TWA009FProfAsseAnnDM.ValidateOreMinuti(Text,SenderField:String);
begin
  if Text <> '' then
    try
      R180OraValidate(Text);
      if SenderField = 'ARR_COMPETENZA_IN_ORE' then
        if 60 mod R180OreMinutiExt(Text) <> 0 then
        begin
          MsgBox.WebMessageDlg(A000MSG_ERR_MINUTI_DIVISORI,mtError,[mbOk],nil,'');
          Abort;
        end;
    except
      MsgBox.WebMessageDlg(A000MSG_ERR_ORA_NON_VALIDA,mtError,[mbOk],nil,'');
      Abort;
    end;
end;

procedure TWA009FProfAsseAnnDM.OnNewRecord(DataSet: TDataSet);
begin
  selTabella.FieldByName('ANNO').AsString:=SalvaAnno;
  selTabella.FieldByName('CODPROFILO').AsString:=SalvaProfilo;
  inherited;
end;

end.
